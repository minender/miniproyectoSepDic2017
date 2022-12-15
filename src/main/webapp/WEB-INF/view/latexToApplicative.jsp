<%-- 
    Document   : latexToApplicative
    Created on : Dec 13, 2022, 9:23:53 PM
    Author     : feder
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
        <title>CalcLogic</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css" >
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css" >
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/mathJax2_7_9.css">
    <script src="${pageContext.request.contextPath}/static/js/popper.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/jquery-3.2.1.min.js"></script>
    <!--  <script src="/Miniproyecto/static/js/jquery.min.js"></script> -->
    <script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/Miniproyecto/static/js/desplegar.js"></script>

    
         <!-- Here we exclude the views which we don't want to import these configurations-->
            <script type="text/x-mathjax-config">
                MathJax.Hub.Config({
                    //extensions: ["tex2jax.js","[MathJax]/extensions/TeX/forminput.js"], // For version 2.3
                    extensions: ["tex2jax.js","[Contrib]/forminput/forminput.js"], // For version 2.7.7
                    jax: ["input/TeX","output/HTML-CSS"],
                    tex2jax: {inlineMath: [ ['$','$'], ["\\(","\\)"] ],processEscapes: true,},
                    TeX: {extensions: ["AMSmath.js","AMSsymbols.js"]}
                });
            </script>
            <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.7/latest.js?config=TeX-MML-AM_CHTML"></script>
    </head>
    <body>
        <h1>Escriba una fórmula</h1>
            <sf:form method="POST" modelAttribute="insertFormula">
                <c:set var="collapse" value="collapse" scope="request"/>
                <tiles:insertDefinition name="jaxButtons" />
                <c:set var="rootId" value="teoremaSymbolsId" scope="request"/>  
                <c:set var="labelName" value="Theorem:" scope="request"/>
                <c:set var="inputForm" value="teorema" scope="request"/>
                <c:set var="initialInput" value="${teorema}" scope="request"/>
                <tiles:insertDefinition name="jaxDiv" />
                <div class="form-group row justify-content-center">
                  <button type="button" onclick="cleanJax('teoremaSymbolsId')" class="btn btn-default">Clean</button>
                  &nbsp 
                  <button type="submit" class="btn btn-default" onclick="setInputValueOnParser('teoremaSymbolsId')">Traducir</button>
                </div>    
                            
                <div class="form-group row justify-content-center" style="display: none;">
                    <label for="teorema" class="col-lg-1 col-form-label">Formula:</label>
                    <div class="col-lg-3">
                        <sf:input path="algorithm" id="teorema" value="${teorema}" class="form-control"/><sf:errors path="algorithm" cssClass="error" /><br/>
                    </div>
                </div>                
            </sf:form>
    </body>
</html>
