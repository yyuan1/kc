/*
 * Copyright 2005-2014 The Kuali Foundation
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
package org.kuali.coeus.common.budget.impl.print;

import org.apache.xmlbeans.XmlObject;
import org.kuali.coeus.sys.framework.model.KcPersistableBusinessObjectBase;
import org.kuali.coeus.sys.api.model.ScaleTwoDecimal;
import org.kuali.coeus.common.budget.framework.calculator.BudgetCalculationService;
import org.kuali.kra.budget.calculator.BudgetCalculationService;
import org.kuali.coeus.common.budget.framework.core.Budget;
import org.kuali.coeus.common.budget.framework.core.BudgetCategoryType;
import org.kuali.coeus.common.budget.framework.core.CostElement;
import org.kuali.kra.budget.personnel.BudgetPersonnelDetails;
import org.kuali.kra.printing.schema.BudgetSalaryDocument;
import org.kuali.kra.printing.schema.BudgetSalaryDocument.BudgetSalary;
import org.kuali.kra.printing.schema.SalaryType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.config.ConfigurableBeanFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * This class generates XML that conforms with the XSD related to Budget Salary
 * Report. The data for XML is derived from {@link org.kuali.coeus.sys.framework.model.KcTransactionalDocumentBase} and
 * {@link Map} of details passed to the class.
 * 
 * @author
 * 
 */
@Component("budgetSalaryXmlStream")
@Scope(ConfigurableBeanFactory.SCOPE_PROTOTYPE)
public class BudgetSalaryXmlStream extends BudgetBaseSalaryStream {

	private static final String BUDGET_SALARY = "Budget Salary";

    @Autowired
    @Qualifier("budgetCalculationService")
	private BudgetCalculationService budgetCalculationService;

    /**
	 * This method generates XML for Budget Salary Report. It uses data passed
	 * in {@link org.kuali.coeus.sys.framework.model.KcTransactionalDocumentBase} for populating the XML nodes. The XMl
	 * once generated is returned as {@link XmlObject}
	 * 
	 * @param printableBusinessObject
	 *            using which XML is generated
	 * @param reportParameters
	 *            parameters related to XML generation
	 * @return {@link XmlObject} representing the XML
	 */
	public Map<String, XmlObject> generateXmlStream(
			KcPersistableBusinessObjectBase printableBusinessObject, Map<String, Object> reportParameters) {
		Map<String, XmlObject> xmlObjectList = new LinkedHashMap<String, XmlObject>();
		this.budget = (Budget) printableBusinessObject;
		BudgetSalaryDocument budgetSalaryDocument = BudgetSalaryDocument.Factory
				.newInstance();
		if (budget != null) {
			BudgetSalary budgetSalary = getSalaryType();
			budgetSalaryDocument.setBudgetSalary(budgetSalary);
			xmlObjectList.put(BUDGET_SALARY, budgetSalaryDocument);
		}

		return xmlObjectList;
	}

	/**
	 * This method will set the values to salary type attributes and finally
	 * return the array of Salary type.
	 */
	protected BudgetSalary getSalaryType() {
		List<SalaryTypeVO> salaryTypeVoList = new ArrayList<SalaryTypeVO>();
		getBudgetCalculationService().calculateBudgetSummaryTotals(budget);
		for (Map.Entry<BudgetCategoryType, List<CostElement>> entry : budget.getObjectCodeListByBudgetCategoryType().entrySet()) {
		    if (isPersonnel(entry.getKey().getCode())) {
		        for (CostElement costElement : entry.getValue()) {
		            addSalaryDataForCostElement(costElement, salaryTypeVoList);
		        }
		    }
		}
		boolean includeNonPersonnel = false;
		setSalaryTypesForLineItemCalcuAmount(salaryTypeVoList,includeNonPersonnel);
		List<SalaryType> salaryTypeList = getListOfSalaryTypeXmlObjects(salaryTypeVoList);
		BudgetSalary budgetSalary = getBudgetSalaryTypeXmlObject();
		budgetSalary.setSalaryArray(salaryTypeList.toArray(new SalaryType[0]));
		return budgetSalary;
	}
	
	private void addSalaryDataForCostElement(CostElement costElement, List<SalaryTypeVO> salaryTypeVoList) {
        SalaryTypeVO groupVO = new SalaryTypeVO();
        groupVO.setCostElement(costElement.getDescription());
        salaryTypeVoList.add(groupVO);
        for (BudgetPersonnelDetails details : budget.getObjectCodePersonnelList().get(costElement)) {
            SalaryTypeVO salaryTypeVoPerPerson = new SalaryTypeVO();
            salaryTypeVoPerPerson.setName(details.getBudgetPerson().getPersonName());
            salaryTypeVoPerPerson.setBudgetPeriodVOs(getBudgetPeriodData(
                    budget.getObjectCodePersonnelSalaryTotals().get(costElement.getCostElement() + "," + details.getPersonId())));
            salaryTypeVoList.add(salaryTypeVoPerPerson);
        }
        if (budget.getObjectCodePersonnelSalaryTotals().get(costElement.getCostElement()) != null) {
            SalaryTypeVO salaryTypeVoPerPerson = new SalaryTypeVO();
            salaryTypeVoPerPerson.setName("Summary Line Item");
            salaryTypeVoPerPerson.setBudgetPeriodVOs(
                    getBudgetPeriodData(budget.getObjectCodePersonnelSalaryTotals().get(costElement.getCostElement())));
            salaryTypeVoList.add(salaryTypeVoPerPerson);                        
        }	    
	}
	
	private List<BudgetDataPeriodVO> getBudgetPeriodData(List<ScaleTwoDecimal> costs) {
        List<BudgetDataPeriodVO> budgetDataList = new ArrayList<BudgetDataPeriodVO>();
        int budgetPeriodId = 1;
        for (ScaleTwoDecimal cost : costs) {
            BudgetDataPeriodVO periodData = new BudgetDataPeriodVO();
            periodData.setBudgetPeriodId(budgetPeriodId++);
            periodData.setPeriodCost(cost);
            budgetDataList.add(periodData);
        }
        return budgetDataList;
	}
	

    protected BudgetCalculationService getBudgetCalculationService() {
        return budgetCalculationService;
    }

    public void setBudgetCalculationService(BudgetCalculationService budgetCalculationService) {
        this.budgetCalculationService = budgetCalculationService;
    }
}
