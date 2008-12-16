/*
 * Copyright 2006-2008 The Kuali Foundation
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
package org.kuali.kra.irb.service;

import org.kuali.core.service.BusinessObjectService;
import org.kuali.kra.irb.bo.Protocol;
import org.kuali.kra.irb.bo.ProtocolReference;
import org.kuali.kra.irb.document.ProtocolDocument;


public interface ProtocolReferenceService {

    /**
     * This method adds ProtocolReference to the List of ProtocolReferences along with 
     * appropriate ProtocolReferenceType.
     * @param protocol which contains list of ProtocolReferences.
     * @param protocolReference object is added to ProtocolReferences list after setting ProtocolReferenceType.
     */
    public abstract void addProtocolReference(Protocol protocol, ProtocolReference protocolReference);
    
    /**
     * This method deletes ProtocolReference from the List at specified position(lineNumber)
     * @param protocol which contains list of ProtocolRefernces
     * @param lineNumber to be deleted
     */
    public abstract void deleteProtocolReference(Protocol protocol, int lineNumber);

}