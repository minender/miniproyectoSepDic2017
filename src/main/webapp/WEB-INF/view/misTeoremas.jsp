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
        <div class="row">
            <div id="myTheoremsSpace" class="col-lg-5">
                <jsp:include page="theoremsListMyTheorems.jsp"/>
            </div>
            <div id="panelSoluciones" class="col-lg-2 d-none">
                <center><h3 class="subtitle"> Proofs</h3></center>
                <ul id="listaSoluciones"></ul>
            </div>
            <div class="col-lg-5" >
                <h5 id="formula"></h5>
            </div>
        </div>
                        
        <!-- Include custom modal for selecting the categories that will be displayed -->
        <jsp:include page="showCategoriesModal.jsp" />

        <script>
            document.getElementById("saveConfig").onclick = function(){
                saveDisplayedCategories("myTheorems");
            }  
        </script>
        <%--<c:choose>
                <c:when test="${isDifferentUser.intValue()!=1}">
                        <tiles:insertDefinition name="footer" />
                </c:when>
        </c:choose>--%>
    </body>
</html>