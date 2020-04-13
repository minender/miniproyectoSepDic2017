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
  <div class="container" style="margin-top: 20px">
    <h1>Students List</h1>

    <table class="table">
  <thead>
    <tr>
      <th scope="col">Name of the subject</th>
    </tr>
  </thead>
  <tbody>
      <c:forEach var="materia" items="${materiasList}">
        <tr>
            <td data-toggle="collapse" href="#studentsList" aria-expanded="false" aria-controls="studentsList">
                <p>
                <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#studentsList-${materia.getId()}" aria-expanded="false" aria-controls="studentsList">
                    ${materia.nombre} 
                </button>          
                </p>
            </td>
        </tr>
        <tr>
            <td>
                <div id="studentsList-${materia.getId()}" class="collapse">
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">First name</th>
                                <th scope="col">Last name</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="student" items="${studentsList}">
                                <c:choose>
                                    <c:when test="${student.getMateria().getId() == materia.getId()}">
                                        <tr>
                                            <td><a href="student?usr=${student.getLogin()}">${student.nombre}</a></td>
                                            <td><a href="student?usr=${student.getLogin()}">${student.apellido}</a></td>
                                        </tr>
                                    </c:when>
                                </c:choose>
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

