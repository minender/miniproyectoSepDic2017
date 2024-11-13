/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.lambdacalculo;

import com.calclogic.service.PredicadoManager;
import com.calclogic.service.SimboloManager;
import java.util.ArrayList;
import java.util.List;
import java.util.Stack;

/**
 *
 * @author federico
 */
public class Phi extends Term{
    
    public ListaInd ind;
    public static int stInd; // start point to index variables in type() method
    
    public Phi(Indice in){
        ind=new ListaInd(in);
    }
    
    public Phi(){
        ind=new ListaInd();
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
    
    public Term type(){
        return type_;
    }
    
    public void computeType() 
    {
        if (ind.orden == 0 && !ind.topeEsPar() )
            type_= new App(new App(new Const(-3,"->"),new Var(1)),new Var(1));
        else if (ind.orden == 0 && ind.topeEsPar())
            throw new IndexOutOfBoundsException();
        else {
        Term[] A = new Term[ind.orden+1];
        A[0] = null;
        Term aux = null;
        Term aux2 = null;
        Stack<ListaInd> stack = new Stack();
        App x = null;
        Indice index = null;
        ParInd par = null;
        int i = stInd;
        int j = 0;
        int offset = 0;
        int pairOrder = 0;
        int n = ind.orden;
        boolean jump = false;
        boolean startWithC = false;
        boolean isEmptyFList = false;
        Term[] lastResult = new Term[n];
        Term noVarResult = null;
        lastResult[0] = null;
        int lastResultIndex = -1;
        ListaInd list = ind;
        ListaInd currentList = ind;
        while (i-stInd+1 <= n) {
            try {
              index = currentList.get(j+offset);
            }
            catch (IndexOutOfBoundsException e) {
                if (offset == 1 || currentList.orden == 0) {
                    jump = true;
                    if (!stack.isEmpty())
                       i--;
                } else
                    throw new IndexOutOfBoundsException();
            }
            if (!jump) {
                if (index instanceof ParInd) {
                    i--;
                    j--;
                    stack.push(currentList);
                    currentList = ((ParInd)index).i2;
                    offset = 0;
                }
                else if (index.toString().equals("b")) {
                    //System.out.println(index);
                    if (i == stInd)
                      A[0] = new Var(i);
                    else
                      x.q = new Var(i);
                    x = new App(new Const(-3,"->"),null);
                    A[i-stInd+1] = new App(x,(j==0 && offset==0?A[0]:(aux==null?new Var(i):aux) ));
                    if (aux != null)
                        aux = null;
                }
                else if (index.toString().equals("c")) {
                    //System.out.println(index);
                    App y = x;
                    x = new App(new Const(-3,"->"),null);  
                    if (i == stInd)
                      A[0] = new App(x,new Var(i)); 
                    else {
                        if (j==0&& offset==0) {
                            if (A[0] instanceof Var) {
                                A[0] = new App(x,A[0]);// new Var(i));
                                ((App)A[1]).q = A[0]; 
                                startWithC = true;
                            }
                            else if (A[0] instanceof App) {
                                aux = (App)A[0];
                            }
                        }
                        else 
                            y.q = (!(aux instanceof App)?new App(x,new Var(i)):((App)aux).q);
                    }
                    if (!(aux instanceof App))
                        if (startWithC || 
                            (A[0] instanceof App && ((App)A[0]).q instanceof Var && 
                             i==((Var)((App)A[0]).q).indice )
                           ) 
                        {
                           A[i-stInd+1] = ((App)A[0]).q;//new Var(i); // este valor i hay que cambiarlo
                           startWithC = false;
                        }
                        else
                           A[i-stInd+1] = new Var(i);
                    else {
                       A[i-stInd+1] = ((App)aux).q;
                       aux = ((App)((App)aux).p).q;
                    }
                }
                j++;
            }
            jump = false;
            /*System.out.println(j);
            System.out.println("PairOrd:"+pairOrder);
            System.out.println("Current List:"+currentList);
            System.out.println(stack);*/
            if (j + pairOrder == currentList.orden) {
                //System.out.println(stack);
                if (!stack.isEmpty()) {
                    if ( ((ParInd)stack.lastElement().tope()).i2 == currentList) {
                        currentList = ((ParInd)stack.lastElement().tope()).i1;
                        offset = 0;
                        pairOrder = 0;
                        j = 0;
                        lastResultIndex++;
                        lastResult[lastResultIndex] = (aux==null?new Var(i+1):aux);// revisar
                        if (((ParInd)stack.lastElement().tope()).i2.orden == 0)
                            lastResult[lastResultIndex] = null;
                        else if (aux == null) 
                            x.q = new Var(i+1);
                    } else if (((ParInd)stack.lastElement().tope()).i1 == currentList){
                        // finish lista
                        isEmptyFList = currentList.orden == 0;
                        pairOrder = ((ParInd)stack.lastElement().tope()).orden;
                        currentList = stack.pop();
                        offset = 1;
                        j = 0;
                        Term lastR = lastResult[lastResultIndex];
                        //System.out.println("lastResult: "+lastR);
                        if (aux != null || isEmptyFList) {
                          aux2 = (isEmptyFList?A[0]:aux);
                          //if (A[0] instanceof App && ((App)A[0]).q instanceof Var && lastR instanceof Var)
                          //{      System.out.println("hola");((Var)((App)A[0]).q).indice = ((Var)lastR).indice;}
                          if (aux2 instanceof App) {
                              Equation eq = new Equation(((App)aux2).q,lastR);
                              Sust s = eq.mgu(false);
                              int l = (isEmptyFList?i-stInd+1:i);
                              for (int k=0;k<=l;k++)
                                  A[k] = A[k].sustParall(s);
                              aux = ((App)((App)aux2).p).q;
                          }
                          else {
                              Var var = new Var(((Var)aux2).indice);
                              Term term = new App(new App(new Const("->"),aux2),lastR);
                              int l = (isEmptyFList?i-stInd+1:i);
                              for (int k=0;k<=l;k++)
                                  A[k] = A[k].sust(var, term);
                              aux = aux2;
                          }
                        }
                        else {
                           if (i-stInd+2 > n && stack.isEmpty()) {
                              x.q = new App(new App(new Const(-3,"->"),new Var(i+1)),(lastR==null?A[0]:lastR));
                              //x = new App(new Const(-3,"->"),null);
                           }
                           else{
                              App y = x;
                              x = new App(new Const(-3,"->"),null);
                              y.q = new App(x,(lastR==null?A[0]:lastR) );
                           }
                        }
                        lastResultIndex--;
                    } else {
                        offset = 0;
                        j=0;
                    }
                }
                else
                    x.q = new Var(i+1);
            }
            if (i-stInd+2 <= n || stack.isEmpty())
               i++;
        }
        stInd = i+1;
        Term it = (aux == null?new Var(i):aux);
        i = 0;
        while (i <= n) {  
            it = new App(new App(new Const(-3,"->"),it),A[i]);
            i = i+1;
        }
        type_= it;
        }
    }
    
    public int nPhi()
    {
        return 1;
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
    
    public Term leibniz(int z, String subtermId, String thisId, SimboloManager s)
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
        return new App(new Const("\\Phi_{K}"),this);
    }
    
    public int maxVar()
    {
        return -1;
    }
    
    public int fresh(int n, int[] max)
    {
        return n;
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
        if (ind.orden == 0) {
           Tipo tipo = new Tipo(false,false,true);
           return new Redex(contexto,tipo,p);
        }
        else
           return null;
    }
    
    public Term invBraBD(Var x)
    {
        Var xn=x;//new Var(n);
        int[] max = new int[1];
        return new Bracket(xn,(new App(this,xn)).kappaIndexado(xn.indice,xn,max));
    }
    
    public Term invBD()
    {
        return this.invBraBD(new Var(0)).invBD();
    }
    
    public Term invBDOneStep()
    {
        return this.invBraBD(new Var(0));
    }
    
    public Term bracketAbsSH(Var x)
    {
        return new App(new Const("K"),this);
    }
    
    @Override
    public Term etaReduc() {
        return this;
    }
    
    public String toStringAll(){
        return "\\Phi_{"+ind.toString()+"}";
    }
    
    public String toStringInFin() {
        return "\\Phi_{"+ind.toString()+"}";
    }
    
    @Override
    public String toStringLaTeXLabeled(SimboloManager s,int z, Term t, String appPosition, List<Term> leibniz, List<String> leibnizL, Id id, int nivel){
        String term = "\\cssId{"+id.id+"}{\\class{"+nivel+" terminoClick}{\\Phi_{"+ind.toString()+"}}}";
        leibniz.add(t.leibniz(z, appPosition, "", s));
        id.id++;
        return term;
    }
    
    @Override
    public String toStringLaTeX(SimboloManager s,String numTeo,List transOp) {
        return "\\Phi_{"+ind.toString()+"}";
    }
    
    @Override
    public String toStringFormatC(SimboloManager s, String pos, int id, String rootId)
    {
        return toStringAll();
    }
    
    @Override
    public String toStringLaTeXWithInputs(SimboloManager s, String position, String rootId) {
        return "\\Phi_{"+ind.toString()+"}";
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
    public ToString toStringLaTeXAbrv(ToString toString, SimboloManager s,PredicadoManager pm,
                                    String nTeo, List transOp)
    {
        toString.term=this.toStringLaTeX(s,"",null);
        return toString;
    }

    public String toStringType(String v) {
        return "NULL";
    }
    
    public String printType() {
        return "";
    }
    
    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Phi other = (Phi) obj;
        if (this.ind != other.ind && (this.ind == null || !this.ind.equals(other.ind))) {
            return false;
        }
        return true;
    }
    
    @Override
    protected Object clone() throws CloneNotSupportedException
    {
        ListaInd cloneInd=(ListaInd)ind.clone();
        Phi phi=new Phi();
        phi.ind=cloneInd;
        phi.alias=this.alias;
        return phi;
    }

    public Term sustParall(List<Var> Vars, List<Term> varsTerm) {
        return this;
    }

    @Override
    public Term inverseVars() {
        return this;
    }
    
    @Override
    public void freeVars(int[] set){
        ;
    }
    
    @Override
    public void freeVars(int[] set, int[] visitNum){
        ;
    }
    
    @Override
    public String stFreeVarsWithAnyIndex(String st) {
        return st;
    }
    
    @Override
    public void boundVars(String[] vars) {
        ;
    }
    
    @Override
    public Term replaceConstByVars() {
        return this;
    }
    
    @Override
    public Term abstractEq(Term[] varTypes) {
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

    
}
