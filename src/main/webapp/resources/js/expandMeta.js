/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function expandMeta(id) {
        elem = $('#'+id);
        if (elem.hasClass('d-none'))
          elem.removeClass('d-none');
        else
          elem.addClass('d-none');
        
}