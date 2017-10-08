/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

function clickAlias(Math1,alias,valorAlias)
{
    var render=document.getElementById(Math1);
//    render.innerHTML="<span id=\"Math1\">$$"+terminos[0]+"$$</span>";
   
    
    render.onclick = function (event) {
      if (!event) {event = window.event}
      var target = event.toElement || event.target;
      while (target && (!target.id || target.id.substring(0,4) != 'agru' )) {target = target.parentNode}
      if(target)
      {


        var tipo = target.id.split("@")[1];
        var index = parseInt(target.id.split("@")[2]);

        var math = MathJax.Hub.getAllJax(Math1)[0];
        var originalText = math.originalText;
        var newText;

        if(tipo == 'alias')
        {
            newText = originalText.replace("\\cssId{"+target.id+"}{\\style{cursor:pointer; color:#08c;}{"+ alias[index] +"}}","\\cssId{"+target.id.replace("alias","valor")+"}{\\style{cursor:pointer;}{\\underline{~"+ valorAlias[index] +"}}}");
        }
        else
        {
            newText = originalText.replace("\\cssId{"+target.id+"}{\\style{cursor:pointer;}{\\underline{~"+ valorAlias[index] +"}}}","\\cssId{"+target.id.replace("valor","alias")+"}{\\style{cursor:pointer; color:#08c;}{"+ alias[index] +"}}");
        }

        MathJax.Hub.Queue(["Text",math,newText]);
      }
    }
    
}

function clickOperator(Math1,myField,teoid)
{
    var render=document.getElementById(Math1);
    
    render.onclick = function (event) {
      if (!event) {event = window.event}
      var target = event.toElement || event.target;
      while (target && (!target.id || target.id.substring(0,6) != 'click@' )) {target = target.parentNode}
      if(target)
      {
         teoid+="";
         parent.window.document.getElementById(myField).value = teoid;
      }
    }
}