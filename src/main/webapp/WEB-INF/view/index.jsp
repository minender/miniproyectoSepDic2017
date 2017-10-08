<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Welcome to Spring Web MVC project</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css" >
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css" >
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap-responsive.css" >
  </head>

  <body>
    <div class="row-fluid" style="margin-left: 50px; height:552px; width: 1100px; overflow: hidden;">
      <h1>Bienvenido a David</h1>
      <h2 contenteditable="true">Inicie sesión o regístrese para continuar </h2>
      <center>
        <sf:form method="POST" modelAttribute="usuariolog">
          <table>
            <tr><td>Nombre de Usuario:</td><td><sf:input path="login" id="usuariolog_login"/></td></tr>
            <tr><td>Clave:</td><td><sf:password path="password" showPassword="true" id="usuariolog_password"/></td></tr>
          </table>
          <input class="btn" type="submit" value="Ingresar">
        </sf:form>${mensaje}
        <a href="registro?new">Registrarse</a>
      </center>
    </div>
  </body>
</html>
