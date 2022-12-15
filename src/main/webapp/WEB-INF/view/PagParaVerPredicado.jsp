<%-- 
        Document   : PagParaVerPredicado
        Created on : Feb 23, 2017, 4:55:28 PM
        Author     : miguel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<!DOCTYPE html>
<html>
    <head>
        <%--<tiles:insertDefinition name="header" />--%>
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
        <title>JSP Page</title>
    </head>
    
    <body>
    <center>
        <h1>${titulo}</h1>
        <%--<p> ${id}  </p>
        <p> ${usuario}  </p>--%>
        <p> ${predicado} </p>
        <%--<p> ${alias}  </p>--%>
        <a href="${url}">Ingrese otra fórmula</a>
    </center>
    </body>
</html>