/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.forms;

import java.util.HashMap;

/**
 *
 * @author francisco
 */
public class teoremasSolucion {


    public HashMap<String, Integer> soluciones;
    private int idTeo;    

    public int getIdTeo() {
        return idTeo;
    }

    public void setIdTeo(int idTeo) {
        this.idTeo = idTeo;
    }
    
    public void insertSolucion(String nombre, Integer id){
        this.soluciones.put(nombre,id);
    
    }
    
}
