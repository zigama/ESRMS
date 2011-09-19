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
}else
{
form1.submit();
}
}

//end of checking the form
//current date and time

//end of current date and time
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
// fill student name for discipline
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

//end of discipline name
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
    <td width="4%" style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;border-left:#CCCCCC 1px solid; padding-left:10px;"><a href="index.htm?mdl=discipline&edit=all&sid" class="Mod"><img src="./images/discipline.png" border="0"></a></td>
    <td width="40%" height="50" style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;"><div align="left" class="ModName">Student discipline</div></td>
    <td width="30%" style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;" valign="middle" >
    <b><font color=#f38943><c:if test="${success!=''}"><script language="javascript">
	var success='${success}';
	if(success!=''){
    alert(success);
    }
    </script></c:if></font></b></td>
    <td width="14%"style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;"><div align="center"><form name="form1" action="discipline?mdl=discipline&edit=all&sid" method="POST" autocomplete="off"><table><tr><td>Student Reg.NO:</td><td><input type="text" name="filter_regNO" id="regNO"></td><td><input type="submit" value="Filtrer" name="FilterDiscipline" class="button"></td></tr></table> </form></div></td>
    <td width="6%" style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;"><div align="center"><a href="index.htm?mdl=discipline&edit=new&sid" class="Mod"><img src="./images/new.png" border="0"><br>New</a></div></td>
	<td width="6%" style="border-bottom:#CCCCCC 1px solid;border-right:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;"><div align="center"><a href="index.htm?mdl=Logged&sid" class="Mod"><img src="./images/cancel.png" border="0"><br>Close</a></div></td>
  </tr>
</table>
</td></tr>
<tr><td style="padding-top:2px;">
<%
if(request.getParameter("edit").equals("all")){%>
<div align="center"><table border="0" width="100%" class="listingTable">
<tr>
<th>Full Name</th>
<th>Registration Number</th>
<th>Class &nbsp;&nbsp;&nbsp;&nbsp;</th>
<th>Department</th>
<th>Offense Type</th>
<th>Offense Occurence Date</th>
<th>Offense Occurence Location</th>
<th>Disciplinary Action</th>
<th>Session</th>
<th>Academic Year</th>

<th colspan='2' scope='col'>Options</th>
</tr>
<c:forEach items="${disciplines}" var="discipline" varStatus="optStatus">

<tr class="even">
<td><c:out value="${discipline.fullname}"/> </td>
<td><c:out value="${discipline.regNO}"/></td>
<td><c:out value="${discipline.classCode}"/></td>
<td><c:out value="${discipline.department}"/></td>
<td><c:out value="${discipline.offenseType}"/></td>
<td><c:out value="${discipline.offenseOccurence}"/></td>
<td><c:out value="${discipline.offenseLocation}"/></td>
<td><c:out value="${discipline.disciplinaryAction}"/></td>
<td><c:out value="${discipline.session}"/></td>
<td><c:out value="${discipline.yearName}"/></td>

<td align="center"><a href="index.htm?mdl=discipline&edit=UseProfile&discipline=${discipline.disciplineID}&sid"><img border="0" src="images/edit.png"></a></td>
<td align="center"><a href='#' onClick="deroulement(this,'delete','discipline?mdl=discipline&edit=all&UseDelete=${discipline.disciplineID}&sid')"><img border="0" src="images/drop.png"></a></td>
</tr>
		</c:forEach>
<tr>
    <td align="center" colspan="12" style="border-top:#CCCCCC 1px dotted;">
    
    
    <c:choose>
    <c:when test="${pagenum==1}">
    	
    	</c:when>
    	<c:otherwise><a href="index.htm?mdl=discipline&edit=all&pagenum=1&sid"><img border="0" src="images/start.png"></a>
    	<a href="index.htm?mdl=discipline&edit=all&pagenum=${pagenum-1}&sid"><img border="0" src="images/prev.png"></a></c:otherwise>
    </c:choose>
    &nbsp;&nbsp;Page <strong>${pagenum }</strong> of ${ lastpage}&nbsp;&nbsp;
    <c:choose>
    <c:when test="${pagenum==lastpage}">
    	
    	</c:when>
    	<c:otherwise><a href="index.htm?mdl=discipline&edit=all&pagenum=${pagenum+1}&sid"><img border="0" src="images/next.png"></a>
    	<a href="index.htm?mdl=discipline&edit=all&pagenum=${lastpage}&sid"><img border="0" src="images/end.png"></a></c:otherwise>
    </c:choose>
    </td></tr>		
</table></div>

<%}%>
<% if( request.getParameter("edit").equals("new")){ %>
<form name="newdiscipline" action="discipline?mdl=discipline&edit=all&sid" method="POST" autocomplete="off">
	<table border=0 width="500" cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFCCC" style="border:groove #FFFCCC 2px;">
	<tr><td colspan="6" align="center" height="30" bgcolor="#FFEECC"><strong>New Student Discipline</strong></td>
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
                <td colspan="4"> <select name="yearname" id="yearname" onChange="showEnrollment(this.value,document.newdiscipline.regno.value);">
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
			Offense Type:		</td>
                <td colspan="4"> <select name="offensetype" id="offensetype" >
                <option  selected="selected">Select Offense Type...</option>
                
                <option value="Infraction of school rules">Infraction of school rules</option>
                 <option value="Criminal offense">Criminal offense</option>
                  <option value="Chronic truancy">Chronic truancy</option>
                   <option value="Other">Other</option>
                </select></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Offense Occurence Date:		</td>
                <td colspan="4"> <input type="text" name="offenseoccurence" id="offenseoccurence" size="30" onFocus="displayCalendar(document.newdiscipline.offenseoccurence,'yyyy-mm-dd',this);"/></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Offense Occurence Location	</td>
                <td colspan="4"> <select name="offenselocation" id="offenselocation" >
                <option  selected="selected">Select Offense Occurence Location...</option>
                
                <option value="On school property">On school property</option>
                 <option value="A school-related function outside of school property">A school-related function outside of school property</option>
                  <option value="A school-related function without appropriate supervision">A school-related function without appropriate supervision</option>
                   <option value="Other">Other</option>
                </select></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Disciplinary Action:		</td>
                <td colspan="4"> <select name="disciplinaryaction" id="disciplinaryaction" >
                <option  selected="selected">Select Disciplinary Action...</option>
                <option value="Corporal punishment">Corporal punishment</option>
                <option value="Community service">Community service</option>
                <option value="Counseling">Counseling</option>
                <option value="Expulsion">Expulsion</option>
                 <option value="Documented warning">Documented warning</option>
                  <option value="Physical activity">Physical activity</option>
                  <option value="Privelege">Privelege</option>
                   <option value="In-school suspension">In-school suspension</option>
                   <option value="Out-school suspension">Out-school suspension</option>
                   <option value="Referral to juvenile justice system">Referral to juvenile justice system</option>
                   <option value="Unsatisfactory behavior grades">Unsatisfactory behavior grades</option>
                </select></td>
        </tr>
        <tr>
        
	  <td colspan="2">&nbsp;</td>
	  <td colspan="4">&nbsp;</td>
	  </tr>
	<tr><td colspan="6" align="center"><input name="NewDiscipline" type="button" value="Register Now" class="button" onClick="return PassCheck(this.form);">&nbsp;&nbsp;||&nbsp;&nbsp;<input name="rst" type="reset" value="Reset" class="button"></td>
	</tr>
  </table>    
</form><%

} %>
<%
if(request.getParameter("edit").equals("UseProfile")){
%>
<form name="disciplineUpdate" action="discipline?mdl=discipline&edit=all&sid" method="POST" >
	<table border=0 width="500" cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFCCC" style="border:groove #FFFCCC 2px;">
	<tr><td colspan="6" align="center" height="30" bgcolor="#FFEECC"><strong>Edit Student discipline</strong></td>
	</tr>
	
	<c:forEach items="${disciplineToUpdate}" var="disciplineUpdate" varStatus="optStatus">
	<tr>
		
		<td colspan="2" style="padding-left:5px;">
			Registration Number:		</td>
                <td colspan="4"><input type="hidden" name="disciplineid" id="disciplineid"  value="${disciplineUpdate.disciplineID }"><input type="hidden" name="enrollment" id="enrollment"  value="${disciplineUpdate.enrollmentID }" disabled="disabled"> <input type="text" name="regno" id="regno" value="${disciplineUpdate.regNO }" disabled="disabled"/></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Student Full Name:		</td>
                <td colspan="4"> <input type="text" name="fullname" id="fullname" size="30" value="${disciplineUpdate.fullname }" disabled="disabled"/></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Academic Year:		</td>
                <td colspan="4"> <input type="text" name="yearname" id="yearname" value="${disciplineUpdate.yearName }" disabled="disabled"/></td>
        </tr>
        
	<tr>
		
		<td colspan="2" style="padding-left:5px;">
			Class:		</td>
                <td colspan="4"> <input type="text" name="classi" id="classi" value="${disciplineUpdate.classCode }" disabled="disabled"> </td>
        </tr>
        
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Department:		</td>
                <td colspan="4"> <input type="text" name="department" id="department" size="30" value="${disciplineUpdate.department }" disabled="disabled"/></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Session:		</td>
                <td colspan="4"> <select name="sessions" id="sessions" >
                
                <c:forEach items="${sessions}" var="session" varStatus="optStatus">
                <c:choose>
                <c:when test="${disciplineUpdate.session==session.sessionID}">
                <option value="${disciplineUpdate.session}" selected="selected">${session.sessionName}</option>
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
			Offense Type:		</td>
                <td colspan="4"> <select name="offensetype" id="offensetype" >
                  
                
                <c:if test="${disciplineUpdate.offenseType!=''}">
                <option value="${disciplineUpdate.offenseType}" selected="selected">${disciplineUpdate.offenseType}</option>
                
                </c:if>
                 <option value="Infraction of school rules">Infraction of school rules</option>
                 <option value="Criminal offense">Criminal offense</option>
                  <option value="Chronic truancy">Chronic truancy</option>
                   <option value="Other">Other</option>
                
                
                </select></td>
        </tr>
        
         <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Offense Occurence Date:		</td>
                <td colspan="4"> <input type="text" name="offenseoccurence" id="offenseoccurence" size="30" value="${disciplineUpdate.offenseOccurence }" onFocus="displayCalendar(document.disciplineUpdate.offenseoccurence,'yyyy-mm-dd',this);"/></td>
        </tr>
       <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Offense Occurence Location	</td>
                <td colspan="4"> <select name="offenselocation" id="offenselocation" >
                
                <c:if test="${disciplineUpdate.offenseLocation!=''}">
                <option value="${disciplineUpdate.offenseLocation}" selected="selected">${disciplineUpdate.offenseLocation}</option>
                </c:if>
                 <option value="On school property">On school property</option>
                 <option value="A school-related function outside of school property">A school-related function outside of school property</option>
                  <option value="A school-related function without appropriate supervision">A school-related function without appropriate supervision</option>
                   <option value="Other">Other</option>
                   </select>
                </td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Disciplinary Action:		</td>
                <td colspan="4"> <select name="disciplinaryaction" id="disciplinaryaction" >
                
                <c:if test="${disciplineUpdate.disciplinaryAction!=''}">
                <option value="${disciplineUpdate.disciplinaryAction}" selected="selected">${disciplineUpdate.disciplinaryAction}</option>
                </c:if>
                <option value="Corporal punishment">Corporal punishment</option>
                <option value="Community service">Community service</option>
                <option value="Counseling">Counseling</option>
                <option value="Expulsion">Expulsion</option>
                 <option value="Documented warning">Documented warning</option>
                  <option value="Physical activity">Physical activity</option>
                  <option value="Privelege">Privelege</option>
                   <option value="In-school suspension">In-school suspension</option>
                   <option value="Out-school suspension">Out-school suspension</option>
                   <option value="Referral to juvenile justice system">Referral to juvenile justice system</option>
                   <option value="Unsatisfactory behavior grades">Unsatisfactory behavior grades</option>
                </select>
                </td>
        </tr>
        
    	   <tr>
	  <td colspan="2">&nbsp;</td>
	  <td colspan="4">&nbsp;</td>
	  </tr>
	<tr><td colspan="6" align="center"><input name="DisciplineChange" type="submit" value="Save Changes" class="button">&nbsp;&nbsp;||&nbsp;&nbsp;<a href="index.htm?mdl=discipline&edit=all&sid" class="button" Style="color:#000000;">Cancel</a></td>
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