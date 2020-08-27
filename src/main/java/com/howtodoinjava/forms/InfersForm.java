/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.forms;

import java.util.ArrayList;
import com.howtodoinjava.lambdacalculo.App;
import com.howtodoinjava.lambdacalculo.Const;
import com.howtodoinjava.lambdacalculo.PasoInferencia;
import com.howtodoinjava.service.SimboloManager;
import java.util.List;
import org.hibernate.validator.constraints.NotEmpty;

/**
 *
 * @author shamuel
 */
public class InfersForm {
    
//    @NotEmpty(message="no debe dejar este campo vacío")
     private String pasoAnt;     
     @NotEmpty(message="You must not leave this field empty")
     private String nStatement;
//     @NotEmpty(message="no debe dejar este campo vacío")
     private String instanciacion;
//     @NotEmpty(message="no debe dejar este campo vacío")
     private String leibniz;
     private String nuevoMetodo;
     private String historial;
     private String categorias;
     private int solucionId;

    public  InfersForm() {
    }

    public String getHistorial() {
        return this.historial;
    }

    public void setHistorial(String historial) {
        this.historial = historial;
    }

//    public void addHistorial(ArrayList)

    public int getSolucionId() {
        return solucionId;
    }

    public void setSolucionId(int solucionId) {
        this.solucionId = solucionId;
    }
    
    
    public InfersForm(String pasoAnt, String nStatement, String instanciacion, String leibniz) {
        this.pasoAnt = pasoAnt;
        this.nStatement = nStatement;
        this.instanciacion = instanciacion;
        this.leibniz = leibniz;
    }

    public void setPasoAnt(String pasoAnt) {
        this.pasoAnt = pasoAnt;
    }

    public void setnStatement(String nStatement) {
        this.nStatement = nStatement;
    }

    public void setInstanciacion(String instanciacion) {
        this.instanciacion = instanciacion;
    }

    public void setLeibniz(String leibniz) {
        this.leibniz = leibniz;
    }
    
    public void setNuevoMetodo(String nuevoMetodo) {
    	this.nuevoMetodo = nuevoMetodo;
    }

    public String getPasoAnt() {
        return pasoAnt;
    }

    public String getnStatement() {
        return nStatement;
    }

    public String getInstanciacion() {
        return instanciacion;
    }

    public String getLeibniz() {
        return leibniz;
    }
    
    public String getNuevoMetodo() {
		return nuevoMetodo;
	}

    public String getCategorias() {
      return categorias;
    }
    
    public void setCategorias(String categorias) {
      this.categorias = categorias;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 43 * hash + (this.pasoAnt != null ? this.pasoAnt.hashCode() : 0);
        hash = 43 * hash + (this.nStatement != null ? this.nStatement.hashCode() : 0);
        hash = 43 * hash + (this.instanciacion != null ? this.instanciacion.hashCode() : 0);
        hash = 43 * hash + (this.leibniz != null ? this.leibniz.hashCode() : 0);
        return hash;
    }



    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final InfersForm other = (InfersForm) obj;
        if ((this.pasoAnt == null) ? (other.pasoAnt != null) : !this.pasoAnt.equals(other.pasoAnt)) {
            return false;
        }
        if (this.nStatement != other.nStatement) {
            return false;
        }
        if ((this.instanciacion == null) ? (other.instanciacion != null) : !this.instanciacion.equals(other.instanciacion)) {
            return false;
        }
        if ((this.leibniz == null) ? (other.leibniz != null) : !this.leibniz.equals(other.leibniz)) {
            return false;
        }
        return true;
    }

        public void generarHistorial(String formula, String nTeo,String pasoPost, Boolean valida, List<PasoInferencia> inferencias, SimboloManager s){
        
        
        this.setHistorial("Theorem "+nTeo+":<br> <center>$"+formula+"$</center> Proof:");  
        
        String ultimaExp = "";
        for (PasoInferencia x: inferencias) {
            this.setHistorial(this.getHistorial()+ "$$" +
                                    x.getExpresion().toStringInf(s,"")+" $$" + " $$ \\equiv< " + 
                                    new App(new App(new Const("\\equiv "),x.getTeoDer()), x.getTeoIzq()).toStringInf(s,"") + 
                                    " - " + x.getLeibniz().toStringInf(s,"") + 
                                    " - " + x.getInstancia().toString()+" > $$");
            ultimaExp = x.getResult().toStringInf(s,"");
        }
        if(valida) {
            this.setHistorial(this.getHistorial()+ "$$" +pasoPost + "$$");
        } else {
            this.setHistorial(this.getHistorial()+ "$$" +ultimaExp + "$$" + "$$" + pasoPost + "$$");
        }
        
    }
    
    public void generarHistorial(String formula, String nTeo, List<PasoInferencia> inferencias,SimboloManager s){
        
        
        this.setHistorial("Theorem "+nTeo+":<br> <center>$"+formula+"$</center> Proof:");  
        String ultimaExp = "";
        for (PasoInferencia x: inferencias) {
            this.setHistorial(this.getHistorial()+ "$$" +
                                    x.getExpresion().toStringInf(s,"")+" $$" + " $$ \\equiv< " + 
                                    new App(new App(new Const("\\equiv "),x.getTeoDer()), x.getTeoIzq()).toStringInf(s,"") + 
                                    " - " + x.getLeibniz().toStringInf(s,"") + 
                                    " - " + x.getInstancia()+" > $$");
                ultimaExp = x.getResult().toStringInf(s,"");
        }
        
        this.setHistorial(this.getHistorial()+ "$$" +ultimaExp + "$$");
    }

}
