/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.lambdacalculo;

import org.springframework.stereotype.Repository;

/**
 *
 * @author miguel
 */
@Repository
public class PasoInferencia {

    private Term expresion; // Teorema a demostrar 
    private Term teoIzq;  // Teorema a utilizar, parte izquierda
    private Term teoDer;  // Teorema a utilizar, parte derecha  
    private Term leibniz;
    private Term result;
    private String instancia;

    public void setResult(Term result) {
        this.result = result;
    }

    public Term getResult() {
        return result;
    }

    public PasoInferencia() {
    }

    public PasoInferencia(Term expresion, Term teoIzq, Term teoDer, Term leibniz, String instancia) {
        this.expresion = expresion;
        this.teoIzq = teoIzq;
        this.teoDer = teoDer;
        this.leibniz = leibniz;
        this.instancia = instancia;
    }

    public void setExpresion(Term expresion) {
        this.expresion = expresion;
    }

    public void setTeoIzq(Term teoIzq) {
        this.teoIzq = teoIzq;
    }

    public void setTeoDer(Term teoDer) {
        this.teoDer = teoDer;
    }

    public void setLeibniz(Term leibniz) {
        this.leibniz = leibniz;
    }

    public void setInstancia(String instancia) {
        this.instancia = instancia;
    }

    public Term getExpresion() {
        return expresion;
    }

    public Term getTeoIzq() {
        return teoIzq;
    }

    public Term getTeoDer() {
        return teoDer;
    }

    public Term getLeibniz() {
        return leibniz;
    }

    public String getInstancia() {
        return instancia;
    }

};
