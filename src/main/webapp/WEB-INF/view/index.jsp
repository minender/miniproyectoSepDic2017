<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>CalcLogic</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/static/img/bluemarine_favicon.ico" type="image/vnd.microsoft.icon" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css" >
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css" >
    <script src="${pageContext.request.contextPath}/static/js/jquery-3.2.1.slim.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
  </head>

  <body>
        <div class="container-fluid" >
        <nav class="row navbar navbar-expand-lg navbar-dark bg-blue">
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#options">
                <span class="navbar-toggler-icon"></span>    
            </button>
          <div class="collapse navbar-collapse" id="options">
          <ul class="navbar-nav">
            <li class="nav-item" ><a href="index/help" class="nav-link">Help</a></li>
          </ul>
          </div>
        </nav>
        <div class="main-center">

        <div class="row justify-content-center">
          <h1>CalcLogic</h1>
        </div>
        <div class="row justify-content-center">
          <h3>Interactive Theorem Asistant for Calculative Logic</h3>
        </div>
        
        <sf:form method="POST" modelAttribute="usuariolog">
         <div class="form-group row justify-content-center">
           <label for="usuariolog_login" class="col-lg-1 col-form-label">Login:</label>
            <div class="col-lg-3">
             <sf:input path="login" id="usuariolog_login" class="form-control"/>
            </div>
         </div>
         <div class="form-group row justify-content-center">
           <label for="usuariolog_password" class="col-lg-1 col-form-label">Password:</label>
            <div class="col-lg-3">
             <sf:password path="password" showPassword="true" id="usuariolog_password" class="form-control"/>
            </div>
         </div>
          <div class="row justify-content-center" >
           <div class="offset-lg-1 col-lg-3">
               <button type="submit" class="btn btn-default">Log In</button>
           </div>
          </div>
        </sf:form>
        <div class="row justify-content-center" >
         <div class="offset-lg-1 col-lg-3">
          <a href="registro?new">Register</a>
         </div>
        </div>
        <div class="row justify-content-center" >
         <div class="offset-lg-1 col-lg-3">
             <span class="error">${mensaje}</span>
         </div>
        </div>
        <div class="description-index">
         <div class="row">
          <div class="col-lg-2">
          </div>
          <div class="col-lg-8">
           <p class="text-justify">CalcLogic is a web application to assist in an interactive way, proofs written in Dijkstra-Scholten calculative logic.</p>
          </div>
          <div class="col-lg-2">
          </div>
         </div>
        </div>
        </div>
        </div>
    </body>
  <%--<body>
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
  --%>
</html>
