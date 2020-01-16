<%-- 
    Document   : perfil
    Created on : 20/03/2014, 08:34:24 AM
    Author     : federico
--%>

<%--<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css" >
    <title>Miniproyecto</title>
    <base href="/Miniproyecto/perfil/"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css" >
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap-responsive.css" >
  </head>
  <body>
    <div class="navbar navbar-inverse navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <div class="nav-collapse collapse">
            <ul class="nav">
              <li class="active"><a href="${usuario.login}/guardar" style="padding-right:0px" >Guardar Predicado</a></li>
              <li><a href="${usuario.login}/listar?comb=n" style="padding-right:0px">listar T&eacute;rminos</a></li>
              <li><a href="${usuario.login}/publico?comb=n" style="padding-right:0px">ver t&eacute;rminos publicos</a></li>
              <li><a href="${usuario.login}/mispublic?comb=n" style="padding-right:0px">Mis publicaciones</a></li>
              <li><a href="${usuario.login}/ingresar" style="padding-right:0px">computar</a></li>
              <li><a href="${usuario.login}/close">cerrar sesi&oacute;n</a></li>
            </ul>
          </div>
        </div>
      </div>
    </div>--%>
    <div class="main-center">
          <div class="row justify-content-center">
            <h1 class="span6">${usuario.login.substring(0,1).toUpperCase()}${usuario.login.substring(1)}'s Profile</h1>
          </div>
          <div class="container">
           <div class="row justify-content-center" >
           <table>
             <tr><td>Name:</td><td>${usuario.getNombre()}</td></tr>
             <tr><td>Last Name:</td><td>${usuario.getApellido()}</td></tr>
             <tr><td>Mail:</td><td>${usuario.getCorreo()}</td></tr>
             <tr><td>&nbsp;</td><td><a href="editar"><button type="button" class="btn btn-default">Edit Profile</button></a></td></tr>
            </table>
            </div>
           </div>
