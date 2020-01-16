/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.lambdacalculo;

/**
 *
 * @author federico
 */
public class ConstInd extends Indice{
    
    final String ind;
    
    public ConstInd(String ind)
    {
        this.ind=ind;
        orden=1;
    }
    
    public String toString()
    {
        return ind;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final ConstInd other = (ConstInd) obj;
        if ((this.ind == null) ? (other.ind != null) : !this.ind.equals(other.ind)) {
            return false;
        }
        return true;
    }
    
    @Override
    protected Object clone() throws CloneNotSupportedException{
        return this;
    }
}
