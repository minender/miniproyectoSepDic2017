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

    <c:forEach items="${showCategorias}" var="cat">
        <li style="list-style: none; color: #03A9F4"><h4><a data-toggle="collapse" href='#collapse-${cat.getNombre().replaceAll(" ","-")}' role="button" aria-expanded="false" aria-controls='collapse-${cat.getNombre().replaceAll(" ","-")}' class="collapse-link">${cat.getNombre()}</a><i style="font-size : 20px"class="ml-1 fa fa-chevron-down" aria-hidden="true"></i></h4> 
            <ul id='collapse-${cat.getNombre().replaceAll(" ","-")}' class="collapse">
                <c:set var="vars" value=""/>
                <c:forEach items="${resuelves}" var="resu">
                    <c:choose>
                        <c:when test="${resu.getCategoria().getId()==cat.getId()}">
                            <li ${!selecTeo && resu.getNumeroteorema().equals(nTeo)?"id=currentTeo":""} style="list-style: none;">
                                <h6 style="color: #000;">
                                    <c:choose>
                                        <c:when test="${!selecTeo}"> 
                                            <c:choose>
                                                <c:when test="${resu.isResuelto()}"> 
                                                    <%--|| resu.getNumeroteorema().equals(nTeo)}">--%>
                                                    <%--<c:set var="vars" value="${resu.getTeorema().getTeoTerm().setToPrint(simboloManager).stFreeVars(simboloManager)}"/>--%>
                                                    <c:choose>
                                                        <c:when test="${!resu.getNumeroteorema().equals(nTeo)}">
                                                            <a onclick="expandMeta('${resu.getNumeroteorema()}','${resu.getVariables().split(";")[1]}')" >
                                                                <i class="fa fa-plus-circle" aria-hidden="true"  style="cursor:pointer; margin-left: 10px; margin-right: 10px;"></i>
                                                            </a>
                                                        </c:when>
                                                    </c:choose>                                    
                                                    <span id="teoIdName${resu.getNumeroteorema()}" class="teoIdName">(${resu.getNumeroteorema()}) ${resu.getNombreteorema()}:</span> &nbsp;<span id="click${resu.getNumeroteorema()}">$${resu.getTeorema().getTeoTerm().evaluar(resu.getVariables()).toStringLaTeX(simboloManager,resu.getNumeroteorema())}$</span>

                                                    <script type="text/javascript">clickTeoremaInicial('ST-${resu.getNumeroteorema()}');
                                                            clickOperator('click${resu.getNumeroteorema()}','nStatement_id','ST-${resu.getNumeroteorema()}','${resu.getTeorema().getTeoTerm().stFreeVars(simboloManager)}');
                                                    </script>

                                                    <c:choose>
                                                        <c:when test="${!resu.getNumeroteorema().equals(nTeo)}">
                                                            <span style="display: none;" id="metaTeo${resu.getNumeroteorema()}">
                                                                <br>
                                                                <span  style="margin-left: 10px; margin-right: 10px;">&nbsp;&nbsp;&nbsp;&nbsp;</span>                
   
                                                                <%--<span id="metateoIdName${resu.getNumeroteorema()}" class="teoIdName">(${resu.getNumeroteorema()}) with Metatheorem (3.7):</span> &nbsp; <span id="clickmeta${resu.getNumeroteorema()}">$${resu.getTeorema().getMetateoTerm().toStringLaTeX(simboloManager,"")}$</span> --%>

                                                                <%--BUSCAR (LUEGO BORRAR ESTE COMENTARIO) --%>
                                                                <div id="metateoIdName${resu.getNumeroteorema()}" class="teoIdName">
                                                                </div>
       
                                                                <%--<script type="text/javascript">clickTeoremaInicial('MT-${resu.getNumeroteorema()}');
                                                                    clickOperator('clickmeta${resu.getNumeroteorema()}','nStatement_id','MT-${resu.getNumeroteorema()}','${resu.getTeorema().getTeoTerm().freeVars()}');
                                                                </script>--%>
                                                            </span>
                                                        </c:when>
                                                    </c:choose>
                                                </c:when>
                                            </c:choose>
                                        </c:when>

                                        <c:otherwise>
                                            <c:choose>
                                                <c:when test="${resu.isResuelto()}">
                                                    <i class="fa fa-unlock" aria-hidden="true" style="margin-right: 10px;"></i>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="fa fa-lock" aria-hidden="true" style="margin-right: 15px;"></i>
                                                </c:otherwise>
                                            </c:choose>
        
                                            <c:choose>
                                                <c:when test="${!resu.isEsAxioma()}">
                                                    <a onclick="return confirm('${resu.getDemopendiente() == -1 ? "You are going to prove the theorem":"You have left an incomplete proof of the theorem"} ${resu.getNumeroteorema()}${resu.getDemopendiente() == -1 ? "":". To be continued the proof from the point where you left it;"}')" href="../../infer/${usuario.getLogin()}/${resu.getNumeroteorema()}">(${resu.getNumeroteorema()}) ${resu.getNombreteorema()}:</a> &nbsp; $${resu.getTeorema().getTeoTerm().evaluar(resu.getVariables()).toStringLaTeX(simboloManager,mensaje)}$
                                                </c:when>

                                                <c:otherwise>
                                                    (${resu.getNumeroteorema()}) ${resu.getNombreteorema()}: &nbsp; $${resu.getTeorema().getTeoTerm().evaluar(resu.getVariables()).toStringLaTeX(simboloManager,"")}$
                                                </c:otherwise>
                                            </c:choose>
                                            <%--<span style="display: none;" id="metaTeo${resu.getNumeroteorema()}">
                                                <br><span  style="margin-left: 10px; margin-right: 10px;">&nbsp;&nbsp;&nbsp;&nbsp;</span>
                                                <c:choose>
                                                    <c:when test="${resu.isResuelto()}">
                                                        <i class="fa fa-unlock" aria-hidden="true" style="margin-right: 10px;"></i>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="fa fa-lock" aria-hidden="true" style="margin-right: 10px;"></i>
                                                    </c:otherwise>
                                                </c:choose>
                                                (${resu.getNumeroteorema()}) Metatheorem: &nbsp; $${resu.getTeorema().getMetateoTerm().toStringLaTeXFinal()}$  
                                                <script type="text/javascript">clickOperator('metaTeo${resu.getNumeroteorema()}','nStatement_id','${resu.getNumeroteorema()}');</script>
                                            </span>--%>
                                        </c:otherwise>
                                    </c:choose>
                                </h6>
                            </li>
                        </c:when>
                    </c:choose>
                </c:forEach>
            </ul>
        </li>
    </c:forEach> 
</div>