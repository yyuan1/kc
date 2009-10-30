/*
 * Copyright 2006-2008 The Kuali Foundation
 * 
 * Licensed under the Educational Community License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.osedu.org/licenses/ECL-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.kuali.kra.timeandmoney.document.authorization;

import java.util.HashSet;
import java.util.Set;

import org.kuali.kra.authorization.ApplicationTask;
import org.kuali.kra.authorization.KcTransactionalDocumentAuthorizerBase;
import org.kuali.kra.infrastructure.TaskName;
import org.kuali.kra.timeandmoney.document.TimeAndMoneyDocument;
import org.kuali.rice.kim.bo.Person;
import org.kuali.rice.kns.authorization.AuthorizationConstants;
import org.kuali.rice.kns.document.Document;

/**
 * This class is the Time and Money Document Authorizer.  It determines the edit modes and
 * document actions for all time and money documents.
 */
public class TimeAndMoneyDocumentAuthorizer extends KcTransactionalDocumentAuthorizerBase {
     
    /**
     * @see org.kuali.rice.kns.document.authorization.TransactionalDocumentAuthorizer#getEditModes(org.kuali.rice.kns.document.Document, org.kuali.rice.kim.bo.Person, java.util.Set)
     */
    public Set<String> getEditModes(Document document, Person user, Set<String> currentEditModes) {
        Set<String> editModes = new HashSet<String>();
        
        TimeAndMoneyDocument timeAndMoneyDocument = (TimeAndMoneyDocument) document;
        
        if (timeAndMoneyDocument.getDocumentNumber() == null) {
            if (canCreateTimeAndMoney(user.getPrincipalId())) {
                editModes.add(AuthorizationConstants.EditMode.FULL_ENTRY);
            } else {
                editModes.add(AuthorizationConstants.EditMode.UNVIEWABLE);
            }
        }
        else {
            if (canExecuteTimeAndMoneyTask(user.getPrincipalId(), timeAndMoneyDocument, TaskName.MODIFY_TIME_AND_MONEY)) {  
                editModes.add(AuthorizationConstants.EditMode.FULL_ENTRY);
            }
            else if (canExecuteTimeAndMoneyTask(user.getPrincipalId(), timeAndMoneyDocument, TaskName.VIEW_TIME_AND_MONEY)) {
                editModes.add(AuthorizationConstants.EditMode.VIEW_ONLY);
            }
            else {
                editModes.add(AuthorizationConstants.EditMode.UNVIEWABLE);
            }
        }
        
        return editModes;
    }
    
    /**
     * @see org.kuali.rice.kns.document.authorization.DocumentAuthorizer#canInitiate(java.lang.String, org.kuali.rice.kim.bo.Person)
     */
    public boolean canInitiate(String documentTypeName, Person user) {
        return canCreateTimeAndMoney(user.getPrincipalId());
    }
  
    /**
     * @see org.kuali.rice.kns.document.authorization.DocumentAuthorizer#canOpen(org.kuali.rice.kns.document.Document, org.kuali.rice.kim.bo.Person)
     */
    public boolean canOpen(Document document, Person user) {
        TimeAndMoneyDocument timeAndMoneyDocument = (TimeAndMoneyDocument) document;
        if (timeAndMoneyDocument.getDocumentNumber() == null) {
            return canCreateTimeAndMoney(user.getPrincipalId());
        }
        return canExecuteTimeAndMoneyTask(user.getPrincipalId(), timeAndMoneyDocument, TaskName.VIEW_TIME_AND_MONEY);
    }
    
    /**
     * @see org.kuali.kra.authorization.KcTransactionalDocumentAuthorizerBase#canEdit(org.kuali.rice.kns.document.Document, org.kuali.rice.kim.bo.Person)
     */
    @Override
    public boolean canEdit(Document document, Person user) {
        return canExecuteTimeAndMoneyTask(user.getPrincipalId(), (TimeAndMoneyDocument) document, TaskName.MODIFY_TIME_AND_MONEY);
    }
    
    /**
     * @see org.kuali.kra.authorization.KcTransactionalDocumentAuthorizerBase#canSave(org.kuali.rice.kns.document.Document, org.kuali.rice.kim.bo.Person)
     */
    @Override
    protected boolean canSave(Document document, Person user) {
        return canEdit(document, user);
    }
    
    /**
     * @see org.kuali.kra.authorization.KcTransactionalDocumentAuthorizerBase#canReload(org.kuali.rice.kns.document.Document, org.kuali.rice.kim.bo.Person)
     */
    @Override
    protected boolean canReload(Document document, Person user) {
        return canEdit(document, user);
    }
    
    /**
     * @see org.kuali.kra.authorization.KcTransactionalDocumentAuthorizerBase#canCopy(org.kuali.rice.kns.document.Document, org.kuali.rice.kim.bo.Person)
     */
    @Override
    protected boolean canCopy(Document document, Person user) {
        return false;
    }
    
    /**
     * Does the user have permission to create a award?
     * @param user the user
     * @return true if the user can create a award; otherwise false
     */
    private boolean canCreateTimeAndMoney(String userId) {
        ApplicationTask task = new ApplicationTask(TaskName.CREATE_TAMD);
        return getTaskAuthorizationService().isAuthorized(userId, task);
    }
    
    /**
     * Does the user have permission to execute the given task for a award?
     * @param username the user's username
     * @param doc the award document
     * @param taskName the name of the task
     * @return true if has permission; otherwise false
     */
    private boolean canExecuteTimeAndMoneyTask(String userId, TimeAndMoneyDocument doc, String taskName) {
        TimeAndMoneyTask task = new TimeAndMoneyTask(taskName, doc);
        return getTaskAuthorizationService().isAuthorized(userId, task);
    }
}
