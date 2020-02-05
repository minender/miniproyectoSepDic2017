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
  <body>
  <tiles:insertDefinition name="nav" />
  <div class="container">
    <h1>Students List</h1>

    <table class="table">
  <thead>
    <tr>
      <th scope="col">Nombre de la asignatura</th>
    </tr>
  </thead>
  <tbody>
      <c:forEach var="materia" items="${materiasList}">
        <tr>
            <td data-toggle="collapse" href="#studentsList" aria-expanded="false" aria-controls="studentsList">
                <p>
                <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#studentsList" aria-expanded="false" aria-controls="studentsList">
                    ${materia.nombre} 
                </button>          
                </p>
            </td>
        </tr>
        <tr>
            <td>
                <div id="studentsList" class="collapse">
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">Nombre</th>
                                <th scope="col">Apellido</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="student" items="${studentsList}">
                                <tr>
                                    <td>${student.nombre}</td>
                                    <td>${student.apellido}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </td>
        </tr>
    </c:forEach>
  </tbody>
</table>
</div>
  <tiles:insertDefinition name="footer" />
  </body>
</html>

