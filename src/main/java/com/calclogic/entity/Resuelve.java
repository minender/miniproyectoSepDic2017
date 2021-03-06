package com.calclogic.entity;
// Generated Mar 20, 2017 12:50:11 PM by Hibernate Tools 3.2.1.GA


import java.util.HashSet;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;

/**
 * Resuelve generated by hbm2java
 */
public class Resuelve  implements java.io.Serializable {

    @Id
    @Column(name="id")
    @GeneratedValue( strategy= GenerationType.SEQUENCE, generator="resuelve_id_seq")
    @SequenceGenerator(name="resuelve_id_seq", sequenceName="resuelve_id_seq")
     private int id;
     private Usuario usuario;
     private Teorema teorema;
     private String nombreteorema;
     private String numeroteorema;
     private boolean resuelto;
     private boolean esAxioma;
     private Categoria categoria;

    public Categoria getCategoria() {
        return categoria;
    }

    public void setCategoria(Categoria categoria) {
        this.categoria = categoria;
    }

    public boolean isEsAxioma() {
        return esAxioma;
    }

    public void setEsAxioma(boolean esAxioma) {
        this.esAxioma = esAxioma;
    }
     private int demopendiente;
     private Set solucions = new HashSet(0);

    public Resuelve() {
    }

    public void setDemopendiente(int demopendiete) {
        this.demopendiente = demopendiete;
    }

    public int getDemopendiente() {
        return demopendiente;
    }

    public Resuelve(Usuario usuario, Teorema teorema, String nombreteorema, String numeroteorema, Categoria categoria) {
        this.usuario = usuario;
        this.teorema = teorema;
        this.nombreteorema = nombreteorema;
        this.numeroteorema = numeroteorema;
        this.resuelto = false;
        this.demopendiente = -1;
        this.categoria = categoria;
    }
    
    public Resuelve(Usuario usuario, Teorema teorema, String nombreteorema, String numeroteorema, boolean resuelto, Categoria categoria) {
        this.usuario = usuario;
        this.teorema = teorema;
        this.nombreteorema = nombreteorema;
        this.numeroteorema = numeroteorema;
        this.resuelto = resuelto;
        this.demopendiente = -1;
        this.categoria = categoria;
    }

    public int getId() {
        return this.id;
    }
   
    
    public void setId(int id) {
        this.id = id;
    }
    public Usuario getUsuario() {
        return this.usuario;
    }
    
    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }
    public Teorema getTeorema() {
        return this.teorema;
    }
    
    public void setTeorema(Teorema teorema) {
        this.teorema = teorema;
    }

    public String getNombreteorema() {
        return this.nombreteorema;
    }
    
    public void setNombreteorema(String nombreteorema) {
        this.nombreteorema = nombreteorema;
    }
    public String getNumeroteorema() {
        return this.numeroteorema;
    }
    
    public void setNumeroteorema(String numeroteorema) {
        this.numeroteorema = numeroteorema;
    }
    public boolean isResuelto() {
        return this.resuelto;
    }
    
    public void setResuelto(boolean resuelto) {
        this.resuelto = resuelto;
    }
    public Set getSolucions() {
        return this.solucions;
    }
    
    public void setSolucions(Set solucions) {
        this.solucions = solucions;
    }




}
