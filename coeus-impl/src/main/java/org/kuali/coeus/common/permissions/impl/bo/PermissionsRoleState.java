/*
 * Copyright 2005-2014 The Kuali Foundation
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
package org.kuali.coeus.common.permissions.impl.bo;

import org.kuali.coeus.common.permissions.impl.web.bean.Role;
import org.kuali.rice.krad.bo.BusinessObjectBase;

/**
 * The PermissionsRoleState is used by the Permissions Edit Role 
 * feature.  The Edit Role form gives a list of role names along
 * with a checkbox for each currently selected role for the user. 
 * An instance of this class is used for each role.  That boolean
 * "state" attribute indicates whether the checkbox has been
 * selected or not. 
 */
@SuppressWarnings("serial")
public class PermissionsRoleState extends BusinessObjectBase {

    private Role role;
    private Boolean state = false;
    
    public PermissionsRoleState(Role role) {
        this.role = role;
    }

    public Boolean getState() {
        return state;
    }

    public void setState(Boolean state) {
        this.state = state;
    }

    public Role getRole() {
        return role;
    }
    
    public void refresh() {
        // do nothing
    }
}
