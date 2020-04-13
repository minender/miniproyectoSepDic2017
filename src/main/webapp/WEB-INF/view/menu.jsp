<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="container-fluid">
        <nav class="row navbar navbar-expand-lg navbar-dark bg-blue">
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#options">
                <span class="navbar-toggler-icon"></span>    
            </button>
          <div class="collapse navbar-collapse" id="options">
          <ul class="navbar-nav nav-fill w-100">
            <li class="nav-item ${perfilMenu}"><a href="home" class="nav-link">Profile</a></li>
	    <li class="nav-item ${guardarMenu}" ><a href="guardar" class="nav-link">Add Abbreviation</a></li>
            <li class="nav-item ${listarTerminosMenu}"><a href="listar?comb=n" class="nav-link">My Abbreviations</a></li>
            <li class="nav-item ${misTeoremasMenu}"><a href="misTeoremas" class="nav-link">My Theorems</a></li>
            <li class="nav-item ${agregarTeoremaMenu}"><a href="guardarteo" class="nav-link">Add Theorems</a></li>
            <li class="nav-item ${computarMenu}"><a href="${pageContext.request.contextPath}/infer/${usuario.login}" class="nav-link">Prove</a></li>
            <c:choose>
                <c:when test="${isAdmin.intValue()==1}">
                    <li class="nav-item ${students}" ><a href="students" class="nav-link">Students</a></li>
                </c:when>    
                <c:otherwise>
                
                </c:otherwise>
            </c:choose>
            <c:choose>
                <c:when test="${isAdmin.intValue()==1}">
                    <li class="nav-item ${theoMenu}" ><a href="theo" class="nav-link">Theories</a></li>
                </c:when>
            </c:choose>
            <li class="nav-item ${helpMenu}" ><a href="help" class="nav-link">Help</a></li>
            <li class="nav-item" ><a href="close" class="nav-link">Sign Out</a></li>
          </ul>
          </div>
        </nav>

<%--
<div class="page-header">
    <h1 style="color: #03A9F4; font-size: 70px; margin-left: 20px;">Logica<small>Demostraciones de Lógica Simbólica</small></h1>
</div>

<div class="navbar navbar-default ">
  <div class="navbar-inner">
    <div class="container">
      <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <div class="nav-collapse collapse">
        <ul class="nav">
          <li ${computarMenu}><a href="../../infer/${usuario.login}">Demostrar</a></li>   
          <li ${listarTerminosMenu}><a href="listar?comb=n">Mis Abreviaciones</a></li>
          <li ${guardarMenu}><a href="guardar">Agregar Abreviación</a></li>
          <li ${misTeoremasMenu}><a href="misTeoremas">Mis Teoremas</a></li>
          <li ${agregarTeoremaMenu}><a href="guardarteo">Agregar Teorema</a></li>
          <li ${perfilMenu}><a href="./">Mi Perfil</a></li>
          <li style="float: right;"><a href="close">Cerrar Sesi&oacute;n</a></li>
        </ul>
      </div>
    </div>
  </div>
</div>
<div class="row-fluid" style="margin-left: 50px; margin-top: 40px; height:552px; width: ${anchuraDiv}; overflow-y:${overflow};">
--%>