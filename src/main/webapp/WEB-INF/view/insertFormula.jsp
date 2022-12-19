<%-- 
    Document   : insertFormula
    Created on : Dec 12, 2022, 11:05:03 AM
    Author     : feder
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html>
    <head>
        <title>JSP Page</title>
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
    </head>
    <body>
      <center>
        <h1>Inserte una f&oacute;rmula escrita en Lenguaje Aplicativo</h1>
          <sf:form action="${pageContext.request.contextPath}/eval/AdminTeoremas/applicativeToLatex" method="POST" modelAttribute="insertFormula">
              <sf:textarea path="algorithm" id="termino_string" style="height: 80px; width: 526px;" /><br><sf:errors path="algorithm" cssClass="error" /><br>
            <input type="submit" value="Traducir"> <input type="button" value="limpiar" onclick="limpiar()">
    </sf:form>
      </center>
    <center>${mensaje}</center>
    </body>
</html>
