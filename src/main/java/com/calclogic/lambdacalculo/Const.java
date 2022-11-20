/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.lambdacalculo;

import com.calclogic.entity.Simbolo;
import com.calclogic.service.PredicadoManager;
import com.calclogic.service.SimboloManager;
import com.calclogic.service.SimboloManagerImpl;
import com.calclogic.dao.SimboloDAO;
import com.calclogic.dao.SimboloDaoImpl;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 *
 * @author federico
 */
public class Const extends Term
{
    final int id;
    final String con;
    final boolean funNotation;
    final int preced;
    final int asociat; //1:izquierda 2:derecha 0:sin regla de asociatividad
    
    
    public Const(String cons)
    {
        id =0;
        con=cons;
        funNotation = false;
        preced = 0;
        asociat = 0;
    }
    
    public Const(int idd, String cons, boolean funNota, int prec, int asoc)
    {
        id = idd;
        con=cons;
        funNotation = funNota;
        preced = prec;
        asociat = asoc;
    }
    
    public Const(int idd, String cons) 
    {
    	id = idd;
        con=cons;
        funNotation = false;
        preced = 0;
        asociat = 0;
        
    }

    public int getId() {
        return id;
    }
    
    public String getCon() {
        return con;
    }
    
    public boolean getFunNotation() {
        return funNotation;
    }
    
    public int getPreced() {
        return preced;
    }
    
    public int getAsociat() {
        return asociat;
    }
 
    public boolean occur(Var x)
    {
        return false;
    }
    
    public String position(Var x) {
        return "3";
    }
    
    @Override
    public Term subterm(String position) {
        if (position.equals(""))
           return this;
        else
           return null;
    }
    
    public Term sust(Var x,Term t)
    {
        return this;
    }
    
   public Term type()
   {
       return null;
   }
   
   public int nPhi()
   {
       return (con.equals("\\Phi_{K}")) ? 1 : 0;
   }
   
   public boolean containTypedA()
   {
       return this instanceof TypedA;
   }
   
   public boolean containT()
   {
       return id == -1;
   }
   
   public void getAxioms(List<String> l)
   {
       if (this instanceof TypedA)
           l.add(this.type().toString());
   }
   
   public Term leibniz(int z, String subterm, String thisId)
   {
       if (thisId.equals(subterm))
           return new Var(z);
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
 
    public int maxVar()
    {
        return -1;
    }
    
    public int fresh(int n)
    {
        return n;
    }
    
    public Tipo esRedex()
    {
        return new Tipo(false,false);
    }
    
    public Tipo esRedexFinal()
    {
        return new Tipo(false,false,false);
    }
    
    public Redex buscarRedexIzq(Term contexto,boolean p)
    {
        return null;
    }
    
    public Redex buscarRedexIzqFinal(Term contexto,boolean p)
    {
        return null;
    }
    
    public Term traducBD()
    {
        return this;
    }
    
    public Term traducBD(List<String> l)
    {
        return this;
    }
    
    public List<Term> contandotraducBD()
    {
        List<Term> list=new ArrayList<Term>();
        
        return list;
    }
    
    public Term invBraBD(int n)
    {
        return null;
    }
    
    public Term invBD()
    {
        return this;
    }
    
    public Term invBDOneStep()
    {
        return null;
    }
    
    public Term bracketAbsBD(Var x)
    {
        return new App(new Const("\\Phi_{K}"),this);
    }
    
    public Term bracketAbsSH(Var x)
    {
        return new App(new Const("K"),this);
    }
    
    public String toStringAll()
    {
        Term typ = this.type();
        if (typ == null || con.equals("S")) //|| con.equals("U"))
            return con;
        else
            return con+"^{"+((TypedTerm)this).getCombDBType()+"}";
    }
        
    @Override
    public String toStringLaTeX(SimboloManager s,String numTeo) {
        Simbolo c1 = s.getSimbolo(this.id);
        if (c1 == null)
           return con;
        else
           return c1.getNotacion_latex();
    }
    
    @Override
    public String toStringLaTeXLabeled(SimboloManager s,int z, Term t, String appPosition, List<Term> leibniz, 
                                     List<String> l2, Id id, int nivel){
        Simbolo c1 = s.getSimbolo(this.id);
        String term;
        if (c1 != null) 
           term = "\\cssId{"+id.id+"}{\\class{"+nivel+" terminoClick}{"+c1.getNotacion_latex()+"}}";
        else 
           term = "\\cssId{"+id.id+"}{\\class{"+nivel+" terminoClick}{"+con+"}}"; 

        leibniz.add(t.leibniz(z, appPosition, ""));
        l2.add(l2.size(),id.id+",");
//        leibniz.add(t.leibniz(z, this).toStringFormatC(s,"",0).replace("\\", "\\\\"));
//        leibnizL.add(t.leibniz(z, this).toStringWithInputs(s,"").replace("\\", "\\\\"));
        id.id++;
        
        return term;
    }
    
    @Override
    public String toStringFormatC(SimboloManager s, String pos, int id, String rootId){
        Simbolo c1 = s.getSimbolo(this.id);
        String term;
        if (c1 != null) 
           term = "C"+c1.getId()+"()";
        else 
           term = con; 
        
        return term;
    }
    
    @Override
    public String toStringLaTeXWithInputs(SimboloManager s, String position, String rootId) {
        Simbolo c1 = s.getSimbolo(this.id);
        if (c1 == null)
           return con;
        else
           return c1.getNotacion_latex();
    }
    
    public ToString toStringAbrvV1(ToString toString)
    {
        toString.term=this.toStringAll();
        return toString;
    }
    
    public ToString toStringAbrv(ToString toString)
    {
        toString.term=this.toStringAll();
        return toString;
    }
    
    @Override
    public ToString toStringLaTeXAbrv(ToString toString, SimboloManager s, PredicadoManager pm,
                                    String nTeo)
    {
        toString.term=this.toStringLaTeX(s,"");
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
        final Const other = (Const) obj;
        if ((this.con == null) ? (other.con != null) : !this.con.trim().equals(other.con.trim())) {
            return false;
        }
        return true;
    }
    
    @Override
    protected Object clone() throws CloneNotSupportedException{
        return new Const(id, con, funNotation, preced, asociat);
    }

    @Override
    public Term sustParall(List<Var> Vars, List<Term> varsTerm) {
        return this;
    }

    @Override
    public void freeVars(int[] set){
        ;
    }
    
    @Override
    public Term abstractEq() {
        return null;
    }
    
    @Override
    public Term checkApp() {
        return this;
    }
    
    @Override
    public String aliases(String position) {

            String currentAlias = "";
            if( this.alias != null) {
                    currentAlias =  this.alias + ':' + position;
            }

            return currentAlias;
    }

    @Override
    public String getType(HashMap<Integer, String> D, SimboloManager simboloManager) throws TypeVerificationException {
        switch (id) {
            case 0:
                return "*->*->b";
            case -1:
                return "b";
            default:
                Simbolo sim = simboloManager.getSimbolo(id);
                if (sim == null) {
                    throw new TypeVerificationException();
                }
                return sim.getTipo();
        }
    }
   
}
