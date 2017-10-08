/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.lambdacalculo;

/**
 *
 * @author federico
 */
public class ParInd extends Indice{
    ListaInd i1;
    ListaInd i2;
    
    public ParInd()
    {
        i1=new ListaInd();
        i2=new ListaInd();
        orden=0;
    }
    
    public ParInd(Indice i,Indice j)
    {
        orden=0;
        if(i==null)
            i1=new ListaInd();
        else
        {
            i1=new ListaInd(i);
            orden=i.orden;
        }
        if(j==null)
            i2=new ListaInd();
        else
        {
            i2=new ListaInd(j);
            orden+=j.orden;
        }
    }
    
    public ParInd(ListaInd i,ListaInd j)
    {
        orden=0;
        if(i==null)
            i1=new ListaInd();
        else
        {
            i1=i;
            orden=i.orden;
        }
        if(j==null)
            i2=new ListaInd();
        else
        {
            i2=j;
            orden+=j.orden;
        }
    }
    
    public void empilarIndIzq(Indice i)
    {
        i1.empilarIndice(i);
        orden+=i.orden;
    }
    
    public void empilarIndDer(Indice i)
    {
        i2.empilarIndice(i);
        orden+=i.orden;
    }
    
    public String toString()
    {
        return "("+i1.toString()+","+i2.toString()+")";
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final ParInd other = (ParInd) obj;
        if (this.i1 != other.i1 && (this.i1 == null || !this.i1.equals(other.i1))) {
            return false;
        }
        if (this.i2 != other.i2 && (this.i2 == null || !this.i2.equals(other.i2))) {
            return false;
        }
        return true;
    }
    
    @Override
    protected Object clone() throws CloneNotSupportedException{
            
        return new ParInd((ListaInd)i1.clone(),(ListaInd)i2.clone());
    }
}
