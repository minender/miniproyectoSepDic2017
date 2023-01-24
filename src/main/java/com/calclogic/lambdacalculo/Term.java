/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.lambdacalculo;

import com.calclogic.entity.PredicadoId;
import com.calclogic.entity.Simbolo;
import com.calclogic.parse.TermUtilities;
import com.calclogic.service.PredicadoManager;
import com.calclogic.service.ResuelveManager;
import com.calclogic.service.SimboloManager;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Stack;

/**
 *
 * @author federico
 */
public abstract class Term implements Cloneable, Serializable{
    
    public String alias;
    
    protected static class Id{
        public int id;
        
        public Id(){
            id = 0;
        }
    }
    
    protected static class ToString{
        public List<String> valores;
        public List<String> alias;
        public String term;
        public int currentnAlias; 
        
        public ToString(){
            valores=new LinkedList<String>();
            alias=new LinkedList<String>();
        }
        
        public void setNuevoAlias(String alia,Term t,SimboloManager s,PredicadoManager p,String nTeo){  
            PredicadoId pid = new PredicadoId(alia, "admin");
            String[] positions = p.getPredicado(pid).getArgumentos().split(",");
            alia = "\\style{cursor:pointer; color:#08c;}{"+alia+"}";
            for (int k=0; k < positions.length; k++)
                alia += (k==0?"(":", ")+t.subterm(positions[k].split("@")[1].trim()).toStringLaTeXAbrvFinal(this,s,p,nTeo).term;
            alia = alia + ")";
            valores.add(t.toStringLaTeXAbrv(this,s,p,nTeo).term.replace("\\", "\\\\"));
            String aux;
            aux="\\cssId{agru@alias@"+currentnAlias+"}{"+alia +"}";
            alias.add(alia.replace("\\", "\\\\"));
            currentnAlias++;

            term=aux;
        }
        
        public void setNuevoAlias(String alia,Term t){   
            //int indice= (new Integer(alia.split("@")[1])).intValue();
            String aux;
            //valores.set(indice,t.toStringAbrv(this).term.replace("\\", "\\\\"));
            ToString toString = t.toStringAbrv(new ToString());
            valores.add(toString.term.replace("\\", "\\\\"));
            alias.add(alia.split("@")[0].replace("_", "\\\\_"));
            //t.toStringAbrv(this);
            valores.addAll(toString.valores);
            alias.addAll(toString.alias);
            //alias.set(indice,alia.split("@")[0].replace("_", "\\\\_"));
            aux="\\cssId{agru@alias@"+alia.split("@")[1]+"}{\\style{cursor:pointer; color:#08c;}{"+alia.split("@")[0].replace("_", "\\_") +"}}";
            currentnAlias++;
            
            term=aux;
        }
        
        public void setNuevoAliasV1(String alia,Term t){   
            String aux;
            valores.add(t.toStringAbrvV1(this).term.replace("\\", "\\\\"));
            alias.add(alia.split("@")[0].replace("_", "\\\\_"));
            aux="\\cssId{agru@alias@"+currentnAlias+"}{\\style{cursor:pointer; color:#08c;}{"+alia.split("@")[0].replace("_", "\\_") +"}}";
            currentnAlias++;
            
            term=aux;
        }
        
        public String toString(){
            return term;
        }
    }
    
    public abstract Term bracketAbsSH(Var x);
    
    public abstract Term traducBD();
    
    public abstract Term traducBD(List<String> l);
    
    public abstract List<Term> contandotraducBD();
    
    public abstract Term bracketAbsBD(Var x);
    
    public abstract Term invBD();
    
    public abstract Term invBDOneStep();
    
    public abstract Term invBraBD(int n);
    
    public abstract Term sust(Var x,Term t);
    
    public abstract Term sustParall(List<Var>  Vars, List<Term> varsTerm);
    
    public Term sustParall(Sust sus) {
        return sustParall(sus.vars, sus.terms);
    }
    
    public abstract int setAlias(int currentAlia);
    
    public abstract Tipo esRedex();
    
    public abstract Tipo esRedexFinal();
    
    public abstract Redex buscarRedexIzq(Term contexto,boolean p);
    
    public abstract Redex buscarRedexIzqFinal(Term contexto,boolean p);
    
    public abstract int maxVar();

    public abstract boolean occur(Var x);
    
    public abstract int fresh(int n, int[] max);
    
    public abstract String position(Var x);
    
    public abstract Term subterm(String position);
    
    public abstract Term checkApp();
    
    public abstract Term type();
    
    public abstract int nPhi();
    
    public abstract boolean containTypedA();
    
    public abstract boolean containT();
    
    public abstract void getAxioms(List<String> l);
    
    public abstract Term leibniz(int z, String subtermId, String thisId, SimboloManager s);
    
    /**
     * Returns a string formatted with variables codification (x_{}) and
     * constants codification (c_{}) with all possible parentheses (that could be
     * unnecesary, see toString method).
     */
    public abstract String toStringAll();

    /**
      * @param kind Type of string that we want to generate
      *     - 'S': simple
      *     - 'I': with inputs -> For the Substitution and Leibniz fields.
      *     - 'L': labeled -> For the last line of a proof.
      *     - 'A': abreviaton -> For aliases
      * @param s
      * @param numTeo
      * @param position
      * @param rootId
      * @param z
      * @param t
      * @param l
      * @param l2
      * @param id
      * @param nivel
      * @param tStr
      * @param pm
      * @return String representation in LaTeX Format.
      */
    public String toStringLaTeX(char kind, SimboloManager s, String numTeo, String position, String appPosition, String rootId, int z, Term t, 
                                List<Term> l, List<String> l2, Id id, int nivel, ToString tStr, PredicadoManager pm)
    {
        switch (kind){
            case 'S':
                return toStringLaTeX(s, numTeo);
            case 'I':
                return toStringLaTeXWithInputs(s, position, rootId);
            case 'L':
                return toStringLaTeXLabeled(s,z,t,appPosition,l,l2,id,nivel);
            case 'A':
                return toStringLaTeXAbrv(tStr,s,pm,numTeo).term;
            default:
                return null;
        }
    }
    
    /**
     * Uses the symbols notation stored in the database to compute
     * the LaTeX format string.
     * @param s
     * @param numTeo
     * @return String representation in LaTeX Format.
     */
    public abstract String toStringLaTeX(SimboloManager s,String numTeo);
    
    /**
     * Creates a LaTeX string with the span HTML tags use to control the subexpresions
     * used for leibniz rule in the client.
     * @param s
     * @param z
     * @param initTerm
     * @param leibniz
     * @param leibnizL
     * @param id
     * @param nivel
     * @return String representation in LaTeX format with span HTML tags for Mathjax.
     */
    public abstract String toStringLaTeXLabeled(SimboloManager s,int z, Term initTerm, String appPosition, List<Term> leibniz, List<String> leibnizL, Id id, int nivel);
    
    /**
     * Creates a non curryfied format that doesn't allow wrong syntax formulas.
     * @param s
     * @param pos
     * @param id
     * @param rootId
     * @return String representation with non curryfied format.
     */
    public abstract String toStringFormatC(SimboloManager s, String pos, int id, String rootId);
    
    /**
     * Similar toStringLaTeX, but puts an HTML input in variables formulas
     * to be used in the sustitution.
     * @param s
     * @param position
     * @param rootId
     * @return String representation with HTML inputs.
     */
    public abstract String toStringLaTeXWithInputs(SimboloManager s, String position, String rootId);
    
    public abstract ToString toStringAbrvV1(ToString toString);
    
    public abstract ToString toStringAbrv(ToString toString);
    
    public abstract ToString toStringLaTeXAbrv(ToString toString, SimboloManager s, PredicadoManager p, String numTeo);
    
    protected String addParentheses(String str) {   
        int i =0;
        int size = str.length();
        while ( i < size-1 ){
            if (str.charAt(i)=='}' && str.charAt(i+1)=='{')
                break;
            i++;
        }
        return str.substring(0, i+2)+"("+str.substring(i+2, size-1)+")}";
    }

    /**
     * Function to get the list of aliases and their position in the AST of this expression
     * @param position of the current node represented with 1's and 2's
     * @return a String that represents all the aliases in this Term and its subterms
     */
    public abstract String aliases(String position);
    
    public int[] freeVars(){
        int[] set =new int[58];
        freeVars(set);
        
        return set;
    }
    
     public String stFreeVars(){
        String st = null;
        int[] set = freeVars();

        int i=0;
        while (st == null && i<58){
            if (set[i] != 0)
                st = ((char)set[i])+"";
            i++;
        } 
        for (int j=i; j<58; j++)
            if (set[j] != 0)
                st += ","+((char)set[j]);
        
        if (st == null)
            return "";
        
        return st;    
        //return hset.toString().replaceAll("[\\s\\[\\]]", "");
    }
    
    public String stFreeVars(SimboloManager s) throws TypeVerificationException{
        String st = null;
        HashMap<Integer,String> h = new HashMap<>();
        int[] set = freeVars();
        getType(h, s);
        int i=0;
        while (st == null && i<58){
            if (set[i] != 0){
                if (h.get(i+65).length() == 4) 
                    st = ((char)set[i])+"(x)";
                else if (h.get(i+65).length() > 4)
                    st = ((char)set[i])+"(x,x)";
                else
                    st = ((char)set[i])+"";
            }
            i++;
        } 
        for (int j=i; j<58; j++)
            if (set[j] != 0)
                if (h.get(j+65).length() == 4) 
                    st += ","+((char)set[j])+"(x)";
                else if (h.get(j+65).length() > 4)
                    st += ","+((char)set[j])+"(x,x)";
                else
                    st += ","+((char)set[j]);
        
        if (st == null)
            return "";
        
        return st;    
        //return hset.toString().replaceAll("[\\s\\[\\]]", "");
    }
    
    public abstract void freeVars(int[] set);
    
    public abstract void boundVars(String[] vars);
    
    public Term setToPrinting(String variables, SimboloManager s) {
        return this.setToPrinting(variables, s, null);
    }
    
    public Term setToPrinting(String variables, SimboloManager s, int[] c) {
        
        if (variables != null && !variables.equals("")) {// If there are no variables, you don't need to make any reduction
            this.evaluar(variables);
            // List<Var> li = TermUtilities.arguments(variables);
            // //List<Var> li2 = TermUtilities.arguments(variables);
            // //li.addAll(li2);
            // int nVar1 = ((App)((App) this).p).q.nPhi();
            // int nVar2 = ((App) this).q.nPhi();
            // List<Var> li2 = li.subList(nVar1+nVar2,li.size());
            // li2.addAll(li.subList(0, nVar1));
            // li2.addAll(li.subList(nVar1+nVar2,li.size()));
            // li2.addAll(li.subList(nVar1,nVar2));
            // //this.evaluar(li);
            // this.evaluar(li2);
        }
        Term arg2;
        arg2 = ((App)this).q.body();
        Term t = null;
        if (this.containT())
            t = arg2;
        else {
            Term arg1 = ((App)((App)this).p).q.body();
            String type;
            try {
                type = arg2.getType(s);
            }
            catch (TypeVerificationException e){
                try {
                   type = arg1.getType(s);
                }
                catch (TypeVerificationException e2){
                    type = "t";
                }
            }
            int opId;
            if (type.equals("b"))
               opId = 1;
            else
               opId = 15;
            if (c != null)
               c[0] = opId;
            t = new App(new App(new Const(opId,"c_{"+opId+"}"),arg1.body()),arg2.body());
        }
        return t;
    }
    
    public Term setToPrint(SimboloManager s) {
        Term arg1, arg2;
        arg1 = ((App)((App)this).p).q.body();
        arg2 = ((App)this).q.body();
        Term t;
        if (arg1.containT())
            t = arg2;
        else {
            String type;
            try {
              type = arg2.getType(s);
            }
            catch (TypeVerificationException e){
                try {
                   type = arg1.getType(s);
                }
                catch (TypeVerificationException e2){
                    type = "t";
                }
            }
            int opId;
            if (type.equals("b"))
               opId = 1;
            else
               opId = 15;
            t = new App(new App(new Const(opId,"c_{"+opId+"}"),arg1.body()),arg2.body());
        }
        return t;
    }
    
    public Term abstractVars (String variables) {
        if (!variables.equals("")) {
           Term arg1;
           arg1 = this;
           String[] vars = variables.split(",");
           for (int i=vars.length-1; 0<=i; i--) 
               arg1 = new Bracket(new Var((int)vars[i].charAt(0)),arg1);
           return arg1;
        }
        else
           return this;
    }
    
    public abstract Term abstractEq();
    
    public boolean isEquality() {
        return this instanceof App && ((App)this).p instanceof App && 
                ((App)((App)this).p).p instanceof Const && 
                ((Const)((App)((App)this).p).p).getCon().equals("=");
    }
    
    public Term body() {
        Term aux = this;
        while (aux instanceof Bracket) {
            aux = ((Bracket)aux).t;
        }
        return aux;
    }
    
    /**
     * Executes toString method asuming that every node associates to left. 
     * @return String without unnecesary parentheses 
     */
    @Override
    public String toString(){
        String term;
        String aux= this.toStringAll();
        if(aux.startsWith("(")){
            term=aux.substring(1, aux.length()-1);
        } else{
            term=aux;
        }   
        return term;
    }
    
    // Deprecated
    public String toStringLaTeXFinal(SimboloManager s) { 
        String term;
        String aux= this.toStringLaTeX(s,"");
        if(aux.startsWith("("))            
            term = aux.substring(1, aux.length()-1);            
        else{
            term=aux;
        }
        return term;
    }
    
    public String toStringLaTeXLabeled(SimboloManager s){
        List<Term> l1 = new LinkedList<>();
        List<String> l2 = new LinkedList<>();
        int z = this.maxVar()+1;
        if (z <= 122)
            z = 122;
        String st = this.toStringLaTeXLabeled(s,z,this,"",l1,l2,new Id(),0)+"$\n";
        String st2 = "";
        st+="<script>\nvar leibniz=[";
        for(Term it: l1) {
            st+="\n\""+it.toStringFormatC(s,"",0,"leibnizSymbolsId_").replace("\\", "\\\\")+"\",";
            st2+="\n\""+it.toStringLaTeXWithInputs(s,"","leibnizSymbolsId_").replace("\\", "\\\\")+"\",";
        }
        st = st.substring(0, st.length()-1)+"];\n";
        st += "leibnizLatex=[";
//        for(String it: l2)
//            st+="\n\""+it+"\",";
        st += st2;
        st = st.substring(0, st.length()-1)+"];\n</script>";
        return st;
    }
    
    // Deprecated
    public String toStringLaTeXLabeledFinal(SimboloManager s,int z, Term initTerm, List<Term> leibniz, List<String> leibnizL, Id id, int nivel){
        String term;
        String aux= this.toStringLaTeXLabeled(s,z, initTerm, "", leibniz, leibnizL, id, nivel);
        int i = 9;
        while  (aux.charAt(i)!='{')
            i++;
        String initStr = aux.substring(0,i+1);
        i=19;
        while (aux.charAt(i)!='{')
            i++;
        if(aux.charAt(i+1)=='(')
            term = initStr+"\\class{"+nivel+"}{"+aux.substring(i+2, aux.length()-3)+"}}";
        else{
            term=aux;
        }
        return term;
    }
    
    public void toStringAbrvFinal(ToString toString){
        String term;
        ToString st=this.toStringAbrv(toString);
        String aux= st.term;
        if(aux.startsWith("("))
            term=aux.substring(1, aux.length()-1);
        else
            term=aux;
        
        st.term = term;
    }
    
    // Deprecate
    public void toStringLaTeXAbrvFinal(ToString toString) {
        String term;
        ToString st=this.toStringLaTeXAbrv(toString,null,null,"");
        String aux= st.term;
        if(aux.startsWith("("))
            term=aux.substring(1, aux.length()-1);
        else
            term=aux;
        
        st.term = term;
    }
    
    public void toStringAbrvFinalV1(ToString toString){
        String term;
        ToString st=this.toStringAbrvV1(toString);
        String aux= st.term;
        if(aux.startsWith("("))
            term=aux.substring(1, aux.length()-1);
        else
            term=aux;
        
        st.term = term;
    }
    
    public Tripla toStringAbrvFinal(){
        String term;
        ToString toString=new ToString();
        /*for (int i=0; i<=25;i++)
        {
            toString.alias.add("");
            toString.valores.add("");
        }*/
        ToString st=this.toStringAbrv(toString);
        String aux= st.term;
        if(aux.startsWith("("))
            term=aux.substring(1, aux.length()-1);
        else
            term=aux;
        
        Tripla tripla = new Tripla();
        tripla.term=term;
        tripla.alias = st.alias;
        tripla.valores= st.valores;
                
        return tripla;
    }
    
    public Tripla toStringLaTeXAbrvFinal(){
        String term;
        ToString toString=new ToString();
        /*for (int i=0; i<=25;i++)
        {
            toString.alias.add("");
            toString.valores.add("");
        }*/
        ToString st=this.toStringAbrv(toString);
        String aux= st.term;
        if(aux.startsWith("("))
            term=aux.substring(1, aux.length()-1);
        else
            term=aux;
        
        Tripla tripla = new Tripla();
        tripla.term=term;
        tripla.alias = st.alias;
        tripla.valores= st.valores;
                
        return tripla;
    }
    
    public Tripla toStringAbrvFinalV1(){
        String term;
        ToString toString=new ToString();
        ToString st=this.toStringAbrvV1(toString);
        String aux= st.term;
        if(aux.startsWith("("))
            term=aux.substring(1, aux.length()-1);
        else
            term=aux;
        
        Tripla tripla = new Tripla();
        tripla.term=term;
        tripla.alias = st.alias;
        tripla.valores= st.valores;
                
        return tripla;
    }
    
    public String toStringAbrvFinalFinal(){
        return this.toStringAbrvFinal().term;
    }
    
    public String toStringAbrvFinalFinalV1(){
        return this.toStringAbrvFinalV1().term;
    }
    
    public String toStringJavascript(String id){
        Tripla tri = this.toStringAbrvFinalV1();
        
        String st="<span id=\"Math"+id+"\">$$"+tri.term +"$$</span>";
        st+="<script>var alias=[";
        for(String it:tri.alias)
            st+="\""+it+"\",\n";

        st+= "];\n valorAlias=[";
        for(String it2:tri.valores)
            st+="\""+it2+"\",\n";
        st+="];\n clickAlias(\"Math"+id +"\",alias, valorAlias);</script>";
        
        return st;
    }
    
    public ToString toStringLaTeXAbrvFinal(ToString toString, SimboloManager s, PredicadoManager p, String numTeo){
        if (alias != null) {
           toString.setNuevoAlias(alias, this, s, p, numTeo);
           return toString;
        }
        toStringLaTeXAbrv(toString,s,p,numTeo);
        return toString;
    }
    
    public String toStringLaTeXJavascript(SimboloManager s, PredicadoManager p, String nTeo, String id){
        ToString tStr=new ToString();
        this.toStringLaTeXAbrvFinal(tStr,s,p,nTeo);
        
        String st;

        st="<span id=\"Math"+id+"\">$"+tStr.term +"$</span>";
        st+="<script>var alias=[";
        for(String it:tStr.alias)
            st+="\""+it+"\",\n";

        st+= "];\nvar valorAlias=[";
        for(String it2:tStr.valores)
            st+="\""+it2+"\",\n";
        st+="];\n clickAlias(\"Math"+id +"\",alias, valorAlias);</script>";
        
        return st;
    }
    
    public String toStringAbrv(){
        Tripla tri = this.toStringAbrvFinal();
        
        return tri.term;
    }
    
    public class Tipo{
        public boolean c;
        public boolean l;
        public boolean t;
        
        public Tipo(boolean com,boolean lambda){
            c=com;
            l=lambda;
        }
        
        public Tipo(boolean com,boolean lambda, boolean traduc){
            c=com;
            l=lambda;
            t=traduc;
        }
    }
    
    public class Redex{
        public Term context;
        public Tipo tipo;
        public boolean p;
        
        public Redex(Term con,Tipo tip,boolean pp){
            context=con;
            tipo=tip;
            p=pp;
        }
    }
    
    public List<String> volverPuroList(){
        try{
            Term clone=(Term)this.clone();
            Redex r=clone.buscarRedexIzq(null,false);
            List<String> puro = new LinkedList<>();
            if(r!=null && r.tipo.l){
                if(r.context==null){
                    List<Term> list = ((Bracket)(((App)clone).p)).t.contandotraducBD();
                    for(Term t:list)
                        puro.add((new App(new Bracket(((Bracket)(((App)clone).p)).x,t),((App)clone).q)).toStringAbrvFinalFinal().replace("\\", "\\\\"));        
                }
                else if(r.context instanceof App){
                    if(r.p){
                        Term t=((App)r.context).p; 
                        List<Term> list = ((Bracket)((App)t).p).t.contandotraducBD();
                        for(Term ter: list){
                            ((App)r.context).p=new App(new Bracket(((Bracket)((App)t).p).x,ter),((App)t).q);
                            puro.add(clone.toStringAbrvFinalFinal().replace("\\", "\\\\"));
                        }
                    }
                    else{
                        Term t=((App)r.context).q;  
                        List<Term> list = ((Bracket)((App)t).p).t.contandotraducBD();
                        for(Term ter: list){
                            ((App)r.context).q=new App(new Bracket(((Bracket)((App)t).p).x,ter),((App)t).q);
                            puro.add(clone.toStringAbrvFinalFinal().replace("\\", "\\\\"));
                        }
                    }
                }
                else if(r.context instanceof Bracket){           
                    Term t=((Bracket)r.context).t;
                    List<Term> list = ((Bracket)((App)t).p).t.contandotraducBD();
                    for(Term ter: list){
                        ((Bracket)r.context).t=new App(new Bracket(((Bracket)((App)t).p).x,ter),((App)t).q);
                        puro.add(clone.toStringAbrvFinalFinal().replace("\\", "\\\\"));
                    }
                }
            }
            if(puro.size() == 0){
                puro.add(this.toStringAbrvFinalFinal().replace("\\", "\\\\"));
            }
            return puro;
        }
        catch(Exception e){}
        return null;
    }
    
    public Term volverPuro(){
        try{
            Term clone=(Term)this.clone();
            Redex r=clone.buscarRedexIzq(null,false);
            if(r!=null && r.tipo.l){
                if(r.context==null)
                    return new App(new Bracket(((Bracket)(((App)clone).p)).x,((Bracket)(((App)clone).p)).t.traducBD()),((App)clone).q);
                else if(r.context instanceof App){
                    if(r.p){
                        Term t=((App)r.context).p; 
                        ((App)r.context).p=new App(new Bracket(((Bracket)((App)t).p).x,((Bracket)((App)t).p).t.traducBD()),((App)t).q);
                        return clone;
                    }
                    else{
                        Term t=((App)r.context).q;  
                        ((App)r.context).q=new App(new Bracket(((Bracket)((App)t).p).x,((Bracket)((App)t).p).t.traducBD()),((App)t).q);
                        return clone;
                    }
                }
                else if(r.context instanceof Bracket){           
                    Term t=((Bracket)r.context).t;
                    ((Bracket)r.context).t=new App(new Bracket(((Bracket)((App)t).p).x,((Bracket)((App)t).p).t.traducBD()),((App)t).q);
                    return clone;
                }
            }
            else
                return this;
        }
        catch(Exception e){}
        return this;
    }
    
    public Term reducir(List<Var> vars)
    {
        Redex r=buscarRedexIzqFinal(null,false);
        if(r!=null)
        {
            if(r.context==null)
            {
                if(r.tipo.c)
                    return this.kappa();
                else if(r.tipo.l)
                    return ((Bracket)(((App)this).p)).t.traducBD().sust(((Bracket)(((App)this).p)).x, ((App)this).q);
                else
                    return this.invBraBD((vars.size()!=0?vars.remove(0).indice:65));
            }
            else if(r.context instanceof App)
            {
                 if(r.p)
                 {
                     Term t=((App)r.context).p; 
                     if (r.tipo.c)
                        ((App)r.context).p=t.kappa();
                     else if (r.tipo.l){
                        ((App)r.context).p=((Bracket)((App)t).p).t.traducBD().sust(((Bracket)((App)t).p).x, ((App)t).q);
                     }
                     else
                        ((App)r.context).p=t.invBraBD((vars.size()!=0?vars.remove(0).indice:65));
                 }
                 else
                 {
                     Term t=((App)r.context).q; 
                     if(r.tipo.c)
                        ((App)r.context).q=t.kappa();
                     else if(r.tipo.l)
                        ((App)r.context).q=((Bracket)((App)t).p).t.traducBD().sust(((Bracket)((App)t).p).x, ((App)t).q);
                     else 
                        ((App)r.context).q=t.invBraBD((vars.size()!=0?vars.remove(0).indice:65));
                 }
            }
            else if(r.context instanceof Bracket)
            {                          
                 Term t=((Bracket)r.context).t; 
                 if(r.tipo.c)
                     ((Bracket)r.context).t=t.kappa();
                 else if(r.tipo.l)
                     ((Bracket)r.context).t=((Bracket)((App)t).p).t.traducBD().sust(((Bracket)((App)t).p).x, ((App)t).q);
                 else 
                     ((Bracket)r.context).t=t.invBraBD((vars.size()!=0?vars.remove(0).indice:65));
            }
        }
        
        return this;
    }
    
    public Term reducir()
    {
        Redex r=buscarRedexIzqFinal(null,false);
        if(r!=null){
            if(r.context==null){
                if(r.tipo.c)
                    return this.kappa();
                else if(r.tipo.l)
                    return ((Bracket)(((App)this).p)).t.traducBD().sust(((Bracket)(((App)this).p)).x, ((App)this).q);                    
                else
                    return this.invBraBD(0);
            }
            else if(r.context instanceof App){
                if(r.p){
                    Term t=((App)r.context).p; 
                    if (r.tipo.c)
                        ((App)r.context).p=t.kappa();
                    else if (r.tipo.l)
                        ((App)r.context).p=((Bracket)((App)t).p).t.traducBD().sust(((Bracket)((App)t).p).x, ((App)t).q);
                     else
                        ((App)r.context).p=t.invBraBD(0);
                 }
                 else
                 {
                     Term t=((App)r.context).q; 
                     if(r.tipo.c)
                        ((App)r.context).q=t.kappa();
                    else if(r.tipo.l)
                        ((App)r.context).q=((Bracket)((App)t).p).t.traducBD().sust(((Bracket)((App)t).p).x, ((App)t).q);
                     else
                        ((App)r.context).q=t.invBraBD(0);
                 }
            }
            else if(r.context instanceof Bracket)
            {     
                 Term t=((Bracket)r.context).t; 
                 if(r.tipo.c)
                     ((Bracket)r.context).t=t.kappa();
                 else if(r.tipo.l)
                     ((Bracket)r.context).t=((Bracket)((App)t).p).t.traducBD().sust(((Bracket)((App)t).p).x, ((App)t).q);
                 else
                     ((Bracket)r.context).t=t.invBraBD(0);
            }
        } 
        return this;
    }
    
    public Term reducirFinal(Corrida corr){
        Redex r=buscarRedexIzqFinal(null,false);
        if(r!=null){
            Term reduc;
            if(r.context==null){
                if(r.tipo.c){
                    reduc = this.kappa();
                    corr.operations.add(new Integer(3));
                    corr.terminos.add(reduc.toStringAbrvFinalFinal().replace("\\", "\\\\"));
                    try{
                        Term tee=(Term)reduc.clone();
                        corr.lambdaTerms.add(tee.invBD().toStringAbrvFinalFinal().replace("\\", "\\\\"));
                    }
                    catch(Exception e){e.printStackTrace();}
                    corr.reducciones++;
                    return reduc;
                }
                else if(r.tipo.l){
                    List<String> puro=this.volverPuroList();
                    for(int i=0; i < puro.size(); i++)
                        corr.operations.add(new Integer(1));
                    
                    corr.terminos.addAll(puro);
                    corr.traducciones+=puro.size();
                    reduc = ((Bracket)(((App)this).p)).t.traducBD().sust(((Bracket)(((App)this).p)).x, ((App)this).q);
                    corr.operations.add(new Integer(3));
                    corr.terminos.add(reduc.toStringAbrvFinalFinal().replace("\\", "\\\\"));
                    try{
                        Term tee=(Term)reduc.clone();
                        corr.lambdaTerms.add(tee.invBD().toStringAbrvFinalFinal().replace("\\", "\\\\"));
                    }
                    catch(Exception e){e.printStackTrace();}
                    corr.reducciones++;
                    return reduc;
                }
                else
                {
                    reduc=this.invBraBD(0);
                    corr.operations.add(new Integer(2));
                    corr.terminos.add(reduc.toStringAbrvFinalFinal().replace("\\", "\\\\"));
                    corr.traducciones++;
                    return reduc;
                }
            }
            else if(r.context instanceof App){
                 if(r.p){
                    Term t=((App)r.context).p; 
                    if(r.tipo.c){
                        ((App)r.context).p=t.kappa();
                        corr.operations.add(new Integer(3));
                        corr.reducciones++;
                        corr.terminos.add(this.toStringAbrvFinalFinal().replace("\\", "\\\\"));
                        try{
                            Term tee=(Term)((App)r.context).p.clone();
                            corr.lambdaTerms.add(tee.invBD().toStringAbrvFinalFinal().replace("\\", "\\\\"));
                        }
                        catch(Exception e){e.printStackTrace();}
                    }
                    else if(r.tipo.l){
                        List<String> puro=this.volverPuroList();
                        for(int i=0; i < puro.size(); i++)
                            corr.operations.add(new Integer(1));
                        
                        corr.terminos.addAll(puro);
                        corr.traducciones+=puro.size();
                        ((App)r.context).p=((Bracket)((App)t).p).t.traducBD().sust(((Bracket)((App)t).p).x, ((App)t).q);
                        corr.operations.add(new Integer(3));
                        corr.terminos.add(this.toStringAbrvFinalFinal().replace("\\", "\\\\"));
                        try{
                            Term tee=(Term)this.clone();
                            corr.lambdaTerms.add(tee.invBD().toStringAbrvFinalFinal().replace("\\", "\\\\"));
                        }
                        catch(Exception e){e.printStackTrace();}
                        corr.reducciones++;
                     }
                     else
                     {
                        ((App)r.context).p=t.invBraBD(0);
                        corr.operations.add(new Integer(2));
                        corr.terminos.add(this.toStringAbrvFinalFinal().replace("\\", "\\\\"));
                        corr.traducciones++;
                    }
                 } else {
                    Term t=((App)r.context).q; 
                    if(r.tipo.c){
                        ((App)r.context).q=t.kappa();
                        corr.operations.add(new Integer(3));
                        corr.reducciones++;
                        corr.terminos.add(this.toStringAbrvFinalFinal().replace("\\", "\\\\"));
                        try{
                            Term tee=(Term)this.clone();
                            corr.lambdaTerms.add(tee.invBD().toStringAbrvFinalFinal().replace("\\", "\\\\"));
                        }
                        catch(Exception e){e.printStackTrace();}
                    }
                    else if(r.tipo.l){
                        List<String> puro=this.volverPuroList();
                        for(int i=0; i < puro.size(); i++)
                            corr.operations.add(new Integer(1));
                        
                        corr.terminos.addAll(puro);
                        corr.traducciones+=puro.size();
                        ((App)r.context).q=((Bracket)((App)t).p).t.traducBD().sust(((Bracket)((App)t).p).x, ((App)t).q);
                        corr.operations.add(new Integer(3));
                        corr.terminos.add(this.toStringAbrvFinalFinal().replace("\\", "\\\\"));
                        try{
                            Term tee=(Term)this.clone();
                            corr.lambdaTerms.add(tee.invBD().toStringAbrvFinalFinal().replace("\\", "\\\\"));
                        }
                        catch(Exception e){e.printStackTrace();}
                        corr.reducciones++;
                     }
                     else
                     {
                        ((App)r.context).q=t.invBraBD(0);
                        corr.operations.add(new Integer(2));
                        corr.terminos.add(this.toStringAbrvFinalFinal().replace("\\", "\\\\"));
                        corr.traducciones++;
                    }
                }
            } else if(r.context instanceof Bracket){           
                Term t=((Bracket)r.context).t; 
                if(r.tipo.c){
                    ((Bracket)r.context).t=t.kappa();
                    corr.operations.add(new Integer(3));
                    corr.terminos.add(this.toStringAbrvFinalFinal().replace("\\", "\\\\"));
                    try{
                        Term tee=(Term)this.clone();
                        corr.lambdaTerms.add(tee.invBD().toStringAbrvFinalFinal().replace("\\", "\\\\"));
                    }
                    catch(Exception e){e.printStackTrace();}
                    corr.reducciones++;
                }
                else if(r.tipo.l){
                    List<String> puro=this.volverPuroList();
                    for(int i=0; i < puro.size(); i++)
                        corr.operations.add(new Integer(1));
                        
                    corr.terminos.addAll(puro);
                    corr.traducciones+=puro.size();
                    ((Bracket)r.context).t=((Bracket)((App)t).p).t.traducBD().sust(((Bracket)((App)t).p).x, ((App)t).q);
                    corr.operations.add(new Integer(3));
                    corr.terminos.add(this.toStringAbrvFinalFinal().replace("\\", "\\\\"));
                    try{
                     Term tee=(Term)this.clone();
                     corr.lambdaTerms.add(tee.invBD().toStringAbrvFinalFinal().replace("\\", "\\\\"));
                    }
                    catch(Exception e){e.printStackTrace();}
                    corr.reducciones++;
                 }
                 else
                 {
                    ((Bracket)r.context).t=t.invBraBD(0);
                    corr.operations.add(new Integer(2));
                    corr.terminos.add(this.toStringAbrvFinalFinal().replace("\\", "\\\\"));
                    corr.traducciones++;
                 }
            }
        }
        return this;
    }
    
    protected class AppIzq{
        Term p;
        App pq;
        App pqr;
        int deep;
        
        AppIzq(Term p1, App q1,App pqr1, int deep1){
            p=p1;
            pq=q1;
            pqr=pqr1;
            deep=deep1;
        }
    }
    
    public AppIzq obtenerIzq(App in,int deep){
        int i=1;
        Term p1=in.p;
        App appizq=in;
        App aizqnivel2=null;
        while((deep != 0) && p1 instanceof App){
            aizqnivel2=appizq;
            appizq=(App)p1;
            p1=((App)p1).p;
            i++;
            deep--;
        }
        return (new AppIzq(p1,appizq,aizqnivel2,i));
    }
    
    public Stack<Term> unfold(SimboloManager s) {
        Stack<Term> stk = new Stack<>();
        if (this instanceof App) {
            stk.push(((App)this).q);
            Term aux = ((App)this).p;
            int j = 1;
            while ( aux instanceof App ){
               stk.push(((App)aux).q);
               aux = ((App)aux).p;
               j++;
            }
            if (aux instanceof Const && s.getSimbolo(((Const)aux).getId()).getArgumentos() == stk.size()) {
                stk.push(aux);
                return stk;
            }
            else
                return null;
        }
        else if (this instanceof Const) {
            stk.push(this);
            return stk;
        }
        else
            return null;
    }
    
    public Term kappa(){
        if(this instanceof App){
            AppIzq izq=obtenerIzq((App)this,-1);
            Const k=new Const("\\Phi_{K}");

            if((izq.p instanceof Phi) && izq.deep==((ListaInd)((Phi)izq.p).ind).orden+1){
                ListaInd l=((Phi)izq.p).ind;
                if(!l.list.isEmpty()){
                    Indice i=l.removerUlt();
                    if(i instanceof ConstInd){
                        if(((ConstInd)i).ind.equals("b")){
                            Term x1=izq.pq.q;
                            izq.pqr.p=izq.p;
                            return new App(x1,this.kappa());
                        }
                        else{
                            Term x1=izq.pq.q;
                            izq.pqr.p=izq.p;
                            return new App(this.kappa(),x1);
                        }
                    }
                    else{
                        Phi phi1=new Phi();
                        Phi phi2=new Phi();
                        phi1.ind=((ParInd)i).i1;//mal tambien
                        phi2.ind=((ParInd)i).i2;//tienes que concatenar con el resto de los indices
                        izq.pq.p=phi1;
                        AppIzq izq2=obtenerIzq((App)this,phi2.ind.orden);//no se empieza del ultimo mal
                        Term t1=izq2.p;
                        Term xnMas1 = ((App)this).q;
                        if ( !(xnMas1 instanceof Var || xnMas1 instanceof Const) ) {
                           try{
                            xnMas1=(Term)((App)this).q.clone();
                           }
                           catch(CloneNotSupportedException e){
                             e.printStackTrace();
                             return null;
                           }
                        }
                        izq2.pq.p=phi2;
                        return new App((new App(t1,xnMas1)).kappa(),this.kappa());
                        
                    }
                }
                else{
                    return izq.pq.q;
                }
            }
            else if(izq.p.equals(k) && izq.deep==2){
                return izq.pq.q;
            }
            else{
                return this;
            }
        }
        else{
            return this;
        }
    }
    
    public int nextVar(int[] vars, int c) {
        int aux = c;
        while (c < vars.length && vars[c] != 0) {
            c++;
        }
        if (aux < vars.length && c == vars.length) {
            c = 0;
            while (c < aux && vars[c] != 0) {
                c++;
            }
            if (c!=aux)
                return c;
            else
                return vars.length;
        }
        else if (aux >= vars.length)
            return aux+1;
        else
            return c;
    }
    
    public Term kappaIndexado(int c,Var xc, int[] max){
        if(this instanceof App){
            AppIzq izq=obtenerIzq((App)this,-1);
            Const k=new Const("\\Phi_{K}");
            if((izq.p instanceof Phi) && izq.deep==((ListaInd)((Phi)izq.p).ind).orden+1){
                ListaInd l=((Phi)izq.p).ind;
                if(!l.list.isEmpty()){
                    Indice i=l.removerUlt();
                    if(i instanceof ConstInd){
                        if(((ConstInd)i).ind.equals("b")){
                            Term x1=izq.pq.q;
                            izq.pqr.p=izq.p;
                            Term aux = new App(x1,this.kappaIndexado(x1.fresh(c,max),xc,max));
                            return aux;
                        }
                        else{
                            Term x1=izq.pq.q;
                            izq.pqr.p=izq.p;
                            Term aux = new App(this.kappaIndexado(x1.fresh(c,max),xc,max),x1);
                            return aux;
                        }
                    }
                    else{
                        Phi phi1=new Phi();
                        Phi phi2=new Phi();
                        phi1.ind=((ParInd)i).i1;//mal tambien
                        phi2.ind=((ParInd)i).i2;//tienes que concatenar con el resto de los indices
                        izq.pq.p=phi1;
                        AppIzq izq2=obtenerIzq((App)this,phi2.ind.orden);//no se empieza del ultimo mal
                        Term t1=izq2.p;
                        izq2.pq.p=phi2;
                        return new App((new App(t1,xc)).kappaIndexado(c,xc,max),this.kappaIndexado(xc.indice,xc,max));
                    }
                } else{
                    /*xc.setIndice(Math.max(izq.pq.q.maxVar(),c));
                    return xc;*/
                    xc.indice=c;
                    return xc;
                }
            }
            else if(izq.p.equals(k) && izq.deep==2){
                xc.indice = izq.pq.q.fresh(c,max);
                return izq.pq.q;
            }
            else{
                return this;
            }
        } else {
            return this;
        }
    }
    
    public Term evaluar(){
        Term term2=this;
        Term term1=term2;

        //do
        //{
        term1=term2;
        Redex redex=term1.buscarRedexIzqFinal(null, false);
        while(redex!=null){
            term1=term1.reducir();
            redex=term1.buscarRedexIzqFinal(null, false);
        }
        //    term2=term1.invBDOneStep();
        //}while(!term1.equals(term2));

	    return term1;
    }
    /**
     * Ojo este metodo solo funciona si el termino es un combinador. Si tiene redex de tipo lambda
     * que provocan una traduccion que generan redex de tipo traduccion, ya no sirve aunque pogas la 
     * lista de variables ligadas sugeridas correctamente
     * 
     * @param vars
     * @return 
     */
    public Term evaluar(String vars) {
        if (";".equals(vars))
            return evaluar(new ArrayList<Var>());
        else {
            //vars = vars + ", "+ vars;
            String[] split_vars = vars.split(";");
            String bound_vars = split_vars[0];
            String free_vars;
            if (split_vars.length == 1) {
                free_vars = "";
            }
            else {
                free_vars = split_vars[1];
            }
            List<Var> li_bound;
            List<Var> li_free;
            if (bound_vars.equals("")) {
                li_bound = new ArrayList<Var>();
            }
            else {
                li_bound = TermUtilities.arguments(bound_vars);
            }
            if (free_vars.equals("")) {
                li_free = new ArrayList<Var>();
            }
            else {
                li_free = TermUtilities.arguments(free_vars);
            }
            // Ojo estas lineas solo funcionan si el termino es un combinador. Si tiene redex de tipo 
            // lambda que provocan una traduccion que generan redex de tipo traduccion, ya no sirve 
            // aunque pogas la lista de variables ligadas sugeridas correctamente
            int nVar1 = (((App)((App) this).p).q.nPhi()!=0?((App)((App) this).p).q.nPhi() - li_free.size():0);
            int nVar2 = (((App) this).q.nPhi()!=0?((App) this).q.nPhi() - li_free.size():0);
            List<Var> li2 = li_free;
            li2.addAll(li_bound.subList(0, nVar1));
            li2.addAll(li_free);
            li2.addAll(li_bound.subList(nVar1,nVar1+nVar2));
            return evaluar(li2);
        }
    }
    
    public Term evaluar(List<Var> vars)
    {
            Term term2=this;
            Term term1=term2;

            //do
            //{
                term1=term2;
                Redex redex=term1.buscarRedexIzqFinal(null, false);
                while(redex!=null)
                {
                    term1=term1.reducir(vars);
                    redex=term1.buscarRedexIzqFinal(null, false);
                }
            //    term2=term1.invBDOneStep();
            //}while(!term1.equals(term2));

	    return term1;
    }
    
    public Corrida evaluarFinal()
    {
        Corrida corr = new Corrida();
        Term term=this;
        corr.terminos.add(term.toStringAbrvFinalFinal().replace("\\", "\\\\"));
        
        Redex redex=term.buscarRedexIzqFinal(null, false);
        while(redex != null){
            term=term.reducirFinal(corr);
            redex=term.buscarRedexIzqFinal(null, false);
        }
        
        return corr;
    }

    public static Term natural(int n){
    	Term suc=new Bracket(new Var(0),new Bracket(new Var(1),new Bracket(new Var(2),new App(new App(new Var(0),new Var(1)),new App(new Var(1),new Var(2)))))); 
    	Term ent=new Bracket(new Var(0),new Bracket(new Var(1),new Var(1))); 
    	
    	for(int i=1; i<=n;i++)
    		ent=(new App(suc,ent)).evaluar(); 
            
            ent.alias="N"+n;

    	return ent;
    }
    
    public void setAlias(String alias){
        this.alias=alias;
    }
    
    @Override
    protected abstract Object clone() throws CloneNotSupportedException;

    public Object clone2() {
    	try {
    		return this.clone();
    	}catch (Exception e) {
			System.out.println("CloneNotSupportedException");
			return null;
		}
    	
    };
    
    public Term toEquality(String variables) {
        
        Term teoTerm = this;
        if (teoTerm instanceof App && ((App)teoTerm).p instanceof App && 
            ((App)((App)teoTerm).p).p instanceof Const && 
            ( ((Const)((App)((App)teoTerm).p).p).getId()==1 ||
              ((Const)((App)((App)teoTerm).p).p).getId()==15
            )
           ) 
        {
            Term arg1, arg2;
            arg1 = ((App)((App)teoTerm).p).q;
            arg2 = ((App)teoTerm).q;
            String[] vars = (variables==null || variables.equals("")?new String[0]:variables.split(","));
            for (int i=vars.length-1; 0<=i; i--) {
                arg1 = new Bracket(new Var((int)vars[i].charAt(0)),arg1);
                arg2 = new Bracket(new Var((int)vars[i].charAt(0)),arg2);
            }
            teoTerm = new App(new App(new Const(0,"="),arg1),arg2);
        }
        else {
            Term arg2 = new Const(-1,"T");
            String[] vars = (variables==null || variables.equals("")?new String[0]:variables.split(","));
            for (int i=vars.length-1; 0<=i; i--) {
                teoTerm = new Bracket(new Var((int)vars[i].charAt(0)),teoTerm);
                arg2 = new Bracket(new Var((int)vars[i].charAt(0)),arg2);
            }
            teoTerm = new App(new App(new Const(0,"="), arg2), teoTerm);
        }
        return teoTerm;
    }
    
    public String getType(SimboloManager simboloManager) throws TypeVerificationException {
        HashMap<Integer, String> D = new HashMap<>();
        return getType(D, simboloManager);
    }
    
    //public abstract String getType(HashMap<Integer, String> D, SimboloManager simboloManager) throws TypeVerificationException;
    public String getType(HashMap<Integer, String> D, SimboloManager simboloManager) throws TypeVerificationException {
        System.out.println("getType not implemented for "+this);
        throw new TypeVerificationException();
    }
    
    public String checkType(HashMap<Integer, String> D, SimboloManager simboloManager, String expected) 
            throws TypeVerificationException {
        String type = this.getType(D, simboloManager);
        
        return Simbolo.matchTipo(type, expected);
    }
    
    public String getBoundVarsComma() {
        String s = this.getBoundVars();
        String boundVars = "";
        if (!s.equals("")) {
            int i = 0;
            while (i < s.length()) {
                char c = s.charAt(i);
                if (boundVars.equals(""))
                    boundVars = "" + c;
                else
                    boundVars += "," + c;
                i++;
            }
        }
        return boundVars;
    }
    
    public String getBoundVars() {
        if (this instanceof App) {
            App a = (App) this;
            return a.p.getBoundVars() + a.q.getBoundVars();
        }
        else if (this instanceof Bracket) {
            String boundVars = "";
            Term aux = this;
            while (aux instanceof Bracket) {
                Var var = ((Bracket) aux).x;
                boundVars += "" + ((char) ((Var) var).indice);
                aux = ((Bracket) aux).t;
            }
            return boundVars + aux.getBoundVars();
        }
        else {
            return "";
        }
    }
}
