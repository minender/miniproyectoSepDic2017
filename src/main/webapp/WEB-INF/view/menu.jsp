<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="page-header">
    <h1 style="color: #03A9F4; font-size: 70px; margin-left: 20px;">L&oacute;gica<small>Demostraciones de Lógica Simbólica</small></h1>
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
          <li ${computarMenu}><a id="linkDemostrar" href="../../infer/${usuario.login}">Demostrar</a></li>   
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
<div class="row-fluid" style="margin-left: 50px; margin-top: 40px; width: 100%;height: 70%">