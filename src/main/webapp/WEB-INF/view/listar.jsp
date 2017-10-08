<%-- 
    Document   : listar
    Created on : 11/05/2014, 01:59:42 AM
    Author     : federico
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
    <%--<script src="${pageContext.request.contextPath}/static/js/jquery.jslatex.packed.js"></script>--%>
    <%--<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>--%>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/mathjax-MathJax-v2.3-248-g60e0a8c/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/ClickOnAlias.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css" >
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css" >
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap-responsive.css" >
    <title>David | Mis Abreviaciones</title>
  </head>
  <body>
    <c:choose>
      <c:when test="${perfil.intValue()==1}">
        <tiles:insertDefinition name="header" />
        <h1>${titulo}</h1>
      </c:when>
    </c:choose>

    <script>
      /*$(function () {
      $(".latex").latex();
      });*/

      function insertAtCursor(myField, myValue) 
      {            
        myValue+="";
        //IE support
        if (parent.window.document.selection) {
          parent.window.document.getElementById(myField).focus();
          sel = parent.window.document.selection.createRange();
          sel.text = myValue;
        }
        //MOZILLA and others
        else if (parent.window.document.getElementById(myField).selectionStart || 
                 parent.window.document.getElementById(myField).selectionStart == '0') {
          var startPos = parent.window.document.getElementById(myField).selectionStart;
          var endPos = parent.window.document.getElementById(myField).selectionEnd;
          var newPos = startPos + myValue.length
          parent.window.document.getElementById(myField).value = parent.window.document.getElementById(myField).value.substring(0, startPos)
              + myValue
              + parent.window.document.getElementById(myField).value.substring(endPos, parent.window.document.getElementById(myField).value.length);
          parent.window.document.getElementById(myField).selectionStart = newPos;
          parent.window.document.getElementById(myField).selectionEnd = newPos;
        } else {
          parent.window.document.getElementById(myField).value += myValue;
          parent.window.document.getElementById(myField).selectionStart = newPos;
          parent.window.document.getElementById(myField).selectionEnd = newPos;
        }
        parent.window.document.getElementById(myField).focus();
      }
    </script>

    <table class="table table-hover" border="1">
      <thead><tr><th style="width: 180px;">Alias</th><th>Término</th></tr></thead>
      <tbody>  
        <c:forEach var="termino" items="${terminos}"> 
          <tr>
            <td>
              <c:choose>
                <c:when test="${click.equals(yes)}">
                  <a href="#!" onclick="insertAtCursor('termino_string', '${termino.getId().getAlias()}')">${termino.getId().getAlias()}</a>
                </c:when>
                <c:otherwise>
                  ${termino.getId().getAlias()}
                </c:otherwise>
              </c:choose>
            </td>
            <td>
              <c:choose>
                <c:when test="${comb.intValue()==1}">$$${termino.getCombinador()}$$</c:when>
                <c:otherwise>${termino.termObject.toStringJavascript(termino.getId().getAlias())}</c:otherwise>
              </c:choose>
            </td>
            <c:choose>
              <c:when test="${!usuario.getLogin().equals(publico)}">
                <c:choose>
                  <c:when test="${publicaciones.intValue()==0}">
                <%--<td>
                    <a href="../${usuario.getLogin()}/modificar?alias=${termino.getId().getAlias()}" >Modificar</a></td>--%>
                    <td><a href="../${usuario.getLogin()}/modificaralias?aliasv=${termino.getId().getAlias()}" >Modificar Alias</a></td>
                    <td><a onclick="return confirm('Seguro que desea eliminar el predicado')" href="../${usuario.getLogin()}/eliminar?alias=${termino.getId().getAlias()}">Eliminar</a></td>
                  </c:when>
                  <c:otherwise>
                    <td><a onclick="return confirm('Seguro que desea eliminar el predicado')" href="../${usuario.getLogin()}/eliminarpubl?alias=${termino.getId().getAlias()}">Eliminar</a></td>
                  </c:otherwise>
                </c:choose>
  <%--            <c:choose>
                  <c:when test="${!usuario.getLogin().equals(admin) && publicaciones.intValue()==0}">
                      <td><a href="../${usuario.getLogin()}/publicar?alias=${termino.getId().getAlias()}">Publicar</a></td>
                  </c:when>
                </c:choose>--%>
              </c:when>
            </c:choose>
          </tr>
        </c:forEach>
      </tbody>
    </table>
<%--    <c:choose>
    <c:when test="${comb.intValue()==1}">
        <a href="${accion}?comb=n">Observar en notaci&oacute;n de lambda t&eacute;rminos</a>
    </c:when>
    <c:otherwise>
        <a href="${accion}?comb=y">Observar en notaci&oacute;n de Broda Damas</a>
    </c:otherwise>
</c:choose>
        <%--<c:choose>
            <c:when test="${perfil.intValue()==1}">
                <a href="./">Perfil</a>
            </c:when>
        </c:choose>--%>
    ${mensaje}
    <c:choose>
      <c:when test="${perfil.intValue()==1}">
        <tiles:insertDefinition name="footer" />
      </c:when>
    </c:choose>
  </body>
</html>
