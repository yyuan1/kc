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

<kul:page showDocumentInfo="false" docTitle="Area Of Research"
	htmlFormAction="researchAreas" transactionalDocument="false"
	headerTitle="Area Of Research" auditCount="0">

	<script language="JavaScript" type="text/javascript"
		src="dwr/engine.js"></script>

	<script language="JavaScript" type="text/javascript" src="dwr/util.js"></script>

	<script language="JavaScript" type="text/javascript"
		src="dwr/interface/CustomAttributeService.js"></script>

	<script language="JavaScript" type="text/javascript"
		src="dwr/interface/SponsorService.js"></script>


	<script src="scripts/jquery/jquery.js"></script>
	<link rel="stylesheet" href="css/jquery/screen.css" type="text/css" />
	<link rel="stylesheet" href="css/jquery/new_kuali.css" type="text/css" />
	<link rel="stylesheet" href="css/jquery/kuali-stylesheet.css"
		type="text/css" />
	<link rel="stylesheet" href="css/jquery/jquery.treeview.css"
		type="text/css" />
	<%-- link rel="stylesheet" href="http://dev.jquery.com/view/trunk/plugins/treeview/jquery.treeview.css" type="text/css" /--%>
	<script type="text/javascript" src="scripts/jquery/jquery.treeview.js"></script>

	<a name="topOfForm"></a>

	<%--
   <div id = "loading">
      <a href="#"><img src="static/images/jquery/ajax-loader.gif" /></a>
   </div> 
--%>
	<div align="center" style="margin: 10px">
	<div id="headermsg" align="left"></div>
	<br />
	<kul:tabTop defaultOpen="true" tabTitle="Area of Research"
		tabErrorKey="researchArea*">
		<kra:researchAreas />
	</kul:tabTop>
     <kul:panelFooter />

        <div id="globalbuttons" class="globalbuttons">
    <%-- <input type="submit" id="generate" value="Generate!" /> --%>
    <input type="image" id="save" src="${ConfigProperties.kr.externalizable.images.url}buttonsmall_save.gif" /> 
    <a
                            href='portal.do?methodToCall=refresh&amp;docFormKey=88888888&amp;anchor=&amp;docNum='  title="cancel"><img
                            src="kr/static/images/buttonsmall_cancel.gif" class="tinybutton" alt="cancel" title="cancel"
                            border="0" /></a>           
                            <!--  still posted -->
          <%--   <input type="submit" name="save" id="generate" 
                src="${ConfigProperties.kr.externalizable.images.url}buttonsmall_save.gif"
                class="globalbuttons" title="save" alt="save"> --%>
            <%-- <html:image src="${ConfigProperties.kr.externalizable.images.url}buttonsmall_save.gif" styleClass="globalbuttons" property="methodToCall.saveSponsorHierarchy" title="save" alt="save" onclick="return okToSave();return false;" />    
            <html:image src="${ConfigProperties.kr.externalizable.images.url}buttonsmall_cancel.gif" styleClass="globalbuttons" property="methodToCall.cancelResearchAreas" title="cancel" alt="cancel" /> --%>  
        </div>

    <script type="text/javascript" src="scripts/researchArea.js"></script> 

</kul:page>
    
 