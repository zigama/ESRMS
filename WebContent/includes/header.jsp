<%@page import="java.util.*" %>
<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>.:: Electronic Student Record Management System ::.</title>
<link rel="stylesheet" type="text/css" href="plugins/tabview.css" ></link>
<link rel="stylesheet" type="text/css" href="plugins/general.css" ></link>
<link type="text/css" rel="stylesheet" href="plugins/dhtmlgoodies_calendar.css?random=20051112" media="screen"></link>
<script type="text/javascript" src="plugins/dhtmlgoodies_calendar.js?random=20060118"></script>
<script type="text/javascript" src="plugins/tabview.js"></script>
<link rel="stylesheet" type="text/css" href="includes/facebox/autocomplete.css" />
<link href="includes/facebox/facebox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="includes/facebox/jquery.js"></script>
<script type='text/javascript' src='includes/facebox/autocomplete.js'></script>
<script type="text/javascript" src="includes/facebox/facebox.js"></script>
<script type="text/javascript">

jQuery(document).ready(function($) {
      $('a[rel*=facebox]').facebox({
        loading_image : '/includes/facebox/loading.gif',
        close_image   : '/includes/facebox/closelabel.gif'
      }) 
    })


</script>
</head>
<body topmargin="0" >
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" style="border:#f38943 solid 1px;">
     <tr>
    <td><div id="border-top" class="h_green">
		<div>
			<div align="center" class="CieName" style="padding-top:25px;">Electronic Student Record Management System</div>
		</div>
	</div></td>
  </tr>
     <tr>
       <td height="20" background="images/menu_grad.jpg">
 
	   <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="40%" align="left" style="padding-left:30px;"><b>${welcome}&nbsp;${myLoggedUser.fullName}
						</b></td>
    <td width="60%" align="left">
    <% 
    if( request.getSession().getAttribute("myLoggedUser")!=null){%>
    <%@ include file="menu.jsp" %><%} %>
    </td>
  </tr>
</table>

</td>
     </tr>
    
    
  <tr>
    <td height="450" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0" height="450">
  <tr>
    <td valign="top">