<%-- 
    Document   : registrado
    Created on : 19/03/2014, 05:36:49 AM
    Author     : federico
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<!DOCTYPE html>
<html>
    <tiles:insertDefinition name="header" />
    <head>
        <script src="${pageContext.request.contextPath}/static/js/jquery-3.2.1.slim.min.js"></script>
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