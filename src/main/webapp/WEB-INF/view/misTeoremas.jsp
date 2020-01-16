<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html>
  <tiles:insertDefinition name="header" />
  <body>
    <tiles:insertDefinition name="nav" />
    <h1>Mis Teoremas</h1>
    <div id="teoremas" style="float: left; width: 35%;">
    <ul>
      <c:forEach items="${categorias}" var="cat"> 
        <li style="list-style: none; color: #03A9F4"><h3>${cat.getNombre()}</h3>
          <ul>
            <c:forEach items="${teoremas}" var="resu">
              <c:choose>
                <c:when test="${resu.getTeorema().getCategoria().getId()==cat.getId()}">      
                  <c:choose>
                    <c:when test="${!resu.isResuelto()}">
                      <li style="list-style: none;">
                        <p style="color: #000;">
                             <i class="fa fa-lock" aria-hidden="true" style="margin-right: 15px;"></i>
                          (${resu.getNumeroteorema()}) ${resu.getNombreteorema()}: &nbsp; $${resu.getTeorema().getTeoTerm().toStringInfFinal()}$                     
                        </p> 
                      </li>
                      
                    </c:when>
                    <c:otherwise>
                      <li style="list-style: none;">
                        <p style="color: #000;">
                            <c:choose>
                            <c:when test="${!resu.isEsAxioma()}">
                                <a style="text-decoration: none" onclick="expandMeta(${resu.getTeorema().getId()})">
                                <i class="fa fa-plus-circle" aria-hidden="true"  style="margin-right: 10px;"></i>
                                </a>
                                <i class="fa fa-unlock" aria-hidden="true" style="margin-right: 10px;"></i>

                                <a style="text-decoration: none" href="javascript:buscarSoluciones(${resu.getTeorema().getId()});"style="cursor:pointer;" title="Haga click para ver las demostraciones del teorema">(${resu.getNumeroteorema()}) ${resu.getNombreteorema()}: </a> &nbsp; $${resu.getTeorema().getTeoTerm().toStringInfFinal()}$
                                <span style="display: none;" id="${resu.getTeorema().getId()}">

                                <br><span  style="margin-left: 53px;"></span>
                                <a style="text-decoration: none" href="javascript:buscarMetaSoluciones(${resu.getTeorema().getId()});"style="cursor:pointer;" title="Haga click para ver las demostraciones del teorema">(${resu.getNumeroteorema()}) Metatheorem: </a> &nbsp; $${resu.getTeorema().getMetateoTerm().toStringInfFinal()}$
                                </span>
                            </c:when>
                            <c:otherwise>
                                <i class="fa fa-unlock" aria-hidden="true" style="margin-right: 10px;"></i>
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
    
    <script>
      function expandMeta(id) {
        elem = document.getElementById(id);
        if (elem.style.display == "inline")
          elem.style.display = "none";
        else
          elem.style.display = "inline";
        
      }
    </script>
    </div>
    <div id="panelSoluciones" style="float:left; width: 48%; margin-left: 5%; margin-right: 2%; display:none">
        
        <div id="listaSoluciones" style="float:left; width: 20%;">
            <h3> Soluciones</h3>
            <ul id="lista">
            <li style="list-style: none;">
                uno
            </li>
            <li style="list-style: none;">
                dos
            </li>
            <li style="list-style: none;">
                tres
            </li>
            </ul>
        </div>
        <div style="float:right; width: 80%; height: 60%; overflow: scroll;">
            <h5 id="formula"></h5>
        </div>
    </div>
    <tiles:insertDefinition name="footer" />
  </body>
</html>
