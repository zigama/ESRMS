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
if(form1.enrollment.value=="")
{
alert("Get in the registration number and academic year please.");
form1.enrollment.focus();
return false;
}else if(form1.sessions.value==""){
	alert("Get in the sessionplease.");
	form1.sessions.focus();
	return false;
	
}else if(form1.course.value==""){
	alert("Get in the course please.");
	form1.course.focus();
	return false;
	
}else if(form1.abscence.value=="" || isNaN(Number(form1.abscence.value))){
	alert("Get in the abscence please.");
	form1.abscence.focus();
	return false;
	
}else if(form1.maxattendance.value=="" || isNaN(Number(form1.maxattendance.value))){
	alert("Get in the max attendance please.");
	form1.maxattendance.focus();
	return false;
	
}else if(Number(form1.abscence.value)>Number(form1.maxattendance.value)){
	
	alert("Your abscence exceed the max attendance please.");
	
	form1.abscence.focus();
	return false;
}else
{
form1.submit();
}
}

//end of checking the form
//validate numbers
	function isInteger(s)
	{
	      var i;
		s = s.toString();
	      for (i = 0; i < s.length; i++)
	      {
	         var c = s.charAt(i);
	         if (isNaN(c)) 
		   {
			alert("Given value is not a number");
			return false;
		   }
	      }
	      return true;
	}
	//end of validate numbers
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
// fill student name for attendance
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

//end of attendance name
//department auto fill

function showEnrollment(value1,value2)
{ 
	
createXMLHttpRequest();
queryString = "search.enrollment" ;
queryString = queryString + "?year="+value1+"&regno="+value2;
//alert(queryString);
xmlHttp.onreadystatechange=enrollmentChanged 

xmlHttp.open("GET", queryString, true);
xmlHttp.send(null);
}
function enrollmentChanged(){

	if(xmlHttp.readyState == 4) {
        if(xmlHttp.status == 200) {
            
          parseEnrollment();
        }
    }
} 
function parseEnrollment(){

	 var responseText = document.createTextNode(xmlHttp.responseText);
     var returnElements=xmlHttp.responseText.split("||");

     

   //Process each of the elements 	
     for ( var i=0; i<returnElements.length; i++ ){
         
         if(returnElements[i]!="")
        {
         valueLabelPair = returnElements[i].split(";");
         document.getElementById("enrollment").value= valueLabelPair[0];
         document.getElementById("classi").value= valueLabelPair[2];
         document.getElementById("department").value= valueLabelPair[4];
         
         
         } 
    }
     
}

//end ofdepartment auto fill

</script>

<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">

<tr><td>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
    <td width="4%" style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;border-left:#CCCCCC 1px solid; padding-left:10px;"><a href="index.htm?mdl=attendance&edit=all&sid" class="Mod"><img src="./images/attendance.png" border="0"></a></td>
    <td width="40%" height="50" style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;"><div align="left" class="ModName">Student attendances</div></td>
    <td width="30%" style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;" valign="middle" >
    <b><font color=#f38943><c:if test="${success!=''}"><script language="javascript">
	var success='${success}';
	if(success!=''){
    alert(success);
    }
    </script></c:if></font></b></td>
    <td width="14%"style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;"><div align="center"><form name="form1" action="attendance?mdl=attendance&edit=all&sid" method="POST" autocomplete="off"><table><tr><td>Student Reg.NO:</td><td><input type="text" name="filter_regNO" id="regNO"></td><td><input type="submit" value="Filtrer" name="FilterAttendance" class="button"></td></tr></table> </form></div></td>
    <td width="6%" style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;"><div align="center"><a href="index.htm?mdl=attendance&edit=new&sid" class="Mod"><img src="./images/new.png" border="0"><br>New</a></div></td>
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
<th>Course</th>
<th>Absences(min)</th>
<th>Excused Absence(min)</th>
<th>Max Attendance(min)</th>
<th>Session</th>
<th>Academic Year</th>

<th colspan='2' scope='col'>Options</th>
</tr>
<c:forEach items="${attendances}" var="attendance" varStatus="optStatus">

<tr class="even">
<td><c:out value="${attendance.fullname}"/> </td>
<td><c:out value="${attendance.regNO}"/></td>
<td><c:out value="${attendance.classCode}"/></td>
<td><c:out value="${attendance.department}"/></td>
<td><c:out value="${attendance.course}"/></td>
<td><c:out value="${attendance.abscences}"/></td>
<td><c:out value="${attendance.execusedAbscences}"/></td>
<td><c:out value="${attendance.maxAttendance}"/></td>
<td><c:out value="${attendance.session}"/></td>
<td><c:out value="${attendance.yearName}"/></td>

<td align="center"><a href="index.htm?mdl=attendance&edit=UseProfile&attendance=${attendance.attendanceID}&sid"><img border="0" src="images/edit.png"></a></td>
<td align="center"><a href='#' onClick="deroulement(this,'delete','attendance?mdl=attendance&edit=all&UseDelete=${attendance.attendanceID}&sid')"><img border="0" src="images/drop.png"></a></td>
</tr>
		</c:forEach>
<tr>
    <td align="center" colspan="12" style="border-top:#CCCCCC 1px dotted;">
    
    
    <c:choose>
    <c:when test="${pagenum==1}">
    	
    	</c:when>
    	<c:otherwise><a href="index.htm?mdl=attendance&edit=all&pagenum=1&sid"><img border="0" src="images/start.png"></a>
    	<a href="index.htm?mdl=attendance&edit=all&pagenum=${pagenum-1}&sid"><img border="0" src="images/prev.png"></a></c:otherwise>
    </c:choose>
    &nbsp;&nbsp;Page <strong>${pagenum }</strong> of ${ lastpage}&nbsp;&nbsp;
    <c:choose>
    <c:when test="${pagenum==lastpage}">
    	
    	</c:when>
    	<c:otherwise><a href="index.htm?mdl=attendance&edit=all&pagenum=${pagenum+1}&sid"><img border="0" src="images/next.png"></a>
    	<a href="index.htm?mdl=attendance&edit=all&pagenum=${lastpage}&sid"><img border="0" src="images/end.png"></a></c:otherwise>
    </c:choose>
    </td></tr>		
</table></div>

<%}%>
<% if( request.getParameter("edit").equals("new")){ %>
<form name="newattendance" action="attendance?mdl=attendance&edit=all&sid" method="POST" autocomplete="off">
	<table border=0 width="500" cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFCCC" style="border:groove #FFFCCC 2px;">
	<tr><td colspan="6" align="center" height="30" bgcolor="#FFEECC"><strong>New Student attendance</strong></td>
	</tr>
	<tr>
		
		<td colspan="2" style="padding-left:5px;">
			Registration Number:		</td>
                <td colspan="4"><input type="hidden" name="enrollment" id="enrollment" > <input type="text" name="regno" id="regno" onBlur="showName(this.value);"/></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Student Full Name:		</td>
                <td colspan="4"> <input type="text" name="fullname" id="fullname" size="30" /></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Academic Year:		</td>
                <td colspan="4"> <select name="yearname" id="yearname" onChange="showEnrollment(this.value,document.newattendance.regno.value);">
                <option selected="selected">Select Academic Year</option>
                <c:forEach items="${years}" var="year" varStatus="optStatus">
                <option value="${year.yearName}" >${year.yearName}</option>
                </c:forEach>
                </select></td>
        </tr>
        
	<tr>
		
		<td colspan="2" style="padding-left:5px;">
			Class:		</td>
                <td colspan="4"> <input type="text" name="classi" id="classi" > </td>
        </tr>
        
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Department:		</td>
                <td colspan="4"> <input type="text" name="department" id="department" size="30"/></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Session:		</td>
                <td colspan="4"> <select name="sessions" id="sessions" >
                <option selected="selected">Select Session...</option>
                <c:forEach items="${sessions}" var="session" varStatus="optStatus">
                <option value="${session.sessionID}">${session.sessionName}</option>
                </c:forEach>
                </select></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Course:		</td>
                <td colspan="4"> <select name="course" id="course" >
                <option  selected="selected">Select Course...</option>
                <c:forEach items="${courses}" var="course" varStatus="optStatus">
                <option value="${course.courseID}">${course.courseName}</option>
                </c:forEach>
                </select></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Absences(minutes):		</td>
                <td colspan="4"> <input type="text" name="abscence" id="abscence" size="30" onKeyUp="isInteger(this.value);"/></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
				</td>
                <td colspan="4"> <input name="execused" type="checkbox" value="execused">Excused Absence</td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Max Attendance(minutes):		</td>
                <td colspan="4"> <input type="text" name="maxattendance" id="maxattendance" size="30" onKeyUp="isInteger(this.value);"/></td>
        </tr>
        <tr>
        
	  <td colspan="2">&nbsp;</td>
	  <td colspan="4">&nbsp;</td>
	  </tr>
	<tr><td colspan="6" align="center"><input name="NewAttendance" type="button" value="Register Now" class="button" onClick="return PassCheck(this.form);">&nbsp;&nbsp;||&nbsp;&nbsp;<input name="rst" type="reset" value="Reset" class="button"></td>
	</tr>
  </table>    
</form><%

} %>
<%
if(request.getParameter("edit").equals("UseProfile")){
%>
<form name="attendanceUpdate" action="attendance?mdl=attendance&edit=all&sid" method="POST" >
	<table border=0 width="500" cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFCCC" style="border:groove #FFFCCC 2px;">
	<tr><td colspan="6" align="center" height="30" bgcolor="#FFEECC"><strong>Edit Student Attendance</strong></td>
	</tr>
	
	<c:forEach items="${attendanceToUpdate}" var="attendanceUpdate" varStatus="optStatus">
	<tr>
		
		<td colspan="2" style="padding-left:5px;">
			Registration Number:		</td>
                <td colspan="4"><input type="hidden" name="attendanceid" id="attendanceid"  value="${attendanceUpdate.attendanceID }"><input type="hidden" name="enrollment" id="enrollment"  value="${attendanceUpdate.enrollmentID }" disabled="disabled"> <input type="text" name="regno" id="regno" value="${attendanceUpdate.regNO }" disabled="disabled"/></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Student Full Name:		</td>
                <td colspan="4"> <input type="text" name="fullname" id="fullname" size="30" value="${attendanceUpdate.fullname }" disabled="disabled"/></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Academic Year:		</td>
                <td colspan="4"> <input type="text" name="yearname" id="yearname" value="${attendanceUpdate.yearName }" disabled="disabled"/></td>
        </tr>
        
	<tr>
		
		<td colspan="2" style="padding-left:5px;">
			Class:		</td>
                <td colspan="4"> <input type="text" name="classi" id="classi" value="${attendanceUpdate.classCode }" disabled="disabled"> </td>
        </tr>
        
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Department:		</td>
                <td colspan="4"> <input type="text" name="department" id="department" size="30" value="${attendanceUpdate.department }" disabled="disabled"/></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Session:		</td>
                <td colspan="4"> <select name="sessions" id="sessions" >
                
                <c:forEach items="${sessions}" var="session" varStatus="optStatus">
                <c:choose>
                <c:when test="${attendanceUpdate.session==session.sessionID}">
                <option value="${attendanceUpdate.session}" selected="selected">${session.sessionName}</option>
                </c:when>
                <c:otherwise>
                <option value="${session.sessionID}">${session.sessionName}</option>
                </c:otherwise>
                </c:choose>
                
                </c:forEach>
                </select></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Course:		</td>
                <td colspan="4"> <select name="course" id="course" >
                
                <c:forEach items="${courses}" var="course" varStatus="optStatus">
                <c:choose>
                <c:when test="${attendanceUpdate.course==course.courseID}">
                <option value="${attendanceUpdate.course}" selected="selected">${course.courseName}</option>
                </c:when>
                <c:otherwise>
                <option value="${course.courseID}">${course.courseName}</option>
                </c:otherwise>
                </c:choose>
                </c:forEach>
                </select></td>
        </tr>
         <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Abcsences(minutes):		</td>
                <td colspan="4"> <input type="text" name="abscence" id="abscence" size="30" value="${attendanceUpdate.abscences }" onKeyUp="isInteger(this.value);"/></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
				Execused Abscences(minutes):</td>
                <td colspan="4"> <input name="execusedabscence" type="text" id="execusedabscence" value="${attendanceUpdate.execusedAbscences}" onKeyUp="isInteger(this.value);"></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Max Attendance(minutes):		</td>
                <td colspan="4"> <input type="text" name="maxattendance" id="maxattendance" size="30" value="${attendanceUpdate.maxAttendance }" onKeyUp="isInteger(this.value);"/></td>
        </tr>
        
    	   <tr>
	  <td colspan="2">&nbsp;</td>
	  <td colspan="4">&nbsp;</td>
	  </tr>
	<tr><td colspan="6" align="center"><input name="AttendanceChange" type="submit" value="Save Changes" class="button">&nbsp;&nbsp;||&nbsp;&nbsp;<a href="index.htm?mdl=attendance&edit=all&sid" class="button" Style="color:#000000;">Cancel</a></td>
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