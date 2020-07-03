/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.lambdacalculo;

import com.howtodoinjava.entity.Simbolo;
import com.howtodoinjava.service.PredicadoManager;
import com.howtodoinjava.service.SimboloManager;
import java.util.ArrayList;
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
   
   public boolean containTypedA()
   {
       return this instanceof TypedA;
   }
   
   public Term leibniz(int z, Term subterm)
   {
       if (this == subterm)
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
    
    public List<Term> contandotraducBD()
    {
        List<Term> list=new ArrayList<Term>();
        
        return list;
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
    
    public String toString()
    {
        Term typ = this.type();
        if (typ == null)
          return con;
        else
          return con+"^{"+typ.toStringFinal()+"}";
    }
   
    /*@Override
    public String toStringInFin() {
        String res;
        System.out.println(con);
        if (con.startsWith("\\equiv")) {
           res =" == ";
        }else if (con.startsWith("\\Rightarrow")){
            res =  " ==> ";
        }else if (con.startsWith("\\Leftarrow")){
            res = " <== ";
        }else if (con.startsWith("\\vee")){
            res = " \\/ ";
        }else if (con.startsWith("\\wedge")){
            res = " /\\ ";
        }else if (con.startsWith("\\nequiv")){
            res = " !== ";
        }else if (con.startsWith("\\neg")){
            res = "!";
        }else{
            res = con;
        }
        return res;
    } */    
        
    @Override
    public String toStringInf(SimboloManager s,String numTeo) {
        Simbolo c1 = s.getSimbolo(this.id);
        if (c1 == null)
           return con;
        else
           return c1.getNotacion_latex();
    }
    
    @Override
    public String toStringInfLabeled(SimboloManager s,int z, Term t, List<Term> leibniz, 
                                     List<String> l2, Id id, int nivel){
        Simbolo c1 = s.getSimbolo(this.id);
        String term;
        if (c1 != null) 
           term = "\\cssId{"+id.id+"}{\\class{"+nivel+" terminoClick}{"+c1.getNotacion_latex()+"}}";
        else 
           term = "\\cssId{"+id.id+"}{\\class{"+nivel+" terminoClick}{"+con+"}}"; 

        leibniz.add(t.leibniz(z, this));
        l2.add(l2.size(),id.id+",");
//        leibniz.add(t.leibniz(z, this).toStringFormatC(s,"",0).replace("\\", "\\\\"));
//        leibnizL.add(t.leibniz(z, this).toStringWithInputs(s,"").replace("\\", "\\\\"));
        id.id++;
        
        return term;
    }
    
    @Override
    public String toStringFormatC(SimboloManager s, String pos, int id){
        Simbolo c1 = s.getSimbolo(this.id);
        String term;
        if (c1 != null) 
           term = "C"+c1.getId()+"()";
        else 
           term = con; 
        
        return term;
    }
    
    @Override
    public String toStringWithInputs(SimboloManager s, String position) {
        Simbolo c1 = s.getSimbolo(this.id);
        if (c1 == null)
           return con;
        else
           return c1.getNotacion_latex();
    }

    /*public Tripla toStringInfLabeled(Id id, int nivel, Tripla tri){
        id.id++;
        tri.term = "\\cssId{"+(id.id-1)+"}{\\class{"+nivel+" terminoClick}{"+con+"}}";
        tri.valores.add("lambda z.z");
        return tri;
    }*/
    
    public ToString toStringAbrvV1(ToString toString)
    {
        toString.term=this.toString();
        return toString;
    }
    
    public ToString toStringAbrv(ToString toString)
    {
        toString.term=this.toString();
        return toString;
    }
    
    @Override
    public ToString toStringInfAbrv(ToString toString, SimboloManager s, PredicadoManager pm,
                                    String nTeo)
    {
        toString.term=this.toStringInf(s,"");
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

    
   
   
}
