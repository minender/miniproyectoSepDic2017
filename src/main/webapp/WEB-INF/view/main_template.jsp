<%-- 
    Document   : perfil
    Created on : 20/03/2014, 08:34:24 AM
    Author     : federico
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html>
    <tiles:insertAttribute name="header"/>
    <body>
        <tiles:insertAttribute name="nav"/>
        <tiles:insertAttribute name="body"/>
        <tiles:insertAttribute name="footer" />
    </body>
</html>
