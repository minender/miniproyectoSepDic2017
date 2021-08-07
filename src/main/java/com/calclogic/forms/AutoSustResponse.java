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
public class AutoSustResponse {
    
    private boolean auto;
    private String error;

    public boolean isAuto() {
        return auto;
    }
    
    public String getError() {
        return error;
    }

    public void setAuto(Boolean isAuto) {
        auto = isAuto;
    }
    
    public void setError(String err) {
        error = err;
    }
}