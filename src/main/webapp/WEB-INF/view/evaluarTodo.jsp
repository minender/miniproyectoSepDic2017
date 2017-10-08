<%-- 
    Document   : evaluar
    Created on : 09/06/2014, 02:06:33 PM
    Author     : federico
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
    <!--<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/mathjax-MathJax-v2.3-248-g60e0a8c/MathJax.js"></script>-->
    <title>Miniproyecto</title>
  </head>
  <body >

    <h1>Evaluando</h1>
        
        
    $$${terminos.get(0)}$$

    <c:forEach var="i" begin="1" end="${nTerms.intValue()}">
        $$${operations.get(i)}$$ $$${terminos.get(i)}$$
    </c:forEach>
        
  </body>
</html>
