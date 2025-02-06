<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="container-fluid">
    <nav class="row navbar navbar-expand-lg navbar-dark bg-blue">
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#options">
            <span class="navbar-toggler-icon"></span>    
        </button>
        <div class="collapse navbar-collapse" id="options">
            <ul class="navbar-nav nav-fill w-100">
                <li class="nav-item ${perfilMenu}"><a href="${urlPrefix}home" class="nav-link">Profile</a></li>
                <li class="nav-item ${guardarMenu}" ><a href="${urlPrefix}guardar" class="nav-link">Add Abbreviation</a></li>
                <li class="nav-item ${listarTerminosMenu}"><a href="${urlPrefix}listar?comb=n" class="nav-link">My Abbreviations</a></li>
                <li class="nav-item ${misTeoremasMenu}"><a id="linkMyTheorems" href="${urlPrefix}myTheorems" class="nav-link">My Theorems</a></li>
                <li class="nav-item ${agregarTeoremaMenu}"><a href="${urlPrefix}guardarteo" class="nav-link">Add Theorems</a></li>
                <li class="nav-item ${proveMenu}"><a href="${pageContext.request.contextPath}/infer/${usuario.login}" class="nav-link">Prove</a></li>
                <c:choose>
                    <c:when test="${isAdmin.intValue()==1}">
                        <li class="nav-item ${students}" ><a href="${urlPrefix}students" class="nav-link">Students</a></li>
                        <!--<li class="nav-item ${theoMenu}" ><a href="${urlPrefix}theo" class="nav-link">Theories</a></li>-->
                        <li class="nav-item dropdown ${theoriesMenu}">
                            <a class="nav-link dropdown-toggle" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                              Theories
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                              <li><a class="dropdown-item" href="${urlPrefix}theo">Symbols Manage</a></li>
                              <li><a class="dropdown-item" href="${urlPrefix}addTheory">Add Theory</a></li>
                            </ul>
                        </li>
                        <li class="nav-item ${catMenu}" ><a href="${urlPrefix}guardarcat" class="nav-link">Add Category</a></li>
                    </c:when>    
                </c:choose>
                <li class="nav-item ${helpMenu}" ><a href="${urlPrefix}help" class="nav-link">Help</a></li>
                <li class="nav-item" ><a id="linkCloseSession" href="${urlPrefix}close" class="nav-link">Sign Out</a></li>
            </ul>
        </div>
    </nav>
</div>
            
<script>
    $(document).ready(function () {
        $(document).click(function (event) {
            var clickover = $(event.target);
            var $navbar = $(".dropdown-menu");
            var $toggle = $(".dropdown-toggle");

            if (!$toggle.is(clickover) && !$navbar.is(clickover) && $navbar.has(event.target).length === 0) {
                $navbar.removeClass("show");
            }
        });

        $(".dropdown-toggle").click(function () {
            $(this).next(".dropdown-menu").toggleClass("show");
        });
    });
</script>

<%--
<div class="page-header">
    <h1 style="color: #03A9F4; font-size: 70px; margin-left: 20px;">Logica<small>Demostraciones de L�gica Simb�lica</small></h1>
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
          <li ${guardarMenu}><a href="guardar">Agregar Abreviaci�n</a></li>
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