/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function limpiar()
{
       var texArea=document.getElementById('termino_string');
       if(texArea.value != "")
       {
             if(confirm("Sure you want to delete the content of the text area?"))
                 texArea.value="";
       }
}

