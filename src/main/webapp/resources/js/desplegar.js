/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

function desplegar(id)
{
  var aux;
  try
  {
    aux = ar.className;
    if (ar.className != "" )
      ar.className = "";
  }
  catch (e)
  {
    ar = document.getElementById(id);
    ar.className = id;
  }
  if (aux != id)
  {
    ar = document.getElementById(id);
    ar.className = id;
  }
}
