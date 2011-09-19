<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/includes/header.jsp" %>
<script language="javascript">
function deroulement(selection,op,path){
	if(confirm("Are you sure you want to "+op+" ?"))
	window.location=path;
	}
function PassCheck(form1)
{
if(form1.to.value=="")
{
alert("Get in the destination phone number please.");
form1.to.focus();
return false;
}
else if(form1.msg.value=="")
{
alert("Type a message to send please.");
form1.msg.focus();
return false;
}
else
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
    <td width="4%" style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;border-left:#CCCCCC 1px solid; padding-left:10px;"><a href="index.htm?mdl=alert&edit=all&sid" class="Mod"><img src="./images/discipline.png" border="0"></a></td>
    <td width="40%" height="50" style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;"><div align="left" class="ModName">Student discipline alerts</div></td>
    <td width="30%" style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;" valign="middle" >
    <b><font color=#f38943><c:if test="${success!=''}"><script language="javascript">
	var success='${success}';
	if(success!=''){
    alert(success);
    }
    </script></c:if></font></b></td>
    <td width="20%"style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;"><div align="center"><form name="form1" action="discipline?mdl=alert&edit=all&sid" method="POST" autocomplete="off"><table><tr><td>Student Reg.NO:</td><td><input type="text" name="filter_regNO" id="regNO"></td><td><input type="submit" value="Filtrer" name="FilterDiscipline" class="button"></td></tr></table> </form></div></td>
    
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

<th scope='col'>Options</th>
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

<td align="center"><a href="index.htm?mdl=alert&edit=UseProfile&discipline=${discipline.disciplineID}&sid" class="con">send SMS</a></td>

</tr>
		</c:forEach>
<tr>
    <td align="center" colspan="11" style="border-top:#CCCCCC 1px dotted;">
    
    
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
<%
if(request.getParameter("edit").equals("UseProfile")){
%>
<form name="form1" action="msg?mdl=msg&edit=all&sid" method="POST">
	<table border=0 width="500" cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFCCC" style="border:groove #FFFCCC 2px;">
	<tr><td colspan="6" align="center" height="30" bgcolor="#FFEECC"><strong>Send SMS To Parents/Guardian</strong></td>
	</tr>
	
	<c:forEach items="${disciplineToUpdate}" var="disciplineUpdate" varStatus="optStatus">
	
                
                <tr>
                <td colspan="2">
			To:                </td>
                <td colspan="4" align="left">
                		<input  type="hidden" name="to" value="${guardianPhoneNO }">
                        <input  type="text" name="to_yenyewe" value="${guardianPhoneNO }" disabled="disabled"></td>
	</tr>
        <tr>
                <td colspan="2" >
                        Message:                </td>
                <td colspan="4" >
                       <textarea name="msg" rows="3" cols="32">${disciplineUpdate.fullname } is sanctioned of ${disciplineUpdate.disciplinaryAction} for ${disciplineUpdate.offenseType} from ${disciplineUpdate.offenseOccurence }.</textarea>                </td>
        </tr>
	<tr>
	  <td colspan="2">&nbsp;</td>
	  <td colspan="4">&nbsp;</td>
	  </tr>
	<tr><td colspan="6" align="center"><input name="send" type="button" value="Send" class="button" onClick="return PassCheck(this.form);">&nbsp;&nbsp;||&nbsp;&nbsp;<a href="index.htm?mdl=alert&edit=all&sid" class="button" Style="color:#000000;">Cancel</a></td>
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