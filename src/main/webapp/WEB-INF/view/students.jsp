<%-- 
    Document   : introducirTermino
    Created on : 06/05/2014, 02:16:02 PM
    Author     : federico
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html>
  <tiles:insertDefinition name="header" />
  <body>
  <tiles:insertDefinition name="nav" />
    <h1>Students List</h1>
    <c:forEach var="student" items="${studentsList}">
        <p>${student.nombre} ${student.apellido}</p> 
        </c:forEach>
  <tiles:insertDefinition name="footer" />
  </body>
</html>

