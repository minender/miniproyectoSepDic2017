<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html>
    <tiles:insertDefinition name="header" />
    <body>
        <c:set var="urlPrefix" value="${navUrlPrefix}" scope="request"/>
        <tiles:insertDefinition name="nav" />
        <div class="row justify-content-center">
            <h1>Enter the category you want to save</h1>
        </div>
        
        <sf:form method="POST" modelAttribute="agregarCategoria">
            
            <div class="form-group row justify-content-center">
                <label for="nombre" class="col-lg-1 col-form-label">Name:</label>
                <div class="col-lg-3">
                    <sf:input path="nombre" id="nombre" class="form-control"/>
                </div>
            </div>
            
            <div class="form-group row justify-content-center">
                <label for="teoriaid" class="col-lg-1 col-form-label">Theory:</label>
                <div class="col-lg-3">
                <select class="form-control" id="selectTeoriaid" name="teoriaid">
                    <c:forEach items="${teorias}" var="teoria">
                        <option value="${teoria.getId()}" <c:if test="${teoria.getId() == usuario.getTeoria().getId()}">selected</c:if>>${teoria.getNombre()}</option>
                    </c:forEach>
                </select>
                </div>
            </div>
                
                
            <div class="row justify-content-center" >
                <div class="offset-lg-1 col-lg-3">
                    <button type="submit" class="btn btn-default">Save</button>
                </div>
            </div>
            
        </sf:form>
    </body>
</html>
