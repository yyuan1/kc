<%@ include file="/WEB-INF/jsp/kraTldHeader.jsp"%>

<%@ attribute name="readOnly" description="All fields are displayed as read-only elements." required="true" %>

<c:set var="committeeMembershipAttributes" value="${DataDictionary.CommitteeMembership.attributes}" />

<div id="workarea">
<c:forEach items="${KualiForm.document.committee.committeeMemberships}" var="membership" varStatus="status">
    <c:set var="committeeMembershipProperty" value="document.committeeList[0].committeeMemberships[${status.index}]" />
    <c:set var="committeeMembershipRoleProperty" value="committeeHelper.newCommitteeMembershipRoles[${status.index}]" />
    <c:set var="committeeMembershipExpertiseProperty" value="committeeHelper.newCommitteeMembershipExpertise[${status.index}]" />
    <c:set var="transparent" value="false" />

    <c:if test="${status.first}">
		<c:set var="transparent" value="true" />
	</c:if>

    <%-- Create Tab Title & Description --%>
    <c:choose>
        <c:when test="${empty membership.termStartDate && empty membership.termEndDate}">
            <c:set var="tabTitleValue" value="${fn:substring(membership.personName, 0, 22)}" />
            <c:set var="tabDescriptionValue" value=" " />
        </c:when>
        <c:otherwise>
            <c:set var="tabTitleValue" value="${fn:substring(membership.personName, 0, 22)} (${membership.status})" />
            <c:set var="tabDescriptionValue" value="Term ${membership.formattedTermStartDate} - ${membership.formattedTermEndDate}" />
        </c:otherwise>
    </c:choose>
    
    <%-- Create Delete Checkbox --%>
    <c:choose>
        <c:when test="${!readOnly}">
            <c:set var="deleteProperty" value="${committeeMembershipProperty}.delete" />
        </c:when>
        <c:otherwise>
            <c:set var="deleteProperty" value="" />
        </c:otherwise>    
    </c:choose>
        
    <kul:tab tabTitle="${tabTitleValue}"
             tabErrorKey=""
             innerTabErrorKey="${committeeMembershipProperty}.*,${committeeMembershipRoleProperty}.*,${committeeMembershipExpertiseProperty}.*"
             auditCluster="requiredFieldsAuditErrors" 
             tabAuditKey="" 
             useRiceAuditMode="true"
             tabDescription="${tabDescriptionValue}"
             leftSideHtmlProperty="${deleteProperty}" 
             leftSideHtmlAttribute="${committeeMembershipAttributes.delete}" 
             leftSideHtmlDisabled="${readOnly}" 
             defaultOpen="false"
             useCurrentTabIndexAsKey="true" 
             transparentBackground="${transparent}">
             <div class="tab-container" align="center">
                 <div id="workarea">
                     <div class="tab-container" align="center" id="G100">
                         <h3>
                             <span class="subhead-left"><bean:write name="KualiForm" property="${committeeMembershipProperty}.personName" /></span>
                             <span class="subhead-right"><kul:help businessObjectClassName="org.kuali.kra.bo.Committee" altText="help" /></span>
                         </h3>
                         <kra-committee:committeeMembershipDetailsSection committeeMembership="${committeeMembershipProperty}" memberIndex="${status.index}" parentTabValue="${tabTitleValue}"  readOnly="${readOnly}" />
                         <kra-committee:committeeMembershipContactInformationSection committeeMembership="${committeeMembershipProperty}" memberIndex="${status.index}" parentTabValue="${tabTitleValue}"  readOnly="${readOnly}" />
                         <kra-committee:committeeMembershipRolesSection committeeMembership="${committeeMembershipProperty}" memberIndex="${status.index}" parentTabValue="${tabTitleValue}"  readOnly="${readOnly}" />
                         <kra-committee:committeeMembershipExpertiseSection committeeMembership="${committeeMembershipProperty}" memberIndex="${status.index}" parentTabValue="${tabTitleValue}" readOnly="${readOnly}" />
                     </div>
                 </div>
             </div>
    </kul:tab>
 </c:forEach>

<c:if test="${fn:length(KualiForm.document.committee.committeeMemberships) > 0}">
    <kul:panelFooter />
</c:if>

</div>