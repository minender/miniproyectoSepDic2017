/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.lambdacalculo;

import com.calclogic.entity.Simbolo;
import com.calclogic.service.PredicadoManager;
import com.calclogic.service.ResuelveManager;
import com.calclogic.service.SimboloManager;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
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
    
    public String position(Var x)
    {
        if(this.equals(x))
            return "";
        else
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
        if(indice==x.indice)
            return t;
        else
            return this;
    }
    
    public Term type()
    {
        return null;
    }
    
    public int nPhi()
    {
        return 0;
    }
    
    public boolean containTypedA()
    {
        return false;
    }
    
    public boolean containT()
    {
        return false;
    }
    
    public void getAxioms(List<String> l)
    {
        ;
    }
    
    public Term leibniz(int z, String subtermId, String thisId)
    {
       if (thisId.equals(subtermId))
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
    
    public int fresh(int n)
    {
        return (n!=indice?n:indice+1);
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
        return this;
    }
    
    public Term bracketAbsSH(Var x)
    {
        if(this.equals(x))
            return new Const("I");
        else
            return new App(new Const("K"),this);
    }
    
    public String toStringAll()
    {
        if(alias == null )
            return "x_{"+indice+"}";
        else
        {
            return alias.split("@")[0].replace("_", "\\_");
        }
    }
    
    @Override
    public String toStringLaTeX(SimboloManager s,String numTeo) {
        if(alias == null ) {
            boolean inRange = (65 <= indice && indice <= 90) || (97 <= indice && indice <= 122);
            return (inRange?""+(char) indice:"x_{"+indice+"}");
        }else {
            return alias;
        }
    }
    
    @Override
    public String toStringLaTeXLabeled(SimboloManager s,int z, Term t, String appPosition, List<Term> leibniz, 
                                     List<String> l2, Id id, int nivel){
        leibniz.add(t.leibniz(z, appPosition, ""));
        l2.add(l2.size(),id.id+",");
        id.id++;
//        leibniz.add(t.leibniz(z, this).toStringFormatC(s,"",0).replace("\\", "\\\\"));
//        leibnizL.add(t.leibniz(z, this).toStringWithInputs(s,"").replace("\\", "\\\\"));
        if(alias == null ) {
            char ascii = (char) (indice>64?indice:indice+65); 
            return "\\cssId{"+(id.id-1)+"}{\\class{"+nivel+" terminoClick}{"+ascii+"}}";
        }else {
            return "\\cssId{"+(id.id-1)+"}{\\class{"+nivel+" terminoClick}{"+alias+"}}";
        }
    }
    
    @Override
    public String toStringFormatC(SimboloManager s,String pos,int id, String rootId) {
        char ascii = (char) indice; 
            return "Input{"+ascii+"," + rootId + pos + ",phatherOpId"+(id!=0?id:"")+"}";
    }
    
    @Override
    public String toStringLaTeXWithInputs(SimboloManager s, String position, String rootId) {
        if(alias == null ) {
            char ascii = (char) indice; 
            return "\\FormInput{"+rootId + position+"}";
        }else {
            return alias;
        }
    }
    
    @Override
    public ToString toStringAbrv(ToString toString)
    {
        if(alias == null)
            toString.term=this.toStringAll();
        else
        {
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
            toString.valores.add(this.toStringAll().replace(alias.replace("_", "\\_"), "x_{"+indice+"}").replace("\\", "\\\\"));
            
            toString.term=aux;
        }
        
        return toString;
    }
    
    @Override
    public ToString toStringLaTeXAbrv(ToString toString, SimboloManager s, PredicadoManager pm, 
                                    String nTeo)
    {
        if(alias == null)
            toString.term=this.toStringLaTeX(s,"");
        else
        {
            /*toString.currentnAlias++;
                int index=toString.aliasIndex.size();
                toString.aliasIndex.put(alias, index);
                toString.valores.add(this.toStringAll());
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
            toString.valores.add(this.toStringAll().replace(alias.replace("_", "\\_"), "x_{"+indice+"}").replace("\\", "\\\\"));
            
            toString.term=aux;
        }
        
        return toString;
    }
    
    public ToString toStringAbrvV1(ToString toString)
    {
        if(alias == null)
            toString.term=this.toStringAll();
        else
        {
            /*toString.currentnAlias++;
                int index=toString.aliasIndex.size();
                toString.aliasIndex.put(alias, index);
                toString.valores.add(this.toStringAll());
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
            toString.valores.add(this.toStringAll().replace(alias.replace("_", "\\_"), "x_{"+indice+"}").replace("\\", "\\\\"));
            
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
        return new Var(indice);
    }

    @Override
    public Term sustParall(List<Var> Vars, List<Term> varsTerm) {
        Var var = null;
        int i= 0;
        for (Iterator<Var> it = Vars.iterator(); it.hasNext();) {
            var = it.next();
            if (this.occur(var)) 
                break;
            i++;
        }
        if (this.occur(var) && (varsTerm.size() ==  Vars.size())) 
            try{
              return (Term)varsTerm.get(i).clone();
            }
            catch(CloneNotSupportedException e){
              System.out.println(e);
              return null;
            }
        else 
            return this;
        
        
    }

    @Override
    public void freeVars(int[] set) {
        if (indice >= 65 && indice <= 122)
           set[indice-65] = indice;
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
            currentAlias = this.alias + ':' + position;
	}
		
	return currentAlias;
    }
    
    @Override
    public String checkType(HashMap<Integer, String> D, SimboloManager simboloManager, String expected) throws TypeVerificationException {
        String type;
        if (!D.containsKey(this.indice)) {
            type = expected;
            System.out.println(((char) this.indice)+" es de tipo "+expected);
            D.put(this.indice, expected);
        }
        else {
            String current_type = D.get(this.indice);
            type = Simbolo.matchTipo(D.get(this.indice), expected);
            if (!type.equals(current_type)){
                System.out.println(((char) this.indice)+" es de tipo "+type);
                D.put(indice, type);
            }    
        }
        
        return type;
    }
}
