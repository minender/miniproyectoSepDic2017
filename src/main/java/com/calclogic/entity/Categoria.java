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
 * Categoria generated by hbm2java
 */
public class Categoria implements java.io.Serializable {
    
    @Id
    @Column(name="id")
    @GeneratedValue( strategy= GenerationType.SEQUENCE, generator="categoria_id_seq")
    @SequenceGenerator(name="categoria_id_seq", sequenceName="categoria_id_seq")
     private int id;
     private String nombre;
     private Set teoremas = new HashSet(0);
     private Set metateoremas = new HashSet(0);

    public Categoria() {
    }

    public Categoria(String nombre) {
        this.nombre = nombre;
    }

    
    public Categoria(int id, String nombre) {
        this.id = id;
        this.nombre = nombre;
    }
    public Categoria(int id, String nombre, Set teoremas, Set metateoremas) {
       this.id = id;
       this.nombre = nombre;
       this.teoremas = teoremas;
       this.metateoremas = metateoremas;
    }
   
    public int getId() {
        return this.id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    public String getNombre() {
        return this.nombre;
    }
    
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    public Set getTeoremas() {
        return this.teoremas;
    }
    
    public void setTeoremas(Set teoremas) {
        this.teoremas = teoremas;
    }
    public Set getMetateoremas() {
        return this.metateoremas;
    }
    
    public void setMetateoremas(Set metateoremas) {
        this.metateoremas = metateoremas;
    }
    
@Override
public boolean equals(Object object){
    boolean isEqual= false;

    if (object != null && object instanceof Categoria)
    {
        Categoria categoria2 = (Categoria)object;
        if (categoria2.getId() == this.getId()){
                isEqual = true;
        }
    }

    return isEqual;
}

    @Override
    public int hashCode() {
        return this.getId();
    }
}
