<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/includes/header.jsp" %>
<script language="javascript">
function deroulement(selection,op,path){
	if(confirm("Are you sure you want to "+op+" ?"))
	window.location=path;
	}
function PassCheck(form1)
{
	if((form1.new_pass.value)!=(form1.verify_pass.value))
	{
	alert("Passwod missmatch.");
	form1.new_pass.focus();
	return false;
	}

else
{
return true;
}
}
//User autocomplete
$().ready(function() {
function formatItem(row) {
		return "<tr><td width=90>" + row[0] + "</td><td width=90>" + row[1] + "</td><td width=90>" + row[2] + "</td><td width=90>" + row[3] + "</td><td width=90>" + row[4] + "</td></tr>";
	}
	function formatResult(row) {
		return row[0].replace(/(<.+?>)/gi, '');
	}

$("#userName,#username").autocomplete('search.user', {
		width: 600,
		multiple: false,
		matchContains: true,
		formatItem: formatItem,
		formatResult: formatResult
		});

}); 


//Start selectable districts and sectors

var xmlHttp;
function createXMLHttpRequest() {
  if (window.ActiveXObject) {
      xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
  } 
  else if (window.XMLHttpRequest) {
      xmlHttp = new XMLHttpRequest();
  }
}

function doRequestUsingGETDistrict(value) {
 
  createXMLHttpRequest();
  queryString = "search.sector" ;
  queryString = queryString + "?distid="+value;
  xmlHttp.onreadystatechange = handleStateChange;
  xmlHttp.open("GET", queryString, true);
  xmlHttp.send(null);
}

function handleStateChange() {
  if(xmlHttp.readyState == 4) {
      if(xmlHttp.status == 200) {
        parseResults();
      }
  }
}
function parseResults() {
          var responseText = document.createTextNode(xmlHttp.responseText);
          var returnElements=xmlHttp.responseText.split("||");
        //Process each of the elements 	
        for ( var i=0; i<returnElements.length; i++ ){
           
           if(returnElements[i]!="")
          {
           valueLabelPair = returnElements[i].split(";")
           document.getElementById('sector').options.length= returnElements.length;     
           document.getElementById('sector').options[i] = new Option(valueLabelPair[0], valueLabelPair[1]);
          } 
      }
}




/*end func*/



// end of initialization
</script>

<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">

<tr><td>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
    <td width="4%" style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;border-left:#CCCCCC 1px solid; padding-left:10px;"><a href="index.htm?mdl=profile&view=all&sid" class="Mod"><img src="./images/student.png" border="0"></a></td>
    <td width="40%" height="50" style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;"><div align="left" class="ModName">Student profile</div></td>
    <td width="14%" style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;" valign="middle" >
    <b><font color=#f38943><c:if test="${success!=''}"><script language="javascript">
	var success='${success}';
	if(success!=''){
    alert(success);
    }
    </script></c:if></font></b></td>
    
   	<td width="16%" style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;"><div align="center"><a href="index.htm?mdl=profile&username=${myLoggedUser.userName }&view=UseProfile&sid" class="Mod"><img src="./images/edit.png" border="0"><br>Edit my profile</a></div></td>
	<td width="16%" style="border-bottom:#CCCCCC 1px solid;border-right:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;"><div align="center"><a href="index.htm?mdl=Logged&sid" class="Mod"><img src="./images/cancel.png" border="0"><br>Close</a></div></td>
  </tr>
</table>
</td></tr>
<tr><td style="padding-top:2px;">
<%
if(request.getParameter("mdl").equals("profile")){%>
<div align="center"><table border="0" width="100%" class="listingTable">
<%
if(request.getParameter("view").equals("UseProfile")){
%>
<tr><td>
<form name="studentUpdate" action="personinfo?mdl=profile&username=${myLoggedUser.userName }&view=all&sid" method="POST" >
	<table border=0 width="500" cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFCCC" style="border:groove #FFFCCC 2px;">
	<tr><td colspan="6" align="center" height="30" bgcolor="#FFEECC"><strong>Edit Student Profile Infos</strong></td>
	</tr>
	
	<c:forEach items="${students}" var="studentUpdate" varStatus="optStatus">
	<tr>
		<td colspan="2" style="padding-left:5px;">
			Registration Number:		</td>
                <td colspan="4">
                <input type="hidden" name="regno_yenyewe" value="${studentUpdate.studentRegNO}" >
			<input type="text" name="regno_yenyewe" value="${studentUpdate.studentRegNO}" disabled="disabled"></td>
        </tr>
          <tr>
		
		<td colspan="2" style="padding-left:5px;">
			First Name:		</td>
                <td colspan="4"> <input type="text" name="firstname" id="firstname" value="${studentUpdate.studentFirstName}"/></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Last Name:		</td>
                <td colspan="4"> <input type="text" name="lastname" size="25" id="lastname"  value="${studentUpdate.studentLastName}"/></td>
        </tr>      
               <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Father Name:		</td>
                <td colspan="4"> <input type="text" name="fathername" size="25" id="fathername" value="${studentUpdate.fatherName}"/></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Mother Name:		</td>
                <td colspan="4"> <input type="text" name="mothername" id="mothername" value="${studentUpdate.motherName}" size="25"/></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Sex:		</td>
                <td colspan="4"> <select name="sex">
                <c:choose>
                <c:when test="${studentUpdate.studentSex=='Male'}">
                <option value="${studentUpdate.studentSex}" selected="selected">${studentUpdate.studentSex}</option>
                <option value="Female">Female</option>
                </c:when>
                <c:otherwise>
                <option value="${studentUpdate.studentSex}" selected="selected">${studentUpdate.studentSex}</option>
                <option value="Male">Male</option>
                </c:otherwise>
                </c:choose>
                </select></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Student Birthdate:		</td>
                <td colspan="4"> <input type="text" name="birthdate" id="birthdate" value="${studentUpdate.studentBirthdate}" onFocus="displayCalendar(document.studentUpdate.birthdate,'yyyy-mm-dd',this)"  /></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Student Citizenship:		</td>
                <td colspan="4"> <input type="text" name="citizenship" id="citizenship" value="${studentUpdate.studentCitizenship}"/></td>
        </tr>
        <tr>
		<td colspan="2" style="padding-left:5px;">
			Resident District:		</td>
                <td> <select name="district" id="district" onChange="doRequestUsingGETDistrict(this.value) ;">
          <c:forEach items="${districts}" var="district" varStatus="optStatus">
          <c:choose>
				<c:when test="${dist==district.districtID}">
						
						<option value="${dist}" selected="selected">${district.districtName}</option>
					
				</c:when>
				<c:otherwise>
				
						<option value="${district.districtID}">${district.districtName}</option>
						
				</c:otherwise>
						
					</c:choose>	
					</c:forEach>
                  </select>               </td>
        </tr>
        <tr>
                <td colspan="2" style="padding-left:5px;">
			Resident Sector:                </td>
                <td>
                        <select name="sector" id="sector" >
                        <c:forEach items="${sectors}" var="sector" varStatus="optStatus">
                        <c:choose>
                        <c:when test="${sect==sector.sectorID}">
                        <option value="${sect }" selected="selected" >${sector.sectorName}</option>
                        </c:when>
                        <c:otherwise>
                        <option value="${sector.sectorID }">${sector.sectorName}</option>
                        </c:otherwise>
                        </c:choose>
                        </c:forEach>
      </select></td>
	</tr>
	<tr>
		
		<td colspan="2" style="padding-left:5px;">
			Resident Cellule:		</td>
                <td colspan="4"> <input type="text" name="cellule" id="cellule"  value="${studentUpdate.studentCellule}"/></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Resident Village:		</td>
                <td colspan="4"> <input type="text" name="village" id="village" value="${studentUpdate.studentVillage}"/></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Guardian Name:		</td>
                <td colspan="4"> <input type="text" name="guardianname" id="guardianname" value="${studentUpdate.guardianName}" size="25"/></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Guardian National ID:		</td>
                <td colspan="4"> <input type="text" name="guardiannatid" id="guardiannatid" value="${studentUpdate.studentGuardianID}"/></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Guardian Phone Number:		</td>
                <td colspan="4"> <input type="text" name="guardianphone" id="guardianphone" value="${studentUpdate.guardianPhoneNO}"/></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Guardian Relationship:		</td>
                <td colspan="4"> <select name="guardianrel" id="guardianrel">
                
                <c:if test="${studentUpdate.guardianRelationship!=''}">
                <option value="${studentUpdate.guardianRelationship}" >${studentUpdate.guardianRelationship}</option>
                </c:if>
                <option value="Father">Father</option>
                <option value="Mother">Mother</option>
                <option value="Uncle">Uncle</option>
                <option value="Aunt">Aunt</option>
                <option value="Sister">Sister</option>
                <option value="Brother">Brother</option>
                <option value="Grand Parent">Grand Parent</option>
                <option value="Other">Other</option>
                
                
                </select></td>
        </tr>
        
	<tr>
                <td colspan="2" style="padding-left:5px;" >
			Username:              </td>
                <td colspan="4" ><input type="hidden" name="username" value="${studentUpdate.studentUserName}"/>
                        <input type="text" name="username_yenyewe" value="${studentUpdate.studentUserName}" disabled="disabled" />
						</td>
	</tr>
	
	<tr>
                <td colspan="2">
			New Password:                </td>
                <td colspan="4" align="left">
                        <input  type="password" name="new_pass" value=""></td>
	</tr>
        <tr>
                <td colspan="2" >
                        Confirm New Password:                </td>
                <td colspan="4" >
                        <input  type="password" name="verify_pass" value="">                </td>
        </tr>
	
	<tr>
	  <td colspan="2">&nbsp;</td>
	  <td colspan="4">&nbsp;</td>
	  </tr>
	<tr><td colspan="6" align="center"><input name="StudentChange" type="submit" value="Save Changes" class="button" onMouseOver="return PassCheck(this.form);">&nbsp;&nbsp;||&nbsp;&nbsp;<a href="index.htm?mdl=personinfo&edit=all&sid" class="button" Style="color:#000000;">Cancel</a></td>
	</tr>
	</c:forEach>
  </table>    
</form></td>
</tr>	
<%	
}
if( request.getParameter("view").equals("all")){ %>
<tr>
    <td height="21" colspan="4" align="center">
	<div class="TabView" id="TabView">

<!-- *** Tabs ************************************************************** -->

<div class="Tabs" style="width: 700px;">

  <a>Personal Information</a>
  
</div>
<!-- *** Pages Student************************************************************* -->

<div class="Pages" style="width: 700px; height: 300px;">

  <div class="Page"> 
  <div class="Pad">

<!-- *** Page of personal infos Start *** -->
  <table width="675">
  <c:forEach items="${students}" var="student" varStatus="optStatus">
  <tr>
    <td style="vertical-align: top;">
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr><td >Registration Number:</td><td><b>${student.studentRegNO}</b></td></tr>
    <tr><td >Full Name:</td><td><b><c:out value="${student.studentLastName}"/> &nbsp;<c:out value="${student.studentFirstName}"/></b></td></tr>
     <tr><td >Sex:</td><td><b><c:out value="${student.studentSex}"/></b></td></tr>
      <tr><td >Birth Date:</td><td><b><c:out value="${student.studentBirthdate}"/></b></td></tr>
    <tr><td> Father's Name:</td><td><b><c:out value="${student.fatherName}"/></b></td></tr>
    <tr><td> Mothers's Name:</td><td><b><c:out value="${student.motherName}"/></b></td></tr>
     <tr><td> Citizenship:</td><td><b><c:out value="${student.studentCitizenship}"/></b></td></tr>
    <tr><td> District:</td><td><b><c:out value="${student.studentDistrict}"/></b></td></tr>
    <tr><td> Sector:</td><td><b><c:out value="${student.studentSector}"/></b></td></tr>
    <tr><td> Cellule:</td><td><b><c:out value="${student.studentCellule}"/></b></td></tr>
    <tr><td> Village:</td><td><b><c:out value="${student.studentVillage}"/></b></td></tr>
    <tr><td> Guardian Name:</td><td><b><c:out value="${student.guardianName}"/></b></td></tr>
     <tr><td> Guardian Relationship:</td><td><b><c:out value="${student.guardianRelationship}"/></b></td></tr>
      <tr><td> Guardian National ID:</td><td><b><c:out value="${student.studentGuardianID}"/></b></td></tr>
       <tr><td> Guardian Phone Number:</td><td><b><c:out value="${student.guardianPhoneNO}"/></b></td></tr>
        <tr><td> User Name:</td><td><b><c:out value="${student.studentUserName}"/></b></td></tr>
   
     </table>
  </td>
  </tr>
  </c:forEach>
</table>
  <!-- *** Page personal infos End ***** -->
</div>
</div>
 
 
 </div>
</div>
	</td>
    </tr>
 <%} %> 
</table></div>

<%}%>

</td></tr>
</table>

<script type="text/javascript">

tabview_initialize('TabView');

</script>
<%@ include file="/includes/footer.jsp"%>
