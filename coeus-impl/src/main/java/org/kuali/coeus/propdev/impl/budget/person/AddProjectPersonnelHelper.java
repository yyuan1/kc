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
package org.kuali.coeus.propdev.impl.budget.person;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.kuali.coeus.common.budget.framework.personnel.BudgetPerson;
import org.kuali.coeus.common.budget.framework.personnel.TbnPerson;
import org.kuali.coeus.sys.framework.service.KcServiceLocator;
import org.kuali.rice.krad.data.DataObjectService;


public class AddProjectPersonnelHelper {

    private String personType;
    private Map<String, String> lookupFieldValues;
    private List<BudgetPerson> results;
    private BudgetPerson editBudgetPerson;
    private String editLineIndex;
    private DataObjectService dataObjectService;
    
    public AddProjectPersonnelHelper() {
        lookupFieldValues = new HashMap<String, String>();
        results = new ArrayList<BudgetPerson>();
        editBudgetPerson = new BudgetPerson();
    }
    
    public void reset() {
        personType = "";
        lookupFieldValues.clear();
        results.clear();
        editBudgetPerson = new BudgetPerson();
        editLineIndex = null;
    }
    
    public String getPersonType() {
        return personType;
    }

    public void setPersonType(String personType) {
        this.personType = personType;
    }

	public Map<String, String> getLookupFieldValues() {
		return lookupFieldValues;
	}

	public void setLookupFieldValues(Map<String, String> lookupFieldValues) {
		this.lookupFieldValues = lookupFieldValues;
	}

	public List<BudgetPerson> getResults() {
		return results;
	}

	public void setResults(List<BudgetPerson> results) {
		this.results = results;
	}

	public BudgetPerson getEditBudgetPerson() {
		return editBudgetPerson;
	}

	public void setEditBudgetPerson(BudgetPerson editBudgetPerson) {
		this.editBudgetPerson = editBudgetPerson;
	}

	public String getEditLineIndex() {
		return editLineIndex;
	}

	public void setEditLineIndex(String editLineIndex) {
		this.editLineIndex = editLineIndex;
	}

	public DataObjectService getDataObjectService() {
        if (dataObjectService == null) {
        	dataObjectService = KcServiceLocator.getService(DataObjectService.class);
        }
		return dataObjectService;
	}

	public void setDataObjectService(DataObjectService dataObjectService) {
		this.dataObjectService = dataObjectService;
	}

	public List<TbnPerson> getTbnPersons() {
		return getDataObjectService().findAll(TbnPerson.class).getResults();
	}
	
}
