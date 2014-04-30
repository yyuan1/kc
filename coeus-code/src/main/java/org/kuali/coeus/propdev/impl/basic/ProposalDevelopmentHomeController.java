/*
 * Copyright 2005-2010 The Kuali Foundation
 * 
 * Licensed under the Educational Community License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.opensource.org/licenses/ecl1.php
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.kuali.coeus.propdev.impl.basic;

import org.kuali.coeus.common.framework.keyword.ScienceKeyword;
import org.kuali.coeus.common.framework.sponsor.Sponsor;
import org.kuali.coeus.common.specialreview.impl.rule.event.SaveDocumentSpecialReviewEvent;
import org.kuali.coeus.propdev.impl.copy.ProposalCopyCriteria;
import org.kuali.coeus.propdev.impl.copy.ProposalCopyService;
import org.kuali.coeus.propdev.impl.copy.ProposalCopyServiceImpl;
import org.kuali.coeus.propdev.impl.core.ProposalDevelopmentControllerBase;
import org.kuali.coeus.propdev.impl.core.ProposalDevelopmentDocument;
import org.kuali.coeus.propdev.impl.core.ProposalDevelopmentDocumentForm;
import org.kuali.coeus.propdev.impl.keyword.PropScienceKeyword;
import org.kuali.coeus.propdev.impl.s2s.S2sAppSubmission;
import org.kuali.coeus.propdev.impl.specialreview.ProposalSpecialReview;
import org.kuali.coeus.sys.framework.service.KcServiceLocator;
import org.kuali.rice.core.api.criteria.QueryByCriteria;
import org.kuali.rice.krad.data.DataObjectService;
import org.kuali.rice.krad.service.BusinessObjectService;
import org.kuali.rice.krad.service.DocumentService;
import org.kuali.rice.krad.service.PessimisticLockService;
import org.kuali.rice.krad.uif.UifParameters;
import org.kuali.rice.krad.uif.element.Action;
import org.kuali.rice.krad.util.GlobalVariables;
import org.kuali.rice.krad.web.controller.MethodAccessible;
import org.kuali.rice.krad.web.form.DocumentFormBase;
import org.springframework.beans.propertyeditors.CustomCollectionEditor;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ProposalDevelopmentHomeController extends ProposalDevelopmentControllerBase {

   @MethodAccessible
   @RequestMapping(value = "/proposalDevelopment", params="methodToCall=createProposal")
   public ModelAndView createProposal(@ModelAttribute("KualiForm") ProposalDevelopmentDocumentForm form, BindingResult result,
           HttpServletRequest request, HttpServletResponse response) throws Exception {

       ProposalDevelopmentDocument proposalDevelopmentDocument = form.getProposalDevelopmentDocument();
       initialSave(proposalDevelopmentDocument);
       save(form, result, request, response);
       initializeProposalUsers(proposalDevelopmentDocument);
       //setting to null so the previous page id(PropDev-InitiatePage) doesn't override the default 
       form.setPageId(null);
       return getTransactionalDocumentControllerService().getUIFModelAndViewWithInit(form, PROPDEV_DEFAULT_VIEW_ID);
   }

    @RequestMapping(value = "/proposalDevelopment", params = "methodToCall=copy")
    public ModelAndView copy(@ModelAttribute("KualiForm") ProposalDevelopmentDocumentForm form, BindingResult result,
                             HttpServletRequest request, HttpServletResponse response) throws Exception {

        ProposalDevelopmentDocument proposalDevelopmentDocument = form.getProposalDevelopmentDocument();

        ProposalCopyService proposalCopyService = getProposalCopyService();
        if (proposalCopyService != null) {
            Map<String, Object> keyMap = new HashMap<String, Object>();
            if (form.getProposalDevelopmentDocument() != null) {
                String proposalNumber = form.getProposalDevelopmentDocument().getDevelopmentProposal().getProposalNumber();
                keyMap.put("proposalNumber", proposalNumber);
            }
            DataObjectService dataObjectService = KcServiceLocator.getService(DataObjectService.class);
            List<S2sAppSubmission> s2sAppSubmissionProposalList =
                    dataObjectService.findMatching(S2sAppSubmission.class,
                            QueryByCriteria.Builder.andAttributes(keyMap).build()).getResults();

            KcServiceLocator.getService(PessimisticLockService.class).releaseAllLocksForUser(proposalDevelopmentDocument.getPessimisticLocks(), GlobalVariables.getUserSession().getPerson());
        //testing purpose, should get from the form

            ProposalCopyCriteria proposalCopyCriteria = null;
            proposalCopyCriteria = form.getProposalCopyCriteria();
                    // new ProposalCopyCriteria();
          //  proposalCopyCriteria.setLeadUnitNumber("000001");

            String newDocNum = null;

            newDocNum = proposalCopyService.copyProposal(proposalDevelopmentDocument, proposalCopyCriteria);
            proposalDevelopmentDocument.setDocumentNumber(newDocNum);

            //to load document from the form but this call is not working with proposalDevelopmentDocumentForm.
            // this.loadDocument(form);
            ProposalDevelopmentDocument copiedDocument = form.getProposalDevelopmentDocument();
            getProposalRoleTemplateService().initializeProposalUsers(copiedDocument);//add in any default permissions
            copiedDocument.getDevelopmentProposal().setS2sAppSubmission(new ArrayList<S2sAppSubmission>());
            for (S2sAppSubmission s2sAppSubmissionListValue : s2sAppSubmissionProposalList) {
                copiedDocument.getDevelopmentProposal().setPrevGrantsGovTrackingID(s2sAppSubmissionListValue.getGgTrackingId());
            }

            DocumentService docService = KcServiceLocator.getService(DocumentService.class);
            docService.saveDocument(copiedDocument);

            // Helper method to clear document form data. the two functions below on good with proposalDevelopmentForm.
            //form.clearDocumentRelatedState();
            //form.setViewOnly(false);
        }
            return super.save(form, result, request, response);

    }
    protected ProposalCopyService getProposalCopyService (){return KcServiceLocator.getService(ProposalCopyService.class);}

   @RequestMapping(value = "/proposalDevelopment", params = "methodToCall=save")
   public ModelAndView save(@ModelAttribute("KualiForm") DocumentFormBase form, BindingResult result,
           HttpServletRequest request, HttpServletResponse response) throws Exception {
       return super.save(form, result, request, response);
   }
   
   @RequestMapping(value = "/proposalDevelopment", params = "methodToCall=saveAndContinue")
   public ModelAndView saveAndContinue(@ModelAttribute("KualiForm") ProposalDevelopmentDocumentForm form, BindingResult result,
           HttpServletRequest request, HttpServletResponse response) throws Exception {
       List<Action> actions = form.getOrderedNavigationActions();
       int indexOfCurrentAction = form.findIndexOfPageId(actions);
       if (indexOfCurrentAction == -1) {
           indexOfCurrentAction = 0;
       }
       if (indexOfCurrentAction < actions.size()-1) {
           form.getActionParameters().put(UifParameters.NAVIGATE_TO_PAGE_ID, actions.get(indexOfCurrentAction+1).getNavigateToPageId());
       }
       return save(form, result, request, response);
   }
   
   @RequestMapping(value = "/proposalDevelopment", params = "methodToCall=previousPage")
   public ModelAndView previousPage(@ModelAttribute("KualiForm") ProposalDevelopmentDocumentForm form, BindingResult result,
           HttpServletRequest request, HttpServletResponse response) throws Exception {
       List<Action> actions = form.getOrderedNavigationActions();
       int indexOfCurrentAction = form.findIndexOfPageId(actions);
       if (indexOfCurrentAction != -1 && indexOfCurrentAction > 0) {
           form.getActionParameters().put(UifParameters.NAVIGATE_TO_PAGE_ID, actions.get(indexOfCurrentAction-1).getNavigateToPageId());
       }
       return navigate(form, result, request, response);
   }
   
   @MethodAccessible
   @RequestMapping(value = "/proposalDevelopment", params="methodToCall=getSponsor")
   public @ResponseBody Sponsor sponsorByCode(@RequestParam("sponsorCode") String sponsorCode) {
       Sponsor sponsor = getLegacyDataAdapter().findBySinglePrimaryKey(Sponsor.class, sponsorCode);
       //clear references that are likely circular
       if (sponsor != null) {
           sponsor.setUnit(null);
           sponsor.setRolodex(null);
       }
       return sponsor;
   }
   
   @RequestMapping(value = "/proposalDevelopment", params="methodToCall=linkProtocol")
   public ModelAndView linkProtocol(@ModelAttribute("KualiForm") DocumentFormBase form, BindingResult result,
           HttpServletRequest request, HttpServletResponse response) throws Exception {
       ProposalDevelopmentDocumentForm pdForm = (ProposalDevelopmentDocumentForm) form;
       ProposalDevelopmentDocument proposalDevelopmentDocument = (ProposalDevelopmentDocument) pdForm.getDocument();
       for (ProposalSpecialReview specialReview : proposalDevelopmentDocument.getDevelopmentProposal().getPropSpecialReviews()) {
           if (!specialReview.isLinkedToProtocol()) {
               pdForm.getSpecialReviewHelper().prepareProtocolLinkViewFields(specialReview);
           }
       }
       return getTransactionalDocumentControllerService().getUIFModelAndView(form);
   }
   
   @RequestMapping(value = "/proposalDevelopment", params="methodToCall=saveDetails")
   public ModelAndView saveDetails(@ModelAttribute("KualiForm") ProposalDevelopmentDocumentForm form, BindingResult result,
           HttpServletRequest request, HttpServletResponse response) throws Exception {
       return super.save(form, result, request, response);
   }
   
   @RequestMapping(value = "/proposalDevelopment", params="methodToCall=saveOpportunity")
   public ModelAndView saveOpportunity(@ModelAttribute("KualiForm") ProposalDevelopmentDocumentForm form, BindingResult result,
           HttpServletRequest request, HttpServletResponse response) throws Exception {
       return super.save(form, result, request, response);
   }      
   
   
   @RequestMapping(value = "/proposalDevelopment", params="methodToCall=saveCompliance")
   public ModelAndView saveComplaince(@ModelAttribute("KualiForm") DocumentFormBase form, BindingResult result,
           HttpServletRequest request, HttpServletResponse response) throws Exception {
       ProposalDevelopmentDocumentForm pdForm = (ProposalDevelopmentDocumentForm) form;
        return super.save(pdForm, result, request, response, SaveDocumentSpecialReviewEvent.class);
   }   
   
   @RequestMapping(value = "/proposalDevelopment", params="methodToCall=saveProposalAttachments")
   public ModelAndView saveProposalAttachments(@ModelAttribute("KualiForm") DocumentFormBase form, BindingResult result,
           HttpServletRequest request, HttpServletResponse response) throws Exception {
       ProposalDevelopmentDocumentForm pdForm = (ProposalDevelopmentDocumentForm) form;
       return super.save(pdForm, result, request, response);
   }
   
   @RequestMapping(value = "/proposalDevelopment", params="methodToCall=saveInternalAttachments")
   public ModelAndView saveInternalAttachments(@ModelAttribute("KualiForm") DocumentFormBase form, BindingResult result,
           HttpServletRequest request, HttpServletResponse response) throws Exception {
       ProposalDevelopmentDocumentForm pdForm = (ProposalDevelopmentDocumentForm) form;
       return super.save(pdForm, result, request, response);
   }   
   
   @RequestMapping(value = "/proposalDevelopment", params="methodToCall=savePersonnelAttachments")
   public ModelAndView savePersonnelAttachments(@ModelAttribute("KualiForm") DocumentFormBase form, BindingResult result,
           HttpServletRequest request, HttpServletResponse response) throws Exception {
       ProposalDevelopmentDocumentForm pdForm = (ProposalDevelopmentDocumentForm) form;
       return super.save(pdForm, result, request, response);
   }
   @RequestMapping(value = "/proposalDevelopment", params="methodToCall=saveAbstracts")
   public ModelAndView saveAbstracts(@ModelAttribute("KualiForm") DocumentFormBase form, BindingResult result,
           HttpServletRequest request, HttpServletResponse response) throws Exception {
       ProposalDevelopmentDocumentForm pdForm = (ProposalDevelopmentDocumentForm) form;
       return super.save(pdForm, result, request, response);
   }
   @RequestMapping(value = "/proposalDevelopment", params="methodToCall=saveNotes")
   public ModelAndView saveNotes(@ModelAttribute("KualiForm") DocumentFormBase form, BindingResult result,
           HttpServletRequest request, HttpServletResponse response) throws Exception {
       ProposalDevelopmentDocumentForm pdForm = (ProposalDevelopmentDocumentForm) form;
       return super.save(pdForm, result, request, response);
   }

   @MethodAccessible
   @RequestMapping(value = "/proposalDevelopment", params="methodToCall=docHandler")
   public ModelAndView docHandler(@ModelAttribute("KualiForm") DocumentFormBase form, BindingResult result, HttpServletRequest request,
           HttpServletResponse response) throws Exception {
       ModelAndView modelAndView = getTransactionalDocumentControllerService().docHandler(form, result, request, response);
       ProposalDevelopmentDocumentForm propDevForm = (ProposalDevelopmentDocumentForm) form;
       propDevForm.initialize();
       return modelAndView;
   }
   
   @InitBinder
   protected void initBinder(WebDataBinder binder) throws Exception {
	   binder.registerCustomEditor(List.class, "document.developmentProposal.propScienceKeywords", new PropScienceKeywordEditor());
   }
   	  
   protected class PropScienceKeywordEditor extends CustomCollectionEditor {
		public PropScienceKeywordEditor() {
			super(List.class);
		}

		protected Object convertElement(Object element) {
			if (element instanceof String) {
				return new PropScienceKeyword(null, getScienceKeyword(element));
			}
			return null;
		}
	}
   
   protected ScienceKeyword getScienceKeyword(Object element) {
	   return (ScienceKeyword) getDataObjectService().findUnique(ScienceKeyword.class, QueryByCriteria.Builder.forAttribute("scienceKeywordCode", element).build());
   }
}
