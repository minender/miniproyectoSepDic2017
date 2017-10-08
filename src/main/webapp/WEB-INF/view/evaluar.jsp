<%-- 
    Document   : evaluar
    Created on : 09/06/2014, 02:06:33 PM
    Author     : federico
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!--<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>-->
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/d3.v3.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/mathjax-MathJax-v2.3-248-g60e0a8c/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/ClickOnAlias.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/ClickOnAlias2.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/jquery-1.10.2.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css" >
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css" >
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap-responsive.css" >
    <title>Miniproyecto</title>
  </head>
  <body onload="termInicial()">
    <script>
          
      var terminos= ["${terminos.get(0)}"
        <c:forEach var="i" begin="1" end="${nTerms.intValue()}">
          ,"${terminos.get(i)}"
        </c:forEach>
      ];        
      var termPuros= ["${termPuros.get(0)}"
        <c:forEach var="i" begin="1" end="${nTermsPuros.intValue()}">
          ,"${termPuros.get(i)}"
        </c:forEach>
      ];
            
      //var alias=["Succ"];
      //var valorAlias=["(\\cssId{agru@alias@0@2}{\\style{cursor:pointer; color:blue;}{Succ}}\\cssId{agru@alias@0@3}{\\style{cursor:pointer; color:blue;}{Succ}})"];
        
      var operaciones=[${operations.get(0).toString()}
        <c:forEach var="i" begin="0" end="${nTerms.intValue()}">
          ,${operations.get(i).toString()}
        </c:forEach>
      ];         
      var i=0;

      function termInicial()
      {
        var render=document.getElementById('Math1');
        render.innerHTML="$$~$$ $$"+terminos[0]+"$$";
        alias= ["${alias.get(0)}"
          <c:forEach var="i" begin="1" end="${nAlias.intValue()}">
            ,"${alias.get(i)}"
          </c:forEach>
        ];

        valorAlias=["${valores.get(0)}"
          <c:forEach var="i" begin="1" end="${nAlias.intValue()}">
            ,"${valores.get(i)}"
          </c:forEach>
        ];
                
        clickAlias2("Math1",alias, valorAlias);
      }
            
      function dibujar()
      {
        var datos=new Array(4);

        datos[0]=[0,0];
        datos[1]=[0,30];
        datos[2]=[40,30];
        datos[3]=[60,30];

        var svg = d3.select("body").append("svg")
                                   .attr("width", 10)
                                   .attr("height", 500);

        var rect = svg.selectAll("rect");

        rect = rect.data(datos).enter().append("rect")
              .attr("x", function(d) { return d[0]; })
              .attr("y", function(d) { return d[1]; })
              .attr("width", 10)
              .attr("height", 10)
              .attr("fill", "#2083bd");
      }
            
      function proxPaso()
      {
        var math1=document.getElementById("Math1");
        if(i != terminos.length-1)
          i++;
        if(operaciones[i] == 1)
        {
          clickAlias2("Math1",alias, valorAlias);
          math1.innerHTML="$$\\downarrow$$ "+"$$"+terminos[i]+"$$";
        }
        else if(operaciones[i] == 2)
        {
          clickAlias("Math1",alias, valorAlias);
          math1.innerHTML="$$"+terminos[i]+"$$ "+"$$\\uparrow$$";    
        }
        else if(operaciones[i] == 3)
        {
          clickAlias2("Math1",alias, valorAlias);
          math1.innerHTML="$$~$$ "+"$$\\rightarrow "+terminos[i]+"$$";
        }
        MathJax.Hub.Queue(["Typeset",MathJax.Hub,"render"]);
      }
            
      function pasoAnterior()
      {
        var math1=document.getElementById("Math1");
        if(i != 0)
          i--;
        if(i == 0)
        {
          clickAlias2("Math1",alias, valorAlias);
          math1.innerHTML="$$~$$ "+"$$"+terminos[i]+"$$";
        }
        else if(operaciones[i] == 1)
        {
          clickAlias2("Math1",alias, valorAlias);
          math1.innerHTML="$$\\downarrow$$ "+"$$"+terminos[i]+"$$";
        }
        else if(operaciones[i] == 2)
        {
          clickAlias("Math1",alias, valorAlias);
          math1.innerHTML="$$"+terminos[i]+"$$ "+"$$\\uparrow$$";    
        }
        else if(operaciones[i] == 3)
        {
          clickAlias2("Math1",alias, valorAlias);
          math1.innerHTML="$$~$$ "+"$$\\rightarrow "+terminos[i]+"$$";
        }
        MathJax.Hub.Queue(["Typeset",MathJax.Hub,"render"]);
      }
            
      function nPasos()
      {
        var math1=document.getElementById("Math1");
        pasosAlante=document.getElementById('pasosAlante');
        var pasos=parseInt(pasosAlante.value);
        if(!isNaN(pasos))
        {
          if(i+pasos <= terminos.length-1)
          {
            i=i+pasos;
          }
          else
          {
            i=terminos.length-1;
          }
          if(operaciones[i] == 1)
          {
            clickAlias2("Math1",alias, valorAlias);
            math1.innerHTML="$$\\downarrow$$ "+"$$"+terminos[i]+"$$";
          }
          else if(operaciones[i] == 2)
          {
            clickAlias("Math1",alias, valorAlias);
            math1.innerHTML="$$"+terminos[i]+"$$ "+"$$\\uparrow$$";    
          }
          else if(operaciones[i] == 3)
          {
            clickAlias2("Math1",alias, valorAlias);
            math1.innerHTML="$$~$$ "+"$$\\rightarrow "+terminos[i]+"$$";
          }
            MathJax.Hub.Queue(["Typeset",MathJax.Hub,"render"]);
        }
      }
            
      function nPasosAtras()
      {
        var math1=document.getElementById("Math1");
        pasosAtras=document.getElementById('pasosAtras');
        var pasos=parseInt(pasosAtras.value);
        if(!isNaN(pasos))
        {
          if(i-pasos >= 0)
          {
            i=i-pasos;
          }
          else
          {
            i=0;
          }

          if(i == 0)
          {
            clickAlias2("Math1",alias, valorAlias);
            math1.innerHTML="$$~$$ "+"$$"+terminos[i]+"$$";
          }
          else if(operaciones[i] == 1)
          {
            clickAlias2("Math1",alias, valorAlias);
            math1.innerHTML="$$\\downarrow$$ "+"$$"+terminos[i]+"$$";
          }
          else if(operaciones[i] == 2)
          {
            clickAlias("Math1",alias, valorAlias);
            math1.innerHTML="$$"+terminos[i]+"$$ "+"$$\\uparrow$$";    
          }
          else if(operaciones[i] == 3)
          {
            clickAlias2("Math1",alias, valorAlias);
            math1.innerHTML="$$~$$ "+"$$\\rightarrow "+terminos[i]+"$$";
          }
            MathJax.Hub.Queue(["Typeset",MathJax.Hub,"render"]);
        }
      }
            
      function proxBeta()
      {
        var math1=document.getElementById("Math1");
        var j=i+1;
        while(j< operaciones.length-1 && operaciones[j] != 3)
        {
          j++;
        }
                
        if(j< operaciones.length && operaciones[j] == 3)
        {
          i=j;
          clickAlias2("Math1",alias, valorAlias);
          math1.innerHTML="$$~$$ "+"$$\\rightarrow "+terminos[i]+"$$";
          MathJax.Hub.Queue(["Typeset",MathJax.Hub,"render"]);
        }
                
      }
            
      function betaAnterior()
      {
        var math1=document.getElementById("Math1");
        var j=i-1;
        while(j> 1 && operaciones[j] != 3)
        {
          j--;
        }
                
        if(j>0 && operaciones[j] == 3)
        {
          i=j;
          clickAlias2("Math1",alias, valorAlias);
          math1.innerHTML="$$~$$ "+"$$\\rightarrow "+terminos[i]+"$$";
          MathJax.Hub.Queue(["Typeset",MathJax.Hub,"render"]);
        }
                
      }
            
      function nBeta()
      {
        var math1=document.getElementById("Math1");
        nBeta=document.getElementById('nBeta');
        var pasos=parseInt(nBeta.value);
        if(!isNaN(pasos))
        {
          var j=i+1;
          for(k=1;k<=pasos;k++)
          {
            while(j< operaciones.length-1 && operaciones[j] != 3)
            {
              j++;
            }
          }
                
          if(j< operaciones.length && operaciones[j] == 3)
          {
            i=j;
            clickAlias2("Math1",alias, valorAlias);
            math1.innerHTML="$$~$$ "+"$$\\rightarrow "+terminos[i]+"$$";
            MathJax.Hub.Queue(["Typeset",MathJax.Hub,"render"]);
          }
        }
      }
            
      function proxTraduc()
      {
        var math1=document.getElementById("Math1");
        var j=i+1;
        while(j< operaciones.length-1 && operaciones[j] == 3)
        {
          j++;
        }
            
        if(j< operaciones.length && operaciones[j] != 3)
        {
          i=j;
          if(operaciones[j] == 1)
          {
            clickAlias2("Math1",alias, valorAlias);
            math1.innerHTML="$$\\downarrow$$ "+"$$"+terminos[i]+"$$";
          }
          else if(operaciones[i] == 2)
          {
            clickAlias("Math1",alias, valorAlias);
            math1.innerHTML="$$"+terminos[i]+"$$ "+"$$\\uparrow$$";
          }
          MathJax.Hub.Queue(["Typeset",MathJax.Hub,"render"]);
        }
                
      }
            
      function traducAnterior()
      {
        var math1=document.getElementById("Math1");
        var j=i-1;
        while(j> 1 && operaciones[j] == 3)
        {
          j--;
        }
            
        if(j>0 && operaciones[j] != 3)
        {
          i=j;
          if(operaciones[j] == 1)
          {
            clickAlias2("Math1",alias, valorAlias);
            math1.innerHTML="$$\\downarrow$$ "+"$$"+terminos[i]+"$$";
          }
          else if(operaciones[i] == 2)
          {
            clickAlias("Math1",alias, valorAlias);
            math1.innerHTML="$$"+terminos[i]+"$$ "+"$$\\uparrow$$";
          }
            MathJax.Hub.Queue(["Typeset",MathJax.Hub,"render"]);
        }
                
      }
    </script>

    <tiles:insertDefinition name="headerEval" />
    <h1>Evaluando</h1>
        
    <div id="terminoGrafico"  style="position:relative; overflow:hidden; left:10px; height:30px; width:1060px; top: 390px; z-index:0;">
      <div id="terminoGraficoDeep" style="position:relative; top:-14px;" >
        <span id="Math2"></span>
      </div>
    </div>
    <div id="render"  style="overflow-x: scroll" >
      <span id="Math1"></span>
    </div>
    <div  style="background:#ccc; height:127px; overflow-y: auto; overflow-x: auto">
      <div  height="500" style="float:left">
        <table>
          <tr>
            <td>
              <input type="button" value="atras" onclick="pasoAnterior()">
            </td>
            <td>
              <input type="button" value="prox" onclick="proxPaso()">
            </td>
          </tr>
          <tr>
            <td>
              <input type="button" value="betaAnterior" onclick="betaAnterior()">
            </td>
            <td>
              <input type="button" value="proxbeta" onclick="proxBeta()">
            </td>
          </tr>
          <tr>
            <td>
              <input type="button" value="traducAnterior" onclick="traducAnterior()">
            </td>
            <td>
              <input type="button" value="proxtraduc" onclick="proxTraduc()">
            </td>
          </tr>
        </table>
      </div >
      <div height="500" style="float:right">
        <table>
          <tr>
            <td>
              <input type="button" value="npasosAtras" onclick="nPasosAtras()">
            </td>
            <td>
              <input type="text" id="pasosAtras" class="span4" >
            </td>
            <td>
              <input type="button" value="npasos" onclick="nPasos()">
            </td>
            <td>
              <input type="text" class="span4" id="pasosAlante" >
            </td>
          </tr>
          <tr>
            <td>
              <input type="button" value="nBetaAnterior" onclick="nBetaAnterior()">
            </td>
            <td>
              <input type="text" class="span4" id="betaPasosAtras" >
            </td>
            <td>
              <input type="button" value="nBeta" onclick="nBeta()">
            </td>
            <td>
              <input type="text" class="span4" id="nBeta" >
            </td>
          </tr>
          <tr>
            <td>
              <input type="button" value="nTraducAnterior" onclick="nTraducAnterior()">
            </td>
            <td>
              <input type="text" class="span4" id="traducPasosAtras" >
            </td>
            <td>
              <input type="button" value="nTraduc" onclick="nTraduc()">
            </td>
            <td>
              <input type="text" class="span4" id="nTraduc" >
            </td>
          </tr>
        </table>
      </div>
    </div>
        
        
    <%--<a href="/Miniproyecto/perfil/${usuario.getLogin()}/ingresar">Perfil</a>--%>
        
    <table>
      <tr>
        <td>Porcentaje de reducciones:</td>
        <td>${nReducciones.floatValue()}</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>Porcentaje de traducciones:</td>
        <td>${nTraduc.floatValue()}</td>
        <td id="mensajeClick">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;haga click encima del rectangulo que desee inspeccionar</td>
      </tr>
    </table>
    <div id="zigzageo" style="overflow:hidden; width: 1080px; height: 197px;">
      <div id="zigzageo-deep"></div>
    </div>

    <script>
      //var rect=document.getElementById("rect1");
      var divTer = document.getElementById("Math2");
      //var x = d3.scale.linear().range([0, 20*106.5]);
      //var y = d3.scale.linear().range([0, 20*49]);
      var zigzagWidth = document.getElementById("zigzageo").offsetWidth;
      var zigzagHeight = document.getElementById("zigzageo").offsetHeight;
      datos=new Array();
      indiceClick = 0;
      var datosTermPuros=new Array();
      var indexPuro = 1;
      var altura = 15;
      var currentAltura = 15;
      var anchura = 40;
      var clickElemenInd = 3;
          
      datos[0]=[15,15,"n"+0,"#2083bd",0];
      datosTermPuros[0]=[15,15,"n"+0,"#ccc",0];
      for(var l=1;l<terminos.length;l++)
      {
        if(operaciones[l]== 1)
        {
          currentAltura += 30;
          altura = Math.max(altura,currentAltura);
          anchura += 15;
          datos[l]=[datos[l-1][0]+15,datos[l-1][1]+30,"n"+l,"#2083bd",1];//"#ffd119"
        }
        else if(operaciones[l]== 2)
        {
          currentAltura -= 30;
          datos[l]=[datos[l-1][0],datos[l-1][1]-30,"n"+l,"#2083bd",2];
        }
        else if(operaciones[l]== 3)
        {
          anchura += 30;
          datos[l]=[datos[l-1][0]+30,datos[l-1][1],"n"+l,"#2083bd",3];
          var aux4 = indexPuro-1;
          datosTermPuros[indexPuro]=[datos[l-1][0]+30,15,"p"+aux4,"#ccc",4];
          indexPuro++;
        }
      }
            
      datos = datosTermPuros.concat(datos);
          
      var width;
      var height;
      if (anchura <= zigzagWidth)
      {
        width = zigzagWidth;
        widthFijo = true;
      }
      else
      {
        width = anchura+20;
        widthFijo = false;                
      }
      if (altura <= zigzagHeight)
      {
        height = zigzagHeight;
        heightFijo = true;
      }
      else
      {
        height = altura+20;
        heightFijo = false;
      }
          
      if( heightFijo == true && widthFijo == true )
        allFijo = true;
      else
        allFijo = false;
            
      var style = document.body.style,
      transform = ("webkitTransform" in style ? "-webkit-"
                : "MozTransform" in style ? "-moz-"
                : "msTransform" in style ? "-ms-"
                : "OTransform" in style ? "-o-"
                : "") + "transform";
            
      deep = d3.select("#zigzageo-deep");
      tGDeep = d3.select("#terminoGraficoDeep");
      var svg = d3.select("#zigzageo-deep").append("svg")
                                           .attr("width", width) 
                                           .attr("height", height);
               
      var group = svg.selectAll("g");   
      group = group.data(datos).enter().append("g");
      var rect = group.selectAll("rect");
      var line = group.selectAll("line");
        
      rect = group.append("rect")
            .attr("x", function(d) { return d[0]; })
            .attr("y", function(d) { return d[1]; })
            .attr("width", 5)
            .attr("height", 5)
            .html(function(d) { return d[2]; })
            .attr("style",function(d) {return "stroke: "+d[3]+"; stroke-width: 7;fill: none;";})
            .on("click",clicked);
                  
      lineCenterv=group.append("line")
            .attr("x1",function(d){return lineCenter(d)['x1'];})
            .attr("y1",function(d){return lineCenter(d)['y1'];})
            .attr("x2",function(d){return lineCenter(d)['x2'];})
            .attr("y2",function(d){return lineCenter(d)['y2'];})
            .attr("style",function(d) {return "stroke:rgb(0,0,0); stroke-width: 1;";});
                  
      lineUnaPuntav=group.append("line")
            .attr("x1",function(d){return lineUnaPunta(d)['x1'];})
            .attr("y1",function(d){return lineUnaPunta(d)['y1'];})
            .attr("x2",function(d){return lineUnaPunta(d)['x2'];})
            .attr("y2",function(d){return lineUnaPunta(d)['y2'];})
            .attr("style",function(d) {return "stroke:rgb(0,0,0); stroke-width: 1;";});      
                  
      lineOtraPuntav=group.append("line")
            .attr("x1",function(d){return lineOtraPunta(d)['x1'];})
            .attr("y1",function(d){return lineOtraPunta(d)['y1'];})
            .attr("x2",function(d){return lineOtraPunta(d)['x2'];})
            .attr("y2",function(d){return lineOtraPunta(d)['y2'];})
            .attr("style",function(d) {return "stroke:rgb(0,0,0); stroke-width: 1;";});
                  
      lineTraduc1v=group.append("line")
            .attr("x1",function(d){return lineTraduc1(d)['x1'];})
            .attr("y1",function(d){return lineTraduc1(d)['y1'];})
            .attr("x2",function(d){return lineTraduc1(d)['x2'];})
            .attr("y2",function(d){return lineTraduc1(d)['y2'];})
            .attr("style",function(d) {return "stroke:rgb(0,0,0); stroke-width: 1;";});                  

      lineTraduc2v=group.append("line")
            .attr("x1",function(d){return lineTraduc2(d)['x1'];})
            .attr("y1",function(d){return lineTraduc2(d)['y1'];})
            .attr("x2",function(d){return lineTraduc2(d)['x2'];})
            .attr("y2",function(d){return lineTraduc2(d)['y2'];})
            .attr("style",function(d) {return "stroke:rgb(0,0,0); stroke-width: 1;";});

      lineTraduc3v=group.append("line")
            .attr("x1",function(d){return lineTraduc3(d)['x1'];})
            .attr("y1",function(d){return lineTraduc3(d)['y1'];})
            .attr("x2",function(d){return lineTraduc3(d)['x2'];})
            .attr("y2",function(d){return lineTraduc3(d)['y2'];})
            .attr("style",function(d) {return "stroke:rgb(0,0,0); stroke-width: 1;";});
                  
      lineTraduc4v=group.append("line")
            .attr("x1",function(d){return lineTraduc4(d)['x1'];})
            .attr("y1",function(d){return lineTraduc4(d)['y1'];})
            .attr("x2",function(d){return lineTraduc4(d)['x2'];})
            .attr("y2",function(d){return lineTraduc4(d)['y2'];})
            .attr("style",function(d) {return "stroke:rgb(0,0,0); stroke-width: 1;";});

      lineInvTraduc1v=group.append("line")
            .attr("x1",function(d){return lineInvTraduc1(d)['x1'];})
            .attr("y1",function(d){return lineInvTraduc1(d)['y1'];})
            .attr("x2",function(d){return lineInvTraduc1(d)['x2'];})
            .attr("y2",function(d){return lineInvTraduc1(d)['y2'];})
            .attr("style",function(d) {return "stroke:rgb(0,0,0); stroke-width: 1;";});
                  
      lineInvTraduc2v=group.append("line")
            .attr("x1",function(d){return lineInvTraduc2(d)['x1'];})
            .attr("y1",function(d){return lineInvTraduc2(d)['y1'];})
            .attr("x2",function(d){return lineInvTraduc2(d)['x2'];})
            .attr("y2",function(d){return lineInvTraduc2(d)['y2'];})
            .attr("style",function(d) {return "stroke:rgb(0,0,0); stroke-width: 1;";});                  
                  
      lineInvTraduc3v=group.append("line")
            .attr("x1",function(d){return lineInvTraduc3(d)['x1'];})
            .attr("y1",function(d){return lineInvTraduc3(d)['y1'];})
            .attr("x2",function(d){return lineInvTraduc3(d)['x2'];})
            .attr("y2",function(d){return lineInvTraduc3(d)['y2'];})
            .attr("style",function(d) {return "stroke:rgb(0,0,0); stroke-width: 1;";});                  

      lineInvTraduc4v=group.append("line")
            .attr("x1",function(d){return lineInvTraduc4(d)['x1'];})
            .attr("y1",function(d){return lineInvTraduc4(d)['y1'];})
            .attr("x2",function(d){return lineInvTraduc4(d)['x2'];})
            .attr("y2",function(d){return lineInvTraduc4(d)['y2'];})
            .attr("style",function(d) {return "stroke:rgb(0,0,0); stroke-width: 1;";});
                  
      betaVectorizadav=group.append("path") //translate("+(-5)+","+(-15)+")
            //.attr("transform",function(d){return trasladarBeta(d)})
            .attr("d",function(d){return betaVectorizada(d);})
            .attr("style",function(d){return "font-size:400px;font-style:normal;font-weight:normal;text-align:start;text-anchor:start;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:Times New Roman"});

  //          var despX = 0;
  //          var despY = 0;
      var grande = 0;
      var deltaX = zigzagWidth-7;
      var deltaY = zigzagHeight-7;
            
      d3.select("#zigzageo").on("mousemove",mousemoved);
      d3.select("#terminoGrafico").on("mousemove",tGMousemoved);
  //          innerWidth = width;
  //          depthX = 0.9;
  //          depthY = 1.5;
  //          currentFocus = [innerWidth / 2, height / 2];
      idle = true;
            
      function lineCenter(d)
      {
        var r;
        if (d[4] == 0)
          r = {'x1':0,'y1':0,'x2':0,'y2':0};
        else if (d[4] == 1)
          r = {'x1':d[0]+2,'y1':d[1]-20,'x2':d[0]+2,'y2':d[1]-5};
        else if (d[4] == 2)
          r = {'x1':d[0]+2,'y1':d[1]+25,'x2':d[0]+2,'y2':d[1]+10};
        else if (d[4]== 3)
          r = {'x1':d[0]-20,'y1':d[1]+2,'x2':d[0]-5,'y2':d[1]+2};
        else if (d[4]== 4)
          r = {'x1':d[0]-20,'y1':d[1]+2,'x2':d[0]-8,'y2':d[1]+2};                 
        return r;
      }
            
      function lineUnaPunta(d)
      {
        var r;
        if (d[4] == 0)
          r = {'x1':0,'y1':0,'x2':0,'y2':0};
        else if (d[4] == 1)
          r = {'x1':d[0]-2,'y1':d[1]-8,'x2':d[0]+2,'y2':d[1]-5};
        else if (d[4] == 2)
          r = {'x1':d[0]-2,'y1':d[1]+13,'x2':d[0]+2,'y2':d[1]+10};
        else if (d[4]== 3)
          r = {'x1':d[0]-8,'y1':d[1]-2,'x2':d[0]-5,'y2':d[1]+2};
        else if (d[4]== 4)
          r = {'x1':d[0]-11,'y1':d[1]-2,'x2':d[0]-8,'y2':d[1]+2};                 
        return r;
      }
            
      function lineOtraPunta(d)
      {
        var r;
        if (d[4] == 0)
          r = {'x1':0,'y1':0,'x2':0,'y2':0};
        else if (d[4] == 1)
          r = {'x1':d[0]+6,'y1':d[1]-8,'x2':d[0]+2,'y2':d[1]-5};
        else if (d[4] == 2)
          r = {'x1':d[0]+6,'y1':d[1]+13,'x2':d[0]+2,'y2':d[1]+10};
        else if (d[4]== 3)
          r = {'x1':d[0]-8,'y1':d[1]+6,'x2':d[0]-5,'y2':d[1]+2};
        else if (d[4]== 4)
          r = {'x1':d[0]-11,'y1':d[1]+6,'x2':d[0]-8,'y2':d[1]+2};                 
        return r;
      }
            
      function lineTraduc1(d)
      {
        var r;
        if (d[4] == 0)
          r = {'x1':0,'y1':0,'x2':0,'y2':0};
        else if (d[4] == 1)
          r = {'x1':d[0]+4,'y1':d[1]-11,'x2':d[0]+9,'y2':d[1]-8};
        else if (d[4] == 2)
          r = {'x1':d[0]-15,'y1':d[1]+19,'x2':d[0]-10,'y2':d[1]+22};
        else if (d[4]== 3)
          r = {'x1':0,'y1':0,'x2':0,'y2':0};
        else if (d[4]== 4)
          r = {'x1':0,'y1':0,'x2':0,'y2':0};                 
        return r;
      }
            
      function lineTraduc2(d)
      {
        var r;
        if (d[4] == 0)
          r = {'x1':0,'y1':0,'x2':0,'y2':0};
        else if (d[4] == 1)
          r = {'x1':d[0]+4,'y1':d[1]-11,'x2':d[0]+9,'y2':d[1]-14};
        else if (d[4] == 2)
          r = {'x1':d[0]-15,'y1':d[1]+19,'x2':d[0]-10,'y2':d[1]+16};
        else if (d[4]== 3)
          r = {'x1':0,'y1':0,'x2':0,'y2':0};
        else if (d[4]== 4)
          r = {'x1':0,'y1':0,'x2':0,'y2':0};                 
        return r;
      }

      function lineTraduc3(d)
      {
        var r;
        if (d[4] == 0)
          r = {'x1':0,'y1':0,'x2':0,'y2':0};
        else if (d[4] == 1)
          r = {'x1':d[0]+11,'y1':d[1]-8,'x2':d[0]+16,'y2':d[1]-11};
        else if (d[4] == 2)
          r = {'x1':d[0]-8,'y1':d[1]+22,'x2':d[0]-3,'y2':d[1]+19};
        else if (d[4]== 3)
          r = {'x1':0,'y1':0,'x2':0,'y2':0};
        else if (d[4]== 4)
          r = {'x1':0,'y1':0,'x2':0,'y2':0};                 
        return r;
      }
            
      function lineTraduc4(d)
      {
        var r;
        if (d[4] == 0)
          r = {'x1':0,'y1':0,'x2':0,'y2':0};
        else if (d[4] == 1)
          r = {'x1':d[0]+11,'y1':d[1]-14,'x2':d[0]+16,'y2':d[1]-11};
        else if (d[4] == 2)
          r = {'x1':d[0]-8,'y1':d[1]+16,'x2':d[0]-3,'y2':d[1]+19};
        else if (d[4]== 3)
          r = {'x1':0,'y1':0,'x2':0,'y2':0};
        else if (d[4]== 4)
          r = {'x1':0,'y1':0,'x2':0,'y2':0};                 
        return r;
      }            
            
      function lineInvTraduc1(d)
      {
        var r;
        if (d[4] == 0)
          r = {'x1':0,'y1':0,'x2':0,'y2':0};
        else if (d[4] == 1)
          r = {'x1':0,'y1':0,'x2':0,'y2':0};
        else if (d[4] == 2)
          r = {'x1':d[0]-4,'y1':d[1]+16.5,'x2':d[0]-2,'y2':d[1]+16.5};
        else if (d[4]== 3)
          r = {'x1':0,'y1':0,'x2':0,'y2':0};
        else if (d[4]== 4)
          r = {'x1':0,'y1':0,'x2':0,'y2':0};                 
        return r;                
      }
            
      function lineInvTraduc2(d)
      {
        var r;
        if (d[4] == 0)
          r = {'x1':0,'y1':0,'x2':0,'y2':0};
        else if (d[4] == 1)
          r = {'x1':0,'y1':0,'x2':0,'y2':0};
        else if (d[4] == 2)
          r = {'x1':d[0]-0.5,'y1':d[1]+18.5,'x2':d[0]-0.5,'y2':d[1]+14.5};
        else if (d[4]== 3)
          r = {'x1':0,'y1':0,'x2':0,'y2':0};
        else if (d[4]== 4)
          r = {'x1':0,'y1':0,'x2':0,'y2':0};                 
        return r;                
      }

      function lineInvTraduc3(d)
      {
        var r;
        if (d[4] == 0)
          r = {'x1':0,'y1':0,'x2':0,'y2':0};
        else if (d[4] == 1)
          r = {'x1':0,'y1':0,'x2':0,'y2':0};
        else if (d[4] == 2)
          r = {'x1':d[0]-2,'y1':d[1]+18.5,'x2':d[0]+1,'y2':d[1]+18.5};
        else if (d[4]== 3)
          r = {'x1':0,'y1':0,'x2':0,'y2':0};
        else if (d[4]== 4)
          r = {'x1':0,'y1':0,'x2':0,'y2':0};                 
        return r;                
      }
            
      function lineInvTraduc4(d)
      {
        var r;
        if (d[4] == 0)
          r = {'x1':0,'y1':0,'x2':0,'y2':0};
        else if (d[4] == 1)
          r = {'x1':0,'y1':0,'x2':0,'y2':0};
        else if (d[4] == 2)
          r = {'x1':d[0]-2,'y1':d[1]+15.5,'x2':d[0]-0.5,'y2':d[1]+14.5};
        else if (d[4]== 3)
          r = {'x1':0,'y1':0,'x2':0,'y2':0};
        else if (d[4]== 4)
          r = {'x1':0,'y1':0,'x2':0,'y2':0};                 
        return r;                
      }
            
      function betaVectorizada(d)
      {
        var r;
        if (d[4] == 0)
          r = "M 0,0";
        else if (d[4] == 1)
          r = "M 0,0";
        else if (d[4] == 2)
          r = "M 0,0";
        else if (d[4]== 3)
          r ="M 0,0";
        else if (d[4]== 4)
        {
          var coord=[10.873529909999998,24.99969285,10.003412789999999,24.99969285,10.129974479999998,24.40555056,10.193255729999999,23.86766034,10.193256539999998,23.386021109999998,10.193256539999998,17.64324747,10.193255729999999,17.045597069999996,10.24598997,16.60087089,10.351459529999998,16.309067849999998,10.46044287,16.01727777,10.6696224,15.760637369999998,10.978998659999998,15.539146109999997,11.291887349999998,15.314153489999999,11.682121319999998,15.201653399999998,12.149701649999999,15.201646109999999,12.70516725,15.201653399999998,13.170986909999998,15.349309649999999,13.54716279,15.644614859999997,13.926845699999996,15.936418439999999,14.116689179999998,16.353019529999997,14.116694039999999,16.89441948,14.116689179999998,17.527237109999998,13.816103579999998,18.04579128,13.214936159999999,18.450083609999997,14.11141581,18.87196239,14.55965739,19.53465687,14.559662789999999,20.43816948,14.55965739,20.930358690000002,14.440126499999998,21.3715692,14.201069039999998,21.761802359999997,13.96551753,22.14852147,13.691299049999998,22.424497919999997,13.378412789999999,22.58973198,13.069034099999998,22.754966309999997,12.69813591,22.83758334,12.265717409999999,22.83758361,11.77352739,22.83758334,11.372746679999999,22.65301323,11.063373659999998,22.28387247,11.063373659999998,23.26473198,11.063372039999999,23.93973063,11.00009079,24.518050379999995,10.873529909999998,24.99969285,11.063373659999998,21.80926323,11.337590519999997,22.26277926,11.72079315,22.48953687,12.212982899999998,22.489536599999997,12.687589169999999,22.48953687,13.035635639999997,22.317271469999998,13.25712366,21.972739859999997,13.47860385,21.624693929999996,13.589345969999998,21.202819469999998,13.589350289999999,20.707114859999997,13.589345969999998,20.32742952,13.51551798,19.940711219999997,13.367865779999999,19.546958609999997,13.22372142,19.149696539999997,13.03739334,18.84735297,12.80888154,18.639927359999998,12.5979408,18.69266565,12.40809705,18.71903277,12.239350289999999,18.71902872,11.88426951,18.71903277,11.706730740000001,18.625868729999997,11.706732899999999,18.439536599999997,11.706730740000001,18.27079092,11.856144689999999,18.18641619,12.15497529,18.186411599999996,12.3413004,18.18641619,12.57333138,18.228603689999996,12.851069039999999,18.312974099999998,13.10067459,17.891103959999995,13.22547912,17.432315369999998,13.225482899999998,16.93660698,13.22547912,16.493644439999997,13.12704171,16.154387009999997,12.930170399999998,15.918833609999998,12.73680774,15.68329371,12.48368301,15.565520249999999,12.170795399999998,15.56551323,11.921183639999999,15.565520249999999,11.706730740000001,15.635832839999997,11.527436159999999,15.77645073,11.351652929999998,15.91708239,11.23036407,16.08583239,11.163569039999999,16.28270073,11.096770229999999,16.47606636,11.063372039999999,16.79423004,11.063373659999998,17.237192849999996,11.063373659999998,21.80926323];
          for (var ind=0;ind<coord.length;ind=ind+2)
          {
            coord[ind]+=d[0]-18;
            coord[ind+1]+=d[1]-12;
          }
           //r ="M 10.873529909999998,24.99969285 L 10.003412789999999,24.99969285 C 10.129974479999998,24.40555056 10.193255729999999,23.86766034 10.193256539999998,23.386021109999998 L 10.193256539999998,17.64324747 C 10.193255729999999,17.045597069999996 10.24598997,16.60087089 10.351459529999998,16.309067849999998 C 10.46044287,16.01727777 10.6696224,15.760637369999998 10.978998659999998,15.539146109999997 C 11.291887349999998,15.314153489999999 11.682121319999998,15.201653399999998 12.149701649999999,15.201646109999999 C 12.70516725,15.201653399999998 13.170986909999998,15.349309649999999 13.54716279,15.644614859999997 C 13.926845699999996,15.936418439999999 14.116689179999998,16.353019529999997 14.116694039999999,16.89441948 C 14.116689179999998,17.527237109999998 13.816103579999998,18.04579128 13.214936159999999,18.450083609999997 C 14.11141581,18.87196239 14.55965739,19.53465687 14.559662789999999,20.43816948 C 14.55965739,20.930358690000002 14.440126499999998,21.3715692 14.201069039999998,21.761802359999997 C 13.96551753,22.14852147 13.691299049999998,22.424497919999997 13.378412789999999,22.58973198 C 13.069034099999998,22.754966309999997 12.69813591,22.83758334 12.265717409999999,22.83758361 C 11.77352739,22.83758334 11.372746679999999,22.65301323 11.063373659999998,22.28387247 L 11.063373659999998,23.26473198 C 11.063372039999999,23.93973063 11.00009079,24.518050379999995 10.873529909999998,24.99969285 M 11.063373659999998,21.80926323 C 11.337590519999997,22.26277926 11.72079315,22.48953687 12.212982899999998,22.489536599999997 C 12.687589169999999,22.48953687 13.035635639999997,22.317271469999998 13.25712366,21.972739859999997 C 13.47860385,21.624693929999996 13.589345969999998,21.202819469999998 13.589350289999999,20.707114859999997 C 13.589345969999998,20.32742952 13.51551798,19.940711219999997 13.367865779999999,19.546958609999997 C 13.22372142,19.149696539999997 13.03739334,18.84735297 12.80888154,18.639927359999998 C 12.5979408,18.69266565 12.40809705,18.71903277 12.239350289999999,18.71902872 C 11.88426951,18.71903277 11.706730740000001,18.625868729999997 11.706732899999999,18.439536599999997 C 11.706730740000001,18.27079092 11.856144689999999,18.18641619 12.15497529,18.186411599999996 C 12.3413004,18.18641619 12.57333138,18.228603689999996 12.851069039999999,18.312974099999998 C 13.10067459,17.891103959999995 13.22547912,17.432315369999998 13.225482899999998,16.93660698 C 13.22547912,16.493644439999997 13.12704171,16.154387009999997 12.930170399999998,15.918833609999998 C 12.73680774,15.68329371 12.48368301,15.565520249999999 12.170795399999998,15.56551323 C 11.921183639999999,15.565520249999999 11.706730740000001,15.635832839999997 11.527436159999999,15.77645073 C 11.351652929999998,15.91708239 11.23036407,16.08583239 11.163569039999999,16.28270073 C 11.096770229999999,16.47606636 11.063372039999999,16.79423004 11.063373659999998,17.237192849999996 L 11.063373659999998,21.80926323";                 
          r ="M "+coord[0]+","+coord[1]+" L "+coord[2]+","+coord[3]+" C "+coord[4]+","+coord[5]+" "+coord[6]+","+coord[7]+" "+coord[8]+","+coord[9]+" L "+coord[10]+","+coord[11]+" C "+coord[12]+","+coord[13]+" "+coord[14]+","+coord[15]+" "+coord[16]+","+coord[17]+" C "+coord[18]+","+coord[19]+" "+coord[20]+","+coord[21]+" "+coord[22]+","+coord[23]+" C "+coord[24]+","+coord[25]+" "+coord[26]+","+coord[27]+" "+coord[28]+","+coord[29]+" C "+coord[30]+","+coord[31]+" "+coord[32]+","+coord[33]+" "+coord[34]+","+coord[35]+" C "+coord[36]+","+coord[37]+" "+coord[38]+","+coord[39]+" "+coord[40]+","+coord[41]+" C "+coord[42]+","+coord[43]+" "+coord[44]+","+coord[45]+" "+coord[46]+","+coord[47]+" C "+coord[48]+","+coord[49]+" "+coord[50]+","+coord[51]+" "+coord[52]+","+coord[53]+" C "+coord[54]+","+coord[55]+" "+coord[56]+","+coord[57]+" "+coord[58]+","+coord[59]+" C "+coord[60]+","+coord[61]+" "+coord[62]+","+coord[63]+" "+coord[64]+","+coord[65]+" C "+coord[66]+","+coord[67]+" "+coord[68]+","+coord[69]+" "+coord[70]+","+coord[71]+" C "+coord[72]+","+coord[73]+" "+coord[74]+","+coord[75]+" "+coord[76]+","+coord[77]+" L "+coord[78]+","+coord[79]+" C "+coord[80]+","+coord[81]+" "+coord[82]+","+coord[83]+" "+coord[84]+","+coord[85]+" M "+coord[86]+","+coord[87]+" C "+coord[88]+","+coord[89]+" "+coord[90]+","+coord[91]+" "+coord[92]+","+coord[93]+" C "+coord[94]+","+coord[95]+" "+coord[96]+","+coord[97]+" "+coord[98]+","+coord[99]+" C "+coord[100]+","+coord[101]+" "+coord[102]+","+coord[103]+" "+coord[104]+","+coord[105]+" C "+coord[106]+","+coord[107]+" "+coord[108]+","+coord[109]+" "+coord[110]+","+coord[111]+" C "+coord[112]+","+coord[113]+" "+coord[114]+","+coord[115]+" "+coord[116]+","+coord[117]+" C "+coord[118]+","+coord[119]+" "+coord[120]+","+coord[121]+" "+coord[122]+","+coord[123]+" C "+coord[124]+","+coord[125]+" "+coord[126]+","+coord[127]+" "+coord[128]+","+coord[129]+" C "+coord[130]+","+coord[131]+" "+coord[132]+","+coord[133]+" "+coord[134]+","+coord[135]+" C "+coord[136]+","+coord[137]+" "+coord[138]+","+coord[139]+" "+coord[140]+","+coord[141]+" C "+coord[142]+","+coord[143]+" "+coord[144]+","+coord[145]+" "+coord[146]+","+coord[147]+" C "+coord[148]+","+coord[149]+" "+coord[150]+","+coord[151]+" "+coord[152]+","+coord[153]+" C "+coord[154]+","+coord[155]+" "+coord[156]+","+coord[157]+" "+coord[158]+","+coord[159]+" C "+coord[160]+","+coord[161]+" "+coord[162]+","+coord[163]+" "+coord[164]+","+coord[165]+" C "+coord[166]+","+coord[167]+" "+coord[168]+","+coord[169]+" "+coord[170]+","+coord[171]+" C "+coord[172]+","+coord[173]+" "+coord[174]+","+coord[175]+" "+coord[176]+","+coord[177]+" L "+coord[178]+","+coord[179];    
        }
        return r;
      }
            
      function zoomBeta(d,x,y,desiredFocus)
      {
        var r;
        if (d[4] == 0)
          r = "M 0,0";
        else if (d[4] == 1)
          r = "M 0,0";
        else if (d[4] == 2)
          r = "M 0,0";
        else if (d[4]== 3)
          r ="M 0,0";
        else if (d[4]== 4)
        {
          var coord=[10.873529909999998,24.99969285,10.003412789999999,24.99969285,10.129974479999998,24.40555056,10.193255729999999,23.86766034,10.193256539999998,23.386021109999998,10.193256539999998,17.64324747,10.193255729999999,17.045597069999996,10.24598997,16.60087089,10.351459529999998,16.309067849999998,10.46044287,16.01727777,10.6696224,15.760637369999998,10.978998659999998,15.539146109999997,11.291887349999998,15.314153489999999,11.682121319999998,15.201653399999998,12.149701649999999,15.201646109999999,12.70516725,15.201653399999998,13.170986909999998,15.349309649999999,13.54716279,15.644614859999997,13.926845699999996,15.936418439999999,14.116689179999998,16.353019529999997,14.116694039999999,16.89441948,14.116689179999998,17.527237109999998,13.816103579999998,18.04579128,13.214936159999999,18.450083609999997,14.11141581,18.87196239,14.55965739,19.53465687,14.559662789999999,20.43816948,14.55965739,20.930358690000002,14.440126499999998,21.3715692,14.201069039999998,21.761802359999997,13.96551753,22.14852147,13.691299049999998,22.424497919999997,13.378412789999999,22.58973198,13.069034099999998,22.754966309999997,12.69813591,22.83758334,12.265717409999999,22.83758361,11.77352739,22.83758334,11.372746679999999,22.65301323,11.063373659999998,22.28387247,11.063373659999998,23.26473198,11.063372039999999,23.93973063,11.00009079,24.518050379999995,10.873529909999998,24.99969285,11.063373659999998,21.80926323,11.337590519999997,22.26277926,11.72079315,22.48953687,12.212982899999998,22.489536599999997,12.687589169999999,22.48953687,13.035635639999997,22.317271469999998,13.25712366,21.972739859999997,13.47860385,21.624693929999996,13.589345969999998,21.202819469999998,13.589350289999999,20.707114859999997,13.589345969999998,20.32742952,13.51551798,19.940711219999997,13.367865779999999,19.546958609999997,13.22372142,19.149696539999997,13.03739334,18.84735297,12.80888154,18.639927359999998,12.5979408,18.69266565,12.40809705,18.71903277,12.239350289999999,18.71902872,11.88426951,18.71903277,11.706730740000001,18.625868729999997,11.706732899999999,18.439536599999997,11.706730740000001,18.27079092,11.856144689999999,18.18641619,12.15497529,18.186411599999996,12.3413004,18.18641619,12.57333138,18.228603689999996,12.851069039999999,18.312974099999998,13.10067459,17.891103959999995,13.22547912,17.432315369999998,13.225482899999998,16.93660698,13.22547912,16.493644439999997,13.12704171,16.154387009999997,12.930170399999998,15.918833609999998,12.73680774,15.68329371,12.48368301,15.565520249999999,12.170795399999998,15.56551323,11.921183639999999,15.565520249999999,11.706730740000001,15.635832839999997,11.527436159999999,15.77645073,11.351652929999998,15.91708239,11.23036407,16.08583239,11.163569039999999,16.28270073,11.096770229999999,16.47606636,11.063372039999999,16.79423004,11.063373659999998,17.237192849999996,11.063373659999998,21.80926323];
          for (var ind=0;ind<coord.length;ind=ind+2)
          {
            coord[ind]=x(coord[ind]+d[0]-18)-desiredFocus[0];
            coord[ind+1]=y(coord[ind+1]+d[1]-12)-desiredFocus[1];
          }
           //r ="M 10.873529909999998,24.99969285 L 10.003412789999999,24.99969285 C 10.129974479999998,24.40555056 10.193255729999999,23.86766034 10.193256539999998,23.386021109999998 L 10.193256539999998,17.64324747 C 10.193255729999999,17.045597069999996 10.24598997,16.60087089 10.351459529999998,16.309067849999998 C 10.46044287,16.01727777 10.6696224,15.760637369999998 10.978998659999998,15.539146109999997 C 11.291887349999998,15.314153489999999 11.682121319999998,15.201653399999998 12.149701649999999,15.201646109999999 C 12.70516725,15.201653399999998 13.170986909999998,15.349309649999999 13.54716279,15.644614859999997 C 13.926845699999996,15.936418439999999 14.116689179999998,16.353019529999997 14.116694039999999,16.89441948 C 14.116689179999998,17.527237109999998 13.816103579999998,18.04579128 13.214936159999999,18.450083609999997 C 14.11141581,18.87196239 14.55965739,19.53465687 14.559662789999999,20.43816948 C 14.55965739,20.930358690000002 14.440126499999998,21.3715692 14.201069039999998,21.761802359999997 C 13.96551753,22.14852147 13.691299049999998,22.424497919999997 13.378412789999999,22.58973198 C 13.069034099999998,22.754966309999997 12.69813591,22.83758334 12.265717409999999,22.83758361 C 11.77352739,22.83758334 11.372746679999999,22.65301323 11.063373659999998,22.28387247 L 11.063373659999998,23.26473198 C 11.063372039999999,23.93973063 11.00009079,24.518050379999995 10.873529909999998,24.99969285 M 11.063373659999998,21.80926323 C 11.337590519999997,22.26277926 11.72079315,22.48953687 12.212982899999998,22.489536599999997 C 12.687589169999999,22.48953687 13.035635639999997,22.317271469999998 13.25712366,21.972739859999997 C 13.47860385,21.624693929999996 13.589345969999998,21.202819469999998 13.589350289999999,20.707114859999997 C 13.589345969999998,20.32742952 13.51551798,19.940711219999997 13.367865779999999,19.546958609999997 C 13.22372142,19.149696539999997 13.03739334,18.84735297 12.80888154,18.639927359999998 C 12.5979408,18.69266565 12.40809705,18.71903277 12.239350289999999,18.71902872 C 11.88426951,18.71903277 11.706730740000001,18.625868729999997 11.706732899999999,18.439536599999997 C 11.706730740000001,18.27079092 11.856144689999999,18.18641619 12.15497529,18.186411599999996 C 12.3413004,18.18641619 12.57333138,18.228603689999996 12.851069039999999,18.312974099999998 C 13.10067459,17.891103959999995 13.22547912,17.432315369999998 13.225482899999998,16.93660698 C 13.22547912,16.493644439999997 13.12704171,16.154387009999997 12.930170399999998,15.918833609999998 C 12.73680774,15.68329371 12.48368301,15.565520249999999 12.170795399999998,15.56551323 C 11.921183639999999,15.565520249999999 11.706730740000001,15.635832839999997 11.527436159999999,15.77645073 C 11.351652929999998,15.91708239 11.23036407,16.08583239 11.163569039999999,16.28270073 C 11.096770229999999,16.47606636 11.063372039999999,16.79423004 11.063373659999998,17.237192849999996 L 11.063373659999998,21.80926323";                 
           r ="M "+coord[0]+","+coord[1]+" L "+coord[2]+","+coord[3]+" C "+coord[4]+","+coord[5]+" "+coord[6]+","+coord[7]+" "+coord[8]+","+coord[9]+" L "+coord[10]+","+coord[11]+" C "+coord[12]+","+coord[13]+" "+coord[14]+","+coord[15]+" "+coord[16]+","+coord[17]+" C "+coord[18]+","+coord[19]+" "+coord[20]+","+coord[21]+" "+coord[22]+","+coord[23]+" C "+coord[24]+","+coord[25]+" "+coord[26]+","+coord[27]+" "+coord[28]+","+coord[29]+" C "+coord[30]+","+coord[31]+" "+coord[32]+","+coord[33]+" "+coord[34]+","+coord[35]+" C "+coord[36]+","+coord[37]+" "+coord[38]+","+coord[39]+" "+coord[40]+","+coord[41]+" C "+coord[42]+","+coord[43]+" "+coord[44]+","+coord[45]+" "+coord[46]+","+coord[47]+" C "+coord[48]+","+coord[49]+" "+coord[50]+","+coord[51]+" "+coord[52]+","+coord[53]+" C "+coord[54]+","+coord[55]+" "+coord[56]+","+coord[57]+" "+coord[58]+","+coord[59]+" C "+coord[60]+","+coord[61]+" "+coord[62]+","+coord[63]+" "+coord[64]+","+coord[65]+" C "+coord[66]+","+coord[67]+" "+coord[68]+","+coord[69]+" "+coord[70]+","+coord[71]+" C "+coord[72]+","+coord[73]+" "+coord[74]+","+coord[75]+" "+coord[76]+","+coord[77]+" L "+coord[78]+","+coord[79]+" C "+coord[80]+","+coord[81]+" "+coord[82]+","+coord[83]+" "+coord[84]+","+coord[85]+" M "+coord[86]+","+coord[87]+" C "+coord[88]+","+coord[89]+" "+coord[90]+","+coord[91]+" "+coord[92]+","+coord[93]+" C "+coord[94]+","+coord[95]+" "+coord[96]+","+coord[97]+" "+coord[98]+","+coord[99]+" C "+coord[100]+","+coord[101]+" "+coord[102]+","+coord[103]+" "+coord[104]+","+coord[105]+" C "+coord[106]+","+coord[107]+" "+coord[108]+","+coord[109]+" "+coord[110]+","+coord[111]+" C "+coord[112]+","+coord[113]+" "+coord[114]+","+coord[115]+" "+coord[116]+","+coord[117]+" C "+coord[118]+","+coord[119]+" "+coord[120]+","+coord[121]+" "+coord[122]+","+coord[123]+" C "+coord[124]+","+coord[125]+" "+coord[126]+","+coord[127]+" "+coord[128]+","+coord[129]+" C "+coord[130]+","+coord[131]+" "+coord[132]+","+coord[133]+" "+coord[134]+","+coord[135]+" C "+coord[136]+","+coord[137]+" "+coord[138]+","+coord[139]+" "+coord[140]+","+coord[141]+" C "+coord[142]+","+coord[143]+" "+coord[144]+","+coord[145]+" "+coord[146]+","+coord[147]+" C "+coord[148]+","+coord[149]+" "+coord[150]+","+coord[151]+" "+coord[152]+","+coord[153]+" C "+coord[154]+","+coord[155]+" "+coord[156]+","+coord[157]+" "+coord[158]+","+coord[159]+" C "+coord[160]+","+coord[161]+" "+coord[162]+","+coord[163]+" "+coord[164]+","+coord[165]+" C "+coord[166]+","+coord[167]+" "+coord[168]+","+coord[169]+" "+coord[170]+","+coord[171]+" C "+coord[172]+","+coord[173]+" "+coord[174]+","+coord[175]+" "+coord[176]+","+coord[177]+" L "+coord[178]+","+coord[179];    
        }
        return r;
      }            
            
      /*function trasladarBeta(d)
       {
           var x1 = d[0]-18;
           var x2 = d[1]-12;
           return "translate("+x1+","+x2+")";
       }*/
            
                  
      function mousemoved() 
      {
        var m = d3.mouse(this);

        /*if ( allFijo || (m[0] - innerWidth / 2 <= 0 && m[1] - height / 2 <= 0))
            desiredFocus = [innerWidth / 2, height/2];  

        else if( widthFijo || (m[0] - innerWidth / 2 < 0 && m[1] - height / 2 > 0))
            desiredFocus = [
             innerWidth / 2,
             Math.round((m[1] - height / 2) / depthY) * depthY + height / 2
           ];
        else if (heightFijo || (m[0] - innerWidth / 2 > 0 && m[1] - height / 2 <= 0))
             desiredFocus = [
               Math.round((m[0] - innerWidth / 2) / depthX) * depthX + innerWidth / 2,
               height / 2
             ];
        else if (m[0] - innerWidth / 2 > 0 && m[1] - height / 2 > 0)
             desiredFocus = [
               Math.round((m[0] - innerWidth / 2) / depthX) * depthX + innerWidth / 2,
               Math.round((m[1] - height / 2) / depthY) * depthY + height / 2
             ];*/
         //var desiredFocus;
        if (allFijo || grande == 1)
          desiredFocus = [0,0];
        else if (widthFijo)
          desiredFocus = [0,-m[1]*(height-zigzagHeight)/zigzagHeight];
        else if (heightFijo)
          desiredFocus = [-m[0]*(width-zigzagWidth)/zigzagWidth,0];
        else
          desiredFocus = [-m[0]*(width-zigzagWidth)/zigzagWidth,-m[1]*(height-zigzagHeight)/zigzagHeight];

        moved(desiredFocus);
      }
            
      function tGMousemoved ()
      {
        var m = d3.mouse(this);
        if (grande == 1)
          tGDesiredFocus = [-m[0]*(tGDeep[0][0].scrollWidth-1060)/1060,0];
        else
          tGDesiredFocus = [0,0];

        tGMoved(tGDesiredFocus);
      }
            
      function tGMoved(tGDesiredFocus) {
        d3.timer(function() {
         // if (idle = Math.abs(desiredFocus[0] - currentFocus[0]) < .5 && Math.abs(desiredFocus[1] - currentFocus[1]) < .5) currentFocus = desiredFocus;
         // else currentFocus[0] += (desiredFocus[0] - currentFocus[0]) * .05, currentFocus[1] += (desiredFocus[1] - currentFocus[1]) * .05;
         // deep.style(transform, "translate("+ (innerWidth / 2 - currentFocus[0]) / depthX + "px," + (height / 2 - currentFocus[1]) / depthY + "px)");
          tGDeep.style(transform, "translate("+ tGDesiredFocus[0] + "px," + tGDesiredFocus[1] + "px)");
        });
      }

      function moved(desiredFocus) {
        if (idle) d3.timer(function() {
         // if (idle = Math.abs(desiredFocus[0] - currentFocus[0]) < .5 && Math.abs(desiredFocus[1] - currentFocus[1]) < .5) currentFocus = desiredFocus;
         // else currentFocus[0] += (desiredFocus[0] - currentFocus[0]) * .05, currentFocus[1] += (desiredFocus[1] - currentFocus[1]) * .05;
         // deep.style(transform, "translate("+ (innerWidth / 2 - currentFocus[0]) / depthX + "px," + (height / 2 - currentFocus[1]) / depthY + "px)");
          deep.style(transform, "translate("+ desiredFocus[0] + "px," + desiredFocus[1] + "px)");
          return idle;
        });
      }
      /*svg.append('foreignobject').text('$$\\lambda$$')
          .attr('x', 10)
          .attr('y', 10)
          .attr('requiredExtensions',"http://example.com/SVGExtensions/EmbeddedXHTML")
          .attr("width", 40)
          .attr("height", 40)
          .append('text').text('$$\\lambda$$')
          .attr('x', 10)
          .attr('y', 10)
          .attr('fill', 'black');
           MathJax.Hub.Queue(["Typeset",MathJax.Hub,"svg"]);*/
      //rect=d3.selectAll("rect").data(datos).on("click",clicked);
      function clicked(d) 
      {
//      var constAumentoX = width/15;
//      var constAumentoY = height/15;
//      var aux1 = grande ? (30)*constAumentoX :30;
//      var aux2 = grande ? (30+15)*constAumentoY:30;
        clickX=d[0];
        clickY=d[1];
        if (grande == 0)
        {
          var x = d3.scale.linear().range([4,(width-clickX)*zigzagWidth/10]);
          x.domain([d[0], width]); //d[0] +  aux1]);
          var y = d3.scale.linear().range([4,(height-clickY)*zigzagHeight/10]);
          y.domain([d[1], height]);//d[1] +  aux2]);
          $("#mensajeClick").html("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;haga click encima del marco del rectangulo para volver al estado anterior");
        }
        else 
        {
          var x = d3.scale.linear().range([0,width]);
          x.domain([0, width]); //d[0] +  aux1]);
          var y = d3.scale.linear().range([0,height]);
          y.domain([0, height]);//d[1] +  aux2]);
          $("#mensajeClick").html("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;haga click encima del rectangulo que desee inspeccionar");
        }
        if (rect.filter(function(d){return d[0]==clickX && d[1]==clickY})[0][0].innerHTML.charAt(0)=="n")
        {
          datos[indiceClick][3] = "#2083bd";
          indiceClick = rect.filter(function(d){return d[0]==clickX && d[1]==clickY})[0][0].innerHTML.substring(1);
          st = terminos[indiceClick];
          indiceClick = parseInt(indiceClick)+datosTermPuros.length;
          datos[indiceClick][3] = "#ffd119";
        }
        else
        {
          datos[indiceClick][3] = "#ccc";
          indiceClick = rect.filter(function(d){return d[0]==clickX && d[1]==clickY})[0][0].innerHTML.substring(1);
          st = termPuros[indiceClick];
          indiceClick = parseInt(indiceClick)+1;
          datos[indiceClick][3] = "#ffd119";
        }
        //y.domain([d[1], 1]).range([d[1] ? 0 : 10, d[1] + 20]);

        if (grande == 1)          
          rect.attr("style",function(d){return "stroke:"+d[3]+"; stroke-width: 7;fill: none;";});

        rect.transition()
            .duration(750)
            .attr("x", function(d) { return x(d[0])-desiredFocus[0] })
            .attr("y", function(d) { return y(d[1])-desiredFocus[1] })
            .attr("width", function(d) { return deltaX; })
            .attr("height", function(d) { return deltaY; });
            //.attr("style",function(d){return "stroke:"+d[3][d[5]]+"; stroke-width: 7;fill: none;";});

        lineCenterv.transition()
            .duration(750)
            .attr("x1",function(d){return x(lineCenter(d)['x1'])-desiredFocus[0]})
            .attr("y1",function(d){return y(lineCenter(d)['y1'])-desiredFocus[1]})
            .attr("x2",function(d){return x(lineCenter(d)['x2'])-desiredFocus[0]})
            .attr("y2",function(d){return y(lineCenter(d)['y2'])-desiredFocus[1]});
                    
        lineUnaPuntav.transition()
            .duration(750)
            .attr("x1",function(d){return x(lineUnaPunta(d)['x1'])-desiredFocus[0];})
            .attr("y1",function(d){return y(lineUnaPunta(d)['y1'])-desiredFocus[1];})
            .attr("x2",function(d){return x(lineUnaPunta(d)['x2'])-desiredFocus[0];})
            .attr("y2",function(d){return y(lineUnaPunta(d)['y2'])-desiredFocus[1];});
                  
        lineOtraPuntav.transition()
            .duration(750)
            .attr("x1",function(d){return x(lineOtraPunta(d)['x1'])-desiredFocus[0];})
            .attr("y1",function(d){return y(lineOtraPunta(d)['y1'])-desiredFocus[1];})
            .attr("x2",function(d){return x(lineOtraPunta(d)['x2'])-desiredFocus[0];})
            .attr("y2",function(d){return y(lineOtraPunta(d)['y2'])-desiredFocus[1];});

        lineTraduc1v.transition()
            .duration(750)
            .attr("x1",function(d){return x(lineTraduc1(d)['x1'])-desiredFocus[0];})
            .attr("y1",function(d){return y(lineTraduc1(d)['y1'])-desiredFocus[1];})
            .attr("x2",function(d){return x(lineTraduc1(d)['x2'])-desiredFocus[0];})
            .attr("y2",function(d){return y(lineTraduc1(d)['y2'])-desiredFocus[1];})
                  
        lineTraduc2v.transition()
            .duration(750)
            .attr("x1",function(d){return x(lineTraduc2(d)['x1'])-desiredFocus[0];})
            .attr("y1",function(d){return y(lineTraduc2(d)['y1'])-desiredFocus[1];})
            .attr("x2",function(d){return x(lineTraduc2(d)['x2'])-desiredFocus[0];})
            .attr("y2",function(d){return y(lineTraduc2(d)['y2'])-desiredFocus[1];})

        lineTraduc3v.transition()
            .duration(750)
            .attr("x1",function(d){return x(lineTraduc3(d)['x1'])-desiredFocus[0];})
            .attr("y1",function(d){return y(lineTraduc3(d)['y1'])-desiredFocus[1];})
            .attr("x2",function(d){return x(lineTraduc3(d)['x2'])-desiredFocus[0];})
            .attr("y2",function(d){return y(lineTraduc3(d)['y2'])-desiredFocus[1];})
                  
        lineTraduc4v.transition()
            .duration(750)
            .attr("x1",function(d){return x(lineTraduc4(d)['x1'])-desiredFocus[0];})
            .attr("y1",function(d){return y(lineTraduc4(d)['y1'])-desiredFocus[1];})
            .attr("x2",function(d){return x(lineTraduc4(d)['x2'])-desiredFocus[0];})
            .attr("y2",function(d){return y(lineTraduc4(d)['y2'])-desiredFocus[1];})

        lineInvTraduc1v.transition()
            .duration(750)
            .attr("x1",function(d){return x(lineInvTraduc1(d)['x1'])-desiredFocus[0];})
            .attr("y1",function(d){return y(lineInvTraduc1(d)['y1'])-desiredFocus[1];})
            .attr("x2",function(d){return x(lineInvTraduc1(d)['x2'])-desiredFocus[0];})
            .attr("y2",function(d){return y(lineInvTraduc1(d)['y2'])-desiredFocus[1];})

        lineInvTraduc2v.transition()
            .duration(750)
            .attr("x1",function(d){return x(lineInvTraduc2(d)['x1'])-desiredFocus[0];})
            .attr("y1",function(d){return y(lineInvTraduc2(d)['y1'])-desiredFocus[1];})
            .attr("x2",function(d){return x(lineInvTraduc2(d)['x2'])-desiredFocus[0];})
            .attr("y2",function(d){return y(lineInvTraduc2(d)['y2'])-desiredFocus[1];})

        lineInvTraduc3v.transition()
           .duration(750)
           .attr("x1",function(d){return x(lineInvTraduc3(d)['x1'])-desiredFocus[0];})
           .attr("y1",function(d){return y(lineInvTraduc3(d)['y1'])-desiredFocus[1];})
           .attr("x2",function(d){return x(lineInvTraduc3(d)['x2'])-desiredFocus[0];})
           .attr("y2",function(d){return y(lineInvTraduc3(d)['y2'])-desiredFocus[1];})

        lineInvTraduc4v.transition()
           .duration(750)
           .attr("x1",function(d){return x(lineInvTraduc4(d)['x1'])-desiredFocus[0];})
           .attr("y1",function(d){return y(lineInvTraduc4(d)['y1'])-desiredFocus[1];})
           .attr("x2",function(d){return x(lineInvTraduc4(d)['x2'])-desiredFocus[0];})
           .attr("y2",function(d){return y(lineInvTraduc4(d)['y2'])-desiredFocus[1];})

        betaVectorizadav.transition()
           .duration(750)
           .attr("d",function(d){return zoomBeta(d,x,y,desiredFocus);})
        if(grande == 0)
        {
          idle = false;
          //   despX = x(0);
          //   despY = y(0);
          deltaX = 5;
          deltaY = 5;
          grande =1;
          desiredFocus = [0,0];
          $("#Math2").css({ opacity: 0 });
          divTer.innerHTML="$$"+st+"$$";
          clickAlias("Math2",alias, valorAlias);
          document.getElementById("terminoGrafico").style.zIndex=1;
          $("#Math2").fadeTo(2000,1);
          MathJax.Hub.Queue(["Typeset",MathJax.Hub,divTer]);
        }
        else
        {
          idle = true
       //   despX = 0;
       //   despY = 0;
          tGMoved([0,0]);
          deltaX = zigzagWidth-7;
          deltaY = zigzagHeight-7;
          grande = 0;
          document.getElementById("terminoGrafico").style.zIndex=0;
          divTer.innerHTML="";
          MathJax.Hub.Queue(["Typeset",MathJax.Hub,divTer]);
        }                
      }
    </script>
    <tiles:insertDefinition name="footer" />
  </body>
</html>
