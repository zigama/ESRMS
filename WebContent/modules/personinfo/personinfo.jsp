<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/includes/header.jsp" %>
<script language="javascript">
function deroulement(selection,op,path){
	if(confirm("Are you sure you want to "+op+" ?"))
	window.location=path;
	}
function PassCheck(form1)
{
if(form1.firstname.value==""){
	alert("Get in the first name please.");
	form1.firstname.focus();
	return false;
	
}else if(form1.lastname.value==""){

	alert("Get in the last name please.");
	form1.lastname.focus();
	return false;
	
	
}else if(form1.birthdate.value==""){

	alert("Get in the birthdate please.");
	form1.birthdate.focus();
	return false;
	
	
}else if(form1.fathername.value==""){

	alert("Get in the father name please.");
	form1.fathername.focus();
	return false;
	
	
}else if(form1.mothername.value==""){

	alert("Get in the mother name please.");
	form1.mothername.focus();
	return false;
	
	
}else if(form1.village.value==""){

	alert("Get in the village please.");
	form1.village.focus();
	return false;
	
	
}else if(form1.district.value==""){

	alert("Get in the district please.");
	form1.district.focus();
	return false;
	
	
}else if(form1.sector.value==""){

	alert("Get in the sector please.");
	form1.sector.focus();
	return false;
	
	
}else if(form1.cellule.value==""){

	alert("Get in the cellule please.");
	form1.cellule.focus();
	return false;
	
	
}else if(form1.guardianname.value==""){

	alert("Get in the guardian name please.");
	form1.guardianname.focus();
	return false;
	
	
}else if(form1.guardiannatid.value==""){

	alert("Get in the guardian national id please.");
	form1.guardiannatid.focus();
	return false;
	
	
}else if(form1.guardianphone.value==""){

	alert("Get in the guardian phone number please.");
	form1.guardianphone.focus();
	return false;
	
	
}else if(form1.citizenship.value==""){

	alert("Get in the citizenship please.");
	form1.citizenship.focus();
	return false;
	
	
}else if(form1.guardianrel.value==""){

	alert("Get in the guardian relationship please.");
	form1.guardianrel.focus();
	return false;
	
	
}else if(form1.sex.value==""){

	alert("Get in the sex please.");
	form1.sex.focus();
	return false;
	
	
}else if(form1.username.value=="")
{
alert("Get in the username please.");
form1.username.focus();
return false;
}
else if((form1.new_pass.value=="")&&(form1.verify_pass.value==""))
{
alert("Cannot save empty fields.");
form1.new_pass.focus();
return false;
}
else if(form1.new_pass.value=="")
{
alert("Specify a password please.");
form1.new_pass.focus();
return false;
}
else if(form1.verify_pass.value=="")
{
alert("Confirm your new password.");
form1.verify_pass.focus();
return false;
}
else if((form1.new_pass.value)!=(form1.verify_pass.value))
{
alert("Passwod missmatch.");
form1.new_pass.focus();
return false;
}
else
{
form1.submit();
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

$("#regNO").autocomplete('search.student', {
		width: 600,
		multiple: false,
		matchContains: true,
		formatItem: formatItem,
		formatResult: formatResult
		});

}); // end of initialization

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
    <td width="4%" style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;border-left:#CCCCCC 1px solid; padding-left:10px;"><a href="index.htm?mdl=personinfo&edit=all&sid" class="Mod"><img src="./images/student.png" border="0"></a></td>
    <td width="40%" height="50" style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;"><div align="left" class="ModName">Student Personal Infos</div></td>
    <td width="30%" style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;" valign="middle" >
    <b><font color=#f38943>
    <c:if test="${success!=''}"><script language="javascript">
	var success='${success}';
	if(success!=''){
    alert(success);
    }
    </script></c:if>  </font></b></td>
    <td width="14%"style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;"><div align="center"><form name="form1" action="personinfo?mdl=personinfo&edit=all&sid" method="POST" autocomplete="off"><table><tr><td>Student Reg.NO:</td><td><input type="text" name="filter_regNO" id="regNO"></td><td><input type="submit" value="Filtrer" name="FilterStudent" class="button"></td></tr></table> </form></div></td>
    <td width="6%" style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;"><div align="center"><a href="index.htm?mdl=personinfo&edit=new&sid" class="Mod"><img src="./images/new.png" border="0"><br>New</a></div></td>
	<td width="6%" style="border-bottom:#CCCCCC 1px solid;border-right:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;"><div align="center"><a href="index.htm?mdl=Logged&sid" class="Mod"><img src="./images/cancel.png" border="0"><br>Close</a></div></td>
  </tr>
</table>
</td></tr>
<tr><td style="padding-top:2px;">
<%
if(request.getParameter("edit").equals("all")){%>
<div align="center"><table border="0" width="100%" class="listingTable">
<tr>
<th>Name</th>
<th>Registration NO</th>
<th>Father's Name</th>
<th>Mother's Name</th>
<th>Sex</th>
<th>Birthdate</th>
<th>Citizenship</th>
<th>Residence</th>
<th>Guardian(Relationship, National ID)</th>
<th>Guardian PhoneNO</th>
<th>Username</th>

<th colspan='2' scope='col'>Options</th>
</tr>
<c:forEach items="${students}" var="student" varStatus="optStatus">

<tr class="even">
<td><c:out value="${student.studentLastName}"/> &nbsp;<c:out value="${student.studentFirstName}"/></td>
<td><c:out value="${student.studentRegNO}"/></td>
<td><c:out value="${student.fatherName}"/></td>
<td><c:out value="${student.motherName}"/></td>
<td><c:out value="${student.studentSex}"/></td>
<td><c:out value="${student.studentBirthdate}"/></td>
<td><c:out value="${student.studentCitizenship}"/></td>
<td><c:out value="${student.studentDistrict}"/> ,&nbsp;<c:out value="${student.studentSector}"/>,&nbsp;<c:out value="${student.studentCellule}"/>,&nbsp;<c:out value="${student.studentVillage}"/></td>
<td><c:out value="${student.guardianName}"/>&nbsp;(${student.guardianRelationship},&nbsp;${student.studentGuardianID})</td>
<td><c:out value="${student.guardianPhoneNO}"/></td>
<td><c:out value="${student.studentUserName}"/></td>

<td align="center"><a href="index.htm?mdl=personinfo&edit=UseProfile&student=${student.studentRegNO}&sid"><img border="0" src="images/edit.png"></a></td>
<td align="center"><a href='#' onClick="deroulement(this,'delete','personinfo?mdl=personinfo&edit=all&UseDelete=${student.studentRegNO}&sid')"><img border="0" src="images/drop.png"></a></td>
</tr>
		</c:forEach>
<tr>
    <td align="center" colspan="13" style="border-top:#CCCCCC 1px dotted;">
    
    
    <c:choose>
    <c:when test="${pagenum==1}">
    	
    	</c:when>
    	<c:otherwise><a href="index.htm?mdl=personinfo&edit=all&pagenum=1&sid"><img border="0" src="images/start.png"></a>
    	<a href="index.htm?mdl=personinfo&edit=all&pagenum=${pagenum-1}&sid"><img border="0" src="images/prev.png"></a></c:otherwise>
    </c:choose>
    &nbsp;&nbsp;Page <strong>${pagenum }</strong> of ${ lastpage}&nbsp;&nbsp;
    <c:choose>
    <c:when test="${pagenum==lastpage}">
    	
    	</c:when>
    	<c:otherwise><a href="index.htm?mdl=personinfo&edit=all&pagenum=${pagenum+1}&sid"><img border="0" src="images/next.png"></a>
    	<a href="index.htm?mdl=personinfo&edit=all&pagenum=${lastpage}&sid"><img border="0" src="images/end.png"></a></c:otherwise>
    </c:choose>
    </td></tr>		
</table></div>

<%}%>
<% if( request.getParameter("edit").equals("new")){ %>
<form name="newStudent" action="personinfo?mdl=personinfo&edit=all&sid" method="POST" autocomplete="off">
	<table border=0 width="500" cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFCCC" style="border:groove #FFFCCC 2px;">
	<tr><td colspan="6" align="center" height="30" bgcolor="#FFEECC"><strong>New Student Infos</strong></td>
	</tr>
	<tr>
		
		<td colspan="2" style="padding-left:5px;">
			First Name:		</td>
                <td colspan="4"> <input type="text" name="firstname" id="firstname" /></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Last Name:		</td>
                <td colspan="4"> <input type="text" name="lastname" id="lastname" /></td>
        </tr>
	<tr>
		
		<td colspan="2" style="padding-left:5px;">
			Registration Number:		</td>
                <td colspan="4"> <input type="hidden" name="regno" id="regno" value="${newRegNO}" >
                <input type="text" name="regno_yenyewe" value="${newRegNO }" disabled="disabled"></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Father Name:		</td>
                <td colspan="4"> <input type="text" name="fathername" id="fathername" /></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Mother Name:		</td>
                <td colspan="4"> <input type="text" name="mothername" id="mothername" /></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Sex:		</td>
                <td colspan="4"> <select name="sex">
                <option>select...</option>
                <option value="Male">Male</option>
                <option value="Female">Female</option>
                </select></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Student Birthdate:		</td>
                <td colspan="4"> <input type="text" name="birthdate" id="birthdate"  onFocus="displayCalendar(document.newStudent.birthdate,'yyyy-mm-dd',this)"  /></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Student Citizenship:		</td>
                <td colspan="4"> <input type="text" name="citizenship" id="citizenship" /></td>
        </tr>
        <tr>
		<td colspan="2" style="padding-left:5px;">
			Resident District:		</td>
                <td> <select name="district" id="district" onChange="doRequestUsingGETDistrict(this.value) ;">
          <option >Select District</option>
						
						<c:forEach items="${districts}" var="district" varStatus="optStatus">
						<option value="${district.districtID}">${district.districtName}</option>
						</c:forEach>
						
                  </select>               </td>
        </tr>
        <tr>
                <td colspan="2" style="padding-left:5px;">
			Resident Sector:                </td>
                <td>
                        <select name="sector" id="sector" >
                        <option selected="selected" >Select Sector</option>
      </select></td>
	</tr>
	<tr>
		
		<td colspan="2" style="padding-left:5px;">
			Resident Cellule:		</td>
                <td colspan="4"> <input type="text" name="cellule" id="cellule"  /></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Resident Village:		</td>
                <td colspan="4"> <input type="text" name="village" id="village" /></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Guardian Name:		</td>
                <td colspan="4"> <input type="text" name="guardianname" id="guardianname" /></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Guardian National ID:		</td>
                <td colspan="4"> <input type="text" name="guardiannatid" id="guardiannatid" /></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Guardian Phone Number:		</td>
                <td colspan="4"> <input type="text" name="guardianphone" id="guardianphone" /></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Guardian Relationship:		</td>
                <td colspan="4"> <select name="guardianrel" id="guardianrel">
                <option >select....</option>
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
		<td colspan="2" style="padding-left:5px;">
			Username:		</td>
                <td colspan="4">
			<input type="hidden" name="username" id="username" value="${newRegNO }"><input type="text" name="username_yenyewe"  value="${newRegNO }" disabled="disabled"></td>
        </tr>
                
                <tr>
                <td colspan="2" style="padding-left:5px;">
			Password:                </td>
                <td colspan="4" align="left">
                        <input  type="hidden" name="new_pass" value="${newRegNO }" > <input  type="password" name="new_pass_yenyewe" value="${newRegNO }" disabled="disabled"></td>
	</tr>
        <tr>
                <td colspan="2" style="padding-left:5px;" >
                        Confirm Password:                </td>
                <td colspan="4" >
                        <input  type="hidden" name="verify_pass" value="${newRegNO }" >    <input  type="password" name="verify_pass_yenyewe" value="${newRegNO }" disabled="disabled">             </td>
        </tr>
	
	<tr>
	  <td colspan="2">&nbsp;</td>
	  <td colspan="4">&nbsp;</td>
	  </tr>
	<tr><td colspan="6" align="center"><input name="NewStudent" type="button" value="Register Now" class="button" onClick="return PassCheck(this.form);">&nbsp;&nbsp;||&nbsp;&nbsp;<input name="rst" type="reset" value="Reset" class="button"></td>
	</tr>
  </table>    
</form><%

} %>
<%
if(request.getParameter("edit").equals("UseProfile")){
%>
<form name="studentUpdate" action="personinfo?mdl=personinfo&edit=all&sid" method="POST" >
	<table border=0 width="500" cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFCCC" style="border:groove #FFFCCC 2px;">
	<tr><td colspan="6" align="center" height="30" bgcolor="#FFEECC"><strong>Edit Student Infos</strong></td>
	</tr>
	
	<c:forEach items="${studentToUpdate}" var="studentUpdate" varStatus="optStatus">
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
				<c:when test="${studentUpdate.studentDistrict==district.districtID}">
						
						<option value="${studentUpdate.studentDistrict}" selected="selected">${district.districtName}</option>
					
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
                        <c:when test="${studentUpdate.studentSector==sector.sectorID}">
                        <option value="${studentUpdate.studentSector }" selected="selected" >${sector.sectorName}</option>
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
                <td colspan="4" >
                        <input type="text" name="username" value="${studentUpdate.studentUserName}" disabled="disabled" />
						</td>
	</tr>
	
	<tr>
	  <td colspan="2">&nbsp;</td>
	  <td colspan="4">&nbsp;</td>
	  </tr>
	<tr><td colspan="6" align="center"><input name="StudentChange" type="submit" value="Save Changes" class="button">&nbsp;&nbsp;||&nbsp;&nbsp;<a href="index.htm?mdl=personinfo&edit=all&sid" class="button" Style="color:#000000;">Cancel</a></td>
	</tr>
	</c:forEach>
  </table>    
</form>
	
<%	
}
%>
</td></tr>

</table>


<%@ include file="/includes/footer.jsp"%>