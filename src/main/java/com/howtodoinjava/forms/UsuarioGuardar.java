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
public class UsuarioGuardar{
    
    @NotEmpty(message="   Este campo no puede estar vacío")
    //@Pattern( regexp="^[A-Z][a-z]*\\(([a-z]\\,[E]*)*[a-z]\\)$",message="Error: Debe seguir el formato Nombre(v1,v2,..,vn)")
     private String alias;
     @NotEmpty(message="   Este campo no puede estar vacío")
     private String termino;

    public UsuarioGuardar() {
    }

    public UsuarioGuardar(String alias, String termino) {
       this.alias = alias;
       this.termino = termino;
    }
   
    public String getAlias() {
        return this.alias;
    }
    
    public void setAlias(String alias) {
        this.alias = alias;
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
		 if ( !(other instanceof UsuarioGuardar) ) return false;
		 UsuarioGuardar castOther = ( UsuarioGuardar ) other; 
         
		 return ( (this.getAlias()==castOther.getAlias()) || ( this.getAlias()!=null && castOther.getAlias()!=null && this.getAlias().equals(castOther.getAlias()) ) )
 && ( (this.getTermino()==castOther.getTermino()) || ( this.getTermino()!=null && castOther.getTermino()!=null && this.getTermino().equals(castOther.getTermino()) ) );
   }
   
   @Override
   public int hashCode() {
         int result = 17;
         
         result = 37 * result + ( getAlias() == null ? 0 : this.getAlias().hashCode() );
         result = 37 * result + ( getTermino() == null ? 0 : this.getTermino().hashCode() );
         return result;
   }
    
}
