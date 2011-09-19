<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/includes/header.jsp" %>
<script language="javascript">
function deroulement(selection,op,path){
	if(confirm("Are you sure you want to "+op+" ?"))
	window.location=path;
	}
function PassCheck(form1)
{
if(form1.yearname.value=="")
{
alert("You need to privide the academic year please!");
form1.yearname.focus();
return false;
}else if(form1.classi.value==""){
	alert("You need to select the classroom please!");
	form1.classi.focus();
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

$("#userName,#username").autocomplete('search.user', {
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
    <td width="4%" style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;border-left:#CCCCCC 1px solid; padding-left:10px;"><a href="index.htm?mdl=monitor&edit=all&sid" class="Mod"><img src="./images/enrollment.png" border="0"></a></td>
    <td width="60%" height="50" style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;"><div align="left" class="ModName">Class Lists</div></td>
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
if(request.getParameter("mdl").equals("classlist")){%>
<div align="center">
<table border="0" width="100%" class="listingTable" >
<tr><td>
<form action="index.htm?mdl=classlist&view=all&sid"  method="post" >
<table border=0 width="500" cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFCCC" style="border:groove #FFFCCC 2px;">
	<tr><td colspan="6" align="center" height="30" bgcolor="#FFEECC"><strong>Please Specify</strong></td></tr>

 <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Academic Year:		</td>
                <td colspan="4">  <select name="yearname" id="yearname" >
                <option value="" selected="selected">Select Academic Year...</option>
                <c:forEach items="${years}" var="year" varStatus="optStatus">
                <option value="${year.yearName}" >${year.yearName}</option>
                </c:forEach>
                </select></td>
        </tr>
        <tr>
		
		<td colspan="2" style="padding-left:5px;">
			Class:		</td>
                <td colspan="4"> <select name="classi" id="classi">
          <option value="" selected="selected">Select Class</option>
						
						<c:forEach items="${classes}" var="class" varStatus="optStatus">
						<option value="${class.classCode}">${class.classCode}</option>
						</c:forEach>
						
                  </select> </td>
        </tr>
<tr><td colspan="6" align="center">

<input type="button" name="showclasslist" value="Show Class List" class="button"onClick="return PassCheck(this.form);" />&nbsp;&nbsp;||&nbsp;&nbsp;<input name="rst" type="reset" value="Reset" class="button" /></td></tr>
</table></form>
	</td>
</tr>

<%if( request.getParameter("view").equals("all")){ %>
<tr>
    <td height="21" colspan="4" align="center">
	<div class="TabView" id="TabView">

<!-- *** Tabs ************************************************************** -->

<div class="Tabs" style="width: 700px;">

  <a>Class List</a>
  
</div>

<div class="Pages" style="width: 700px; height: 300px;">
 
 <div class="Page">
  <div class="Pad">
  <!-- *** Page3 Start *** -->
  <table width="675">
   
    <c:if test="${errorMsg!=''}"><b>${errorMsg}</b>
    </c:if>
    
  <tr><td style="vertical-align: top;"><table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr><td align="left"> Academic Year:&nbsp;<b>${acadeyear}</b></td></tr>
    <tr><td align="left"> Department:&nbsp;<b>${departement}</b></td></tr>
    <tr><td align="left">Class:&nbsp;<b>${classe}</b></td></tr>
    <tr>
    <td colspan="3"><table style=" border: 1px solid silver;">
   
    
    <tr>
    <td  style=" border: 1px solid silver;"><b>NO<%int no=1; %></b></td>
    <td style=" border: 1px solid silver;" ><b>Student Name</b></td>
    <td  style=" border: 1px solid silver;" align="center"><b>Student Registration Number</b></td>
    
    </tr>
    <c:forEach items="${ClassList}" var="myClassList" varStatus="optStatus">
   <tr>
   
   	<td style=" border: 1px solid silver;" align="center"><% out.print(no); no++;  %></td>
    <td  style=" border: 1px solid silver;" align="center">${myClassList.fullname}</td>
    <td  style=" border: 1px solid silver;" align="center">${myClassList.regNO}</td>
    
    
   </tr>
   </c:forEach>
   
   
   </table></td></tr>
   <tr><td colspan="7" align="left"><form action="report?mdl=analysis&view=all&sid"  method="post" target="_blank" ><table><tr><td><input type="hidden" name="classi" value="${classe}"/><input type="hidden" name="yearname" value="${acadeyear}" /><input type="submit" name="printclasslist" value="Print Class List" class="button"/></td></tr></table></form></td></tr>
    </table>
    </td></tr>
    
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
