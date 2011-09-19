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
</script>

<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">

<tr><td>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
    <td width="4%" style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;border-left:#CCCCCC 1px solid; padding-left:10px;"><a href="index.htm?mdl=msg&edit=all&sid" class="Mod"><img src="./images/envsent.gif" border="0"></a></td>
    <td width="47%" height="50" style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;"><div align="left" class="ModName">Sent Messages</div></td>
    <td width="37%" style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;" valign="middle" >
    <b><font color=#f38943><c:if test="${success!=''}"><script language="javascript">
	var success='${success}';
	if(success!=''){
    alert(success);
    }
    </script></c:if></font></b></td>
    <td width="6%" style="border-bottom:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;"><div align="center"><a href="index.htm?mdl=msg&edit=new&sid" class="Mod"><img src="./images/new.png" border="0"><br>New</a></div></td>
	<td width="6%" style="border-bottom:#CCCCCC 1px solid;border-right:#CCCCCC 1px solid;border-top:#CCCCCC 1px solid;"><div align="center"><a href="index.htm?mdl=Logged&sid" class="Mod"><img src="./images/cancel.png" border="0"><br>Close</a></div></td>
  </tr>
</table>
</td></tr>
<tr><td style="padding-top:2px;">
<%
if(request.getParameter("edit").equals("all")){%>
<div align="center"><table border="0" width="100%" class="listingTable">
<tr>
<th></th>
<th>Sender Phone Number</th>
<th>Receiver Phone Number</th>
<th>Message</th>
<th>Date</th>
<th>Status</th>
<th>ErrorMsg</th>
<th colspan='2' scope='col'>Options</th>
</tr>
<c:forEach items="${SMSs}" var="sms" varStatus="optStatus">

<tr class="even">
<td><img src="./images/smallenv.gif" border="0"></td>
<td><c:out value="${sms.smsSender}"/></td>
<td><c:out value="${sms.smsReceiver}"/></td>
<td><c:out value="${sms.smsMessage}"/></td>
<td><c:out value="${sms.smsSentTime}"/></td>
<td><c:out value="${sms.smsStatus}"/></td>
<td><c:out value="${sms.smsErrorMsg}"/></td>
<td align="center"><a href="index.htm?mdl=msg&edit=smsProfile&sms=${sms.smsID}&sid"><img border="0" src="images/edit.png"></a></td>
<td align="center"><a href='#' onClick="deroulement(this,'delete','msg?mdl=msg&edit=all&smsDelete=${sms.smsID}&sid')"><img border="0" src="images/drop.png"></a></td>
</tr>
		</c:forEach>
	<tr>
    <td align="center" colspan="9" style="border-top:#CCCCCC 1px dotted;">
    
    
    <c:choose>
    <c:when test="${pagenum==1}">
    	
    	</c:when>
    	<c:otherwise><a href="index.htm?mdl=msg&edit=all&pagenum=1&sid"><img border="0" src="images/start.png"></a>
    	<a href="index.htm?mdl=msg&edit=all&pagenum=${pagenum-1}&sid"><img border="0" src="images/prev.png"></a></c:otherwise>
    </c:choose>
    &nbsp;&nbsp;Page <strong>${pagenum }</strong> of ${ lastpage}&nbsp;&nbsp;
    <c:choose>
    <c:when test="${pagenum==lastpage}">
    	
    	</c:when>
    	<c:otherwise><a href="index.htm?mdl=msg&edit=all&pagenum=${pagenum+1}&sid"><img border="0" src="images/next.png"></a>
    	<a href="index.htm?mdl=msg&edit=all&pagenum=${lastpage}&sid"><img border="0" src="images/end.png"></a></c:otherwise>
    </c:choose>
    </td></tr>			
</table></div>

<%}%>
<% if( request.getParameter("edit").equals("new")){ %>
<form name="form1" action="msg?mdl=msg&edit=all&sid" method="POST">
	<table border=0 width="500" cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFCCC" style="border:groove #FFFCCC 2px;">
	<tr><td colspan="6" align="center" height="30" bgcolor="#FFEECC"><strong>Send New SMS</strong></td>
	</tr>
       
                
                <tr>
                <td colspan="2">
			To:                </td>
                <td colspan="4" align="left">
                        <input  type="text" name="to" title="Like (+250788660270)"></td>
	</tr>
        <tr>
                <td colspan="2" >
                        Message:                </td>
                <td colspan="4" >
                       <textarea name="msg" rows="3" cols="32"></textarea>                </td>
        </tr>
	<tr>
	  <td colspan="2">&nbsp;</td>
	  <td colspan="4">&nbsp;</td>
	  </tr>
	<tr><td colspan="6" align="center"><input name="send" type="button" value="Send" class="button" onClick="return PassCheck(this.form);">&nbsp;&nbsp;||&nbsp;&nbsp;<a href="index.htm?mdl=msg&edit=all&sid" class="button" Style="color:#000000;">Cancel</a></td>
	</tr>  </table>    
</form><%

} %>
<%
if(request.getParameter("edit").equals("smsProfile")){
%>
<form name="form1" action="msg?mdl=msg&edit=all&sid" method="POST">
	<table border=0 width="500" cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFCCC" style="border:groove #FFFCCC 2px;">
	<tr><td colspan="6" align="center" height="30" bgcolor="#FFEECC"><strong>Edit SMS Profile</strong></td>
	</tr>
	
	<c:forEach items="${smsToUpdate}" var="smsUpdate" varStatus="optStatus">
	<tr>
		<td colspan="2">
			Send From:		</td>
                <td colspan="4">
                <input type="hidden" name="smsid" value="${smsUpdate.smsID}" >
			<input type="text" name="sender" value="${smsUpdate.smsSender}" disabled="disabled"></td>
        </tr>
                
                <tr>
                <td colspan="2">
			To:                </td>
                <td colspan="4" align="left">
                        <input  type="text" name="to" value="${smsUpdate.smsReceiver}"></td>
	</tr>
        <tr>
                <td colspan="2" >
                        Message:                </td>
                <td colspan="4" >
                       <textarea name="msg" rows="3" cols="32">${smsUpdate.smsMessage}</textarea>                </td>
        </tr>
	<tr>
                <td colspan="2" width="300">
			Date:                </td>
                <td colspan="4" >
                        <input type="text" name="senttime" value="${smsUpdate.smsSentTime}" size="40" disabled="disabled"/>                </td>
	</tr>
	<tr >
                <td colspan="2" width="300" style="padding-left:5px;">
                        Status:                </td>
                <td colspan="4">
                        <input type="text" name="status" value="${smsUpdate.smsStatus}" size="40" disabled="disabled"/>                </td>
      </tr>
	  	
	<tr>
                <td colspan="2" width="300" >
			Error Message:              </td>
                <td colspan="4" >
                        <input type="text" name="status" value="${smsUpdate.smsErrorMsg}" size="40" disabled="disabled"/> </td>
	</tr>
	
	
	<tr>
	  <td colspan="2">&nbsp;</td>
	  <td colspan="4">&nbsp;</td>
	  </tr>
	<tr><td colspan="6" align="center"><input name="Resend" type="submit" value="Resend" class="button" onClick="return PassCheck(this.form);">&nbsp;&nbsp;||&nbsp;&nbsp;<a href="index.htm?mdl=msg&edit=all&sid" class="button" Style="color:#000000;">Cancel</a></td>
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