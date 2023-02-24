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
    <tiles:insertDefinition name="header" />
    <head>
        <base href="${pageContext.request.contextPath}/perfil/${usuario.login}/"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap-responsive.css" >
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/font-awesome.min.css">
        <c:choose>
            <c:when test="${showCategorias.size() == 0}">
                <script>
                    $(document).ready(function(){$("#exampleModal").modal('show');});
                </script>
            </c:when>
        </c:choose>
        <!--  <script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script> -->
        <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/inferForm.js"></script>
        <script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
        <script type="text/javascript">
            
            var buttonsEnabled = true; // Determines if certain buttons of this view can be activated or not.

            // Indicates if the user can make click in a theorem to start a demonstration or not. 
            // We don't use the same "buttonsEnabled" variables just in case one is enabled while the other still shouldn't.
            var clickInTheoremAllowed = true; 
                                                
            $(function(){
                
                setViewState(${elegirMetodo});
                    
                $("#metodosDemostracion").change(function(){
                    let commonPrefix = "Are you sure you want to use the";
                    let commonSufix = "method?";
                    var metodosDemostracionValue = this.value
                    //$('#nuevoMetodo_id').val(this.options[this.selectedIndex].text);
                    $('#nuevoMetodo_id').val(metodosDemostracionValue);

                    //shwo modal for confirmation
                    if (this.value != 0) {
                        openModal(this.value);
                    }
                });
                
                $('#formula').on('click','#teoremaMD',async function(event){
                    if (clickInTheoremAllowed){
                        clickInTheoremAllowed = false;
                        var selectTeoInicial = $("#selectTeoInicial").val();
                        if (selectTeoInicial==="1"){
                            await proofMethodAjax("DM", "ST-${nTeo}");
                            clickInTheoremAllowed = true;
                        }
                        else{
                            clickInTheoremAllowed = true;
                        }
                    }
                });
                
                $('#formula').on('click','.teoremaClick',async function(event){
                    if (clickInTheoremAllowed){
                        clickInTheoremAllowed = false;
                        // The "this.id" refers to the side, that could be "d" for "derecho" or "i" for "izquierdo"
                        await proofMethodAjax("SS", null, this.id);
                        clickInTheoremAllowed = true;
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
                    };
                    try {
                        range.setEnd(lastChild,1);
                    }
                    catch (e) {
                        range.setEnd(lastChild,0);
                    }
                    return ancestor.id;
                }

                $('#formula').on("mouseup",function(event){
                    // This gets the entire well formed expression that can be substituted
                    var total_expression = $(".0");
                    var range = window.getSelection().getRangeAt(0);
                    var id = "";
                    var ancestor = range.commonAncestorContainer;
                    if (total_expression && total_expression.find(ancestor).length){                   
                        id = completeSelection(ancestor, range);
                        leibnizMouse(id,id);
                    }
                    else if (total_expression && window.getSelection().type === 'Range') {
                        let isStartInside = total_expression.find(range.startContainer).length;
                        let isEndInside = total_expression.find(range.endContainer).length;
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
                });
            })
        </script>
        
        <style>
            #leibnizVar {
                width: 0.4cm;
                height: 0.4cm;
                font-size: 15px;
            }
        </style>
    </head>
    <body>

        <!-- Include custom modal for confirmation -->
        <jsp:include page="modals/confirmationModal.jsp" />

        <!-- To show the word Loading in the center of the screen -->
        <jsp:include page="modals/loadingModal.jsp"/>

        <!-- For selecting the categories that will be displayed -->
        <jsp:include page="modals/showCategoriesModal.jsp" />

        <tiles:insertDefinition name="nav" />

        <input id="selectTeoInicial" value="" type="hidden"/>

        <div class="row">
            <div class="col-lg-7" style="padding-right: 0px;">
                <article class="proof">
                    <div id="formulaInput" class="d-none">
                    </div>
                <h5 id="formula" style="width:100%; height: 100%">${formula}</h5>
                </article>
            </div>    

            <!--<div style="float: right; width: 40%;">-->
            <div class="col-lg-5" style="padding-right: 0px; padding-left: 0px;">
                <div id="metodosDiv">
                    <h3 style="color: #08c; margin: 0px;padding:0px;height:40px;">Proof method</h3>
                    <!-- Algunos métodos sólo deberían estar visibles después de que el usuario los desbloquee haciendo las demostraciones necesarias -->
                    <select class="form-control" id="metodosDemostracion">
                        <option value="0">Select a method</option>
                        <option value="DM">Direct method</option>
                        <option value="SS">Starting from one side</option>
                        <option value="TR">Transitivity</option>
                        <option value="WE">Weakening</option>
                        <option value="ST">Strengthening</option>
                        <!--<option value="ND">Natural deduction</option>-->
                        <option value="CO">Proof by contradiction</option>
                        <option value="CR">Counter-reciprocal</option>
                        <option value="AI">Conjunction by parts</option>
                        <option value="MI">Mutual implication</option>
                        <option value="CA">Case analysis</option>
                        <option value="GE">Generalization</option>
                        <option value="WI">Witness</option>
                    </select>
                </div>

                <article id="teoremas" class="teoremas">
                    <div class="row flex align-items-center">
                        <h3 style="margin-left: 5%; margin-top: 2%;padding:0px;height:40px;"><a>Theorems</a></h3>
                        <a data-target="#exampleModal" data-toggle="modal">            
                            <i id="cate-cog" class="fa fa-cog ml-2" aria-hidden="true"></i>                
                        </a>
                    </div>

                    <ul style="padding-left: 20px;">
                        <div id="myTheoremsSpace">
                            <jsp:include page="theoremsList/theoremsListProve.jsp"/>
                        </div>
                    </ul>
                </article> 

                <!-- Modal to show the current instantiation of the theorem -->
                <div class="modal fade" id="instantiationModal" tabindex="-1" role="dialog" aria-labelledby="instantiationModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h4 class="modal-title" id="instantiationModalLabel">Instantiation of </h4>
                                <button onclick="$('#showInstantiation').html('');" type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body" style="overflow-x: scroll;">
                                <center><span id="showInstantiation"></span></center>
                            </div>
                        </div>
                    </div>                 
                </div>                 
            </div>
        
            <script>
                function getURLuntilUsername(){
                    const currentURL = window.location.href; 
                    const urlSplitted = currentURL.split("/");
                    var stop = 0;
                    for (i=0; i < urlSplitted.length; i++){
                        // We are interested in that the URL of the AJAX preserves from the current one
                        // until the username, and before that username it can only be the "infer" or the
                        // "perfil" word.
                        if ((urlSplitted[i] === "infer") || (urlSplitted[i] === "perfil")){
                            stop = i+1; // The +1 is because we stop in the username (after current position)
                            break;
                        }
                    }
                    return urlSplitted.slice(0,stop+1).join("/");
                }
                function expandMeta(id, vars) {
                    elem = document.getElementById("metateoIdName"+id);
                    elem2 = document.getElementById("metaTeo"+id);
                    if (elem.style.display == "inline") {
                        elem.style.display = "none";
                        elem2.style.display = "none";
                    } else{
                        // Case when the metatheorems have not been generated yet
                        if (elem.childElementCount==0) {
                            $.ajax({
                                type: 'POST',
                                url: getURLuntilUsername() + "/metatheorem",
                                dataType: "json",
                                data: {nTheo: id},
                                success: function(newData) {
                                    let div = document.getElementById("metateoIdName"+id);
                                    div.innerHTML = newData.string;
                                    MathJax.Hub.Typeset();
                                    clickOperator('clickMT'+id,'nStatement_id','MT-'+id, vars)
                                    elem.style.display = elem2.style.display = "inline";
                                }, error: function(XMLHttpRequest, textStatus, errorThrown) { 
                                    alert("Status: " + textStatus); alert("Error: " + errorThrown/*XMLHttpRequest.responseText*/); 
                                }
                            });   
                        }
                        // Case when the metatheorems had been generated previously, 
                        // so we only need to show them again
                        else {
                            elem.style.display = elem2.style.display = "inline";
                        }
                    }
                };
            </script>
        </div>

        <c:choose>
            <c:when test="${!selecTeo}">
                <form id="inferForm" action="${pageContext.request.contextPath}/infer/${usuario.getLogin()}/${nTeo}/${nSol}" method="POST" style="display:none">
                    <br>
              
                    <input name="nuevoMetodo" id="nuevoMetodo_id" value='' style="display: none;"/>
                    <div class="row justify-content-center">
                        <div class="col-10">
                            <div id="jaxButtonsDiv" class="row justify-content-center">
                                <c:set var="collapse" value="" scope="request"/>
                                <tiles:insertDefinition name="jaxButtons"/>
                            </div>
                            <div id="stSustLeibDiv" class="row justify-content-center">
                                <div class="col-l-2" style="padding-left: 5px; padding-right: 5px;">
                                    <div class="form-group card text-center border-primary">
                                        <div class="card-header" style="padding-bottom: 2px; padding-top: 2px;">
                                            Statement:
                                            <input name="nStatement" id="nStatement_id" value="${nStatement}" type="hidden"/>
                                        </div>
                                        <div id="stbox" class="card-body d-flex align-items-center justify-content-center"></div>
                                    </div>
                                </div>
                                <!--<br>-->
                                <script>
                                    window['auto'] = ${autoSust};
                                </script>
                                <div class="col-l-4" style="padding-left: 5px; padding-right: 5px;">
                                    <div style="display: none;">
                                        Substitution:<br><input name="instanciacion" id="instanciacion_id" value="${instanciacion}"/></br>
                                    </div>
                                    <c:set var="rootId" value="substitutionButtonsId" scope="request"/>
                                    <c:set var="labelName" value="Substitution:" scope="request"/>
                                    <c:set var="inputForm" value="instanciacion_id" scope="request"/>
                                    <tiles:insertDefinition name="jaxSubstitutionDiv"/>
                                </div>

                                <div class="col-l-4" style="padding-left: 5px; padding-right: 5px;">
                                    <div style="display: none;">
                                        Leibniz: <br><input name="leibniz" id="leibniz_id" value="${leibniz}"/></br>
                                    </div>
                                    <c:set var="rootId" value="leibnizSymbolsId" scope="request"/>
                                    <c:set var="labelName" value="Leibniz:" scope="request"/>
                                    <c:set var="inputForm" value="leibniz_id" scope="request"/>
                                    <c:set var="prefixMathJax" value="E^{\\\\FormInput{leibnizVar}}: " scope="request"/>
                                    <c:set var="prefixCnotation" value="lambda z." scope="request"/>
                                    <tiles:insertDefinition name="jaxDiv"/>
                                </div>
                            </div>
                        </div>
                        <div class="col-l-1">
                            <!-- Note: The logic of the onclick functions for these buttons is in InferForm.js -->
                            <input id ="BtnInferir" class="btn btn-default" type="submit" name="submitBtnI" value="Infer"/>
                            <br><br><input id ="BtnRetroceder" class="btn btn-default" name="submitBtnR" type="submit" value="Go back"> 
                            <br><br><input id="BtnLimpiar" class="btn btn-default" type="button" value="Clean">
                            <input id="Btn" type="hidden" name="submitBtn" value=""/>
                        </div>
                    </div>
                </form>
            </c:when>
        </c:choose>

        <script>
            document.getElementById("saveConfig").onclick = function(){
                saveDisplayedCategories("prove", ${selecTeo});
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
    <%--<tiles:insertDefinition name="footer" /> --%>
    </body>
</html>