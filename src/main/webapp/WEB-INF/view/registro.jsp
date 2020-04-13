<%-- 
    Document   : registo
    Created on : 09/03/2014, 03:56:16 AM
    Author     : federico
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<c:choose>
 <c:when test="${isRegistro=='1'}">
  <!DOCTYPE html>
   <html>
    <head>
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/static/img/bluemarine_favicon.ico" type="image/vnd.microsoft.icon" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css" >
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css" >
        <%--<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap-responsive.css" >--%>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CalcLogic</title>
    </head>
    <body>
        <div class="container-fluid" >
        <nav class="row navbar navbar-expand-lg navbar-dark bg-blue">
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#options">
                <span class="navbar-toggler-icon"></span>    
            </button>
          <div class="collapse navbar-collapse" id="options">
          <ul class="navbar-nav">
            <li class="nav-item" ><a href="index/help" class="nav-link">Help</a></li>
          </ul>
          </div>
        </nav>
 </c:when>
</c:choose>
        <div class="main-center">
        <div class="row justify-content-center">
         <h1>Fill the following form</h1>
        </div>
        <sf:form method="POST" modelAttribute="registro">
            <div class="form-group row justify-content-center">
                <label for="registro_nombre" class="col-lg-1 col-form-label">Name:</label>
                <div class="col-lg-3">
                 <sf:input path="nombre" id="registro_nombre" class="form-control"/><sf:errors path="nombre" cssClass="error" />
                </div>
            </div>
            <div class="form-group row justify-content-center">
                <label for="registro_apellido" class="col-lg-1 col-form-label">Last Name:</label>
                <div class="col-lg-3">
                 <sf:input path="apellido"  id="registro_apellido" class="form-control"/><sf:errors path="apellido" cssClass="error" />
                </div>
            </div>
            <div class="form-group row justify-content-center">
                <label for="registro_correo" class="col-lg-1 col-form-label">Mail:</label>
                <div class="col-lg-3">
                 <sf:input path="correo" id="registro_correo" class="form-control"/><sf:errors path="correo" cssClass="error" />
                </div>
            </div>
              <c:choose>
                <c:when test="${isRegistro=='1'}">
                 <div class="form-group row justify-content-center">
                  <label for="registro_login" class="col-lg-1 col-form-label">Login:</label>
                  <div class="col-lg-3">
                      <sf:input path="login" id="registro_login" class="form-control"/><sf:errors path="login" cssClass="error" />
                  </div>
                 </div>
                </c:when>
                <c:otherwise>
                 <div class="col-lg-3">
                  <sf:input path="login" id="registro_login" type="hidden"/>
                 </div>
                </c:otherwise>
               </c:choose>
            
            <div class="form-group row justify-content-center">
                <label for="registro_materiaid" class="col-lg-1 col-form-label">Subject:</label>
                <div class="col-lg-3">
                    <sf:select path="materiaid" id="registro_materiaid" class="form-control">
                        <sf:option value="0" label="Seleccione una materia"/>
                        <c:forEach items="${materias}" var="materia">
                            <sf:option value="${materia.id}" label="${materia.nombre}"/>
                        </c:forEach>
                    </sf:select>
                   <sf:errors path="materiaid" cssClass="error"/>
                </div>
            </div>
            <div class="form-group row justify-content-center">
                <label for="registro_password" class="col-lg-1 col-form-label">Password:</label>
                <div class="col-lg-3">
                 <sf:password path="password" showPassword="true" id="registro_password" class="form-control"/><sf:errors path="password" cssClass="error" />
                </div>
            </div>
            <div class="form-group row justify-content-center">
                <label for="registro_passwordConf" class="col-lg-1 col-form-label">Confirm Password:</label>
                <div class="col-lg-3">
                 <sf:password path="passwordConf" showPassword="true" id="registro_passwordConf" class="form-control"/><sf:errors path="passwordConf" cssClass="error" />
                </div>
            </div>
            <div class="row justify-content-center" >
             <div class="offset-lg-1 col-lg-3">
               <button class="btn btn-default" type="submit">${valueSubmit}</button>
             </div>
            </div>
        </sf:form>
          <c:choose>
           <c:when test="${isRegistro=='1'}">
            <div class="row justify-content-center" >
             <div class="offset-lg-1 col-lg-3">
              <a href="index">Log In</a>
             </div>
            </div>
           </c:when>
          </c:choose>
        </div>
<c:choose>
 <c:when test="${isRegistro=='1'}">
        </div>
    </body>
  </html>
 </c:when>
</c:choose>