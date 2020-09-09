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
          extensions: ["tex2jax.js","[MathJax]/extensions/TeX/forminput.js"],
          jax: ["input/TeX","output/HTML-CSS"],
          tex2jax: {inlineMath: [ ['$','$'], ["\\(","\\)"] ],processEscapes: true},
          TeX: {extensions: ["AMSmath.js","AMSsymbols.js"]}
         });
        </script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/mathjax-MathJax-v2.3-248-g60e0a8c/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
        <script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
        <script type="text/javascript">
            
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
                        $("#currentTeo").hide();
                    </c:otherwise>
                </c:choose>
                    
                    
                $("#metodosDemostracion").change(function(){
                    var metodosDemostracionValue = this.value
                    $('#nuevoMetodo_id').val(this.options[this.selectedIndex].text);
                    if(this.value==="1"){
                        if(confirm("Are you sure you want to use the direct method?")){
                            $("#selectTeoInicial").val("1");
                            alert('Select the theorem with which the proof will begin.');
                            $(".teoIdName").css({"cursor":"pointer","color":"#08c"});
                            $(".operator").css({"cursor":"","color":""});
                            $("#metodosDiv").hide();
                        }
                    }
                    else if(this.value==="2"){
                        if(confirm("Are you sure you want to use the one-sided method?")){
                            //$("#nTeorema").val();
                            $("#selectTeoInicial").val("0");
                            alert('Select the side where the demo will start.');
                            $("#metodosDiv").hide();
                            $("#currentTeo").hide();
                            teoremaClickeable();
                        }
                    }
                    else if(this.value==="3"){
                        if(confirm("Are you sure you want to use the Weakening method?")){
                            //var nTeo = $("#nTeorema").val();
                            $("#selectTeoInicial").val("0");
                            $("#metodosDiv").hide();
                            $("#currentTeo").hide();
                            metodoD();
                        }
                    }
                    else if(this.value==="4"){
                        if(confirm("Are you sure you want to use the Strengthening method?")){
                            //var nTeo = $("#nTeorema").val();
                            $("#selectTeoInicial").val("0");
                            $("#metodosDiv").hide();
                            $("#currentTeo").hide();
                            metodoF();
                        }
                    }else if(this.value==="5"){
                    	if(confirm("Are you sure you want to use the Natural Deduction with one-sided method?")){
                            //$("#nTeorema").val();
                            $("#selectTeoInicial").val("0");
                            alert('Select the side where the demo will start.');
                            $("#metodosDiv").hide();
                            $("#currentTeo").hide();
                            teoremaClickeable();
                        }
					}else if(this.value==="6"){
						
						var implication = $("#implicationVariable").text();
                		if(implication != "true"){
                			alert("El teorema seleccionado no aplica para el metodo Asumir antecedente con metodo directo.");
                            $("#metodosDiv").show();
                		}else if(confirm("Are you sure you want to use the Natural Deduction with direct method?")){
							$("#HQcategory").attr("hidden",false);
							$("#currentTeo").hide();
							$("#selectTeoInicial").val("1");
                            alert('Select the theorem with which the proof will begin.');
                            $(".teoIdName").css({"cursor":"pointer","color":"#08c"});
                            $(".operator").css({"cursor":"","color":""});
                            $("#metodosDiv").hide();
                        }
                    }
                });
                
                
                $('#formula').on('click','.teoremaClick',function(event){
                    var data = {};
                    data["nuevoMetodo"] = $('#nuevoMetodo_id').val();
                    var form = $('#inferForm');
                    
                    data["lado"] = this.id;
                    if(this.id==='d' || this.id==='i'){
                        
                        $.ajax({
                            type: 'POST',
                            url: $(form).attr('action')+"/teoremaInicialPL",
                            dataType: 'json',
                            data: data,
                            success: function(data) {
                                $('#formula').html(data.historial);
                                MathJax.Hub.Typeset();
                                //$('#teoremaInicial').val("ST-"+teoId + "@d");
                                $("#inferForm").show();
                                //$("#nuevoMetodo").val("1");
                                var nSol = $(form).attr('action').split('/').pop(); //$('#nSolucion').val();
                                if(nSol==="new"){
                                   //$('#nSolucion').val(data.nSol);
                                   //nSol = $('#nSolucion').val();
                                   var url = $(form).attr('action');
                                   url = url.substring(0,url.length-3)+data.nSol;
                                   $(form).attr('action',url);
                                }
                            },
                            error: function(XMLHttpRequest, textStatus, errorThrown) { 
                              alert("Status: " + textStatus); alert("Error: " + errorThrown/*XMLHttpRequest.responseText*/); 
                            }
                        }); 
                    }
                    
                });
                
                var p1=[];
                var p2=[];
                var idt1;
                var idt2;
                
                function hasNumericClass(element){
                    let clases = $(element).attr("class");
                    isNumeric = false;
                    if (clases){
                        clases = clases.split(" ");
                        for (let i = 0; i<clases.length;i++){
                            if ($.isNumeric(clases[i])){
                                isNumeric = true
                            }
                        }
                    }
                    return isNumeric
                    
                }
                
                function hasNumericId(element){
                    let id = $(element).attr("id");
                    isNumeric = false;
                    if (id){
                        id = id.split(" ");
                        for (let i = 0; i<id.length;i++){
                            if ($.isNumeric(id[i])){
                                isNumeric = true
                            }
                        }
                    }
                    return isNumeric
                    
                }
                
                function completeSelection(ancestor, range){
                    while (!hasNumericId(ancestor)) {
                        ancestor = ancestor.parentNode;
                    }
                    range.setStart(ancestor.firstChild,0);
                    var lastChild = ancestor.lastChild;
                    while ( lastChild.hasChildNodes() ) {
                        lastChild = lastChild.lastChild;
                    }
                    range.setEnd(lastChild,1);
                    return ancestor.id;
                }

                $('#formula').on("mouseup",function(event){
                    //Obtiene toda la expresion bien formada que se puede sustituir
                    var total_expression = $(".0");
                    var range = window.getSelection().getRangeAt(0);
                    /*var _iterator = document.createNodeIterator(
                        range.commonAncestorContainer,
                        NodeFilter.SHOW_ALL, // pre-filter
                        {
                            // custom filter
                            acceptNode: function (node) {
                                return NodeFilter.FILTER_ACCEPT;
                            }
                        }
                    );*/
                    var id = "";
                    var ancestor = range.commonAncestorContainer;
                    if (total_expression && total_expression.find(ancestor).length){//window.getSelection().type === 'Range'){                        
                        id = completeSelection(ancestor, range);
                        leibnizMouse(id,id);
                    }
                    else if (total_expression && window.getSelection().type === 'Range') {
                       isStartInside = total_expression.find(range.startContainer).length;
                       isEndInside = total_expression.find(range.endContainer).length;
                       if (isStartInside && !isEndInside) {
                           var lastChild = total_expression[0].lastChild;
                           while ( lastChild.hasChildNodes() ) {
                                lastChild = lastChild.lastChild;
                           }
                           range.setEnd(lastChild,1);
                           ancestor = range.commonAncestorContainer;
                           id = completeSelection(ancestor, range);
                           leibnizMouse(id,id);
                       }
                       else if (!isStartInside && isEndInside) {
                           var firstChild = total_expression[0].firstChild;
                           while ( firstChild.hasChildNodes() ) {
                               firstChild = firstChild.firstChild;
                           }
                           range.setStart(firstChild,0);
                           ancestor = range.commonAncestorContainer;
                           id = completeSelection(ancestor, range);
                           leibnizMouse(id,id);
                       }
                    }
                    /*_nodes = [];
                    while (_iterator.nextNode()) {
                        if (_nodes.length === 0 && _iterator.referenceNode !== range.startContainer) continue;
                        _nodes.push(_iterator.referenceNode);                           
                        if (_iterator.referenceNode === range.endContainer) break;
                    }
                    var index = 0;
                    while (index < _nodes.length) {
                        if (typeof(_nodes[index].className)!='undefined' && 
                               _nodes[index].className.includes('terminoClick') && 
                               typeof(_nodes[index].id)!='undefined' && 
                               !isNaN(parseInt(_nodes[index].id)) 
                           )
                        index ++;
                    }
                    //Si esta expresion existe y lo seleccionado tiene un rango (no es un simple click):
                        //Obtiene el primero y el ultimo elemento del subrayado
                        var first_element = window.getSelection().getRangeAt(0).startContainer;
                        if (first_element.nodeType !== 1) {
                            first_element = first_element.parentNode;
                        } 
                        var last_element = window.getSelection().getRangeAt(0).endContainer
                        if (last_element.nodeType !== 1) {
                            last_element = last_element.parentNode;
                        }*/
                        /*
                            //Si el primer elemento no es un parte de una subexpresion (digamos un parentesis),
                            // entonces se convierte en el elemento siguiente (su hermano) y asi
                            if (!$(first_element).hasClass("terminoClick") && !hasNumericClass(first_element)){
                                while(!$(first_element).hasClass("terminoClick") && !hasNumericClass(first_element) && $(first_element).next().length > 0){
                                    first_element = $(first_element).next()[0]
                                }
                            };
                            if ($(first_element).hasClass("0")){
                                while(!$(first_element).hasClass("terminoClick")){
                                    first_element = $(first_element).children()[0]
                                }
                            }
                            //Obtenemos el nivel del primer elemento
                            var nivel_first_element = $(first_element).attr('class');
                            if (nivel_first_element && nivel_first_element.length >= 2){
                              nivel_first_element = nivel_first_element.split(" ")[1];
                              //Obtenemos el id del primer elemento
                              var id_first_element = $(first_element).attr("id");
                              idt1=first_element.id;
                              p1 = [id_first_element,nivel_first_element];  
                            }
                            //Si el ultimo elemento no es un parte de una subexpresion (digamos un parentesis),
                            // entonces se convierte en el elemento anterior (su hermano) y asi
                            if (!$(last_element).hasClass("terminoClick") && !hasNumericClass(last_element)){
                                while(!$(last_element).hasClass("terminoClick") && !hasNumericClass(last_element) && $(last_element).prev().length > 0){
                                    last_element = $(last_element).prev()[0]
                                }
                            };
                            
                            //Si aun asi el ultimo elemento no tiene ni terminoClick ni clase Numerica (se selecciono algo fuera del teorema sin saber)
                            if (!$(last_element).hasClass("terminoClick") && !hasNumericClass(last_element)){
                                last_element = $("#0")[0]
                            }
                            //Obtenemos el id del primer elemento
                            idt2=last_element.id;
                            //Si ambos id son iguales, se puede obtener la subexpresion
                            if(idt1 === idt2){
                            leibnizMouse(idt1,idt2)
                            }
                            //Si no, se usa leibnizMouse(para obtener el comun entre ellos)
                            else{   
                                    var nivel_last_element = $(last_element).attr('class');
                                    if (nivel_last_element && nivel_last_element.length >= 2){
                                        nivel_last_element = nivel_last_element.split(" ")[1];
                                        var id_last_element = $(last_element).attr("id");
                                        p2 = [id_last_element,nivel_last_element];
                                        leibnizMouse(p1,p2)
                                                                    
                                }
                                
                            }
                        */
                    //}
                });
            })
        </script>
        <base href="${pageContext.request.contextPath}/perfil/${usuario.login}/"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css" >
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css" >
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap-responsive.css" >
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/font-awesome.min.css">
        <!--<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css" integrity="sha384-oS3vJWv+0UjzBfQzYUhtDYW+Pj2yciDJxpsK1OYPAYjqT085Qq/1cq5FLXAZQ7Ay" crossorigin="anonymous">-->
        </style>
        <tiles:insertDefinition name="style" />
        <title>Logic | Prove</title>
    </head>
    <body>
        <div id="modalLoading" class="modal" >
            <center>
                <div class="box-loading">
                  <div class="lds-ring">
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                  </div>
                <center>Loading</center>
                </div>
            </center>
        </div>
        <tiles:insertDefinition name="nav" />
        <input id="selectTeoInicial" value="" type="hidden"/>
        <%--<input id="nTeorema" value="${nTeo}" type="hidden"/>
        <input id="nSolucion" value="${nSol}" type="hidden"/>--%>
        <script>
            function insertAtCursor(myField, myValue) 
            {            
                myValue+="";
                parent.window.document.getElementById(myField).value = myValue;
            }
        </script>
        
        <div style="float: right; width: 40%;">
          <div id="metodosDiv">
            <h3 style="color: #08c; margin: 0px;padding:0px;height:40px;">Proof method</h3>
              <select class="form-control" id="metodosDemostracion">
                <option value="0">Select a method</option>
                <option value="1">Direct method</option>
                <option value="2">Starting from one side</option>
                <option value="3">Weakening</option>
                <option value="4">Strengthening</option>
                <option value="5">Natural Deduction,one-sided</option>
                <option value="6">Natural Deduction,direct</option>
                <option value="7">Proof by cases</option>
                <option value="8">Proof by contradiction</option>

              </select>
          </div>
            <article id="teoremas" class="teoremas">
                <div class="row flex align-items-center">
                <h3 style="margin-left: 5%; margin-top: 2%;padding:0px;height:40px;"><a>Theorems</a></h3>
                <a data-target="#exampleModal" data-toggle="modal">            
                    <i class="fa fa-cog ml-2" aria-hidden="true"></i>                
                </a>
               </div>
            <ul>
                <div id="misteoremasSpace">
                                   
                <div id="misteoremas"> 
                    <div id="showNoCategories">
		                <c:choose>
		                    <c:when test="${showCategorias.size() == 0}">
		                        You currently have no categories to display, adjust your settings
		                    </c:when>
		                </c:choose>
               		</div>
               		
              <!-- This adds a special category for natural deduction with direct method -->
              <p id="implicationVariable" hidden="true">${implication}</p>
              <li style="list-style: none; color: #03A9F4" id="HQcategory" hidden="true">
              		<h4><a data-toggle="collapse" href='#collapse-HQ' role="button" aria-expanded="false" aria-controls='collapse-HQ' class="collapse-link">H/Q</a><i style="font-size : 20px"class="ml-1 fa fa-chevron-down" aria-hidden="true" ></i></h4> 
         			<c:choose>	
         			
                        <c:when test="${implication}">
                        	<ul id='collapse-HQ' class="collapse">
                        		<li id="currentTeoH" style="list-style: none;">
                        			<h6 style="color: #000;">
                        				<a><i class="fa fa-circle" aria-hidden="true"  style="margin-left: 10px; margin-right: 10px;"></i></a>
                        				<span id="teoIdNameH" class="teoIdName">H &nbsp;:</span> &nbsp;<span id="clickH">$${ Hstring } $</span>
	                                    <script>clickTeoremaInicial('ST-H');</script>
                        			</h6>
                        		</li>
                        		<li id="currentTeoQ" style="list-style: none;">
                        			<h6 style="color: #000;">
                        				<a><i class="fa fa-circle" aria-hidden="true"  style="margin-left: 10px; margin-right: 10px;"></i></a>
                        				<span id="teoIdNameQ" class="teoIdName">Q &nbsp;:</span> &nbsp;<span id="clickQ">$${ Qstring } $</span>
	                                    <script>clickTeoremaInicial('ST-Q');</script>
                        			</h6>
                        		</li>
                        	
                        	</ul>
                        </c:when>
                    </c:choose>
                        
              </li>
              <!-- End of special category -->
              
              
              <c:forEach items="${showCategorias}" var="cat"> 
              	  
                  <li style="list-style: none; color: #03A9F4"><h4><a data-toggle="collapse" href='#collapse-${cat.getNombre().replaceAll(" ","-")}' role="button" aria-expanded="false" aria-controls='collapse-${cat.getNombre().replaceAll(" ","-")}' class="collapse-link">${cat.getNombre()}</a><i style="font-size : 20px"class="ml-1 fa fa-chevron-down" aria-hidden="true"></i></h4> 
                      <ul id='collapse-${cat.getNombre().replaceAll(" ","-")}' class="collapse">
                    <c:forEach items="${resuelves}" var="resu">
                      <c:choose>
                        <c:when test="${resu.getCategoria().getId()==cat.getId()}">      
                            <li ${!selecTeo && resu.getNumeroteorema().equals(nTeo)?"id=currentTeo":""} style="list-style: none;">
                              <h6 style="color: #000;">
                                <c:choose>
                                 <c:when test="${!selecTeo}">
                                  <c:choose>
                                   <c:when test="${resu.isResuelto() || resu.getNumeroteorema().equals(nTeo)}">
                                       <c:choose>
                                         <c:when test="${resu.getNumeroteorema().equals(nTeo)}">
                                            <a >
                                              <i class="fa fa-circle" aria-hidden="true"  style="margin-left: 10px; margin-right: 10px;"></i>
                                            </a>
                                         </c:when>
                                         <c:otherwise>
                                            <a onclick="expandMeta('metaTeo${resu.getNumeroteorema()}')" >
                                              <i class="fa fa-plus-circle" aria-hidden="true"  style="margin-left: 10px; margin-right: 10px;"></i>
                                            </a>
                                         </c:otherwise>
                                       </c:choose>

                                    
 <span id="teoIdName${resu.getNumeroteorema()}" class="teoIdName">(${resu.getNumeroteorema()}) ${resu.getNombreteorema()}:</span> &nbsp;<span id="click${resu.getNumeroteorema()}">$${resu.getTeorema().getTeoTerm().toStringInf(simboloManager,resu.getNumeroteorema())}$</span>

                                    <script>clickTeoremaInicial('ST-${resu.getNumeroteorema()}');
                                            clickOperator('click${resu.getNumeroteorema()}','nStatement_id','ST-${resu.getNumeroteorema()}','${resu.getTeorema().getTeoTerm().freeVars()}');
                                    </script>
                               <c:choose>
                                <c:when test="${!resu.getNumeroteorema().equals(nTeo)}">
                                <span style="display: none;" id="metaTeo${resu.getNumeroteorema()}">
                                   <br><span  style="margin-left: 10px; margin-right: 10px;">&nbsp;&nbsp;&nbsp;&nbsp;</span>                
                                   
 <span id="metateoIdName${resu.getNumeroteorema()}" class="teoIdName">(${resu.getNumeroteorema()}) Metatheorem:</span> &nbsp; <span id="clickmeta${resu.getNumeroteorema()}">$${resu.getTeorema().getMetateoTerm().toStringInf(simboloManager,"")}$</span>  
                                       
                                   <script>clickTeoremaInicial('MT-${resu.getNumeroteorema()}');
                                           clickOperator('clickmeta${resu.getNumeroteorema()}','nStatement_id','MT-${resu.getNumeroteorema()}','${resu.getTeorema().getTeoTerm().freeVars()}');
                                   </script>
                                </span>
                                </c:when>
                               </c:choose>
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
                                    
                                        <c:choose>
                                        <c:when test="${!resu.isEsAxioma()}">

                                            <a onclick="return confirm('${resu.getDemopendiente() == -1 ? "You are going to prove the theorem":"You have left an incomplete proof of the theorem"} ${resu.getNumeroteorema()}${resu.getDemopendiente() == -1 ? "":". To be continued the proof from the point where you left it;"}')" href="../../infer/${usuario.getLogin()}/${resu.getNumeroteorema()}">(${resu.getNumeroteorema()}) ${resu.getNombreteorema()}:</a> &nbsp; $${resu.getTeorema().getTeoTerm().toStringInf(simboloManager,mensaje)}$
                                        </c:when>
                                        <c:otherwise>
                                        (${resu.getNumeroteorema()}) ${resu.getNombreteorema()}: &nbsp; $${resu.getTeorema().getTeoTerm().toStringInf(simboloManager,"")}$    
                                        </c:otherwise>
                                        </c:choose>

                                        <%--<span style="display: none;" id="metaTeo${resu.getNumeroteorema()}">
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
                                       </span>--%>
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
              </div>
              </div>
            </ul>
          </article>     
                         <!-- Modal -->
          <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" id="exampleModalLabel">Configurations</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                    <h5>Show categories</h5>
                    <ul>
                    <c:forEach items="${categorias}" var="categoria">
                    <div class="row flex align-items-center"> 
                        <li>${categoria.getNombre()}</li>
                        <c:choose>
                            <c:when test="${showCategorias.contains(categoria)}">
                                <input type="checkbox" id="categoria-${categoria.getId()}" name="${categoria.getId()}" value="true" class="ml-2 categoria-settings" checked >
                            </c:when>
                            <c:otherwise>
                                <input type="checkbox" id="categoria-${categoria.getId()}" name="${categoria.getId()}" value="true" class="ml-2 categoria-settings">
                            </c:otherwise>
                        </c:choose>
                  </div>
                    </c:forEach>
                    </ul>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button id="saveConfig" type="button" class="btn btn-primary" data-dismiss="modal">Save changes</button>
                    </div>
                </div>
            </div>
        </div>
    
        </div>

        <script>
            function expandMeta(id) {
                elem = document.getElementById(id);
                if (elem.style.display == "inline")
                    elem.style.display = "none";
                else
                    elem.style.display = "inline";
            };
            
            //function getMetateo(id) {
            
            //}
        </script>

        <div style="width: 60%; height: 400px; overflow: scroll;">
            <h5 id="formula" style="width:100%; height: 100%">${formula}</h5>
        </div>    
          <c:choose>
          <c:when test="${!selecTeo}">
          <form id="inferForm" action="${pageContext.request.contextPath}/infer/${usuario.getLogin()}/${nTeo}/${nSol}" method="POST" style="display:none">
              <%--Paso anterior:<br><sf:input path="pasoAnt" id="pasoAnt_id" value="${pasoAnt}"/><sf:errors path="pasoAnt" cssClass="error" />--%>
              <br>
              <!--<div class="nn-box-loading">
                  <div class="loader">
                      <i class="fa fa-paper-plane"></i>
                  </div>
                  <span translate>Loading</span>
              </div>
              -->
         
              <!--\cssId{eq}{\style{cursor:pointer;}{p\equiv q}}-->
              
              <input name="nuevoMetodo" id="nuevoMetodo_id" value='' style="display: none;"/>
              
                Theorem to use:<br>
              <input name="nStatement" id="nStatement_id" value="${nStatement}"/>
              <%--<select style="width: auto; height: auto; border: none;" class="form-control" id="mensaje" name="nStatement">
                  <c:forEach items="${teoremas}" var="cat">
                      <option value="${cat.getId()}" >${cat.getCategoria().getNombre()} - ${cat.getEnunciadoizq()} == ${cat.getEnunciadoder()}</option>
                  </c:forEach>  
              </select>--%>
              
              
              <br>
              
              
              <tiles:insertDefinition name="jaxButtons" />
              
              <div style="display: none;">
              	Substitution:<br><input name="instanciacion" id="instanciacion_id" value="${instanciacion}"/></br>
              </div>
              
              <c:set var="rootId" value="substitutionButtonsId" scope="request"/>
          	  <c:set var="labelName" value="Substitution:" scope="request"/>
          	  <c:set var="inputForm" value="instanciacion_id" scope="request"/>
		  	  <tiles:insertDefinition name="jaxSubstitutionDiv" />
             
          	
          	  <div style="display: none;">
	              Leibniz: <br><input name="leibniz" id="leibniz_id" value="${leibniz}"/></br>
          	  </div>
              <br>
              
              <c:set var="rootId" value="leibnizSymbolsId" scope="request"/>
          	  <c:set var="labelName" value="Leibniz:" scope="request"/>
          	  <c:set var="inputForm" value="leibniz_id" scope="request"/>
          	  <c:set var="prefixMathJax" value="E^{z}: " scope="request"/>
          	  <c:set var="prefixCnotation" value="lambda z." scope="request"/>
		  	  <tiles:insertDefinition name="jaxDiv" />
              
              <input id ="BtnInferir" class="btn" type="submit" name="submitBtnI" value="Infer"
              onclick="setInputValueOnParser('leibnizSymbolsId'); setSubstitutionOnInput('substitutionButtonsId')"/> 
              <input id ="BtnRetroceder" class="btn" name="submitBtnR" type="submit" value="Go back"> 
              <input id="BtnLimpiar" class="btn" type="button" value="Clean"
              onclick="cleanJax('leibnizSymbolsId'); cleanJaxSubstitution('substitutionButtonsId')">
              <input id="Btn" type="hidden" name="submitBtn" value=""/>
              <%--<input type="hidden" id="teoremaInicial" name="teoremaInicial" value="${teoInicial}"/>
              <input type="hidden" id="nuevoMetodo" name="nuevoMetodo" value="0"/>--%>
          </form>
          
          
          
		  
		  
          </c:when>
          </c:choose>
              <a href="misTeoremas" id="linkDemostrar" style="display:none"></a>
          <script>
              function guardarMostrarCategorias(){
            allCategoriasSettings = document.getElementsByClassName("categoria-settings");
            let categorias = {
                listaIdCategorias:[],
                username: "${usuario.getLogin()}"
            };
            for (let i = 0; i<allCategoriasSettings.length;i++){
                cat = allCategoriasSettings.item(i);
                if (cat.checked === true){
                    let id = allCategoriasSettings.item(i).getAttribute("name");
                    categorias.listaIdCategorias.push(id);
                }
                
            };
                $.ajax({
                cache:false,
                type: 'POST',
                url: "misTeoremas",
                data: JSON.stringify(categorias),
                contentType: "application/json",
                success:  function(data) { 
                    var element = document.getElementById("misteoremas");
                    element.parentNode.removeChild(element);
                    
                     var p = document.getElementById("misteoremasSpace");
                     var newElement = document.createElement("div");
                     newElement.setAttribute('id', "misteoremas");
                     categories = data.categories
                     teoremas = data.resuelves;
                     var script= document.createElement('script');
                     script.type= 'text/javascript';
                     script.innerHTML = '';
                     if (categories.length == 0 ){
                         newElement.innerHTML = "<div id='showNoCategories'>You currently have no categories to display, adjust your settings</div>"
                     }else{
                        newRows=''
                        for (i=0;i<categories.length;i++){
                            newRows = newRows + '<li style="list-style: none; color: #03A9F4"><h4><a data-toggle="collapse" href="#collapse-' + categories[i].categoryname.split(" ").join("-") + '" role="button" aria-expanded="false" aria-controls="collapse-' + categories[i].categoryname.split(" ").join("-") + '" class="collapse-link">' + categories[i].categoryname + '</a><i style="font-size : 20px"class="ml-1 fa fa-chevron-down" aria-hidden="true"></i></h4>';
                            newRows = newRows + '<ul id="collapse-' + categories[i].categoryname.split(" ").join("-") + '" class="collapse">';
                            for (j=0;j < teoremas.length ;j++){
                                if (teoremas[j].categoryid == categories[i].categoryid){
                                    <c:choose>
                                        <c:when test='${!nTeo.equals("")}'>
                                            if  (${!selecTeo} && teoremas[j].numeroteorema == ${nTeo}){                     
                                        </c:when>
                                        <c:otherwise>
                                            if  (${!selecTeo} && teoremas[j].numeroteorema == ""){                     
                                        </c:otherwise>
                                    </c:choose>
                                        newRows = newRows + '<li id="currentTeo" style="list-style: none;">'
                                   }else{
                                       newRows = newRows + '<li style="list-style: none;">'
                                   }
                                   newRows = newRows + '<h6 style="color: #000;">'
                                   if (${!selecTeo}){
                                    <c:choose>
                                        <c:when test='${!nTeo.equals("")}'>
                                            if(teoremas[j].isResuelto || teoremas[j].numeroteorema == ${nTeo}){
                                        </c:when>
                                        <c:otherwise>
                                            if(teoremas[j].isResuelto || teoremas[j].numeroteorema == ""){
                                        </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test='${!nTeo.equals("")}'>
                                           if(teoremas[j].numeroteorema == ${nTeo}){
                                        </c:when>
                                        <c:otherwise>
                                           if(teoremas[j].numeroteorema == ""){
                                        </c:otherwise>
                                    </c:choose>
                                              newRows = newRows + '<a>'
                                              newRows = newRows + '<i class="fa fa-circle" aria-hidden="true"  style="margin-left: 10px; margin-right: 10px;"></i>'
                                              newRows = newRows + '<a>'
                                           }else{
                                              newRows = newRows + '<a onclick="expandMeta(' + "'metaTeo" + teoremas[j].numeroteorema + "'" + ')" >'
                                              newRows = newRows + '<i class="fa fa-plus-circle" aria-hidden="true"  style="margin-left: 10px; margin-right: 10px;"></i>'
                                             newRows = newRows + '</a>'
                                            }
    
                                       
                                            newRows = newRows + '<span id="teoIdName' + teoremas[j].numeroteorema + '" class="teoIdName">(' + teoremas[j].numeroteorema + ')'+ teoremas[j].nombreteorema + ':</span> &nbsp;<span id="click' + teoremas[j].numeroteorema + '">$' + teoremas[j].stringNumero + '$</span>';
                                            //newRows = newRows + '<script>clickTeoremaInicial(' + "'" + 'ST-' + teoremas[j].numeroteorema + "'" + ');';
                                            //newRows = newRows + 'clickOperator(' + "'" + 'click' + teoremas[j].numeroteorema + "'" + ',' + "'" + 'nStatement_id' + "'" + ',' + "'" + 'ST-' + teoremas[j].numeroteorema + "'" + ');<' + '/script>';                                            
                                            var script1= document.createElement('script');
                                            script.type= 'text/javascript';
                                            script.innerHTML= script.innerHTML + 'clickTeoremaInicial(' + "'" + 'ST-' + teoremas[j].numeroteorema + "'" + '); clickOperator(' + "'" + 'click' + teoremas[j].numeroteorema + "'" + ',' + "'" + 'nStatement_id' + "'" + ',' + "'" + 'ST-' + teoremas[j].numeroteorema + "'" + ');';
                                            <c:choose>
                                                <c:when test='${!nTeo.equals("")}'>
                                                    if(teoremas[j].numeroteorema != ${nTeo}){
                                                </c:when>
                                                <c:otherwise>
                                                    if(teoremas[j].numeroteorema != ""){
                                                </c:otherwise>
                                            </c:choose>
                                                newRows = newRows + '<span style="display: none;" id="metaTeo' + teoremas[j].numeroteorema + '">';
                                                newRows = newRows + '<br><span  style="margin-left: 10px; margin-right: 10px;">&nbsp;&nbsp;&nbsp;&nbsp;</span>';
                                                newRows = newRows + ' <span id="metateoIdName' + teoremas[j].numeroteorema + '" class="teoIdName">(' + teoremas[j].numeroteorema + ') Metatheorem:</span> &nbsp; <span id="clickmeta' + teoremas[j].numeroteorema + '">$' + teoremas[j].metateoremastring + '$</span>  '
                                                //newRows = newRows + '<script>clickTeoremaInicial(' + "'" + 'MT-' + teoremas[j].numeroteorema + "'" + ');'
                                                //newRows = newRows + 'clickOperator(' + "'" + 'clickmeta' + teoremas[j].numeroteorema + "'" + ',' + "'" + 'nStatement_id' + "'" + ',' + "'" + 'MT-' + teoremas[j].numeroteorema + "'" +');';
                                                //newRows = newRows + '</' + 'script>';
                                                script.innerHTML= script.innerHTML + 'clickTeoremaInicial(' + "'" + 'MT-' + teoremas[j].numeroteorema + "'" + '); clickOperator(' + "'" + 'clickmeta' + teoremas[j].numeroteorema + "'" + ',' + "'" + 'nStatement_id' + "'" + ',' + "'" + 'MT-' + teoremas[j].numeroteorema + "'" +');'
                                                newRows = newRows + '</span>';
                                            }
                                        }
                                    }else{
                                        if (teoremas[j].isResuelto){
                                            newRows = newRows + '<i class="fa fa-unlock" aria-hidden="true" style="margin-right: 10px;"></i>';
                                        }else{
                                            newRows = newRows + '<i class="fa fa-lock" aria-hidden="true" style="margin-right: 15px;"></i>'
                  
                                        }
                                        if (!teoremas[j].isAxioma){
                                            if(teoremas[j].demopendiente == -1){
                                                newRows = newRows + '<a onclick="return confirm(' + "'" + 'You are going to prove the theorem' + teoremas[j].numeroteorema + "'" + ')" href="../../infer/${usuario.getLogin()}/' + teoremas[j].numeroteorema + '">(' + teoremas[j].numeroteorema + ')' +  teoremas[j].nombreteorema + ':</a> &nbsp; $' + teoremas[j].string + '$'
                                            }else{
                                                newRows = newRows + '<a onclick="return confirm(' + "'" + 'You have left an incomplete proof of the theorem' + teoremas[j].numeroteorema + '. To be continued the proof from the point where you left it;' + "'" + ')" href="../../infer/${usuario.getLogin()}/' + teoremas[j].numeroteorema + '">(' + teoremas[j].numeroteorema + ')' +  teoremas[j].nombreteorema + ':</a> &nbsp; $' + teoremas[j].string + '$'
                                           
                                            }
                                        }else{
                                           newRows = newRows + '(' + teoremas[j].numeroteorema + ') ' + teoremas[j].nombreteorema + ': &nbsp; $' + teoremas[j].string + '$'  
                                        }
                                    }
                                    newRows = newRows + '</h6>';
                                    newRows = newRows + '</li>'
                                       
                                       
                                       
                                   }
                                }
                                newRows = newRows + "</ul></li>"
                            }
                        innerHTML = newRows
                        newElement.innerHTML = innerHTML;                        
                        }
                     p.appendChild(newElement);
                     
                     MathJax.Hub.Queue(["Typeset",MathJax.Hub,"misteoremas"]);
                     terminoClick = document.getElementsByClassName("terminoClick")
                     if ($('#metodosDemostracion')[0].value && terminoClick.length == 0){
                            $(".teoIdName").css({"cursor":"pointer","color":"#08c"});
                            $(".operator").css({"cursor":"","color":""});
                        }
                    if (terminoClick.length > 0){
                        $("#currentTeo").hide();
                    }
                        document.body.appendChild(script);
                     }
                
                 });
        }
        document.getElementById("saveConfig").onclick = function(){
            guardarMostrarCategorias();
        }
          </script>
                    <script>
              $(".collapse-link").on("click",function(e){
                  if($(this).next().hasClass("fa-chevron-down")){
                      $(this).next().removeClass("fa-chevron-down");
                      $(this).next().addClass("fa-chevron-up");
                      
                  }else if ($(this).next().hasClass("fa-chevron-up")){
                      $(this).next().removeClass("fa-chevron-up");
                      $(this).next().addClass("fa-chevron-down");
                  }
              })
        
          </script>
    <tiles:insertDefinition name="footer" /> 
    </body>
</html>