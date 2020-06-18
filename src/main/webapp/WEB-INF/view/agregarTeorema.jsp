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
    <tiles:insertDefinition name="header" />
  <%--<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css" >
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css" >
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap-responsive.css" >
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/desplegar.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <title>L&oacute;gica | Agregar Teorema</title>
    <tiles:insertDefinition name="style" />
  </head>--%>
  <body>
    <tiles:insertDefinition name="nav" />
    <div class="row justify-content-center">
      <h1>Enter the theorem that you want to save</h1>
    </div>
    <c:choose>
      <c:when test="${modificar.intValue()==0}">
        <sf:form method="POST" modelAttribute="agregarTeorema">
          <c:choose>
            <c:when test='${usuario.isAdmin()}'>
              <div class="form-group row justify-content-center">
               <div class="col-lg-3">
                <sf:checkbox path="axioma" value="false" />
                <label for="axioma" class="col-lg-1 col-form-label">Axiom</label>
               </div>
              </div>
            </c:when>
          </c:choose>
          
          <tiles:insertDefinition name="jaxButtons" />
          <c:set var="rootId" value="teoremaSymbolsId" scope="request"/>  
          <c:set var="labelName" value="Theorem:" scope="request"/>
          <c:set var="inputForm" value="teorema" scope="request"/>
          <tiles:insertDefinition name="jaxDiv" />
          <div class="form-group row justify-content-center">
            <button type="button" onclick="cleanJax('teoremaSymbolsId')" class="btn btn-default">Clean</button>
          </div>    
              
          <div class="form-group row justify-content-center" style="display: none;">
              <label for="teorema" class="col-lg-1 col-form-label">Theorem:</label>
            <div class="col-lg-3">
               <sf:input path="teorema" id="teorema" value="${teorema}" class="form-control"/><sf:errors path="teorema" cssClass="error" /><br/>
            </div>
           </div>
          
          <div class="form-group row justify-content-center">
              <label for="tipo" class="col-lg-1 col-form-label">Type:</label>
              <div class="col-lg-3">
                <select class="form-control" id="selecTipo" name="tipoSeleccionado">
                  <option value="">Lógica Proposicional</option>
                  <option value="">Lógica de Predicado</option>
                </select>
              </div>
          </div>
          <div class="form-group row justify-content-center">
              <label for="categoria" class="col-lg-1 col-form-label">Category:</label>
              <div class="col-lg-3">
                <select class="form-control" id="selecCateg" name="categoriaSeleccionada">
                 <c:forEach items="${categoria}" var="cat">
                  <option value="${cat.getId()}" <c:choose><c:when test='${cat.getId()==selected}'>selected="selected"</c:when></c:choose>${selected}>${cat.getId()} - ${cat.getNombre()}</option>
                 </c:forEach>  
                </select>  
              </div>
          </div>
          <div class="form-group row justify-content-center">
              <label for="numeroT" class="col-lg-1 col-form-label">Theorem Number:</label>
              <div class="col-lg-3">
                <sf:input class="form-control" path="numeroTeorema" value="${numeroTeorema}"/><sf:errors path="numeroTeorema" cssClass="error" />  
              </div>
          </div>
          <div class="form-group row justify-content-center">
              <label for="nombreT" class="col-lg-1 col-form-label">Theorem Name (Optional):</label>
              <div class="col-lg-3">
                <sf:input class="form-control" path="nombreTeorema" value="${nombreTeorema}"/><sf:errors path="nombreTeorema" cssClass="error" />
              </div>
          </div>
          <div class="row justify-content-center" >
               <div class="offset-lg-1 col-lg-3">
                   <button type="submit" class="btn btn-default" onclick="setInputValueOnParser('teoremaSymbolsId')">Save</button>
               </div>
          </div>
          <div class="row justify-content-center" >
               <div class="offset-lg-1 col-lg-3">
                   &nbsp;
               </div>
          </div>
        </sf:form>${mensaje}
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
