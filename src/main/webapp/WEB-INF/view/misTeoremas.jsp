<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html>
  <tiles:insertDefinition name="header" />
      <c:choose>
          <c:when test="${isDifferentUser.intValue()==1}">
            <style>
              html{
                  padding-left:15px;
              }
            </style>
          </c:when>
      </c:choose>
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
    <c:choose>
        <c:when test="${isDifferentUser.intValue()==1}">
            <div class="row flex align-items-center">
                <h1>Theorems from ${usuario.getNombre()} ${usuario.getApellido()}</h1>
                <a data-target="#exampleModal" data-toggle="modal">            
                    <i class="fa fa-cog ml-2" aria-hidden="true"></i>                
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <tiles:insertDefinition name="nav" />
            <div class="row flex align-items-center">
            <h1>My Theorems</h1>
            <a data-target="#exampleModal" data-toggle="modal">            
                <i class="fa fa-cog ml-2" aria-hidden="true"></i>                
            </a>
            </div>
        </c:otherwise>
    </c:choose>
    <div class="row">
    <div id="misteoremasSpace" class="col-lg-5">
     <div id="misteoremas" >
         <div id="showNoCategories">
            <c:choose>
                <c:when test="${showCategorias.size() == 0}">
                    You currently have no categories to display, adjust your settings                
                </c:when>
            </c:choose>
         </div>
       <ul>
      <c:forEach items="${showCategorias}" var="cat"> 
          <li id="category-${cat.getId()}"><h3 class="subtitle">${cat.getNombre()}</h3>
          <ul>
            <c:forEach items="${teoremas}" var="resu">
              <c:choose>
                <c:when test="${resu.getCategoria().getId()==cat.getId()}">      
                  <c:choose>
                    <c:when test="${!resu.isResuelto()}">
                      <li >
                        <p >
                             <i class="fa fa-lock" aria-hidden="true" ></i>
                          (${resu.getNumeroteorema()}) ${resu.getNombreteorema()}: &nbsp; ${resu.getTeorema().getTeoTerm().toStringInfJavascript(simboloManager,predicadoManager,"",resu.getNumeroteorema())}                     
                        </p> 
                      </li>
                      
                    </c:when>
                    <c:otherwise>
                      <li >
                        <p >
                            <c:choose>
                            <c:when test="${!resu.isEsAxioma()}">
                                <a class="expandmeta" onclick="expandMeta(${resu.getTeorema().getId()})">
                                <i class="fa fa-plus-circle" aria-hidden="true" ></i>
                                </a>
                                <i class="fa fa-unlock" aria-hidden="true"></i>

                                <a href="javascript:buscarSoluciones(${resu.getTeorema().getId()});" title="Haga click para ver las demostraciones del teorema">(${resu.getNumeroteorema()}) ${resu.getNombreteorema()}: </a> &nbsp; ${resu.getTeorema().getTeoTerm().toStringInfJavascript(simboloManager,predicadoManager,"",resu.getNumeroteorema())}
                                <span class="d-none" id="${resu.getTeorema().getId()}">

                                <br><span class="metaitem"></span>
                                <a href="javascript:buscarMetaSoluciones(${resu.getTeorema().getId()});" title="Haga click para ver las demostraciones del teorema">(${resu.getNumeroteorema()}) Metatheorem: </a> &nbsp; $${resu.getTeorema().getMetateoTerm().toStringInfJavascript(simboloManager,predicadoManager,"",resu.getNumeroteorema())}$
                                </span>
                            </c:when>
                            <c:otherwise>
                                <i class="fa fa-unlock" aria-hidden="true" ></i>
                                (${resu.getNumeroteorema()}) ${resu.getNombreteorema()}: &nbsp; ${resu.getTeorema().getTeoTerm().toStringInfJavascript(simboloManager,predicadoManager,"",resu.getNumeroteorema())}                     
                        
                            </c:otherwise>
                          </c:choose>
                        </p>
                      </li>
                    </c:otherwise>
                  </c:choose>
                </c:when>
              </c:choose>
            </c:forEach>
          </ul>
        </li>
      </c:forEach> 
     </ul>
    
     </div>
     </div>
     <div id="panelSoluciones" class="col-lg-2 d-none">
         <center><h3 class="subtitle"> Proofs</h3></center>
           <ul id="listaSoluciones">
            
           </ul>
     </div>
     <div class="col-lg-5" >
       <h5 id="formula"></h5>
     </div>
    </div>
            
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
                     newElement.setAttribute("class","col-lg-5");
                     categories = data.categories
                     teoremas = data.resuelves
                    
                     if (categories.length == 0 ){
                         newElement.innerHTML = "<div id='showNoCategories'>You currently have no categories to display, adjust your settings</div>"
                     }else{
                     newRows=''
                     innerHTML = "<ul>"

                     for (i=0;i<categories.length;i++){
                         newRows = newRows + "<li id=category-"+categories[i].categoryid+"><h3 class='subtitle'>"+categories[i].categoryname+"</h3>"
                         newRows = newRows + "<ul>";
                         for (j=0;j < teoremas.length ;j++){
                            if (teoremas[j].categoryid == categories[i].categoryid){
                                if (!teoremas[j].isResuelto){
                                    newRows = newRows + "<li><p><i class='fa fa-lock' aria-hidden='true'></i>(" + teoremas[j].numeroteorema + ")"+ teoremas[j].nombreteorema + ": &nbsp; $" + teoremas[j].string + "$</p></li>"
                                }else{
                                    newRows = newRows + "<li><p>"
                                    if (!teoremas[j].isAxioma){
                                        newRows = newRows + "<a class='expandmeta' onclick='expandMeta(" + teoremas[j].teoremaid + ")'><i class='fa fa-plus-circle' aria-hidden='true'></i></a><i class='fa fa-unlock' aria-hidden='true'></i><a href='javascript:buscarSoluciones(" + teoremas[j].teoremaid + ");' title='Haga click para ver las demostraciones del teorema'>(" + teoremas[j].numeroteorema + ")" +  teoremas[j].nombreteorema + ": </a> &nbsp; $" + teoremas[j].string + "$<span class='d-none' id='" + teoremas[j].teoremaid + "'><br><span class='metaitem'></span><a href='javascript:buscarMetaSoluciones(" + teoremas[j].teoremaid + ");' title='Haga click para ver las demostraciones del teorema'>(" + teoremas[j].numeroteorema + ") Metatheorem: </a> &nbsp; $" + teoremas[j].metateoremastring + "$</span>"
                                    }else{
                                        newRows = newRows + "<i class='fa fa-unlock' aria-hidden='true' ></i> (" + teoremas[j].numeroteorema + ")" + teoremas[j].nombreteorema + ": &nbsp; $" + teoremas[j].string + "$"
                                    }
                                    newRows = newRows + "</p></li>"
                                }
                            }
                         }
                        newRows = newRows + "</ul></li>";
 
                     }
                     innerHTML = innerHTML + newRows + "</ul>"
                     newElement.innerHTML = innerHTML;
                    }
                     
                     p.appendChild(newElement);
                     MathJax.Hub.Queue(["Typeset",MathJax.Hub,"misteoremas"]);
                     
                     <c:choose>
                        <c:when test="${isDifferentUser.intValue()==1}">
                             let iframe = $('#studentIframe', parent.document)[0];
                            //let iframe = parent.getElementById("studentIframe")

                            let need_height = iframe.contentWindow.document.body.offsetHeight + 20
                            let iframeSpace = $('#iframeSpace', parent.document);
                            iframeSpace.css({
                                "min-height": "100%",   
                                "height": need_height + "px"
                            })
                       </c:when>
                    </c:choose>
                    
                }
        });
        }
        
        document.getElementById("saveConfig").onclick = function(){
            guardarMostrarCategorias();

        }
</script> 
    <c:choose>
        <c:when test="${isDifferentUser.intValue()!=1}">
            <tiles:insertDefinition name="footer" />
        </c:when>
    </c:choose>

  </body>
</html>
