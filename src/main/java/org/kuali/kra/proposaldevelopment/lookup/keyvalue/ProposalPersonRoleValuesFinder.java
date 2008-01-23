/*
 * Copyright 2007 The Kuali Foundation.
 * 
 * Licensed under the Educational Community License, Version 1.0 (the "License");
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
package org.kuali.kra.proposaldevelopment.lookup.keyvalue;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;

import org.kuali.core.lookup.keyvalues.KeyValuesBase;
import org.kuali.core.service.KeyValuesService;
import org.kuali.core.service.KualiConfigurationService;
import org.kuali.core.web.ui.KeyLabelPair;
import org.kuali.kra.infrastructure.Constants;
import org.kuali.kra.infrastructure.KraServiceLocator;
import org.kuali.kra.proposaldevelopment.bo.ProposalPersonRole;
import org.kuali.kra.proposaldevelopment.document.ProposalDevelopmentDocument;
import org.kuali.kra.proposaldevelopment.service.KeyPersonnelService;
import org.kuali.kra.proposaldevelopment.web.struts.form.ProposalDevelopmentForm;

import static org.kuali.core.util.GlobalVariables.getKualiForm;
import static org.kuali.kra.infrastructure.Constants.PRINCIPAL_INVESTIGATOR_ROLE;
import static org.kuali.kra.infrastructure.Constants.PROPOSAL_PERSON_ROLE_PARAMETER_PREFIX;
import static org.kuali.kra.infrastructure.Constants.PARAMETER_COMPONENT_DOCUMENT;
import static org.kuali.kra.infrastructure.Constants.PARAMETER_MODULE_PROPOSAL_DEVELOPMENT;
import static org.kuali.kra.infrastructure.KraServiceLocator.getService;

/**
 * Temporary class until this can be gotten working via table.
 *
 * @author $Author: lprzybyl $
 * @version $Revision: 1.6 $
 */
public class ProposalPersonRoleValuesFinder extends KeyValuesBase {
    private static final org.apache.commons.logging.Log LOG = org.apache.commons.logging.LogFactory.getLog(ProposalPersonRoleValuesFinder.class);
    
    /**
     * @see org.kuali.core.lookup.keyvalues.KeyValuesBase#getKeyValues()
     */
    public List getKeyValues() {
        final Collection<ProposalPersonRole> roles = getKeyValuesService().findAll(ProposalPersonRole.class);
        final ProposalDevelopmentDocument document = ((ProposalDevelopmentForm) getKualiForm()).getProposalDevelopmentDocument();
        final boolean hasPrincipalInvestigator = getKeyPersonnelService().hasPrincipalInvestigator(document);
        List<KeyLabelPair> keyValues = new ArrayList<KeyLabelPair>();
        keyValues.add(new KeyLabelPair("", "select:"));

        for (ProposalPersonRole role : roles) {
            LOG.debug("Adding role " + role.getProposalPersonRoleId());
            LOG.debug("With description " + findRoleDescription(role));
            if (!hasPrincipalInvestigator || !PRINCIPAL_INVESTIGATOR_ROLE.equals(role.getProposalPersonRoleId())) {
                keyValues.add(new KeyLabelPair(role.getProposalPersonRoleId(), findRoleDescription(role)));
            }
        }

        return keyValues;
    }

    protected String getRoleIdPrefix() {
        return new String();
    }

    protected String findRoleDescription(ProposalPersonRole role) {
        return getConfigurationService().getParameterValue(PARAMETER_MODULE_PROPOSAL_DEVELOPMENT, 
                                                           PARAMETER_COMPONENT_DOCUMENT, 
                                                           PROPOSAL_PERSON_ROLE_PARAMETER_PREFIX 
                                                           + getRoleIdPrefix()
                                                           + role.getProposalPersonRoleId().toLowerCase());    
    }

    /**
     * Locate from Spring a singleton instance of the <code>{@link KualiConfigurationService}</code>.
     * 
     * @return KualiConfigurationService
     */
    protected KualiConfigurationService getConfigurationService() {
        return getService(KualiConfigurationService.class);
    }
    
    /**
     * Locate from Spring a singleton instance of the <code>{@link KeyPersonnelService}</code>.
     * 
     * @return KeyPersonnelService
     */
    private KeyPersonnelService getKeyPersonnelService() {
        return getService(KeyPersonnelService.class);
    }
    
    /**
     * Locate from Spring a singleton instance of the <code>{@link KeyValuesService}</code>.
     * 
     * @return KeyValuesService
     */
    private KeyValuesService getKeyValuesService() {
        return getService(KeyValuesService.class);
    }
}
