/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.forms;

import org.hibernate.validator.constraints.NotEmpty;

/**
 *
 * @author federico
 */
public class InsertarEvaluar {
    
     @NotEmpty(message="You must not leave this field empty")
     private String nombre;
     @NotEmpty(message="You must not leave this field empty")
     private String algoritmo;

    public InsertarEvaluar() {
    }

    public InsertarEvaluar(String nombre, String algoritmo) {
       this.nombre = nombre;
       this.algoritmo = algoritmo;
    }
   
    public String getNombre() {
        return this.nombre;
    }
    
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    public String getAlgoritmo() {
        return this.algoritmo;
    }
    
    public void setAlgoritmo(String algoritmo) {
        this.algoritmo = algoritmo;
    }

   @Override
   public boolean equals(Object other) {
         if ( (this == other ) ) return true;
		 if ( (other == null ) ) return false;
		 if ( !(other instanceof InsertarEvaluar) ) return false;
		 InsertarEvaluar castOther = ( InsertarEvaluar ) other; 
         
		 return ( (this.getNombre()==castOther.getNombre()) || ( this.getNombre()!=null && castOther.getNombre()!=null && this.getNombre().equals(castOther.getNombre()) ) )
 && ( (this.getAlgoritmo()==castOther.getAlgoritmo()) || ( this.getAlgoritmo()!=null && castOther.getAlgoritmo()!=null && this.getAlgoritmo().equals(castOther.getAlgoritmo()) ) );
   }
   
   @Override
   public int hashCode() {
         int result = 17;
         
         result = 37 * result + ( getNombre() == null ? 0 : this.getNombre().hashCode() );
         result = 37 * result + ( getAlgoritmo() == null ? 0 : this.getAlgoritmo().hashCode() );
         return result;
   }
}
