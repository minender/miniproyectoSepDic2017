/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.lambdacalculo;

import java.util.LinkedList;
import java.util.List;
import java.util.ListIterator;

/**
 *
 * @author federico
 */
public class ListaInd extends Indice {

    public List<Indice> list;

    public ListaInd(Indice... ids) {
        list = new LinkedList<Indice>();
        orden=0;
        for (Indice i:ids) {
            empilarIndice(i);
        }
    }
    
    public boolean esEpsilon()
    {
        return list.isEmpty();
    }

    public void empilarIndice(Indice i)
    {
        list.add(0, i);
        orden+=i.orden;
    }
    
    public void empilarIndIzq(Indice i)
    {
        ((ParInd)list.get(0)).empilarIndIzq(i);
        orden+=i.orden;
    }
    
    public void empilarIndDer(Indice i)
    {
        ((ParInd)list.get(0)).empilarIndDer(i);
        orden+=i.orden;
    }
    
    public void empilarParInd(Indice i)
    {
        list.add(0,i);
        orden+=((ParInd)i).i1.orden+((ParInd)i).i2.orden;
    }
    
    //mosca solo funciona si el ultimo no es un par 
    //no importa porque los pares siempre aparecen de ultimo y una vez que
    //lo remuves no necesitas mas el orden
    public Indice removerUlt()
    {
        Indice I=list.remove(list.size()-1);
        orden=orden-I.orden;//no hace falta es ineficiente el orden no se va a usar despues
        return I;
    }
    
    public Indice tope()
    {
        return list.get(0);
    }
    
    public boolean topeEsPar()
    {
        return !list.isEmpty() && list.get(0) instanceof ParInd;
    }
    
    public String toString() {
        String s = "";
        if (list.isEmpty()) {
            s = "";
        } else {
            for (Indice i : list) {
                s =i.toString()+s;
            }
        }
        
        return s;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final ListaInd other = (ListaInd) obj;
        if (this.list != other.list && (this.list == null || !this.list.equals(other.list))) {
            return false;
        }
        return true;
    }

    @Override
    protected Object clone() throws CloneNotSupportedException {
        
        ListaInd cloneList= new ListaInd();
        ListIterator<Indice> it=list.listIterator();
        
        int k=0;
        while(it.hasNext())
        {
            Indice i=it.next();
            if(i instanceof ParInd)
                i=(Indice)i.clone();
            cloneList.list.add(k,i);
            k++;
            cloneList.orden+=i.orden;
        }
        
        return cloneList;
    }
    
    
}
