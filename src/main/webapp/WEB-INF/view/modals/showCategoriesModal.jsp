<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="exampleModalLabel">Configurations</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <h5>Show categories</h5>
                <ul>
                    <c:forEach items="${categorias}" var="categoria">
                        <div class="row flex align-items-center">
                            <li>${categoria.getNombre()}</li>
                            <c:choose>
                                <c:when test="${showCategorias.contains(categoria)}">
                                    <input type="checkbox" id="categoria-${categoria.getId()}" name="${categoria.getId()}" value="true" class="ml-2 categoria-settings" checked >
                                </c:when>
                                <c:otherwise>
                                    <input type="checkbox" id="categoria-${categoria.getId()}" name="${categoria.getId()}" value="true" class="ml-2 categoria-settings">
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:forEach>
                </ul>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button id="saveConfig" type="button" class="btn btn-primary" data-dismiss="modal">Save changes</button>
            </div>
        </div>
    </div>
</div>