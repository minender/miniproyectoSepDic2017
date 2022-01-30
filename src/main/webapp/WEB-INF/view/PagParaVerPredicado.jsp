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
                //extensions: ["tex2jax.js","[MathJax]/extensions/TeX/forminput.js"],
                extensions: ["tex2jax.js","[Contrib]/forminput/forminput.js"],
                jax: ["input/TeX","output/HTML-CSS"],
                tex2jax: {inlineMath: [["$","$"],["\\(","\\)"]]},
                TeX: {extensions: ["AMSmath.js","AMSsymbols.js"]}   
            });
        </script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.7/latest.js?config=TeX-MML-AM_CHTML"></script>
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