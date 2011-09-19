<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:forEach items="${myUser}" var="user" varStatus="optStatus">
<c:out value="${user.userName }"/>|&nbsp;&nbsp;<em><c:out value="${user.fullName }"/></em>|&nbsp;&nbsp;<c:out value="${user.role }"/>|&nbsp;&nbsp;<c:out value="${user.email }"/>|&nbsp;&nbsp;<c:out value="${user.phoneNumber }"/></c:forEach>
