<%-- 
        Document   : PagParaVerPredicado
        Created on : Feb 23, 2017, 4:55:28 PM
        Author     : miguel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<!DOCTYPE html>
<html>
    <head>
        <tiles:insertDefinition name="header" />
        <title>JSP Page</title>
    </head>
    
    <body>
        <h1>Hello World!</h1>
        <p> ${id}  </p>
        <p> ${usuario}  </p>
        <p> ${predicado}  </p>
        <p> ${alias}  </p>
        <p> ${predserializado}  </p>
            
    </body>
</html>