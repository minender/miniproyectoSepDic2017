<%-- 
    Document   : listar
    Created on : 11/05/2014, 01:59:42 AM
    Author     : federico
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <base href="/Miniproyecto/perfil/"/>
    </head>
    <body>
    <center>
        <table class="listar-terminos" border="1">
            <tr><th>Alias</th><th>Predicado</th></tr>
            <c:forEach var="termino" items="${terminos}">
                <tr><td>${termino.getId().getAlias()}</td><td>${termino.getCombinador()}</td>
                    <td><form action="${usuario.getLogin()}/modificar?alias=${termino.getId().getAlias()}" method="POST"><input type="submit" value="Modificar"></form></td>
                    <td><form action="${usuario.getLogin()}/eliminar?alias=${termino.getId().getAlias()}" method="POST"><input type="submit" value="Eliminar"></form></td>
                </tr>
            </c:forEach>
        </table>
    </center>
    <a href="../">Perfil</a>
    </body>
</html>
