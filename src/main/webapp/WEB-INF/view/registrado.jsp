<%-- 
    Document   : registrado
    Created on : 19/03/2014, 05:36:49 AM
    Author     : federico
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css" >
      <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css" >
      <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap-responsive.css" >
      <title>David | Registrado</title>
    </head>
    <body>
      <div class="row-fluid" style="margin-left: 50px; height:552px; width: 1100px; overflow: hidden;">
        <h1> ${usuario.login} usted se ha registrado con éxito</h1>
        Ahora puede ingresar a la aplicación haciendo click 
        <a href="../index">aquí</a>
      </div>
    </body>
</html>
