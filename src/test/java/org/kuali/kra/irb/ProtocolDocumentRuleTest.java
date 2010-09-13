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
package org.kuali.kra.irb;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.kuali.kra.infrastructure.KeyConstants;
import org.kuali.kra.infrastructure.KraServiceLocator;
import org.kuali.kra.irb.test.ProtocolRuleTestBase;
import org.kuali.kra.rules.ResearchDocumentRuleBase;
import org.kuali.rice.kns.service.DictionaryValidationService;
import org.kuali.rice.kns.util.ErrorMap;
import org.kuali.rice.kns.util.GlobalVariables;
import org.kuali.rice.kns.util.MessageMap;
import org.kuali.rice.kns.util.RiceKeyConstants;

public class ProtocolDocumentRuleTest extends ProtocolRuleTestBase {

    private static final String PROTOCOL_LUN_FORM_ELEMENT="protocolHelper.leadUnitNumber";
    private static final String ERROR_PROPERTY_ORGANIZATION_ID = "protocolHelper.newProtocolLocation.organizationId"; 
    private ProtocolDocumentRule rule = null;
    private DictionaryValidationService dictionaryValidationService = null;

    @Before
    public void setUp() throws Exception {
        super.setUp();
        rule = new ProtocolDocumentRule();
        dictionaryValidationService = KraServiceLocator.getService(DictionaryValidationService.class);
    }

    @After
    public void tearDown() throws Exception {
        rule = null;
        dictionaryValidationService = null;
        super.tearDown();
    }

    @Test
    public void testRequiredBusinessRuleOK() throws Exception {
        ProtocolDocument document = getNewProtocolDocument();
        setProtocolRequiredFields(document);
        
        MessageMap messageMap = GlobalVariables.getMessageMap();
        messageMap.addToErrorPath(ResearchDocumentRuleBase.DOCUMENT_ERROR_PATH);
        dictionaryValidationService.validateDocumentAndUpdatableReferencesRecursively(document, 10, true, true);
        assertTrue(messageMap.hasNoErrors());
        messageMap.removeFromErrorPath(ResearchDocumentRuleBase.DOCUMENT_ERROR_PATH);
        
        assertTrue(rule.processLeadUnitBusinessRules(document));
    }
    
    @Test
    public void testMissingRequiredFields() throws Exception {
        ProtocolDocument document = getNewProtocolDocument();
        //setProtocolRequiredFields(document);
        document.getDocumentHeader().setDocumentDescription(DEFAULT_DOCUMENT_DESCRIPTION);
        ErrorMap errorMap = GlobalVariables.getErrorMap();
        errorMap.addToErrorPath(rule.DOCUMENT_ERROR_PATH);
        dictionaryValidationService.validateDocumentAndUpdatableReferencesRecursively(document, 10,true,true);
        assertEquals(3, errorMap.size());
        assertError("document.protocolList[0].leadUnitNumber", RiceKeyConstants.ERROR_REQUIRED);
        assertError("document.protocolList[0].title", RiceKeyConstants.ERROR_REQUIRED);
        assertError("document.protocolList[0].principalInvestigatorId", RiceKeyConstants.ERROR_REQUIRED);
        
    }

    @Test
    public void testInvalidLU() throws Exception {
        ProtocolDocument document = getNewProtocolDocument();
        setProtocolRequiredFields(document);
        document.getProtocol().setLeadUnitNumber("bogus");
        assertFalse(rule.processLeadUnitBusinessRules(document));
        assertError(PROTOCOL_LUN_FORM_ELEMENT, KeyConstants.ERROR_PROTOCOL_LEAD_UNIT_NUM_INVALID);
    }

    @Test
    public void testProcessProtocolLocationBusinessRules() throws Exception {
        ProtocolDocument document = getNewProtocolDocument();
        setProtocolRequiredFields(document);
        document.getProtocol().getProtocolLocations().clear();
        assertFalse(rule.processProtocolLocationBusinessRules(document));
        assertError(ERROR_PROPERTY_ORGANIZATION_ID, KeyConstants.ERROR_PROTOCOL_LOCATION_SHOULD_EXIST);
    }

}
