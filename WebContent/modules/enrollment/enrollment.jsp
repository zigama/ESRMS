<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/includes/header.jsp" %>
<script language="javascript">
function deroulement(selection,op,path){
	if(confirm("Are you sure you want to "+op+" ?"))
	window.location=path;
	}

//check form
function PassCheck(form1)
{
if(form1.regno.value=="")
{
alert("Get in the registration number please.");
form1.regno.focus();
return false;
}

else if(form1.classi.value=="")
{
alert("Specify a class please.");
form1.classi.focus();
return false;
}
else if(form1.department.value=="")
{
alert("Enter academic year.");
form1.department.focus();
return false;
}
else
{
form1.submit();
}
}

//end of checking the form

//User autocomplete
$().ready(function() {
function formatItem(row) {
		return "<tr><td width=90>" + row[0] + "</td><td width=90>" + row[1] + "</td><td width=90>" + row[2] + "</td><td width=90>" + row[3] + "</td><td width=90>" + row[4] + "</td></tr>";
	}
	function formatResult(row) {
		return row[0].replace(/(<.+?>)/gi, '');
	}

$("#regNO,#regno").autocomplete('search.student', {
		width: 600,
		multiple: false,
		matchContains: true,
		formatItem: formatItem,
		formatResult: formatResult
		});

}); // end of initialization
// fill student name for enrollment
var xmlHttp;
function createXMLHttpRequest() {
    if (window.ActiveXObject) {
        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    } 
    else if (window.XMLHttpRequest) {
        xmlHttp = new XMLHttpRequest();
    }
}
function showName(value)
{ 
	
createXMLHttpRequest();
queryString = "search.name" ;
queryString = queryString + "?regno="+value;

xmlHttp.onreadystatechange=stateChanged 

xmlHttp.open("GET", queryString, true);
xmlHttp.send(null);
}
function stateChanged(){

	if(xmlHttp.readyState == 4) {
        if(xmlHttp.status == 200) {
          parseName();
        }
    }
} 
function parseName(){

	 var responseText = document.createTextNode(xmlHttp.responseText);
     var returnElements=xmlHttp.responseText.split("||");

     

   //Process each of the elements 	
     for ( var i=0; i<returnElements.length; i++ ){
         
         if(returnElements[i]!="")
        {
         valueLabelPair = returnElements[i].split(";");
         document.getElementById("fullname").value= valueLabelPair[0];
         
         } 
    }
     
}

//end of enrollment name
//department auto fill

function showDepartment(value)
{ 
	
createXMLHttpRequest();
queryString = "search.department" ;
queryString = queryString + "?class="+value;

xmlHttp.onreadystatechange=departmentChanged 

xmlHttp.open("GET", queryString, true);
xmlHttp.send(null);
}
function departmentChanged(){

	if(xmlHttp.readyState == 4) {
        if(xmlHttp.status == 200) {
            
          parseDepartment();
        }
    }
} 
function parseDepartment(){

	 var responseText = document.createTextNode(xmlHttp.responseText);
     var returnElements=xmlHttp.responseText.split("||");

     

   //Process each of the elements 	
     for ( var i=0; i<returnElements.length; i++ ){
         
         if(returnElements[i]!="")
        {
         valueLabelPair = returnElements[i].split(";");
         document.getElementById("department").value= valueLabelPair[3]+"("+valueLabelPair[4]+")";
         
         
         } 
    }
     
}

//end ofdepartment auto fill

</script>

<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">

<tr><td>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
    <td width="4%" style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;border-left:#CCCCCC 1px solid; padding-left:10px;"><a href="index.htm?mdl=enrollment&edit=all&sid" class="Mod"><img src="./images/enrollment.png" border="0"></a></td>
    <td width="40%" height="50" style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;"><div align="left" class="ModName">Student Enrollments</div></td>
    <td width="30%" style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;" valign="middle" >
    <b><font color=#f38943><c:if test="${success!=''}"><script language="javascript">
	var success='${success}';
	if(success!=''){
    alert(success);
    }
    </script></c:if></font></b></td>
    <td width="14%"style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;"><div align="center"><form name="form1" action="enrollment?mdl=enrollment&edit=all&sid" method="POST" autocomplete="off"><table><tr><td>Student Reg.NO:</td><td><input type="text" name="filter_regNO" id="regNO"></td><td><input type="submit" value="Filtrer" name="FilterEnrollment" class="button"></td></tr></table> </form></div></td>
    <td width="6%" style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;"><div align="center"><a href="index.htm?mdl=enrollment&edit=new&sid" class="Mod"><img src="./images/new.png" border="0"><br>New</a></div></td>
	<td width="6%" style="border-bottom:#CCCCCC 1px solid;border-right:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;"><div align="center"><a href="index.htm?mdl=Logged&sid" class="Mod"><img src="./images/cancel.png" border="0"><br>Close</a></div></td>
  </tr>
</table>
</td></tr>
<tr><td style="padding-top:2px;">
<%
if(request.getParameter("edit").equals("all")){%>
<div align="center"><table border="0" width="100%" class="listingTable">
<tr>
<th>Full Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
<th>Registration Number</th>
<th>Class &nbsp;&nbsp;&nbsp;&nbsp;</th>
<th>Department</th>
<th>Academic Year</th>

<th colspan='2' scope='col'>Options</th>
</tr>
<c:forEach items="${enrollments}" var="enrollment" varStatus="optStatus">

<tr class="even">
<td><c:out value="${enrollment.fullname}"/> </td>
<td><c:out value="${enrollment.regNO}"/></td>
<td><c:out value="${enrollment.classCode}"/></td>
<td><c:out value="${enrollment.department}"/></td>
<td><c:out value="${enrollment.yearName}"/></td>

<td align="center"><a href="index.htm?mdl=enrollment&edit=UseProfile&enrollment=${enrollment.enrollmentID}&sid"><img border="0" src="images/edit.png"></a></td>
<td align="center"><a href='#' onClick="deroulement(this,'delete','enrollment?mdl=enrollment&edit=all&UseDelete=${enrollment.enrollmentID}&sid')"><img border="0" src="images/drop.png"></a></td>
</tr>
		</c:forEach>
<tr>
    <td align="center" colspan="7" style="border-top:#CCCCCC 1px dotted;">
    
    
    <c:choose>
    <c:when test="${pagenum==1}">
    	
    	</c:when>
    	<c:otherwise><a href="index.htm?mdl=enrollment&edit=all&pagenum=1&sid"><img border="0" src="images/start.png"></a>
    	<a href="index.htm?mdl=enrollment&edit=all&pagenum=${pagenum-1}&sid"><img border="0" src="images/prev.png"></a></c:otherwise>
    </c:choose>
    &nbsp;&nbsp;Page <strong>${pagenum }</strong> of ${ lastpage}&nbsp;&nbsp;
    <c:choose>
    <c:when test="${pagenum==lastpage}">
    	
    	</c:when>
    	<c:otherwise><a href="index.htm?mdl=enrollment&edit=all&pagenum=${pagenum+1}&sid"><img border="0" src="images/next.png"></a>
    	<a href="index.htm?mdl=enrollment&edit=all&pagenum=${lastpage}&sid"><img border="0" src="images/end.png"></a></c:otherwise>
    </c:choose>
    </td></tr>		
</table></div>

<%}%>
<% if( request.getParameter("edit").equals("new")){ %>
<form name="newEnrollment" action="enrollment?mdl=enrollment&edit=all&sid" method="POST" autocomplete="off">
	<table border=0 width="500" cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFCCC" style="border:groove #FFFCCC 2px;">
	<tr><td colspan="6" align="center" height="30" bgcolor="#FFEECC"><strong>New Student Enrollment</strong></td>
	</tr>
	<tr>
		
		<td colspan="2" style="padding-left:5px;">
			Registration Number:		</td>
                <td colspan="4"> <input type="text" name="regno" id="regno" onBlur="showName(this.value);"/></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Student Full Name:		</td>
                <td colspan="4"> <input type="text" name="fullname" id="fullname" size="30" /></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Academic Year:		</td>
                <td colspan="4"> <select name="yearname" id="yearname">
                <option value="${curryear}" selected="selected">${curryear}</option>
                </select></td>
        </tr>
        
	<tr>
		
		<td colspan="2" style="padding-left:5px;">
			Class:		</td>
                <td colspan="4"> <select name="classi" id="classi" onChange="showDepartment(this.value);">
          <option >Select Class</option>
						
						<c:forEach items="${classes}" var="class" varStatus="optStatus">
						<option value="${class.classCode}">${class.classCode}</option>
						</c:forEach>
						
                  </select> </td>
        </tr>
        
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Department:		</td>
                <td colspan="4"> <input type="text" name="department" id="department" size="30"/></td>
        </tr>
        <tr>
        
	  <td colspan="2">&nbsp;</td>
	  <td colspan="4">&nbsp;</td>
	  </tr>
	<tr><td colspan="6" align="center"><input name="NewEnrollment" type="button" value="Enroll Now" class="button" onClick="return PassCheck(this.form);">&nbsp;&nbsp;||&nbsp;&nbsp;<input name="rst" type="reset" value="Reset" class="button"></td>
	</tr>
  </table>    
</form><%

} %>
<%
if(request.getParameter("edit").equals("UseProfile")){
%>
<form name="enrollmentUpdate" action="enrollment?mdl=enrollment&edit=all&sid" method="POST" >
	<table border=0 width="500" cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFCCC" style="border:groove #FFFCCC 2px;">
	<tr><td colspan="6" align="center" height="30" bgcolor="#FFEECC"><strong>Edit Student Enrollment</strong></td>
	</tr>
	
	<c:forEach items="${enrollmentToUpdate}" var="enrollmentUpdate" varStatus="optStatus">
	<tr>
		
		<td colspan="2" style="padding-left:5px;">
			Registration Number:		</td>
                <td colspan="4"> <input type="hidden" name="enrollmentid" value="${enrollmentUpdate.enrollmentID}" /><input type="hidden" name="regno" id="regno" value="${enrollmentUpdate.regNO}"/><input type="text" name="regno_yenyewe" id="regno_yenyewe" value="${enrollmentUpdate.regNO}" disabled="disabled"/></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Student Full Name:		</td>
                <td colspan="4"> <input type="text" name="fullname" id="fullname" size="30" value="${enrollmentUpdate.fullname}"/></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Academic Year:		</td>
                <td colspan="4"> <input type="hidden" name="yearname" id="yearname" size="30" value="${enrollmentUpdate.yearName}"/><input type="text" name="yearname_yenyewe" id="yearname_yenyewe" size="30" value="${enrollmentUpdate.yearName}" disabled="disabled"/></td>
        </tr>
	<tr>
		
		<td colspan="2" style="padding-left:5px;">
			Class:		</td>
                <td colspan="4"> <select name="class"  onChange="showDepartment(this.value);">
          
						<c:forEach items="${classes}" var="class" varStatus="optStatus">
						<c:choose>
				<c:when test="${enrollmentUpdate.classCode==class.classCode}">
						
						<option value="${class.classCode}" selected="selected">${enrollmentUpdate.classCode }</option>
				</c:when>
				<c:otherwise>
				
						<option value="${class.classCode}">${class.classCode}</option>
						
				</c:otherwise>
						
					</c:choose>	
						
						</c:forEach>
						
                  </select> </td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Department:		</td>
                <td colspan="4"> <input type="text" name="department" id="department"  size="30" value="${enrollmentUpdate.department}"/></td>
        </tr>
	   <tr>
	  <td colspan="2">&nbsp;</td>
	  <td colspan="4">&nbsp;</td>
	  </tr>
	<tr><td colspan="6" align="center"><input name="EnrollmentChange" type="submit" value="Save Changes" class="button">&nbsp;&nbsp;||&nbsp;&nbsp;<a href="index.htm?mdl=enrollment&edit=all&sid" class="button" Style="color:#000000;">Cancel</a></td>
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