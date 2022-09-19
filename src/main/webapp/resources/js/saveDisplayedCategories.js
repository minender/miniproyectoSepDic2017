/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

// Used both in the "My Theorems" and "Prove" views to change the categories
// that are currently displayed
async function saveDisplayedCategories(currentView, selecTeo=null) {
    allCategoriasSettings = document.getElementsByClassName("categoria-settings");
    let categorias = {
        listaIdCategorias:[],
        username: "${usuario.getLogin()}",
        currentView,
        selecTeo,
    };
    for (let i = 0; i<allCategoriasSettings.length;i++){
        cat = allCategoriasSettings.item(i);
        if (cat.checked === true){
            let id = allCategoriasSettings.item(i).getAttribute("name");
            categorias.listaIdCategorias.push(id);
        }
    };
    $("#modalLoading").css('display','inline-block');
    await $.ajax({
        type: 'POST',
        url: "theoremsList", // This is located in PerfilController.java
        contentType: "application/json",
        data: JSON.stringify(categorias),
        dataType: "text",  
        success:  function(data) {
            let split = data.split("myTheorems");
            if (split.length > 1){
                // NOTE: If we use document.getElementById("...").innerHTML = data,
                // the internal <scripts> that data can have will not be executed.
                $("#myTheoremsSpace").html(data);
                MathJax.Hub.Typeset();
            }
            // Case when the user is no longer active
            else {
                window.location = $("#linkCloseSession").attr("href");
            }
        }, error: function(XMLHttpRequest, textStatus, errorThrown) { 
            alert("Status: " + textStatus); alert("Error: " + errorThrown/*XMLHttpRequest.responseText*/); 
        }
    });
    $("#modalLoading").css('display','none'); 
}