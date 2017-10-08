<%-- 
    Document   : insertarEvaluar
    Created on : 24/05/2014, 08:32:15 PM
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
        <script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/desplegar.js"></script>
        <script type="text/javascript">
            function limpiar()
            {
                var texArea=document.getElementById('termino_string');
                if(texArea.value != "")
                {
                    if(confirm("Seguro que desea borrar el contenido del área de texto"))
                        texArea.value="";
                }
            }
        </script>
        <base href="/Miniproyecto/perfil/${usuario.login}/"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css" >
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css" >
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap-responsive.css" >
        <tiles:insertDefinition name="style" />
        <title>Miniproyecto</title>
    </head>
    <body>
        <tiles:insertDefinition name="header" />
        <h1>Inserte su predicado a computar</h1>
    <center>
    <sf:form action="/Miniproyecto/eval/${usuario.getLogin()}" method="POST" modelAttribute="insertarEvaluar">
        <!--N&uacute;mero m&aacute;ximo de beta reducciones:<br/>-->
        Nombre del algoritmo: <sf:input path="nombre" id="algoritmo_nombre" value="${nombre}"/><sf:errors path="nombre" cssClass="error" /><br/>
        Término:<br><sf:textarea path="algoritmo" id="termino_string" style="height: 80px; width: 526px;" /><sf:errors path="algoritmo" cssClass="error" /><br/>
            <input type="submit" value="Computar"> <input type="button" value="limpiar" onclick="limpiar()">
    </sf:form> ${mensaje}
    </center>
           <%-- <a href="/Miniproyecto/perfil/${usuario.getLogin()}">Perfil</a>--%>
            
        <script>
            t=document.getElementById('termino_string');
            t.innerText="${termino}";
        </script>
        <c:choose>
            <c:when test="${!usuario.getLogin().equals(admin)}">
                <article id="predefinidos" >
                    <h2 style="margin: 0px;padding:0px;height:40px;"><a ${hrefAMiMismo} onclick="desplegar('predefinidos')">Predicados predefinidos</a></h2>
                <iframe width="100%" height="100%" src="/Miniproyecto/perfil/${usuario.getLogin()}/predef?comb=n">
                </iframe>
                </article>
            </c:when>
        </c:choose>
        <article id="misTerminos" >
            <h2 style="margin: 0px;padding:0px;height:40px;"><a ${hrefAMiMismo} onclick="desplegar('misTerminos')">Mis predicados</a></h2>
            <iframe width="100%" height="100%" src="/Miniproyecto/perfil/${usuario.getLogin()}/listarocult?comb=n">
            </iframe>
        </article>
        
        <article id="publicos" >
            <h2 style="margin: 0px;padding:0px;height:40px;"><a ${hrefAMiMismo} onclick="desplegar('publicos')">Predicados públicos</a></h2>
            <iframe width="100%" height="100%" src="/Miniproyecto/perfil/${usuario.getLogin()}/publiconoclick?comb=n">
            </iframe>
        </article>
        <tiles:insertDefinition name="footer" />
    </body>
</html>
