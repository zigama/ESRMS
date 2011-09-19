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
	alert("Get in the session please.");
	form1.sessions.focus();
	return false;
	
}else if(form1.course.value==""){
	alert("Get in the course please.");
	form1.course.focus();
	return false;
	
}else if(form1.markquiz.value=="" || isNaN(Number(form1.markquiz.value))){
	alert("Get in the mark for quiz please.");
	form1.markquiz.focus();
	return false;
	
}else if(form1.markexam.value=="" || isNaN(Number(form1.markexam.value))){
	alert("Get in the mark for exam please.");
	form1.markexam.focus();
	return false;
	
}else if(form1.maxscore.value=="" || isNaN(Number(form1.maxscore.value))){
	alert("Get in the max score please.");
	form1.maxscore.focus();
	return false;
	
}else if((Number(form1.markquiz.value)+Number(form1.markexam.value))>Number(form1.maxscore.value)){
	
	alert("Your marks exceed the max score please.");
	
	form1.markquiz.focus();
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
	         if (isNaN(c)&& c!='.'||isNaN(Number(s)) )
		   {
			alert("Given mark value is not a number");
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
// fill student name for score
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

//end of score name
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
    <td width="4%" style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;border-left:#CCCCCC 1px solid; padding-left:10px;"><a href="index.htm?mdl=score&edit=all&sid" class="Mod"><img src="./images/score.png" border="0"></a></td>
    <td width="40%" height="50" style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;"><div align="left" class="ModName">Student scores</div></td>
    <td width="30%" style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;" valign="middle" >
    <b><font color=#f38943><c:if test="${success!=''}"><script language="javascript">
	var success='${success}';
	if(success!=''){
    alert(success);
    }
    </script></c:if></font></b></td>
    <td width="14%"style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;"><div align="center"><form name="form1" action="score?mdl=score&edit=all&sid" method="POST" autocomplete="off"><table><tr><td>Student Reg.NO:</td><td><input type="text" name="filter_regNO" id="regNO"></td><td><input type="submit" value="Filtrer" name="FilterMarks" class="button"></td></tr></table> </form></div></td>
    <td width="6%" style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;"><div align="center"><a href="index.htm?mdl=score&edit=new&sid" class="Mod"><img src="./images/new.png" border="0"><br>New</a></div></td>
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
<th>Quiz</th>
<th>Exam</th>
<th>Max Score</th>
<th>Session</th>
<th>Academic Year</th>

<th colspan='2' scope='col'>Options</th>
</tr>
<c:forEach items="${scores}" var="score" varStatus="optStatus">

<tr class="even">
<td><c:out value="${score.fullname}"/> </td>
<td><c:out value="${score.regNO}"/></td>
<td><c:out value="${score.classCode}"/></td>
<td><c:out value="${score.department}"/></td>
<td><c:out value="${score.course}"/></td>
<td><c:out value="${score.markQuiz}"/></td>
<td><c:out value="${score.markExam}"/></td>
<td><c:out value="${score.maxScore}"/></td>
<td><c:out value="${score.session}"/></td>
<td><c:out value="${score.yearName}"/></td>

<td align="center"><a href="index.htm?mdl=score&edit=UseProfile&score=${score.markID}&sid"><img border="0" src="images/edit.png"></a></td>
<td align="center"><a href='#' onClick="deroulement(this,'delete','score?mdl=score&edit=all&UseDelete=${score.markID}&sid')"><img border="0" src="images/drop.png"></a></td>
</tr>
		</c:forEach>
<tr>
    <td align="center" colspan="12" style="border-top:#CCCCCC 1px dotted;">
    
    
    <c:choose>
    <c:when test="${pagenum==1}">
    	
    	</c:when>
    	<c:otherwise><a href="index.htm?mdl=score&edit=all&pagenum=1&sid"><img border="0" src="images/start.png"></a>
    	<a href="index.htm?mdl=score&edit=all&pagenum=${pagenum-1}&sid"><img border="0" src="images/prev.png"></a></c:otherwise>
    </c:choose>
    &nbsp;&nbsp;Page <strong>${pagenum }</strong> of ${ lastpage}&nbsp;&nbsp;
    <c:choose>
    <c:when test="${pagenum==lastpage}">
    	
    	</c:when>
    	<c:otherwise><a href="index.htm?mdl=score&edit=all&pagenum=${pagenum+1}&sid"><img border="0" src="images/next.png"></a>
    	<a href="index.htm?mdl=score&edit=all&pagenum=${lastpage}&sid"><img border="0" src="images/end.png"></a></c:otherwise>
    </c:choose>
    </td></tr>		
</table></div>

<%}%>
<% if( request.getParameter("edit").equals("new")){ %>
<form name="newscore" action="score?mdl=score&edit=all&sid" method="POST" autocomplete="off">
	<table border=0 width="500" cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFCCC" style="border:groove #FFFCCC 2px;">
	<tr><td colspan="6" align="center" height="30" bgcolor="#FFEECC"><strong>New Student score</strong></td>
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
                <td colspan="4"> <select name="yearname" id="yearname" onChange="showEnrollment(this.value,document.newscore.regno.value);">
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
			Quiz Mark:		</td>
                <td colspan="4"> <input type="text" name="markquiz" id="markquiz" size="30" onKeyUp="isInteger(this.value);"/></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Exam Mark:		</td>
                <td colspan="4"> <input type="text" name="markexam" id="markexam" size="30" onKeyUp="isInteger(this.value);"/></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Max Score:		</td>
                <td colspan="4"> <input type="text" name="maxscore" id="maxscore" size="30" onKeyUp="isInteger(this.value);"/></td>
        </tr>
        <tr>
        
	  <td colspan="2">&nbsp;</td>
	  <td colspan="4">&nbsp;</td>
	  </tr>
	<tr><td colspan="6" align="center"><input name="Newscore" type="button" value="Register Now" class="button" onClick="return PassCheck(this.form);">&nbsp;&nbsp;||&nbsp;&nbsp;<input name="rst" type="reset" value="Reset" class="button"></td>
	</tr>
  </table>    
</form><%

} %>
<%
if(request.getParameter("edit").equals("UseProfile")){
%>
<form name="scoreUpdate" action="score?mdl=score&edit=all&sid" method="POST" >
	<table border=0 width="500" cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFCCC" style="border:groove #FFFCCC 2px;">
	<tr><td colspan="6" align="center" height="30" bgcolor="#FFEECC"><strong>Edit Student Score</strong></td>
	</tr>
	
	<c:forEach items="${scoreToUpdate}" var="scoreUpdate" varStatus="optStatus">
	<tr>
		
		<td colspan="2" style="padding-left:5px;">
			Registration Number:		</td>
                <td colspan="4"><input type="hidden" name="markid" id="markid"  value="${scoreUpdate.markID }"><input type="hidden" name="enrollment" id="enrollment"  value="${scoreUpdate.enrollmentID }" disabled="disabled"> <input type="text" name="regno" id="regno" value="${scoreUpdate.regNO }" disabled="disabled"/></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Student Full Name:		</td>
                <td colspan="4"> <input type="text" name="fullname" id="fullname" size="30" value="${scoreUpdate.fullname }" disabled="disabled"/></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Academic Year:		</td>
                <td colspan="4"> <input type="text" name="yearname" id="yearname" value="${scoreUpdate.yearName }" disabled="disabled"/></td>
        </tr>
        
	<tr>
		
		<td colspan="2" style="padding-left:5px;">
			Class:		</td>
                <td colspan="4"> <input type="text" name="classi" id="classi" value="${scoreUpdate.classCode }" disabled="disabled"> </td>
        </tr>
        
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Department:		</td>
                <td colspan="4"> <input type="text" name="department" id="department" size="30" value="${scoreUpdate.department }" disabled="disabled"/></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Session:		</td>
                <td colspan="4"> <select name="sessions" id="sessions" >
                
                <c:forEach items="${sessions}" var="session" varStatus="optStatus">
                <c:choose>
                <c:when test="${scoreUpdate.session==session.sessionID}">
                <option value="${scoreUpdate.session}" selected="selected">${session.sessionName}</option>
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
                <c:when test="${scoreUpdate.course==course.courseID}">
                <option value="${scoreUpdate.course}" selected="selected">${course.courseName}</option>
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
			Quiz Mark:		</td>
                <td colspan="4"> <input type="text" name="markquiz" id="markquiz" size="30" value="${scoreUpdate.markQuiz }" onKeyUp="isInteger(this.value);"/></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Exam Mark:		</td>
                <td colspan="4"> <input type="text" name="markexam" id="markexam" size="30" value="${scoreUpdate.markExam }" onKeyUp="isInteger(this.value);"/></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Max Score:		</td>
                <td colspan="4"> <input type="text" name="maxscore" id="maxscore" size="30" value="${scoreUpdate.maxScore }" onKeyUp="isInteger(this.value);"/></td>
        </tr>
    	   <tr>
	  <td colspan="2">&nbsp;</td>
	  <td colspan="4">&nbsp;</td>
	  </tr>
	<tr><td colspan="6" align="center"><input name="ScoreChange" type="submit" value="Save Changes" class="button">&nbsp;&nbsp;||&nbsp;&nbsp;<a href="index.htm?mdl=score&edit=all&sid" class="button" Style="color:#000000;">Cancel</a></td>
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