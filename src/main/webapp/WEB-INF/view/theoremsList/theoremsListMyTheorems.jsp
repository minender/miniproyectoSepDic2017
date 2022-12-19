<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div id="myTheorems">
    <div id="showNoCategories">
        <c:choose>
            <c:when test="${showCategorias.size() == 0}">
                You currently have no categories to display. Adjust your settings with the gear button above               
            </c:when>
        </c:choose>
    </div>

    <ul style="list-style: none;">
        <c:forEach items="${showCategorias}" var="cat"> 
            <li id="category-${cat.getId()}"><h3 class="subtitle">${cat.getNombre()}</h3>
                <ul style="list-style: none;">
                    <c:forEach items="${resuelves}" var="resu">
                        <c:choose>
                            <c:when test="${resu.getCategoria().getId()==cat.getId()}">      
                                <c:choose>
                                    <c:when test="${((!resu.isResuelto()) && resu.getDemopendiente() < 1) || (resu.isEsAxioma() && resu.getUsuario().getLogin().equals('AdminTeoremas'))}">
                                        <li>
                                            <p>
                                                <c:choose>
                                                    <c:when test="${resu.isResuelto()}">
                                                        <i class="fa fa-unlock" aria-hidden="true" ></i>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="fa fa-lock" aria-hidden="true" ></i>
                                                    </c:otherwise>
                                                </c:choose>
                                                (${resu.getNumeroteorema()}) ${resu.getNombreteorema()}: &nbsp; ${resu.getTeorema().getTeoTerm().evaluar(resu.getVariables()).toStringLaTeXJavascript(simboloManager,predicadoManager,"",resu.getNumeroteorema())}
                                                <c:choose>
                                                    <c:when test="${!resu.getUsuario().getLogin().equals('AdminTeoremas') || usuario.getLogin().equals('AdminTeoremas')}">
                                                        <a onclick="return confirm('Are you sure you want to delete the theorem?')" href="javascript:delTeo(${resu.getTeorema().getId()})"><i class="fa fa-trash" aria-hidden="true" ></i></a>
                                                        <a onclick="return confirm('Do you want to edit this theorem?')" href="editarteo/${resu.getTeorema().getId()}"><i class="fa fa-pencil" aria-hidden="true" ></i></a>
                                                    </c:when>
                                                </c:choose>
                                            </p> 
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <li>
                                            <p>
                                                <c:choose>
                                                    <c:when test="${!resu.isEsAxioma()}">
                                                        <a class="expandmeta" onclick="expandMeta(${resu.getTeorema().getId()})">
                                                            <i class="fa fa-plus-circle" aria-hidden="true" ></i>
                                                        </a>
                                                        <c:choose>
                                                            <c:when test="${resu.isResuelto()}">
                                                                <i class="fa fa-unlock" aria-hidden="true"></i>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <i class="fa fa-lock" aria-hidden="true" ></i>        
                                                            </c:otherwise>
                                                        </c:choose>

                                                        <a href="javascript:buscarSoluciones(${resu.getTeorema().getId()});" title="Haga click para ver las demostraciones del teorema">(${resu.getNumeroteorema()}) ${resu.getNombreteorema()}: </a> &nbsp; ${resu.getTeorema().getTeoTerm().evaluar(resu.getVariables()).toStringLaTeXJavascript(simboloManager,predicadoManager,"",resu.getNumeroteorema())}
                                                        <span class="d-none" id="${resu.getTeorema().getId()}">
                                                            <br><span class="metaitem"></span>
                                                            <a href="javascript:buscarMetaSoluciones(${resu.getTeorema().getId()});" title="Haga click para ver las demostraciones del teorema">(${resu.getNumeroteorema()}) with Metatheorem (3.7): </a> &nbsp; ${resu.getTeorema().getMetateoTerm().toStringLaTeXJavascript(simboloManager,predicadoManager,"",resu.getNumeroteorema())}
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="fa fa-unlock" aria-hidden="true" ></i>
                                                        (${resu.getNumeroteorema()}) ${resu.getNombreteorema()}: &nbsp; ${resu.getTeorema().getTeoTerm().evaluar(resu.getVariables()).toStringLaTeXJavascript(simboloManager,predicadoManager,"",resu.getNumeroteorema())}                     
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