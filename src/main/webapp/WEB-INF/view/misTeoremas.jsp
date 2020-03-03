<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html>
  <tiles:insertDefinition name="header" />
  <body>
    <div id="modalLoading" class="modal" >
        <center>
           <div class="box-loading">
             <div class="lds-ring">
                <div></div>
                <div></div>
                <div></div>
                <div></div>
             </div>
             <center>Loading</center>
           </div>
        </center>
    </div>
    <c:choose>
        <c:when test="${isDifferentUser.intValue()==1}">
            <h1>Teoremas de ${usuario.getNombre()} ${usuario.getApellido()}</h1>
        </c:when>
        <c:otherwise>
            <tiles:insertDefinition name="nav" />
            <h1>Mis Teoremas</h1>
        </c:otherwise>
    </c:choose>
    <div class="row">
     <div id="misteoremas" class="col-lg-5">
     <ul>
      <c:forEach items="${categorias}" var="cat"> 
          <li ><h3 class="subtitle">${cat.getNombre()}</h3>
          <ul>
            <c:forEach items="${teoremas}" var="resu">
              <c:choose>
                <c:when test="${resu.getCategoria().getId()==cat.getId()}">      
                  <c:choose>
                    <c:when test="${!resu.isResuelto()}">
                      <li >
                        <p >
                             <i class="fa fa-lock" aria-hidden="true" ></i>
                          (${resu.getNumeroteorema()}) ${resu.getNombreteorema()}: &nbsp; $${resu.getTeorema().getTeoTerm().toStringInfFinal()}$                     
                        </p> 
                      </li>
                      
                    </c:when>
                    <c:otherwise>
                      <li >
                        <p >
                            <c:choose>
                            <c:when test="${!resu.isEsAxioma()}">
                                <a class="expandmeta" onclick="expandMeta(${resu.getTeorema().getId()})">
                                <i class="fa fa-plus-circle" aria-hidden="true" ></i>
                                </a>
                                <i class="fa fa-unlock" aria-hidden="true"></i>

                                <a href="javascript:buscarSoluciones(${resu.getTeorema().getId()});" title="Haga click para ver las demostraciones del teorema">(${resu.getNumeroteorema()}) ${resu.getNombreteorema()}: </a> &nbsp; $${resu.getTeorema().getTeoTerm().toStringInfFinal()}$
                                <span class="d-none" id="${resu.getTeorema().getId()}">

                                <br><span class="metaitem"></span>
                                <a href="javascript:buscarMetaSoluciones(${resu.getTeorema().getId()});" title="Haga click para ver las demostraciones del teorema">(${resu.getNumeroteorema()}) Metatheorem: </a> &nbsp; $${resu.getTeorema().getMetateoTerm().toStringInfFinal()}$
                                </span>
                            </c:when>
                            <c:otherwise>
                                <i class="fa fa-unlock" aria-hidden="true" ></i>
                                (${resu.getNumeroteorema()}) ${resu.getNombreteorema()}: &nbsp; $${resu.getTeorema().getTeoTerm().toStringInfFinal()}$                     
                        
                            </c:otherwise>
                          </c:choose>
                        </p>
                      </li>
                    </c:otherwise>
                  </c:choose>
                </c:when>
              </c:choose>
            </c:forEach>
          </ul>
        </li>
      </c:forEach> 
     </ul>
    
     </div>
     <div id="panelSoluciones" class="col-lg-2 d-none">
         <center><h3 class="subtitle"> Proofs</h3></center>
           <ul id="listaSoluciones">
            
           </ul>
     </div>
     <div class="col-lg-5" >
       <h5 id="formula"></h5>
     </div>
    </div>
    <c:choose>
        <c:when test="${isDifferentUser.intValue()!=1}">
            <tiles:insertDefinition name="footer" />
        </c:when>
    </c:choose>
  </body>
</html>
