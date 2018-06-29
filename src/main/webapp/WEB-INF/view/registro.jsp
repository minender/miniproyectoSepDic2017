<%-- 
    Document   : registo
    Created on : 09/03/2014, 03:56:16 AM
    Author     : federico
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
  <head>
    <style>
      .error {
        color: #ff0000;
      }
    </style>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css" >
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css" >
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap-responsive.css" >
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>L&oacute;gica | Registro</title>
  </head>
  <body>
    <div class="row-fluid" style="margin-left: 50px; height:552px; width: 1100px; overflow: hidden;">
      <h1>Llene el siguiente formulario:</h1>
      <center>
        <sf:form method="POST" modelAttribute="registro">
          <table>
            <tr><td>Nombre:</td><td><sf:input path="nombre" id="registro_nombre"/><sf:errors path="nombre" cssClass="error" /></td></tr>
            <tr><td>Apellido:</td><td><sf:input path="apellido"  id="registro_apellido"/><sf:errors path="apellido" cssClass="error" /></td></tr>
            <tr><td>Correo:</td><td><sf:input path="correo" id="registro_correo"/><sf:errors path="correo" cssClass="error" /></td></tr>
            <c:choose>
             <c:when test="${isRegistro=='1'}">
              <tr><td>Nombre de Usuario:</td><td><sf:input path="login" id="registro_login" /><sf:errors path="login" cssClass="error" /></td></tr>
             </c:when>
             <c:otherwise>
              <sf:input path="login" id="registro_login" type="hidden"/>   
             </c:otherwise>
            </c:choose>
            <tr><td>Materia:</td>
                <td><sf:select path="materiaid" id="registro_materiaid">
                   <sf:option value="0" label="Seleccione una materia"/>
                   <c:forEach items="${materias}" var="materia">
                       <sf:option value="${materia.id}" label="${materia.nombre}"/>
                   </c:forEach>
                  </sf:select>
                <sf:errors path="materiaid" cssClass="error"/></td>
            </tr>
            <tr><td>Clave:</td><td><sf:password path="password" showPassword="true" id="usuario_password"/><sf:errors path="password" cssClass="error" /></td></tr>
            <tr><td>Confirme su clave:</td><td><sf:password path="passwordConf" showPassword="true" id="registro_passwordConf"/><sf:errors path="passwordConf" cssClass="error" /></td></tr>
          </table>
          <input class="btn" type="submit" value="${valueSubmit}">
        </sf:form>
         <c:choose>
           <c:when test="${isRegistro=='1'}">
             <a href="/Miniproyecto/index">Iniciar Seci&oacute;n</a>
           </c:when>
         </c:choose>
       
      </center>
    </div>
  </body>
</html>
