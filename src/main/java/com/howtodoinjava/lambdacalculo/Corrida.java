/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.lambdacalculo;


import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author federico
 */
public class Corrida {
 
    public List<Integer> operations;
    public List<String> terminos;
    public List<String> lambdaTerms;
    public int reducciones;
    public int traducciones;
    
    public Corrida()
    {
        operations = new ArrayList<Integer>();
        terminos = new ArrayList<String>();
        lambdaTerms = new ArrayList<String>();
        reducciones = 0;
        traducciones = 0;
    }
    
}
