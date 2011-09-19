<script language="javascript">

function PassCheck(form1)
{
if(form1.username.value=="")
{
alert("Get in the username please.");
form1.username.focus();
return false;
}
else if(form1.password.value=="")
{
alert("Get in the password please.");
form1.password.focus();
return false;
}

else
{
form1.submit();
}
}
</script>


<p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p>
<c:if test="${logStatus!=''}">
<div align=center><font color=red><strong>${logStatus}</strong></font><br><br></div>
</c:if>
<form name="form1" action="index.htm?mdl=login" method="post" onSubmit="return PassCheck(this);">
<table width="500" border="0" cellspacing="0" cellpadding="0" align="center" style="border:#f38943 solid 1px;">
  <tr>
  <td width="266" rowspan="4" align="center" valign="top" style="padding:3px;">
      <img src="images/j_login_lock.jpg" width="152" height="137"><br />
      <a href="mailto:zigdidier1986@yahoo.fr" class="con">Forgot your username or password?</a></td>
    <td width="234" align="center" style="padding:3px;">Enter the username and password into respective fields, then click &quot;Login&quot; </td>
    
  </tr>
  <tr>
    <td align="center"><input type="text" name="username" value="Username" onFocus="this.value=''" autocomplete="off"></td>
    </tr>
  <tr>
    <td align="center"><input type="password" name="password" value="Password" onFocus="this.value=''"></td>
    </tr>
  <tr>
    <td align="center"><input type="submit" class="button" name="Login" value="Login"></td>
    </tr>
</table>
</form>

<p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p>