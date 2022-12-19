/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.forms;

import java.util.Objects;
import org.hibernate.validator.constraints.NotEmpty;

/**
 *
 * @author feder
 */
public class InsertFormula {
    
    @NotEmpty(message="No debe dejar este campo vacío")
     private String algorithm;
    
    public InsertFormula(){
    }
    
    public InsertFormula(String algorithm) {
       this.algorithm = algorithm;
    }
    
    public String getAlgorithm() {
        return algorithm;
    }
    
    public void setAlgorithm(String algorithm) {
        this.algorithm = algorithm;
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 59 * hash + Objects.hashCode(this.algorithm);
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final InsertFormula other = (InsertFormula) obj;
        if (!Objects.equals(this.algorithm, other.algorithm)) {
            return false;
        }
        return true;
    }
    
    
}
