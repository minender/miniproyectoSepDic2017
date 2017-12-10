<%-- 
    Document   : PagParaVerPredicado
    Created on : Feb 23, 2017, 4:55:28 PM
    Author     : miguel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
                <script type="text/x-mathjax-config">
          MathJax.Hub.Config({
          tex2jax: {
          inlineMath: [ ['$','$'], ["\\(","\\)"] ],
          processEscapes: true
          }
         });
        </script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/mathjax-MathJax-v2.3-248-g60e0a8c/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
    </head>
    
    <body>
        <h1>Hello World!</h1>
        <p> ${id}  </p>
        <p> ${usuario}  </p>
        <p> ${predicado}  </p>
        <p> ${alias}  </p>
        <p> ${predserializado}  </p>
        
    </body>
</html>
