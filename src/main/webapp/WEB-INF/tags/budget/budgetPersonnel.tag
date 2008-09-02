<%--
 Copyright 2006-2008 The Kuali Foundation

 Licensed under the Educational Community License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.osedu.org/licenses/ECL-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
--%>

<%@ include file="/WEB-INF/jsp/kraTldHeader.jsp"%>

<c:set var="budgetPersonAttributes" value="${DataDictionary.BudgetPerson.attributes}" />

<div id="workarea">
<kul:tab tabTitle="Budget Personnel" defaultOpen="true" transparentBackground="true" tabErrorKey="document.budgetPerson*" auditCluster="budgetPersonnelAuditWarnings" tabAuditKey="document.budgetPerson*" useRiceAuditMode="true" alwaysOpen="true">
	<div class="tab-container" align="center">
    	<div class="h2-container">
    		<span class="subhead-left"><h2>Budget Personnel</h2></span>
    		<span class="subhead-right"><kul:help businessObjectClassName="org.kuali.kra.budget.bo.BudgetPerson" altText="help"/></span>
        </div>
        <table id="budget-personnel-table" cellpadding=0 cellspacing="0" summary="">
        	<tr>
	        	<th>&nbsp;</th>
	            <th>Person</th>
	            <th><kul:htmlAttributeLabel attributeEntry="${budgetPersonAttributes.jobCode}" /></div></th>
	            <th><kul:htmlAttributeLabel attributeEntry="${budgetPersonAttributes.appointmentType}" /></div></th>
	            <th><kul:htmlAttributeLabel attributeEntry="${budgetPersonAttributes.calculationBase}" /></div></th>
	            <th><kul:htmlAttributeLabel attributeEntry="${budgetPersonAttributes.effectiveDate}" /></th>
	            <th>Actions</th>
			</tr>
            <c:forEach var="person" items="${KualiForm.document.budgetPersons}" varStatus="status">
            <tr>
              	<th scope="row"><div align="center">${status.index + 1}</div></th>
              	<td>${person.personName} <c:if test="${!empty person.role}"><span class="fineprint">(${person.role})</span></c:if></td>
              	<td>
              		<kul:htmlControlAttribute property="document.budgetPerson[${status.index}].jobCode" attributeEntry="${budgetPersonAttributes.jobCode}" />
              		<kul:lookup boClassName="org.kuali.kra.budget.bo.JobCode" fieldConversions="jobCode:document.budgetPerson[${status.index}].jobCode" anchor="${tabKey}" />
              	</td>
              	<td>
              		<kra:kraControlAttribute property="document.budgetPerson[${status.index}].appointmentTypeCode" readOnly="${readOnly}" attributeEntry="${budgetPersonAttributes.appointmentType}"/>
              	</td>
              	<td>
              		<div align="center">
                  		<kul:htmlControlAttribute property="document.budgetPerson[${status.index}].calculationBase" attributeEntry="${budgetPersonAttributes.calculationBase}" />
              		</div>
              	</td>
              	<td>
              		<div align="center">
						<kul:htmlControlAttribute property="document.budgetPerson[${status.index}].effectiveDate" attributeEntry="${budgetPersonAttributes.effectiveDate}" datePicker="true" />
                  	</div>
                </td>
              	<td>
              		<div align=center>&nbsp;
              			<kra:section permission="modifyBudgets">
	              			<html:image property="methodToCall.deleteBudgetPerson.line${status.index}.x" src='${ConfigProperties.kra.externalizable.images.url}tinybutton-delete1.gif' styleClass="tinybutton"/>
	              		</kra:section>
              		</div>
              	</td>
			</tr>
        	</c:forEach>
        </table>
   	</div>
</kul:tab>

<!--  "workarea" div is ended in panelfooter tag -->
<kul:panelFooter /> 
