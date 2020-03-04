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
public class AgregarSimbolo {
    
     private int id;
     private boolean modificar;
     private String notacion_latex;
     private int argumentos;
     private boolean esInfijo;
     private int asociatividad;
     private int precedencia;
     private String notacion;
     private int teoriaid;
//     @NotEmpty(message="no debe dejar este campo vacío")
    

    public AgregarSimbolo(){};
    
    public AgregarSimbolo(String notacion_latex, int argumentos, boolean esInfijo, int asociatividad, int precedencia, String notacion, int teoriaid, boolean modificar) {
        this.notacion_latex = notacion_latex;
        this.argumentos = argumentos;
        this.esInfijo = esInfijo;
        this.asociatividad = asociatividad;
        this.precedencia = precedencia;
        this.notacion = notacion;
        this.teoriaid = teoriaid;
        this.modificar = modificar;
    }
        public AgregarSimbolo(int id, String notacion_latex, int argumentos, boolean esInfijo, int asociatividad, int precedencia, String notacion, int teoriaid, boolean modificar) {
        this.id = id;
        this.notacion_latex = notacion_latex;
        this.argumentos = argumentos;
        this.esInfijo = esInfijo;
        this.asociatividad = asociatividad;
        this.precedencia = precedencia;
        this.notacion = notacion;
        this.teoriaid = teoriaid;
        this.modificar = modificar;
    }

    public String getNotacion_latex() {
        return notacion_latex;
    }

    public int getArgumentos() {
        return argumentos;
    }

    public boolean isEsInfijo() {
        return esInfijo;
    }

    public int getAsociatividad() {
        return asociatividad;
    }

    public int getPrecedencia() {
        return precedencia;
    }

    public String getNotacion() {
        return notacion;
    }

    public int getTeoriaid() {
        return teoriaid;
    }

    public int getId() {
        return id;
    }

    public boolean isModificar() {
        return modificar;
    }
    
    
    

    public void setNotacion_latex(String notacion_latex) {
        this.notacion_latex = notacion_latex;
    }

    public void setArgumentos(int argumentos) {
        this.argumentos = argumentos;
    }

    public void setEsInfijo(boolean esInfijo) {
        this.esInfijo = esInfijo;
    }

    public void setAsociatividad(int asociatividad) {
        this.asociatividad = asociatividad;
    }

    public void setPrecedencia(int precedencia) {
        this.precedencia = precedencia;
    }

    public void setNotacion(String notacion) {
        this.notacion = notacion;
    }

    public void setTeoriaid(int teoriaid) {
        this.teoriaid = teoriaid;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setModificar(boolean modificar) {
        this.modificar = modificar;
    }
    
    
    
    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final AgregarSimbolo other = (AgregarSimbolo) obj;
        if (this.notacion != other.notacion) {
            return false;
        }
        return true;
    }

    
}
