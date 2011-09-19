<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/includes/header.jsp" %>
<script language="javascript">
function deroulement(selection,op,path){
	if(confirm("Are you sure you want to "+op+" ?"))
	window.location=path;
	}
function PassCheck(form1)
{
if(form1.username.value=="")
{
alert("Get in the username please.");
form1.username.focus();
return false;
}
else if((form1.new_pass.value=="")&&(form1.verify_pass.value==""))
{
alert("Cannot save empty fiels.");
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
else if(form1.role_id.value=="")
{
alert("Select User Group Please.");
form1.role_id.focus();
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
    <td width="4%" style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;border-left:#CCCCCC 1px solid; padding-left:10px;"><a href="index.htm?mdl=accesscon&edit=all&sid" class="Mod"><img src="./images/user.png" border="0"></a></td>
    <td width="40%" height="50" style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;"><div align="left" class="ModName">System User Accounts</div></td>
    <td width="30%" style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;" valign="middle" >
    <b><font color=#f38943><c:if test="${success!=''}"><script language="javascript">
	var success='${success}';
	if(success!=''){
    alert(success);
    }
    </script></c:if></font></b></td>
    <td width="14%"style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;"><div align="center"><form name="form1" action="accesscon?mdl=accesscon&edit=all&sid" method="POST" autocomplete="off"><table><tr><td>Username:</td><td><input type="text" name="filter_username" id="userName"></td><td><input type="submit" value="Filtrer" name="FilterUsers" class="button"></td></tr></table> </form></div></td>
    <td width="6%" style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;"><div align="center"><a href="index.htm?mdl=accesscon&edit=new&sid" class="Mod"><img src="./images/new.png" border="0"><br>New</a></div></td>
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
<th>User Name</th>
<th>Role</th>
<th>Email Address</th>
<th>Phone Number</th>
<th colspan='2' scope='col'>Options</th>
</tr>
<c:forEach items="${users}" var="user" varStatus="optStatus">

<tr class="even">
<td><c:out value="${user.fullName}"/></td>
<td><c:out value="${user.userName}"/></td>
<td><c:out value="${user.role}"/></td>
<td><c:out value="${user.email}"/></td>
<td><c:out value="${user.phoneNumber}"/></td>
<td align="center"><a href="index.htm?mdl=accesscon&edit=UseProfile&user=${user.userID}&sid"><img border="0" src="images/edit.png"></a></td>
<td align="center"><a href='#' onClick="deroulement(this,'delete','accesscon?mdl=accesscon&edit=all&UseDelete=${user.userID}&sid')"><img border="0" src="images/drop.png"></a></td>
</tr>
		</c:forEach>
<tr>
    <td align="center" colspan="7" style="border-top:#CCCCCC 1px dotted;">
    
    
    <c:choose>
    <c:when test="${pagenum==1}">
    	
    	</c:when>
    	<c:otherwise><a href="index.htm?mdl=accesscon&edit=all&pagenum=1&sid"><img border="0" src="images/start.png"></a>
    	<a href="index.htm?mdl=accesscon&edit=all&pagenum=${pagenum-1}&sid"><img border="0" src="images/prev.png"></a></c:otherwise>
    </c:choose>
    &nbsp;&nbsp;Page <strong>${pagenum }</strong> of ${ lastpage}&nbsp;&nbsp;
    <c:choose>
    <c:when test="${pagenum==lastpage}">
    	
    	</c:when>
    	<c:otherwise><a href="index.htm?mdl=accesscon&edit=all&pagenum=${pagenum+1}&sid"><img border="0" src="images/next.png"></a>
    	<a href="index.htm?mdl=accesscon&edit=all&pagenum=${lastpage}&sid"><img border="0" src="images/end.png"></a></c:otherwise>
    </c:choose>
    </td></tr>		
</table></div>

<%}%>
<% if( request.getParameter("edit").equals("new")){ %>
<form name="form1" action="accesscon?mdl=accesscon&edit=all&sid" method="POST" autocomplete="off">
	<table border=0 width="500" cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFCCC" style="border:groove #FFFCCC 2px;">
	<tr><td colspan="6" align="center" height="30" bgcolor="#FFEECC"><strong>Create New User Account</strong></td>
	</tr>
        <tr>
		<td colspan="2">
			Username:		</td>
                <td colspan="4"><input type="hidden" name="sid" value="sid">
			<input type="text" name="username" id="username"></td>
        </tr>
                
                <tr>
                <td colspan="2">
			Password:                </td>
                <td colspan="4" align="left">
                        <input  type="password" name="new_pass" value=""></td>
	</tr>
        <tr>
                <td colspan="2" >
                        Confirm Password:                </td>
                <td colspan="4" >
                        <input  type="password" name="verify_pass" value="">                </td>
        </tr>
	<tr>
                <td colspan="2" width="300">
			Full Name:                </td>
                <td colspan="4" >
                        <input type="text" name="fullname" size="40" />                </td>
	</tr>
	<tr >
                <td colspan="2" width="300" style="padding-left:5px;">
                        E-mail:                </td>
                <td colspan="4">
                        <input type="text" name="email" size="40" />                </td>
      </tr>
	  	
	<tr>
                <td colspan="2" width="300" >
			User Group:              </td>
                <td colspan="4" >
                        <select name="role_id">
						<option value="" selected="selected">Select ...</option>
						<c:forEach items="${roles}" var="role" varStatus="optStatus">
						<option value="${role.roleID}">${role.roleName}</option>
						</c:forEach>
						
                  </select></td>
	</tr>
	<tr>
                <td colspan="2" width="300" >
			Phone Number:              </td>
                <td colspan="4" >
                        <input type="text" name="phonenumber"  title="Like(+250788660270)"/>
						</td>
	</tr>
	
	<tr>
	  <td colspan="2">&nbsp;</td>
	  <td colspan="4">&nbsp;</td>
	  </tr>
	<tr><td colspan="6" align="center"><input name="NewUser" type="button" value="Create Now" class="button" onClick="return PassCheck(this.form);">&nbsp;&nbsp;||&nbsp;&nbsp;<input name="rst" type="reset" value="Reset" class="button"></td>
	</tr>
  </table>    
</form><%

} %>
<%
if(request.getParameter("edit").equals("UseProfile")){
%>
<form name="form1" action="accesscon?mdl=accesscon&edit=all&sid" method="POST" >
	<table border=0 width="500" cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFCCC" style="border:groove #FFFCCC 2px;">
	<tr><td colspan="6" align="center" height="30" bgcolor="#FFEECC"><strong>Edit User Account</strong></td>
	</tr>
	
	<c:forEach items="${userToUpdate}" var="userUpdate" varStatus="optStatus">
	<tr>
		<td colspan="2">
			Username:		</td>
                <td colspan="4">
                <input type="hidden" name="userid" value="${userUpdate.userID}" >
			<input type="text" name="username" value="${userUpdate.userName}" disabled="disabled"></td>
        </tr>
                
                <tr>
                <td colspan="2">
			Password:                </td>
                <td colspan="4" align="left">
                        <input  type="password" name="new_pass" value="${userUpdate.password}"></td>
	</tr>
        <tr>
                <td colspan="2" >
                        Confirm Password:                </td>
                <td colspan="4" >
                        <input  type="password" name="verify_pass" value="${userUpdate.password}">                </td>
        </tr>
	<tr>
                <td colspan="2" width="300">
			Full Name:                </td>
                <td colspan="4" >
                        <input type="text" name="fullname" value="${userUpdate.fullName}" size="40" />                </td>
	</tr>
	<tr >
                <td colspan="2" width="300" style="padding-left:5px;">
                        E-mail:                </td>
                <td colspan="4">
                        <input type="text" name="email" value="${userUpdate.email}" size="40" />                </td>
      </tr>
	  	
	<tr>
                <td colspan="2" width="300" >
			User Group:              </td>
                <td colspan="4" >
                        <select name="role_id">
                        <c:forEach items="${roles}" var="role" varStatus="optStatus">
                        <c:choose>
                        <c:when test="${userUpdate.role ==role.roleName}">
						<option value="${role.roleID}" selected="selected">${userUpdate.role }</option>
						</c:when>
						<c:otherwise>
												<option value="${role.roleID}">${role.roleName}</option>
						</c:otherwise>
						</c:choose>
						</c:forEach>
						
                  </select></td>
	</tr>
	<tr>
                <td colspan="2" width="300" >
			Phone Number:              </td>
                <td colspan="4" >
                        <input type="text" name="phonenumber" value="${userUpdate.phoneNumber}" title="Like(+250788660270)" />
						</td>
	</tr>
	<tr>
	<td colspan="6" align="center"><input name="commPass" type="checkbox" value="commit">Commit password</td>
	</tr>
	<tr>
	  <td colspan="2">&nbsp;</td>
	  <td colspan="4">&nbsp;</td>
	  </tr>
	<tr><td colspan="6" align="center"><input name="UserChange" type="submit" value="Save Changes" class="button">&nbsp;&nbsp;||&nbsp;&nbsp;<a href="index.htm?mdl=accesscon&edit=all&sid" class="button" Style="color:#000000;">Cancel</a></td>
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