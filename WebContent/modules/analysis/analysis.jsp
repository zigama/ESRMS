<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/includes/header.jsp" %>
<script language="javascript">
function deroulement(selection,op,path){
	if(confirm("Are you sure you want to "+op+" ?"))
	window.location=path;
	}
function PassCheck(form1)
{
if(form1.regno.value=="")
{
alert("Error occured please contact the school!.");
window.location.href="http://localhost:8080/ESRMS/";
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

	$("#regno").autocomplete('search.student', {
		width: 600,
		multiple: false,
		matchContains: true,
		formatItem: formatItem,
		formatResult: formatResult
		});

}); // end of initialization
</script>

<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">

<tr><td>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
    <td width="4%" style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;border-left:#CCCCCC 1px solid; padding-left:10px;"><a href="index.htm?mdl=analysis&edit=all&sid" class="Mod"><img src="./images/monitor.jpg" border="0"></a></td>
    <td width="60%" height="50" style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;"><div align="left" class="ModName">Student performance and developmental progress</div></td>
    <td width="30%" style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;" valign="middle" >
    <b><font color=#f38943><c:if test="${success!=''}"><script language="javascript">
	var success='${success}';
	if(success!=''){
    alert(success);
    }
    </script></c:if></font></b></td>
    
   
	<td width="6%" style="border-bottom:#CCCCCC 1px solid;border-right:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;"><div align="center"><a href="index.htm?mdl=Logged&sid" class="Mod"><img src="./images/cancel.png" border="0"><br>Close</a></div></td>
  </tr>
</table>
</td></tr>
<tr><td style="padding-top:2px;">
<%
if(request.getParameter("mdl").equals("analysis")){%>
<div align="center"><table border="0" width="100%" class="listingTable">
<tr><td>
<form name="form1" action="index.htm?mdl=analysis&view=all&sid" method="POST" autocomplete="off">
	<table border=0 width="500" cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFCCC" style="border:groove #FFFCCC 2px;">
	<tr><td colspan="6" align="center" height="30" bgcolor="#FFEECC"><strong>Specify a period</strong></td>
	</tr>
	        
	<tr><td colspan="2" style="padding-left:5px;">
			Registration Number:		</td><td><input type="text" name="regno" id="regno" value="" /></td></tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Academic Year:		</td>
                <td colspan="4">  <select name="yearname" id="yearname" >
                <option selected="selected">Select Academic Year...</option>
                <c:forEach items="${years}" var="year" varStatus="optStatus">
                <option value="${year.yearName}" >${year.yearName}</option>
                </c:forEach>
                </select></td>
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
    
	<tr><td colspan="6" align="center"><input name="ViewProgress" type="button" value="Show Now" class="button" onClick="return PassCheck(this.form);">&nbsp;&nbsp;||&nbsp;&nbsp;<input name="rst" type="reset" value="Reset" class="button"></td>
	</tr>
  </table>    
</form></td>
</tr>
<%if( request.getParameter("view").equals("all")){ %>
<tr>
    <td height="21" colspan="4" align="center">
	<div class="TabView" id="TabView">

<!-- *** Tabs ************************************************************** -->

<div class="Tabs" style="width: 700px;">

 <a>Personal Information</a> <a>Score&frasl;Results</a><a>Attendance</a><a>Discipline</a>
  
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


<div class="Page">
  <div class="Pad">
  <!-- *** Page1 Start *** -->
  <table width="675">
  <c:forEach items="${enrollment}" var="enrollment" varStatus="optStatus">
  <tr>
    <td style="vertical-align: top;"><table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr><td >Registration Number:</td><td><b>${enrollment.regNO}</b></td></tr>
    <tr><td >Full Name:</td><td><b>${enrollment.fullname}</b></td></tr>
    <tr><td> Academic Year:</td><td><b>${enrollment.yearName}</b></td></tr>
    <tr><td> Department:</td><td><b>${enrollment.department}</b></td></tr>
    <tr><td >Class:</td><td><b>${enrollment.classCode}</b></td></tr>
    <tr>
    <td colspan="7"><table style=" border: 1px solid silver;">
    
    <tr><td rowspan="2" style=" border: 1px solid silver;"><b>Course Titles</b></td><td colspan="3" style=" border: 1px solid silver;"><b>Maximum Score</b></td><td colspan="3" style=" border: 1px solid silver;"><b>${sessionName }</b></td></tr>
    <tr><td  style=" border: 1px solid silver;"><b>Max Quiz</b></td>
    <td style=" border: 1px solid silver;"><b>Max Exam</b></td>
    <td  style=" border: 1px solid silver;"><b>Total</b></td>
    <td  style=" border: 1px solid silver;"><b>Mark Quiz</b></td>
    <td style=" border: 1px solid silver;"><b>Mark Exam</b></td>
    <td  style=" border: 1px solid silver;"><b>Total</b></td> </tr>
   <c:forEach items="${marks}" var="marks" varStatus="optStatus">
   <tr>
   <td  style=" border: 1px solid silver;">${marks.course}</td>
   <td  style=" border: 1px solid silver;">${marks.maxScore/2}</td>
    <td style=" border: 1px solid silver;">${marks.maxScore/2}</td>
    <td  style=" border: 1px solid silver;">${marks.maxScore}</td>
    <td  style=" border: 1px solid silver;">${marks.markQuiz}</td>
    <td style=" border: 1px solid silver;">${marks.markExam}</td>
    <td  style=" border: 1px solid silver;">${marks.markQuiz+marks.markExam}</td></tr>
   </c:forEach>
   <tr><td  style=" border: 1px solid silver;"><b>Total</b></td>
    <td style=" border: 1px solid silver;"><b>${maxQuizTotal }</b></td>
    <td  style=" border: 1px solid silver;"><b>${maxExamTotal }</b></td>
    <td  style=" border: 1px solid silver;"><b>${maxTotal }</b></td>
    <td  style=" border: 1px solid silver;"><b>${markQuizTotal }</b></td>
    <td style=" border: 1px solid silver;"><b>${markExamTotal }</b></td>
    <td  style=" border: 1px solid silver;"><b>${markTotal }</b></td></tr>
    <tr><td colspan="4" style=" border: 1px solid silver;">Percentage</td><td colspan="3" style=" border: 1px solid silver;"><b>${percentage }%</b></td></tr>
    <tr><td colspan="4" rowspan="5" style=" border: 1px solid silver;">School Stamp</td><td colspan="3" rowspan="5" style=" border: 1px solid silver;"><b></b></td></tr>
   
    </table>
    </td>
    </tr>
    <tr><td colspan="7" align="left"><form action="report?mdl=analysis&view=all&sid"  method="post" target="_blank" ><table><tr><td><input type="hidden" name="regno" value="${enrollment.regNO}"/><input type="hidden" name="yearname" value="${enrollment.yearName}" /><input type="hidden" name="sessions" value="${sessionID}"/><input type="submit" name="printbulletin" value="Print Bulletin" class="button"/></td></tr></table></form></td></tr>
    </table>
  </td>
  </tr>
  </c:forEach>
</table>
  <!-- *** Page1 End ***** -->

  </div>
  </div>
 
 <div class="Page">
  <div class="Pad">
  <!-- *** Page2 Start *** -->
  <table width="675">
  <c:forEach items="${enrollment}" var="enrollment" varStatus="optStatus">
  <tr><td style="vertical-align: top;"><table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr><td >Registration Number:</td><td><b>${enrollment.regNO}</b></td></tr>
    <tr><td >Full Name:</td><td><b>${enrollment.fullname}</b></td></tr>
    <tr><td> Academic Year:</td><td><b>${enrollment.yearName}</b></td></tr>
    <tr><td> Department:</td><td><b>${enrollment.department}</b></td></tr>
    <tr><td >Class:</td><td><b>${enrollment.classCode}</b></td></tr>
    <tr>
    <td colspan="6"><table style=" border: 1px solid silver;">
    
    <tr><td rowspan="2" style=" border: 1px solid silver;"><b>Course Titles</b></td>
    <td style=" border: 1px solid silver;" rowspan="2"><b>Maximum Attendance(min)</b></td>
    <td colspan="4" style=" border: 1px solid silver;"><b>${sessionName }</b></td></tr>
    
    <tr>
    <td  style=" border: 1px solid silver;" align="center"><b>Unexcused Absence(min)</b></td>
    <td style=" border: 1px solid silver;" align="center"><b>Excused Absence(min)</b></td>
    <td  style=" border: 1px solid silver;" align="center"><b>Total(min)</b></td>
    <td  style=" border: 1px solid silver;" align="center"><b>Percentage(%)</b></td> </tr>
   <c:forEach items="${attendances}" var="attendance" varStatus="optStatus">
   <tr>
   <td  style=" border: 1px solid silver;">${attendance.course}</td>
    <td  style=" border: 1px solid silver;" align="center">${attendance.maxAttendance}</td>
    <td  style=" border: 1px solid silver;" align="center">${attendance.abscences}</td>
    <td style=" border: 1px solid silver;" align="center">${attendance.execusedAbscences}</td>
    <td  style=" border: 1px solid silver;" align="center">${attendance.maxAttendance -(attendance.abscences+attendance.execusedAbscences)}</td>
   <td  style=" border: 1px solid silver;" align="center">${percentageCourseAttendance}</td></tr>
   </c:forEach>
   <tr><td  style=" border: 1px solid silver;" align="center"><b>Total</b></td>
    <td  style=" border: 1px solid silver;" align="center"><b>${totalAttendance}</b></td>
    <td  style=" border: 1px solid silver;" align="center"><b>${totalAbscence }</b></td>
    <td style=" border: 1px solid silver;" align="center"><b>${totalExecusedAbscence }</b></td>
    <td  style=" border: 1px solid silver;" align="center"><b>${totalCourseAttendance }</b></td></tr>
    <tr><td colspan="2" style=" border: 1px solid silver;">Percentage</td><td colspan="4" style=" border: 1px solid silver;" align="center" ><b>${percentageAttendance }%</b></td></tr>
    <tr><td colspan="2" rowspan="5" style=" border: 1px solid silver;" >School Stamp</td><td colspan="4" rowspan="5" style=" border: 1px solid silver;"><b></b></td></tr>
    </table>
    </td>
    </tr>
    <tr><td colspan="7" align="left"><form action="report?mdl=analysis&view=all&sid"  method="post" target="_blank" ><table><tr><td><input type="hidden" name="regno" value="${enrollment.regNO}"/><input type="hidden" name="yearname" value="${enrollment.yearName}" /><input type="hidden" name="sessions" value="${sessionID}"/><input type="submit" name="printattendance" value="Print Attendance" class="button"/></td></tr></table></form></td></tr>
    </table>
    </td></tr></c:forEach>
  </table>
  <!-- *** Page2 End ***** -->
  
 </div>
 </div>
 
 <div class="Page">
  <div class="Pad">
  <!-- *** Page3 Start *** -->
  <table width="675">
  <c:forEach items="${enrollment}" var="enrollment" varStatus="optStatus">
  <tr><td style="vertical-align: top;"><table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr><td >Registration Number:</td><td><b>${enrollment.regNO}</b></td></tr>
    <tr><td >Full Name:</td><td><b>${enrollment.fullname}</b></td></tr>
    <tr><td> Academic Year:</td><td><b>${enrollment.yearName}</b></td></tr>
    <tr><td> Department:</td><td><b>${enrollment.department}</b></td></tr>
    <tr><td >Class:</td><td><b>${enrollment.classCode}</b></td></tr>
    <tr>
    <td colspan="4"><table style=" border: 1px solid silver;">
    
    <tr>
    <td style=" border: 1px solid silver;" colspan="4" align="center"><b>${sessionName }</b></td></tr>
    
    <tr>
    <td  style=" border: 1px solid silver;"><b>Offense Type</b></td>
    <td style=" border: 1px solid silver;" ><b>Offense Occurence Date</b></td>
    <td  style=" border: 1px solid silver;" align="center"><b>Offense Occurence Location</b></td>
    <td style=" border: 1px solid silver;" align="center"><b>Disciplinary Action</b></td>
    </tr>
    <c:forEach items="${discipline}" var="discipline" varStatus="optStatus">
   <tr>
   
    <td  style=" border: 1px solid silver;" align="center">${discipline.offenseType}</td>
    <td  style=" border: 1px solid silver;" align="center">${discipline.offenseOccurence}</td>
    <td style=" border: 1px solid silver;" align="center">${discipline.offenseLocation}</td>
    <td  style=" border: 1px solid silver;" align="center">${discipline.disciplinaryAction}</td>
   </tr>
   </c:forEach></table></td></tr>
   <tr><td colspan="7" align="left"><form action="report?mdl=analysis&view=all&sid"  method="post" target="_blank" ><table><tr><td><input type="hidden" name="regno" value="${enrollment.regNO}"/><input type="hidden" name="yearname" value="${enrollment.yearName}" /><input type="hidden" name="sessions" value="${sessionID}"/><input type="submit" name="reportdiscipline" value="Report Discipline" class="button"/></td></tr></table></form></td></tr>
    </table>
    </td></tr></c:forEach>
  </table>
  <!-- *** Page3 End ***** -->
  
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
