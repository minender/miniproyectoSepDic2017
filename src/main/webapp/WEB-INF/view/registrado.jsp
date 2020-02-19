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
            <li class="nav-item" ><a href="index/help" class="nav-link">Theoretical Basis</a></li>
          </ul>
          </div>
        </nav>
        <div class="main-center">

        <div class="row justify-content-center">
          <h1> ${usuario.login.substring(0,1).toUpperCase()}${usuario.login.substring(1)}, you have successfully registered</h1>
        </div>
        
        <div class="row justify-content-center">
               Now you can enter the application by clicking 
        </div>
        <div class="row justify-content-center">
               <a href="index">here</a>
        </div>

        </div>
        </div>
    </body>
</html>