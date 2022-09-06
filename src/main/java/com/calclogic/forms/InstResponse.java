/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.forms;

/**
 *
 * @author federico
 */
public class InstResponse extends GenericResponse{
    
    private String instantiation;
    private String error;

    public String getInstantiation() {
        return instantiation;
    }
    
    @Override
    public String getError() {
        return error;
    }

    @Override
    public void setError(String err) {
        error = err;
    }

    public void setInstantiation(String inst) {
        instantiation = inst;
    }
}