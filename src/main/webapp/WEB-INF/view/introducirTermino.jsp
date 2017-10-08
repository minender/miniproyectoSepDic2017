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
    <title>David|Agregar Abreviación</title>
    <tiles:insertDefinition name="style" />
  </head>
  <body>
    <tiles:insertDefinition name="header" />
    <h1>Introduzca la abreviación que desee guardar</h1>
    
    <div style="float: right; width: 600px;">
      <c:choose>
        <c:when test="${!usuario.getLogin().equals(admin)}">
          <article id="predefinidos" >
            <h3 style="margin: 0px;padding:0px;height:40px;"><a href="#!" onclick="desplegar('predefinidos')">Abreviaciones predefinidas</a></h3>
            <iframe style="width: 100%; height: 100%; border: none;" src="../${usuario.getLogin()}/predef?comb=n">
            </iframe>
          </article>
        </c:when>
      </c:choose>
      <article id="misTerminos" >
        <h3 style="margin: 0px;padding:0px;height:40px;"><a href="#!" onclick="desplegar('misTerminos')">Mis abreviaciones</a></h3>
        <iframe style="width: 100%; height: 100%; border: none;" src="../${usuario.getLogin()}/listarocult?comb=n">        
        </iframe>
      </article>
    </div>
    
    <c:choose>
      <c:when test="${modificar.intValue()==0}">
        <sf:form method="POST" modelAttribute="usuarioGuardar">
          Alias:<br><sf:input path="alias" id="termino_alias" value="${alias}"/><sf:errors path="alias" cssClass="error" /><br/>
          Término:<br><sf:input path="termino" id="termino_string" style="width: 526px;" /><sf:errors path="termino" cssClass="error" /><br/>
          <input class="btn" type="submit" value="Guardar">
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
    <!--<a href="./">Perfil</a>-->
    
    <script>
        t=document.getElementById('termino_string');
        t.innerText="${termino}";
    </script>
      
<!--        <article id="publicos" >
          <h2 style="margin: 0px;padding:0px;height:40px;"><a href="#!" onclick="desplegar('publicos')">Predicados públicos</a></h2>
      <iframe width="100%" height="100%" src="../${usuario.getLogin()}/publiconoclick?comb=n">
      -->
      <!--</iframe>-->
      <!--</article>-->
      <tiles:insertDefinition name="footer" />
  </body>
</html>
