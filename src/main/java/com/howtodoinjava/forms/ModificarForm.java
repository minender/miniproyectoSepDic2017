/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.forms;

import javax.validation.constraints.Pattern;
import org.hibernate.validator.constraints.NotEmpty;

/**
 *
 * @author federico
 */
public class ModificarForm{
    
     @NotEmpty(message="You must not leave this field empty")
     private String termino;

    public ModificarForm() {
    }

    public ModificarForm( String termino) {
       this.termino = termino;
    }
   
    public String getTermino() {
        return this.termino;
    }
    
    public void setTermino(String termino) {
        this.termino = termino;
    }

   @Override
   public boolean equals(Object other) {
         if ( (this == other ) ) return true;
		 if ( (other == null ) ) return false;
		 if ( !(other instanceof ModificarForm) ) return false;
		 ModificarForm castOther = ( ModificarForm ) other; 
         
		 return  (this.getTermino()==castOther.getTermino()) || ( this.getTermino()!=null && castOther.getTermino()!=null && this.getTermino().equals(castOther.getTermino()) ) ;
   }
   
   @Override
   public int hashCode() {
         int result = 17;
         
         result = 37 * result + ( getTermino() == null ? 0 : this.getTermino().hashCode() );
         return result;
   }
    
}
