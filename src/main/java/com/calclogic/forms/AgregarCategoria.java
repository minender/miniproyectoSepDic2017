package com.calclogic.forms;

public class AgregarCategoria {
    
     private int id;
     private boolean modificar;
     private String nombre;
     private int teoriaid;
    

    public AgregarCategoria(){};
    
    public AgregarCategoria(int teoriaid, String nombre) {
        this.teoriaid = teoriaid;
        this.nombre = nombre;
        //this.modificar = modificar;
    }
    
    public AgregarCategoria(int id, int teoriaid, String nombre) {
        this.id = id;
        this.teoriaid = teoriaid;
        this.nombre = nombre;
        //this.modificar = modificar;
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
    
    public String getNombre() {
        return nombre;
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
    
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
}
