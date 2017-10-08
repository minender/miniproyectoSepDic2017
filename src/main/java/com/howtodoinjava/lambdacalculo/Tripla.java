/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.lambdacalculo;

import java.util.LinkedList;
import java.util.List;

/**
 *
 * @author federico
 */
public class Tripla {
    
    public String term;
    public List<String> alias;
    public List<String> valores;
    
    
    public Tripla()
    {
        alias = new LinkedList<String>();
        valores = new LinkedList<String>();
    }
}
