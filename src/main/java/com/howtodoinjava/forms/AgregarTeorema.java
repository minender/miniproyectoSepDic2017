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
public class AgregarTeorema {
    
     private boolean axioma;
     @NotEmpty(message="You must not leave this field empty")
     private String teorema;
//     @NotEmpty(message="no debe dejar este campo vacío")
     private String categoria;
     @NotEmpty(message="You must not leave this field empty")
     private String numeroTeorema;
     private int categoriaSeleccionada;

    public void setAxioma(boolean axioma) {
        this.axioma = axioma;
    }

     // opcional
     private String nombreTeorema;

    public boolean isAxioma() {
        return axioma;
    }
     
     
    public AgregarTeorema() {
    }

    public AgregarTeorema(String teorema, String categoria, String numeroTeorema, String nombreTeorema) {
        this.teorema = teorema;
        this.categoria = categoria;
        this.numeroTeorema = numeroTeorema;
        this.nombreTeorema = nombreTeorema;
    }

    public String getTeorema() {
        return teorema;
    }

    public String getCategoria() {
        return categoria;
    }

  public void setCategoriaSeleccionada(int categoriaSeleccionada) {
    this.categoriaSeleccionada = categoriaSeleccionada;
  }

  public int getCategoriaSeleccionada() {
    return categoriaSeleccionada;
  }

    public String getNumeroTeorema() {
        return numeroTeorema;
    }

    public String getNombreTeorema() {
        return nombreTeorema;
    }

    public void setTeorema(String teorema) {
        this.teorema = teorema;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public void setNumeroTeorema(String numeroTeorema) {
        this.numeroTeorema = numeroTeorema;
    }

    public void setNombreTeorema(String nombreTeorema) {
        this.nombreTeorema = nombreTeorema;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final AgregarTeorema other = (AgregarTeorema) obj;
        if (this.axioma != other.axioma) {
            return false;
        }
        if ((this.teorema == null) ? (other.teorema != null) : !this.teorema.equals(other.teorema)) {
            return false;
        }
        if ((this.categoria == null) ? (other.categoria != null) : !this.categoria.equals(other.categoria)) {
            return false;
        }
        if ((this.numeroTeorema == null) ? (other.numeroTeorema != null) : !this.numeroTeorema.equals(other.numeroTeorema)) {
            return false;
        }
        if (this.categoriaSeleccionada != other.categoriaSeleccionada) {
            return false;
        }
        if ((this.nombreTeorema == null) ? (other.nombreTeorema != null) : !this.nombreTeorema.equals(other.nombreTeorema)) {
            return false;
        }
        return true;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 29 * hash + (this.axioma ? 1 : 0);
        hash = 29 * hash + (this.teorema != null ? this.teorema.hashCode() : 0);
        hash = 29 * hash + (this.categoria != null ? this.categoria.hashCode() : 0);
        hash = 29 * hash + (this.numeroTeorema != null ? this.numeroTeorema.hashCode() : 0);
        hash = 29 * hash + this.categoriaSeleccionada;
        hash = 29 * hash + (this.nombreTeorema != null ? this.nombreTeorema.hashCode() : 0);
        return hash;
    }

    
}
