<%-- 
    Document   : introducirTermino
    Created on : 06/05/2014, 02:16:02 PM
    Author     : federico
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css" >
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css" >
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap-responsive.css" >
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/desplegar.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <title>L&oacute;gica | Agregar Teorema</title>
    <tiles:insertDefinition name="style" />
  </head>
  <body>
    <tiles:insertDefinition name="header" />
    <h1>Introduzca el teorema que desea agregar</h1>
    <c:choose>
      <c:when test="${modificar.intValue()==0}">
        <sf:form method="POST" modelAttribute="agregarTeorema">
          <c:choose>
            <c:when test='${usuario.isAdmin()}'>
              <label style="display: -webkit-inline-box; margin-right: 4px;"><sf:checkbox path="axioma" style="margin: 0 4px 0 0;" value="false" />Axioma</label>
            </c:when>
          </c:choose>
          <label style="display: -webkit-inline-box"><input type="checkbox" style="margin: 0 4px 0 0;" value="" >Es Esquema</label>
          <br>
          Teorema:<br><sf:input path="teorema" value="${teorema}"/><sf:errors path="teorema" cssClass="error" /><br/>
          Tipo: <br>
          <select class="form-control" id="selecTipo" name="tipoSeleccionado">
            <option value="">Lógica Propocisional</option>
            <option value="">Lógica de Predicado</option>
          </select><br>
          Categoría:<br>
          <select class="form-control" id="selecCateg" name="categoriaSeleccionada">
            <c:forEach items="${categoria}" var="cat">
              <option value="${cat.getId()}" <c:choose><c:when test='${cat.getId()==selected}'>selected="selected"</c:when></c:choose>${selected}>${cat.getId()} - ${cat.getNombre()}</option>
            </c:forEach>  
          </select><br>
<%--          Número de Categoria:<br><sf:input path="categoria" value="${categoria}"/><sf:errors path="categoria" cssClass="error" /><br/>--%>
          Número de Teorema:<br><sf:input path="numeroTeorema" value="${numeroTeorema}"/><sf:errors path="numeroTeorema" cssClass="error" /><br/>
          Nombre de Teorema (Opcional):<br><sf:input path="nombreTeorema" value="${nombreTeorema}"/><sf:errors path="nombreTeorema" cssClass="error" /><br/>
          <input class="btn" type="submit" value="Guardar">
        </sf:form><br>${mensaje}
      </c:when>
      <c:otherwise>
        <c:choose>
          <c:when test="${modificar.intValue()==1}">
            <sf:form method="POST" modelAttribute="modificarForm">
              Término:<br><sf:textarea path="termino" id="termino_string" style="height: 80px; width: 526px;"/><sf:errors path="termino" cssClass="error" /><br/>
              <input type="submit" value="Guardar">
            </sf:form>${mensaje}
          </c:when>
          <c:otherwise>
            <sf:form method="POST" modelAttribute="modificarAliasForm">
              Alias:<sf:input path="alias" id="termino_alias" value="${alias}"/><sf:errors path="alias" cssClass="error" /><br/>
              <input type="submit" value="Guardar">
            </sf:form>${mensaje}
          </c:otherwise>
        </c:choose>
      </c:otherwise>
    </c:choose>
    <tiles:insertDefinition name="footer" />
  </body>
</html>