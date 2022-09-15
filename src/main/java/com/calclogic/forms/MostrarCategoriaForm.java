/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.forms;

import java.util.List;

/**
 *
 * @author jt
 */
public class MostrarCategoriaForm {
    private List<Integer> listaIdCategorias;
    private String username;
    private Boolean selecTeo;

    public MostrarCategoriaForm() {
    }

    public MostrarCategoriaForm(List<Integer> listaIdCategorias, String username) {
        this.listaIdCategorias = listaIdCategorias;
    }

    public MostrarCategoriaForm(List<Integer> listaIdCategorias, String username, Boolean selecTeo) {
        this.listaIdCategorias = listaIdCategorias;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getUsername() {
        return username;
    }

    public List<Integer> getListaIdCategorias() {
        return listaIdCategorias;
    }

    public void setListaIdCategorias(List<Integer> listaIdCategorias) {
        this.listaIdCategorias = listaIdCategorias;
    }

    public void setSelecTeo(Boolean selecTeo) {
        this.selecTeo = selecTeo;
    }

    public Boolean getSelecTeo() {
        return selecTeo;
    }
    
}
