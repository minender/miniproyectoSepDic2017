/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.lambdacalculo;

/**
 *
 * @author federico
 */
public interface TypedTerm {
    
    public Term type();
    
    public String getCombDBType();
}