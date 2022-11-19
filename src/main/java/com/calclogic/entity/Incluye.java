package com.calclogic.entity;

public class Incluye implements java.io.Serializable {

    private Teoria padre;
    private Teoria hijo;

    
    public Incluye(){;}
     
    public Incluye(Teoria padre, Teoria hijo) {
        this.padre = padre;
        this.hijo = hijo;
    }

    public Teoria getPadre() {
        return padre;
    }

    public Teoria getHijo() {
        return hijo;
    }

    public void setPadre(Teoria teoria) {
        this.padre = teoria;
    }

    public void setHijo(Teoria teoria) {
        this.hijo = teoria;
    }
     
}
