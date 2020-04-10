<%-- 
    Document   : help
    Created on : Feb 1, 2020, 6:49:57 PM
    Author     : federico
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html>
    <tiles:insertDefinition name="header" />
 <body>
        <c:choose>
            <c:when test='${sesion.equals("logout")}'>
      <div class="container-fluid">
        <nav class="row navbar navbar-expand-lg navbar-dark bg-blue">
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#options">
                <span class="navbar-toggler-icon"></span>    
            </button>
          <div class="collapse navbar-collapse" id="options">
          <ul class="navbar-nav">
                <li class="nav-item active" ><a href="theo" class="nav-link">Help</a></li>
                <li class="nav-item" ><a href=".." class="nav-link">Log In</a></li>
          </ul>
          </div>
        </nav>
            </c:when>
            <c:otherwise>
              <tiles:insertDefinition name="nav" />
            </c:otherwise>
        </c:choose>
<div class="main-center">
    <iframe width="560" height="315" src="https://www.youtube.com/embed/dQw4w9WgXcQ" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen>
    </iframe>
</div>
   <c:choose>
    <c:when test='${!sesion.equals("logout")}'>
        <tiles:insertDefinition name="footer" />
    </c:when>
   </c:choose>
</div>
 </body>
</html>
