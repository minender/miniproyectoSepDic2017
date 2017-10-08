/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.lambdacalculo;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 *
 * @author federico
 */
public class Var extends Term{
    public int indice;
    
    public Var(){
        this.indice=-1;
    }
    
    public Var(int indice){
        this.indice=indice;
    }

    public void setIndice(int indice) {
        if(indice==-1)
            this.indice = indice;
        else
            System.out.println("asignacion doble");
    }
    
    public boolean occur(Var x)
    {
        if(this.equals(x))
            return true;
        else
            return false;
    }
    
    public Term sust(Var x,Term t)
    {
        if(indice==x.indice)
            return t;
        else
            return this;
    }
    
    public int setAlias(int currentAlia)
    {
        if(alias != null)
        {
            alias = alias+"@"+currentAlia;
            currentAlia++;
        }
        
        return currentAlia;
    }
    
    public Term bracketAbsBD(Var x)
    {
        if(this.equals(x))
            return new Phi();
        else
            return new App(new Const("\\Phi_{K}"),this);
    }
    
    public int maxVar()
    {
        return indice;
    }
    
    public Term traducBD()
    {
        return this;
    }
    
    public List<Term> contandotraducBD()
    {
        List<Term> list=new ArrayList<Term>();
        
        return list;
    }
    
    public Redex buscarRedexIzq(Term contexto,boolean p)
    {
        return null;
    }
    
    public Redex buscarRedexIzqFinal(Term contexto,boolean p)
    {
        return null;
    }
    
    public Tipo esRedex()
    {
        return new Tipo(false,false);
    }
    
    public Tipo esRedexFinal()
    {
        return new Tipo(false,false,false);
    }
    
    public Term invBraBD()
    {
        return null;
    }
    
    public Term invBD()
    {
        return this;
    }
    
    public Term invBDOneStep()
    {
        return this;
    }
    
    public Term bracketAbsSH(Var x)
    {
        if(this.equals(x))
            return new Const("I");
        else
            return new App(new Const("K"),this);
    }
    
    public String toString()
    {
        if(alias == null )
            return "x_{"+indice+"}";
        else
        {
            return alias.split("@")[0].replace("_", "\\_");
        }
    }
    
    @Override
    public String toStringInf() {
        if(alias == null ) {
            char ascii = (char) indice; 
            return ""+ascii;
        }else {
            return alias;
        }
    }
    
    @Override
    public String toStringInFin() {
        if(alias == null ) {
            char ascii = (char) indice; 
            return ""+ascii;
        }else {
            return alias;
        }
    }
    
    public ToString toStringAbrv(ToString toString)
    {
        if(alias == null)
            toString.term=this.toString();
        else
        {
            /*toString.currentnAlias++;
                int index=toString.aliasIndex.size();
                toString.aliasIndex.put(alias, index);
                toString.valores.add(this.toString());
                toString.alias.add(alias);
            toString.term="\\cssId{agru@alias@"+toString.currentnAlias+"}{\\style{cursor:pointer; color:blue;}{"+alias+"}}";*/
            String aux="0";
            String[] Aux = alias.split("@");
            if(Aux.length == 2)
            {
                aux = alias.split("@")[1];
                toString.alias.add(Aux[0].replace("_", "\\\\_"));
            }
            else
                toString.alias.add(alias.replace("_", "\\\\_"));
            aux="\\cssId{agru@alias@"+aux+"}{\\style{cursor:pointer; color:blue;}{"+alias.replace("_", "\\_") +"}}";
            toString.currentnAlias++;
            toString.valores.add(this.toString().replace(alias.replace("_", "\\_"), "x_{"+indice+"}").replace("\\", "\\\\"));
            
            toString.term=aux;
        }
        
        return toString;
    }
    
    public ToString toStringInfAbrv(ToString toString)
    {
        if(alias == null)
            toString.term=this.toStringInf();
        else
        {
            /*toString.currentnAlias++;
                int index=toString.aliasIndex.size();
                toString.aliasIndex.put(alias, index);
                toString.valores.add(this.toString());
                toString.alias.add(alias);
            toString.term="\\cssId{agru@alias@"+toString.currentnAlias+"}{\\style{cursor:pointer; color:blue;}{"+alias+"}}";*/
            String aux="0";
            String[] Aux = alias.split("@");
            if(Aux.length == 2)
            {
                aux = alias.split("@")[1];
                toString.alias.add(Aux[0].replace("_", "\\\\_"));
            }
            else
                toString.alias.add(alias.replace("_", "\\\\_"));
            aux="\\cssId{agru@alias@"+aux+"}{\\style{cursor:pointer; color:blue;}{"+alias.replace("_", "\\_") +"}}";
            toString.currentnAlias++;
            toString.valores.add(this.toString().replace(alias.replace("_", "\\_"), "x_{"+indice+"}").replace("\\", "\\\\"));
            
            toString.term=aux;
        }
        
        return toString;
    }
    
    public ToString toStringAbrvV1(ToString toString)
    {
        if(alias == null)
            toString.term=this.toString();
        else
        {
            /*toString.currentnAlias++;
                int index=toString.aliasIndex.size();
                toString.aliasIndex.put(alias, index);
                toString.valores.add(this.toString());
                toString.alias.add(alias);
            toString.term="\\cssId{agru@alias@"+toString.currentnAlias+"}{\\style{cursor:pointer; color:blue;}{"+alias+"}}";*/
            String aux="0";
            String[] Aux = alias.split("@");
            if(Aux.length == 2)
                toString.alias.add(Aux[0].replace("_", "\\\\_"));
            else
                toString.alias.add(alias.replace("_", "\\\\_"));
            aux="\\cssId{agru@alias@"+toString.currentnAlias+"}{\\style{cursor:pointer; color:blue;}{"+alias.replace("_", "\\_") +"}}";
            toString.currentnAlias++;
            toString.valores.add(this.toString().replace(alias.replace("_", "\\_"), "x_{"+indice+"}").replace("\\", "\\\\"));
            
            toString.term=aux;
        }
        
        return toString;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Var other = (Var) obj;
        if (this.indice != other.indice) {
            return false;
        }
        return true;
    }
    
    @Override
    protected Object clone() throws CloneNotSupportedException{
        return this;
    }

    @Override
    public Term sustParall(ArrayList<Var> Vars, ArrayList<Term> varsTerm) {
        Var var = null;
        int i= 0;
        for (Iterator<Var> it = Vars.iterator(); it.hasNext();) {
            var = it.next();
            if (this.occur(var)) 
                break;
            i++;
        }
        if (this.occur(var) && (varsTerm.size() ==  Vars.size())) 
            return varsTerm.get(i);
        else 
            return this;
        
        
    }

    @Override
    public Term checkApp() {
        return this;
    }
  
}
