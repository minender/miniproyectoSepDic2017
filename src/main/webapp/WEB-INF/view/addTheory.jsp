<%-- 
    Document   : addTheory
    Created on : Feb 3, 2025, 10:18:23 PM
    Author     : alejandro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html>
    <tiles:insertDefinition name="header" />
    <body>
        <c:set var="urlPrefix" value="${navUrlPrefix}" scope="request"/>
        <tiles:insertDefinition name="nav" />
        <div class="row justify-content-center">
            <h1>Enter the theory you want to save</h1>
        </div>
        
        <sf:form method="POST" modelAttribute="addTheoryForm">

            <c:if test="${bindingResult.hasGlobalErrors()}">
                <div class="alert alert-danger">
                    <sf:errors cssClass="text-danger" />
                </div>
            </c:if>
            
            <c:if test="${not empty errorMessage}">
                <div class="form-group row justify-content-center">
                    <div class="col-lg-4">
                        <div class="alert alert-danger" role="alert">
                            ${errorMessage}
                        </div>
                    </div>
                </div>
            </c:if>
            
            <c:if test="${not empty successMessage}">
                <div class="form-group row justify-content-center">
                    <div class="col-lg-4" >
                        <div class="alert alert-success">
                            ${successMessage}
                        </div>
                    </div>
                </div>
            </c:if>
            
            <div class="form-group row justify-content-center">
                <label for="name" class="col-lg-1 col-form-label">Name:</label>
                <div class="col-lg-3">
                    <sf:errors path="name" cssClass="text-danger"/>
                    <sf:input path="name" id="name" class="form-control"/>
                </div>
            </div>
            
            <div class="form-group row justify-content-center">
                <label for="parentTheories" class="col-lg-1 col-form-label">Parent theories:</label>
                <div class="col-lg-3">
                    <sf:errors path="parentTheories" cssClass="text-danger"/>
                    <select class="form-select form-control" id="parentTheories" name="parentTheories" multiple>
                        <c:forEach items="${theoryList}" var="theory">
                            <option value="${theory.getId()}" style="color: #495057;">${theory.getNombre()}</option>
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

<%--<c:if test="${theory.getId() == usuario.getTeoria().getId()}">selected</c:if>--%>