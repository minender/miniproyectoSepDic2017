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
public class SubstResponse extends GenericResponse{

    private String[] sustFormatC;
    private String[] sustLatex;
    private String error;

    public String[] getSustFormatC() {
        return sustFormatC;
    }
    
    public String[] getSustLatex() {
        return sustLatex;
    }
    
    @Override
    public String getError() {
        return error;
    }

    @Override
    public void setError(String err) {
        error = err;
    }    

    public void setSustFormatC(String[] sust) {
        sustFormatC = sust;
    }
    
    public void setSustLatex(String[] sust) {
        sustLatex = sust;
    }

}
