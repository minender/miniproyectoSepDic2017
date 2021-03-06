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
    <div class="container mt-5">
        <div class="row justify-content-center flex-column align-items-center" >
        <h1 style="margin-bottom: 40px">Select Theorem to Prove</h1>
        <iframe width="900" height="400" src="https://www.youtube.com/embed/tXh3lYiUwMQ" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
        </div>
        <div class="row justify-content-center flex-column align-items-center" >
        <h1 style="margin-bottom: 40px">Inference Fields</h1>
        <iframe width="900" height="400" src="https://www.youtube.com/embed/r9rYegG6gIk" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
        <h1 style="margin-bottom: 40px">Leibniz or Replacement Rule</h1>
        <iframe width="900" height="400" src="https://www.youtube.com/embed/Df6NlR2ZzUE" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
        </div>
        <div class="row justify-content-center flex-column align-items-center" >
        <h1 style="margin-bottom: 40px">Leibniz's Rule by Underlining</h1>
        <iframe width="900" height="400" src="https://www.youtube.com/embed/3vX6fVBZX2U" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
        </div>
        <div class="row justify-content-center flex-column align-items-center" >
        <h1 style="margin-bottom: 40px">Function Application in Variables of Type Function</h1>
        <iframe width="900" height="400" src="https://www.youtube.com/embed/ducWPQmiqPI" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
        </div>
        <div class="row justify-content-center flex-column align-items-center" >
        <h1 style="margin-bottom: 40px">Proof Method "Starting From One Side"</h1>
        <iframe width="900" height="400" src="https://www.youtube.com/embed/E8igQxqeanM" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
        </div>
        <div class="row justify-content-center flex-column align-items-center" >
        <h1 style="margin-bottom: 40px">Direct Method</h1>
        <iframe width="900" height="400" src="https://www.youtube.com/embed/xGWYNCULFk" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
        </div>
    </div>9
   <c:choose>
    <c:when test='${!sesion.equals("logout")}'>
        <tiles:insertDefinition name="footer" />
    </c:when>
   </c:choose>
</div>
 </body>
</html>