package com.calclogic.entity;
// Generated Feb 27, 2019 12:50:11 PM by Hibernate Tools 3.2.1.GA


import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;

import org.antlr.v4.parse.ANTLRParser.throwsSpec_return;
//import org.apache.naming.java.javaURLContextFactory;



/**
 * Simbolo generated by hbm2java
 */
public class Simbolo  extends notacionOwner implements java.io.Serializable {

    @Id
    @Column(name="id")
    @GeneratedValue( strategy= GenerationType.SEQUENCE, generator="simbolo_id_seq")
    @SequenceGenerator(name="simbolo_id_seq", sequenceName="simbolo_id_seq")
     private int id;
     private String notacion_latex;
     private int argumentos;
     private boolean esInfijo;
     private int asociatividad;
     private int precedencia;
     private String notacion;
     private Teoria teoria;


    public Simbolo(String notacion_latex, boolean esInfijo, int precedencia, String notacion, Teoria teoria) {
        this.notacion_latex = notacion_latex;
        this.esInfijo = esInfijo;
        this.precedencia = precedencia;
        this.notacion = notacion;
        this.teoria = teoria;
    }

    public Simbolo(String notacion_latex, int argumentos, boolean esInfijo, int precedencia, String notacion, Teoria teoria) {
        this.notacion_latex = notacion_latex;
        this.argumentos = argumentos;
        this.esInfijo = esInfijo;
        this.precedencia = precedencia;
        this.notacion = notacion;
        this.teoria = teoria;
    }

    public Simbolo(String notacion_latex, boolean esInfijo, int asociatividad, int precedencia, String notacion, Teoria teoria) {
        this.notacion_latex = notacion_latex;
        this.esInfijo = esInfijo;
        this.asociatividad = asociatividad;
        this.precedencia = precedencia;
        this.notacion = notacion;
        this.teoria = teoria;
    }

    public Simbolo(String notacion_latex, int argumentos, boolean esInfijo, int asociatividad, int precedencia, String notacion, Teoria teoria) {
        this.notacion_latex = notacion_latex;
        this.argumentos = argumentos;
        this.esInfijo = esInfijo;
        this.asociatividad = asociatividad;
        this.precedencia = precedencia;
        this.notacion = notacion;
        this.teoria = teoria;
    }


    public Simbolo() {
    }

    public int getId() {
        return id;
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
    
    public boolean isInf() {
        return esInfijo;
    }

    public int getAsociatividad() {
        return asociatividad;
    }
    
    public int getAs() {
        return asociatividad;
    }

    public int getPrecedencia() {
        return precedencia;
    }
    
    public int getPr() {
        return precedencia;
    }

    public String getNotacion() {
        return notacion;
    }

    public Teoria getTeoria() {
        return teoria;
    }
    
    
    public void setId(int id) {
        this.id = id;
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

    public void setTeoria(Teoria teoria) {
        this.teoria = teoria;
    }
    
   
}