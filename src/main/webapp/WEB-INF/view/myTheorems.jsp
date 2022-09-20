<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html>
    <tiles:insertDefinition name="header" />

    <c:choose>
        <c:when test="${isDifferentUser.intValue()==1}">
            <style>
                html{
                    padding-left:15px;
                }
            </style>
        </c:when>
    </c:choose>
    
    <body>
        <!-- To show the word Loading in the center of the screen -->
        <jsp:include page="modals/loadingModal.jsp"/>

        <!-- For selecting the categories that will be displayed -->
        <jsp:include page="modals/showCategoriesModal.jsp" />

        <c:choose>
            <c:when test="${isDifferentUser.intValue()==1}">
                <div class="row flex align-items-center">
                    <h1>Theorems from ${usuario.getNombre()} ${usuario.getApellido()}</h1>
                    <a data-target="#exampleModal" data-toggle="modal">            
                        <i id="cate-cog" class="fa fa-cog ml-2" aria-hidden="true"></i>                
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <tiles:insertDefinition name="nav" />
                <div class="row flex align-items-center">
                    <h1>My Theorems</h1>
                    <a data-target="#exampleModal" data-toggle="modal">            
                        <i id="cate-cog" class="fa fa-cog ml-2" aria-hidden="true"></i>                
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
        <div class="row" style="display:flex">
            <article id="myTheoremsSpace" class="col-lg-5" style="height:600px; overflow:scroll">
                <jsp:include page="theoremsList/theoremsListMyTheorems.jsp"/>
            </article>
            <article class="col-lg-7" style="display:flex; flex-direction:row; position:relative; height:600px; overflow:scroll">
                <div id="panelSoluciones" class="col-lg-3 d-none">
                    <h3 class="subtitle">Proofs</h3>
                    <ul id="listaSoluciones"></ul>
                </div>
                <div class="col-lg-5" >
                    <h5 id="formula"></h5>
                </div>
            </article>
        </div>

        <script>
            document.getElementById("saveConfig").onclick = function(){
                saveDisplayedCategories("myTheorems");
            }  
        </script>
    </body>
</html>