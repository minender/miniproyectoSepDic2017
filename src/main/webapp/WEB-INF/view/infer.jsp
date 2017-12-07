<%-- 
    Document   : insertarEvaluar
    Created on : 24/05/2014, 08:32:15 PM
    Author     : federico
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html>

    <!-- Desde aqui -->
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="${pageContext.request.contextPath}/static/js/jquery-3.2.1.min.js"></script>
        <!--  <script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script> -->
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/desplegar.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/ClickOnAlias.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/inferForm.js"></script>
        <script type="text/x-mathjax-config">
          MathJax.Hub.Config({
          tex2jax: {
          inlineMath: [ ['$','$'], ["\\(","\\)"] ],
          processEscapes: true
          }
         });
        </script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/mathjax-MathJax-v2.3-248-g60e0a8c/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
        <script type="text/javascript">
            function limpiar()
            {
                var texArea=document.getElementById("asdasd");
                if(texArea.value != "")
                {
                    if(confirm("Seguro que desea borrar el contenido del área de texto"))
                        texArea.value="";
                }
            }
            
            $(function(){
                
                    
                <c:choose>
                    <c:when test="${elegirMetodo=='1'}">
                        $("#metodosDiv").show();
                        $("#inferForm").hide();
                    </c:when>
                    <c:otherwise>
                        $("#selectTeoInicial").val("0");
                        $("#inferForm").show();
                        $("#metodosDiv").hide();
                    </c:otherwise>
                </c:choose>
                    
                    
                $("#metodosDemostracion").change(function(){
                    
                    if(this.value==="1"){
                        if(confirm("Esta seguro que desea utlizar el metodo directo ?")){
                            $("#selectTeoInicial").val("1");
                            alert('Seleccione el teorema con el cual va a empezar la demostracion.');
                            $("#metodosDiv").hide();
                        }
                    }
                    else if(this.value==="2"){
                        if(confirm("Esta seguro que desea utlizar el metodo partir de un lado ?")){
                            var nTeo = $("#nTeorema").val();
                            $("#selectTeoInicial").val("0");
                            alert('Seleccione el teorema con el cual va a empezar la demostracion.');
                            $("#metodosDiv").hide();
                            teoremaClickeable(nTeo);
                        }
                    }
                    else if(this.value==="3"){
                        if(confirm("Esta seguro que desea utlizar el metodo Debilitamiento/Fortalecimiento ?")){
                            var nTeo = $("#nTeorema").val();
                            $("#selectTeoInicial").val("0");
                            $("#metodosDiv").hide();
                            metodoDF(nTeo);
                        }
                    }
                });
                
                
                $('#formula').on('click','.teoremaClick',function(event){
                    var data = {};
                    var form = $('#inferForm');
                    var teoId = $("#nTeorema").val();

                    data["teoid"] = teoId;
                    if(this.id==='d'){
                        data["lado"] = "d";
                        $.ajax({
                            type: 'POST',
                            url: $(form).attr('action')+"/teoremaInicialPL",
                            dataType: 'json',
                            data: data,
                            success: function(data) {

                                $('#formula').html(data.historial);
                                MathJax.Hub.Typeset();
                                $('#teoremaInicial').val(teoId + "-d");
                                $("#inferForm").show();
                                $("#nuevoMetodo").val("1");
                            }
                        }); 
                    }
                    else if(this.id==='i'){
                        data["lado"] = "i";
                        $.ajax({
                        type: 'POST',
                        url: $(form).attr('action')+"/teoremaInicialPL",
                        dataType: 'json',
                        data: data,
                        success: function(data) {

                            $('#formula').html(data.historial);
                            MathJax.Hub.Typeset();
                            $('#teoremaInicial').val(teoId + "-i");
                            $("#inferForm").show();
                            $("#nuevoMetodo").val("1");
                        }
                        });
                    } 
                });
                
                var p1=[];
                var p2=[];
                
                $("#formula").on("mousedown",".terminoClick",function(event){
                    var nivel = $(this).parent().attr('class');
                    nivel = nivel.split(" ")[1];
                    var id = $(this).parent().attr("id");
                    p1 = [id,nivel];
                });
                $("#formula").on("mouseup",".terminoClick",function(event){
                    var nivel = $(this).parent().attr('class');
                    nivel = nivel.split(" ")[1];
                    var id = $(this).parent().attr("id");
                    p2 = [id,nivel];
                    alert(p1);
                    alert(p2);
                    leibnizMouse(p1,p2)
                });
            });   

        </script>
        <base href="/Miniproyecto/perfil/${usuario.login}/"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css" >
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css" >
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap-responsive.css" >
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        </style>
        <tiles:insertDefinition name="style" />
        <title>L&oacute;gica | Demostrar</title>
    </head>
    <body>
        <tiles:insertDefinition name="header" />
        <input id="selectTeoInicial" value="" type="hidden"/>
        <input id="nTeorema" value="${nTeo}" type="hidden"/>
        <input id="nSolucion" value="${nSol}" type="hidden"/>
        <script>
            function insertAtCursor(myField, myValue) 
            {            
                myValue+="";
                parent.window.document.getElementById(myField).value = myValue;
            }
        </script>
        
        <div style="float: right; width: 40%;">

          <div id="metodosDiv">
            <h3 style="color: #08c; margin: 0px;padding:0px;height:40px;">Método de demostración</h3>
              <select class="form-control" id="metodosDemostracion">
                <option value="0">Seleccione un método</option>>
                <option value="1">Método Directo</option>
                <option value="2">Partir de un lado de la ecuación</option>
                <option value="3">Debilitamiento/Fortalecimiento</option>
                <option value="4">Asumir el antecedente</option>
                <option value="5">Prueba por casos</option>
                <option value="6">Prueba por contradicción</option>

              </select>
          </div>
          <article id="teoremas">
            <h3 style="margin: 0px;padding:0px;height:40px;"><a onclick="desplegar('teoremas')">Teoremas</a></h3>
            <ul>
              <c:forEach items="${categorias}" var="cat"> 
                <li style="list-style: none; color: #03A9F4"><h4 >${cat.getNombre()}</h4>
                  <ul>
                    <c:forEach items="${resuelves}" var="resu">
                      <c:choose>
                        <c:when test="${resu.getTeorema().getCategoria().getId()==cat.getId()}">      
                            <li style="list-style: none;">
                              <h6 style="color: #000;">
                                <c:choose>
                                <c:when test="${!selecTeo}">
                                <c:choose>
                                <c:when test="${resu.isResuelto() || resu.getNumeroteorema().equals(nTeo)}">
                                <a onclick="expandMeta('metaTeo${resu.getNumeroteorema()}')">
                                    <i class="fa fa-plus-circle" aria-hidden="true"  style="margin-left: 10px; margin-right: 10px;"></i>
                                </a>
                                    <span id="click${resu.getNumeroteorema()}">
                                    
                                (${resu.getNumeroteorema()}) ${resu.getNombreteorema()}: &nbsp; $${resu.getTeorema().getTeoTerm().toStringInfFinal()}$    

                                
                                </span>
                                    <script>clickOperator('click${resu.getNumeroteorema()}','nStatement_id','ST-${resu.getNumeroteorema()}');</script>
                                <span style="display: none;" id="metaTeo${resu.getNumeroteorema()}">
                                   <br><span  style="margin-left: 10px; margin-right: 10px;">&nbsp;&nbsp;&nbsp;&nbsp;</span>                
                                   
                                    (${resu.getNumeroteorema()}) Metatheorem: &nbsp; $${resu.getTeorema().getMetateoTerm().toStringInfFinal()}$  
                                       
                                   <script>clickOperator('metaTeo${resu.getNumeroteorema()}','nStatement_id','MT-${resu.getNumeroteorema()}');</script>
                               </span>
                               </c:when>
                               </c:choose>
                                </c:when>
                                <c:otherwise>
                                   <c:choose>
                                    <c:when test="${resu.isResuelto()}">
                                        <i class="fa fa-unlock" aria-hidden="true" style="margin-right: 10px;"></i>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fa fa-lock" aria-hidden="true" style="margin-right: 15px;"></i>
                                    </c:otherwise>
                                    </c:choose>
                                        <span id="click${resu.getNumeroteorema()}">
                                    
                                        <c:choose>
                                        <c:when test="${!resu.isEsAxioma()}">

                                            <a onclick="return confirm('${resu.getDemopendiente() == -1 ? "Usted va a demostrar el teorema ":"Usted ha dejado una demostraci&oacute;n incompleta del teorema"} ${resu.getNumeroteorema()}${resu.getDemopendiente() == -1 ? "":". Continuar&aacute; la demostraci&oacute;n desde el punto en que la dej&oacute;"}')" href="../../infer/${usuario.getLogin()}/${resu.getNumeroteorema()}">(${resu.getNumeroteorema()}) ${resu.getNombreteorema()}:</a> &nbsp; $${resu.getTeorema().getTeoTerm().toStringInfFinal()}$
                                        </c:when>
                                        <c:otherwise>
                                        (${resu.getNumeroteorema()}) ${resu.getNombreteorema()}: &nbsp; $${resu.getTeorema().getTeoTerm().toStringInfFinal()}$    
                                        </c:otherwise>
                                        </c:choose>

                                        </span>
                                            <script>clickOperator('click${resu.getNumeroteorema()}','nStatement_id','${resu.getNumeroteorema()}');</script>
                                        <span style="display: none;" id="metaTeo${resu.getNumeroteorema()}">
                                           <br><span  style="margin-left: 10px; margin-right: 10px;">&nbsp;&nbsp;&nbsp;&nbsp;</span>

                                           <c:choose>
                                                <c:when test="${resu.isResuelto()}">
                                                    <i class="fa fa-unlock" aria-hidden="true" style="margin-right: 10px;"></i>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="fa fa-lock" aria-hidden="true" style="margin-right: 10px;"></i>
                                                </c:otherwise>
                                            </c:choose>

                                            (${resu.getNumeroteorema()}) Metatheorem: &nbsp; $${resu.getTeorema().getMetateoTerm().toStringInfFinal()}$  

                                           <script>clickOperator('metaTeo${resu.getNumeroteorema()}','nStatement_id','${resu.getNumeroteorema()}');</script>
                                       </span>
                                        </c:otherwise>
                                        </c:choose>
                              </h6>
                            </li>
                        </c:when>
                      </c:choose>
                    </c:forEach>
                  </ul>
                </li>
              </c:forEach> 
            </ul>
          </article>     

        </div>

        <script>
            function expandMeta(id) {
                elem = document.getElementById(id);
                if (elem.style.display == "inline")
                    elem.style.display = "none";
                else
                    elem.style.display = "inline";

            };
        
            function getMetateo(id) {
            
            }
        </script>

        <script>
            t=document.getElementById('pasoAnt');
            t.innerText="${pasoAnt}";
        </script>

        <div style="width: 60%; height: 400px; overflow: scroll;">
            <h5 id="formula">${formula}</h5>
        </div>    
          <c:choose>
          <c:when test="${!selecTeo}">
          <form id="inferForm" action="/Miniproyecto/infer/${usuario.getLogin()}/${nTeo}/${nSol}" method="POST" style="display:none">
              <%--Paso anterior:<br><sf:input path="pasoAnt" id="pasoAnt_id" value="${pasoAnt}"/><sf:errors path="pasoAnt" cssClass="error" />--%>
              <br>
              <!--\cssId{eq}{\style{cursor:pointer;}{p\equiv q}}-->
              Teorema a usar:<br>
              <input name="nStatement" id="nStatement_id" value="${nStatement}"/>
              <%--<select style="width: auto; height: auto; border: none;" class="form-control" id="mensaje" name="nStatement">
                  <c:forEach items="${teoremas}" var="cat">
                      <option value="${cat.getId()}" >${cat.getCategoria().getNombre()} - ${cat.getEnunciadoizq()} == ${cat.getEnunciadoder()}</option>
                  </c:forEach>  
              </select>--%>
              <br>
              Instanciación:<br><input name="instanciacion" id="instanciacion_id" value="${instanciacion}"/></br>
              Leibniz:<br><input name="leibniz" id="leibniz_id" value="${leibniz}"/></br>
              <br>
              <input id ="BtnInferir" class="btn" type="submit" name="submitBtnI" value="Inferir"/> <input id ="BtnRetroceder" class="btn" name="submitBtnR" type="submit" value="Retroceder"> <input id="BtnLimpiar" class="btn" type="button" value="limpiar">
              <input id="Btn" type="hidden" name="submitBtn" value=""/>
              <input type="hidden" id="teoremaInicial" name="teoremaInicial" value=""/>
              <input type="hidden" id="nuevoMetodo" name="nuevoMetodo" value="0"/>
          <form> 
          </c:when>
          </c:choose>
          <br>

    <tiles:insertDefinition name="footer" /> 
    </body>

</html>
