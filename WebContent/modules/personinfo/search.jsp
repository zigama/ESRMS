<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:forEach items="${myStudent}" var="student" varStatus="optStatus">
<c:out value="${student.studentRegNO }"/>|&nbsp;&nbsp;<em><c:out value="${student.studentFirstName }"/></em>|&nbsp;&nbsp;<c:out value="${student.studentLastName }"/>|&nbsp;&nbsp;<c:out value="${student.guardianName }"/>|&nbsp;&nbsp;<c:out value="${student.studentDistrict}"/></c:forEach>
