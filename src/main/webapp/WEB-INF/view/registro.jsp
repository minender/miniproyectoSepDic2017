<%-- 
    Document   : registo
    Created on : 09/03/2014, 03:56:16 AM
    Author     : federico
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
  <head>
    <style>
      .error {
        color: #ff0000;
      }
    </style>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css" >
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css" >
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap-responsive.css" >
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Registro</title>
  </head>
  <body>
    <div class="row-fluid" style="margin-left: 50px; height:552px; width: 1100px; overflow: hidden;">
      <h1>Llene el siguiente formulario:</h1>
      <center>
        <sf:form method="POST" modelAttribute="usuario">
          <table>
            <tr><td>Nombre:</td><td><sf:input path="nombre" id="usuario_nombre"/><br/><sf:errors path="nombre" cssClass="error" /></td></tr>
            <tr><td>Apellido:</td><td><sf:input path="apellido"  id="usuario_apellido"/></td></tr>
            <tr><td>Correo:</td><td><sf:input path="correo" id="usuario_correo"/></td></tr>
            <tr><td>Nonbre de Usuario:</td><td><sf:input path="login" id="usuario_login"/><sf:errors path="login" cssClass="error" /></td></tr>
            <tr><td>Clave:</td><td><sf:password path="password" showPassword="true" id="usuario_password"/></td></tr>
            <tr><td>Confirme su clave:</td><td><input type="password" name="password2"></td></tr>
          </table>
          <input class="btn" type="submit" value="Registrarse">
        </sf:form>
        <a href="/Miniproyecto/index">Iniciar Seci&oacute;n</a>
      </center>
    </div>
  </body>
</html>
