package org.kuali.coeus.propdev.impl.core;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.kuali.coeus.propdev.impl.datavalidation.ProposalDevelopmentDataValidationItem;
import org.kuali.coeus.propdev.impl.state.ProposalState;
import org.kuali.coeus.sys.framework.gv.GlobalVariableService;
import org.kuali.coeus.sys.framework.validation.AuditHelper;
import org.kuali.kra.infrastructure.Constants;
import org.kuali.rice.core.api.config.property.ConfigurationService;
import org.kuali.rice.core.api.util.RiceKeyConstants;
import org.kuali.rice.krad.document.Document;
import org.kuali.rice.krad.util.KRADConstants;
import org.kuali.rice.krad.web.controller.MethodAccessible;
import org.kuali.rice.krad.web.form.DialogResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@SuppressWarnings("deprecation")
@Controller
public class ProposalDevelopmentSubmitController extends
		ProposalDevelopmentControllerBase {

    @Autowired
    @Qualifier("auditHelper")
    private AuditHelper auditHelper;
    
    @Autowired
    @Qualifier("globalVariableService")
    private GlobalVariableService globalVariableService;

    @Autowired
    @Qualifier("kualiConfigurationService")
    private ConfigurationService configurationService;

    @RequestMapping(value = "/proposalDevelopment", params = "methodToCall=deleteProposal")
    public ModelAndView deleteProposal(@ModelAttribute("KualiForm") ProposalDevelopmentDocumentForm form, BindingResult result,
            HttpServletRequest request, HttpServletResponse response) throws Exception {
        DialogResponse disapproveConfirm = form.getDialogResponse("PropDev-SubmitPage-ConfirmDelete");
        if (disapproveConfirm == null) {
            return getModelAndViewService().showDialog("PropDev-SubmitPage-ConfirmDelete", true, form);
        }

        getProposalDevelopmentService().deleteProposal(form.getProposalDevelopmentDocument());
        return getNavigationControllerService().returnToHub(form);

    }
    @RequestMapping(value = "/proposalDevelopment", params="methodToCall=saveAndExit")
    public  ModelAndView saveAndExit(@ModelAttribute("KualiForm") ProposalDevelopmentDocumentForm form, BindingResult result, HttpServletRequest request, HttpServletResponse response)throws Exception{	
   		save(form,result,request,response);
   		return getNavigationControllerService().returnToHub(form);
	}
    @RequestMapping(value = "/proposalDevelopment", params="methodToCall=submitForReview")
    public  ModelAndView submitForReview(@ModelAttribute("KualiForm") ProposalDevelopmentDocumentForm form, BindingResult result, HttpServletRequest request, HttpServletResponse response)throws Exception {
        
 	   if(proposalValidToSubmit(form)) {
 		  return getTransactionalDocumentControllerService().route(form);
	   }
	   else {
		   return getModelAndViewService().showDialog("PropDev-DataValidationSection", true, form);
	   }
   } 
   @RequestMapping(value = "/proposalDevelopment", params = "methodToCall=cancelProposal")
    public ModelAndView cancelProposal(@ModelAttribute("KualiForm") ProposalDevelopmentDocumentForm form, BindingResult result,
            HttpServletRequest request, HttpServletResponse response) throws Exception {
	   form.getDevelopmentProposal().setProposalStateTypeCode(ProposalState.CANCELED);
	   return getTransactionalDocumentControllerService().cancel(form);
    }
    @MethodAccessible
    @RequestMapping(value = "/proposalDevelopment", params={"methodToCall=navigate", "actionParameters[navigateToPageId]=PropDev-SubmitPage"}) 
    public ModelAndView navigateToSubmit(@ModelAttribute("KualiForm") ProposalDevelopmentDocumentForm form, BindingResult result, HttpServletRequest request, HttpServletResponse response) {
        ((ProposalDevelopmentViewHelperServiceImpl) form.getViewHelperService()).populateCreditSplits(form);
        ((ProposalDevelopmentViewHelperServiceImpl) form.getViewHelperService()).populateQuestionnaires(form);
        getDataObjectService().wrap(form.getDevelopmentProposal()).fetchRelationship("deadlineTypeRef");
        return getNavigationControllerService().navigate(form);
   }
  
    public AuditHelper getAuditHelper() {
        return auditHelper;
    }

    public void setAuditHelper(AuditHelper auditHelper) {
        this.auditHelper = auditHelper;
    }
   
   @RequestMapping(value = "/proposalDevelopment", params="methodToCall=blanketApprove")
   public  ModelAndView blanketApprove(@ModelAttribute("KualiForm") ProposalDevelopmentDocumentForm form)throws Exception {
       
	   if(proposalValidToSubmit(form)) {
		   return getTransactionalDocumentControllerService().blanketApprove(form);
	   }
	   else {
		   return getModelAndViewService().showDialog("PropDev-DataValidationSection", true, form);
	   }
   	}
   
   @RequestMapping(value = "/proposalDevelopment", params="methodToCall=recall")
   public  ModelAndView recall(@ModelAttribute("KualiForm") ProposalDevelopmentDocumentForm form, BindingResult result, HttpServletRequest request, HttpServletResponse response)throws Exception {
	   String successMessageKey = null;
	   Document document = form.getDocument();
	   if (getDocumentService().documentExists(document.getDocumentNumber())) {
           String recallExplanation = form.getDialogExplanations().get(KRADConstants.QUESTION_ACTION_RECALL_REASON);
           document = getDocumentService().recallDocument(document, recallExplanation, false);
           successMessageKey = RiceKeyConstants.MESSAGE_ROUTE_RECALLED;
       }
       if (successMessageKey != null) {
           getGlobalVariableService().getMessageMap().putInfo(KRADConstants.GLOBAL_MESSAGES, successMessageKey);
       }
	   
	   return getModelAndViewService().getModelAndView(form);
  } 
  
   @RequestMapping(value = "/proposalDevelopment", params="methodToCall=disapprove")
   public  ModelAndView disapprove(@ModelAttribute("KualiForm") ProposalDevelopmentDocumentForm form)throws Exception {
	   String applicationUrl = getConfigurationService().getPropertyValueAsString(KRADConstants.APPLICATION_URL_KEY);
	   form.setReturnLocation(applicationUrl);
	   return   getTransactionalDocumentControllerService().disapprove(form);
   } 
   
  boolean proposalValidToSubmit(ProposalDevelopmentDocumentForm form) {
	  boolean isValid = true;
	  form.setAuditActivated(true);
	  List<ProposalDevelopmentDataValidationItem> dataValidationItems = ((ProposalDevelopmentViewHelperServiceImpl)form.getViewHelperService())
			  															.populateDataValidation(form,form.getView().getViewIndex());
	  if(dataValidationItems != null && dataValidationItems.size() > 0 ) {
		  for(ProposalDevelopmentDataValidationItem validationItem : dataValidationItems) {
			  if (StringUtils.equalsIgnoreCase(validationItem.getSeverity(), Constants.AUDIT_ERRORS)) {
				  isValid = false;
				  form.setDataValidationItems(dataValidationItems);
	              break;
	          }
		  }
	  }
	  getGlobalVariableService().getMessageMap().clearErrorMessages();
      return isValid;
  }
   
  public GlobalVariableService getGlobalVariableService() {
      return globalVariableService;
  }

  public void setGlobalVariableService(GlobalVariableService globalVariableService) {
      this.globalVariableService = globalVariableService;
  }
  
  public ConfigurationService getConfigurationService() {
	  return configurationService;
  }
	
  public void setConfigurationService(ConfigurationService configurationService) {
	  this.configurationService = configurationService;
  }
   
}