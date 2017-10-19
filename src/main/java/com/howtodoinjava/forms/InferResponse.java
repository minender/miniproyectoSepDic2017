/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.forms;
import com.howtodoinjava.lambdacalculo.App;
import com.howtodoinjava.lambdacalculo.Const;
import com.howtodoinjava.lambdacalculo.PasoInferencia;
import java.util.List;

/**
 *
 * @author francisco
 */
public class InferResponse {
    
    private String historial;
    private String errorParser2;
    private String errorParser3;

    public String getHistorial() {
        return historial;
    }

    public void setHistorial(String formula) {
        this.historial = formula;
    }

    public String getErrorParser2() {
        return errorParser2;
    }

    public void setErrorParser2(String errorParser2) {
        this.errorParser2 = errorParser2;
    }

    public String getErrorParser3() {
        return errorParser3;
    }

    public void setErrorParser3(String errorParser3) {
        this.errorParser3 = errorParser3;
    }
    
    public void generarHistorial(String formula, String nTeo,String pasoPost, Boolean valida, List<PasoInferencia> inferencias){
        
        
        this.setHistorial("Theorem "+nTeo+":<br> <center>$"+formula+"$</center> Proof:");  
        
        String ultimaExp = "";
        for (PasoInferencia x: inferencias) {
            this.setHistorial(this.getHistorial()+ "$$" +
                                    x.getExpresion().toStringInf()+" $$" + " $$ \\equiv< " + 
                                    new App(new App(new Const("\\equiv "),x.getTeoDer()), x.getTeoIzq()).toStringInf() + 
                                    " - " + x.getLeibniz().toStringInf() + 
                                    " - " + x.getInstancia().toString()+" > $$");
            ultimaExp = x.getResult().toStringInf();
        }
        if(valida) {
            this.setHistorial(this.getHistorial()+ "$$" +pasoPost + "$$");
        } else {
            this.setHistorial(this.getHistorial()+ "$$" +ultimaExp + "$$" + "$$" + pasoPost + "$$");
        }
        
    }
    
    public void generarHistorial(String formula, String nTeo, List<PasoInferencia> inferencias){
        
        
        this.setHistorial("Theorem "+nTeo+":<br> <center>$"+formula+"$</center> Proof:");  
        String ultimaExp = "";
        for (PasoInferencia x: inferencias) {
            this.setHistorial(this.getHistorial()+ "$$" +
                                    x.getExpresion().toStringInf()+" $$" + " $$ \\equiv< " + 
                                    new App(new App(new Const("\\equiv "),x.getTeoDer()), x.getTeoIzq()).toStringInf() + 
                                    " - " + x.getLeibniz().toStringInf() + 
                                    " - " + x.getInstancia()+" > $$");
                ultimaExp = x.getResult().toStringInf();
            }
        
        this.setHistorial(this.getHistorial()+ "$$" +ultimaExp + "$$");
    }
    
}
