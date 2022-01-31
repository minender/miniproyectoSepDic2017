<%-- 
    Document   : evaluar
    Created on : 09/06/2014, 02:06:33 PM
    Author     : federico
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <tiles:insertDefinition name="header" />

  <body >
    <h1>Evaluando</h1>
        
    $$${terminos.get(0)}$$

    <c:forEach var="i" begin="1" end="${nTerms.intValue()}">
        $$${operations.get(i)}$$ $$${terminos.get(i)}$$
    </c:forEach>
        
  </body>
</html>
