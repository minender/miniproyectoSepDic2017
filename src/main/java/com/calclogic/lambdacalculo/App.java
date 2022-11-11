/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.lambdacalculo;

import com.calclogic.entity.Simbolo;
import com.calclogic.service.PredicadoManager;
import com.calclogic.service.SimboloManager;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Stack;
import java.util.List;
import java.util.Map;
import org.apache.commons.lang3.text.StrSubstitutor;
import com.calclogic.lambdacalculo.TypeVerificationException;

/**
 *
 * @author federico
 */
public class App extends Term{
    
    public Term p;
    public Term q;
    
    public App(Term p1,Term q1){
        p=p1;
        q=q1;
    }
    
    public boolean occur(Var x){
        return p.occur(x) || q.occur(x);
    }
    
    public String position(Var x){
        if (p.occur(x)) 
            return "1"+p.position(x);
        else if (q.occur(x)) 
            return "2"+q.position(x);
        else
            return "3";
    }
    
    @Override
    public Term subterm(String position) {
        if (position.equals(""))
            return this;
        else if (position.charAt(0) == '1')
            return p.subterm(position.substring(1));
        else if (position.charAt(0) == '2')
            return q.subterm(position.substring(1));
        else
            return null;
    }
    
    public Term sust(Var x,Term t){
        Term t2;
        try{
            t2=(Term)t.clone();
        }
        catch(CloneNotSupportedException e){   
            e.printStackTrace();
            return null;
        }
        return new App(p.sust(x, t),q.sust(x,t2));
    }
    
    public Term bracketAbsSH(Var x){
        boolean occup=p.occur(x);
        boolean occuq=q.occur(x);
        
        if(occup && occuq)
            return new App(new App(new Const("S"),p.bracketAbsSH(x)),q.bracketAbsSH(x));
        else if(occup && !occuq)
            return new App(new App(new Const("C"),p.bracketAbsSH(x)),q);
        else if(!occup && occuq)
            return new App(new App(new Const("B"),p),q.bracketAbsSH(x));
        else
            return new App(new Const("K"),this);
    }

    @Override
    public Term sustParall(List<Var> Vars, List<Term> varsTerm) {
        if (p instanceof Var) {
            Var var = null;
            int i= 0;
            for (Iterator<Var> it = Vars.iterator(); it.hasNext();) {
                var = it.next();
                if (p.occur(var)) 
                    break;
                i++;
            }
            if (p.occur(var) && (varsTerm.size() ==  Vars.size()) && 
                !varsTerm.get(i).occur(new Var('E')) && 
                !varsTerm.get(i).occur(new Var('f')) && 
                !varsTerm.get(i).occur(new Var('g')) &&
                !(varsTerm.get(i).esRedexFinal().t) && 
                !(varsTerm.get(i) instanceof Bracket)
               )
            {
                Term term = varsTerm.get(i);
                if (p.occur(new Var('E')))
                    return new App(new Bracket(new Var('z'),term), q.sustParall(Vars, varsTerm));
                else
                    return new App(new Bracket(new Var('x'),term), q.sustParall(Vars, varsTerm));
            }
            else
                return new App(p.sustParall(Vars, varsTerm), q.sustParall(Vars, varsTerm));
        }
        else
            return new App(p.sustParall(Vars, varsTerm), q.sustParall(Vars, varsTerm));
    }
    
    @Override
    public void freeVars(int[] set){
        p.freeVars(set);
        q.freeVars(set);
    }
    
    @Override
    public Term abstractEq() {
        String sVars = this.stFreeVars();
        if (sVars!=null) {
           q = q.abstractVars(sVars);
           ((App)p).q = ((App)p).q.abstractVars(sVars);
        }
        return this;
    }
    
    @Override
    public Term checkApp() {
        Term termP = p.checkApp();
        if ( q instanceof Sust){
            List<Var> varss = ((Sust) q).vars;
            List<Term> termss = ((Sust) q).terms;  
            //MakeTerm mk = new MakeTerm();
            Term termQ = termP.sustParall((ArrayList<Var>) varss , (ArrayList<Term>) termss);
            return termQ;
        }
        else{
            return new App(p.checkApp(),q.checkApp());
        }
    }

    
    private class Tripla{
        Indice i;
        Term r;
        Term resto;
        
        public Tripla(Indice ii,Term rr,Term rresto){
            i=ii;
            r=rr;
            resto=rresto;
        }
    }
    
    public Tripla rEi(Var x){
        boolean occup=p.occur(x);
        boolean occuq=q.occur(x);
        Indice i=null;
        Term r=null;
        Term resto=null;
        
        if(occup && !occuq){
            i=new ConstInd("c");
            r=q;
            if(p instanceof Bracket)//no debes borrarlo
                p=((Bracket)p).bracketAbsBD();
            resto=p;
        }
        else if(!occup && occuq){
            i=new ConstInd("b");
            r=p;
            if(q instanceof Bracket)//no debes borrarlo
                q=((Bracket)q).bracketAbsBD();
            resto=q;
        }
        else if(occup && occuq){
            i=new ParInd();
            r=p;
            resto=q;
        }
        
        return new Tripla(i,r,resto);
    }
    
    public Term bracketAbsBD(Var x){
        boolean occup=p.occur(x);
        boolean occuq=q.occur(x);
        
        if(!occup && !occuq)
            return new App(new Const("\\Phi_{K}"),this);
        else{
            Phi phi=new Phi();
            return bAbsBDIterat(x, phi.ind, phi, this/*,'n'*/);
        }
    }
    
    private Term bAbsBDIterat(Var x,ListaInd ind/*Phi phi*/,Term t0,Term t1/*,char c*/){
        Term exit;
        exit=t0;
        Indice i=null;
        Term r=null;
        Term resto=t1;
        Tripla t=null;
            
        while(resto instanceof App){
            //En la primera it al entrar en rEi estoy calculando denuevo occur
            t=((App)resto).rEi(x);
            /*if(c=='n')
                ((ListaInd)phi.ind).empilarIndice(t.i);//pudiera fallar porque
            else if(c=='i')
                ((ListaInd)phi.ind).empilarIndIzq(t.i);
            else if(c=='d')
                ((ListaInd)phi.ind).empilarIndDer(t.i);*/
                              
            if( !(t.i instanceof ParInd) ){
                ind.empilarIndice(t.i);
                exit=new App(exit,t.r);
                resto=t.resto;
            }
            else{
                /*exit=bAbsBDIterat(x, phi, exit, t.r,'i');
                exit=bAbsBDIterat(x, phi, exit, t.resto,'d');*/
                exit=bAbsBDIterat(x, ((ParInd)t.i).i1, exit, t.r/*,'i'*/);
                exit=bAbsBDIterat(x, ((ParInd)t.i).i2, exit, t.resto/*,'d'*/);
                ind.empilarParInd(t.i);
                resto=null;
            }
        }
        return exit;
    }
    
    public int maxVar(){
        return Math.max(p.maxVar(), q.maxVar());
    }
    
    public int fresh(int n)
    {
        return q.fresh(p.fresh(n));
    }
    
    public Term traducBD()
    {
        return new App(p.traducBD(),q.traducBD());
    }
    
    public List<Term> contandotraducBD(){
        List<Term> list1=p.contandotraducBD();
        for(int i=0; i<list1.size() ;i++)
            list1.set(i,new App(list1.get(i),q));
        
        Term p1;
        if( list1.size() == 0 )
            p1=p;
        else
            p1 = list1.get(list1.size()-1);
            
        List<Term> list2=q.contandotraducBD();
        for(int i=0; i<list2.size() ;i++)
            list2.set(i,new App(p1,list2.get(i)));
        
        list1.addAll(list2);
        
        return list1;
    }
    
    public Tipo esRedex(){
        Const k=new Const("\\Phi_{K}");
        AppIzq izq=obtenerIzq(this,-1);
        if(p instanceof Bracket)
            return new Tipo(false,true);
        else if((izq.p instanceof Phi) && izq.deep==((ListaInd)((Phi)izq.p).ind).orden+1)
            return new Tipo(true,false);
        else if(izq.p.equals(k) && izq.deep==2)
            return new Tipo(true,false);
        else
            return new Tipo(false,false);
    }
    
    public Tipo esRedexFinal(){
        Const k=new Const("\\Phi_{K}");
        AppIzq izq=obtenerIzq(this,-1);

        if(p instanceof Bracket)
            return new Tipo(false,true,false);
        else if((izq.p instanceof Phi) && izq.deep==((ListaInd)((Phi)izq.p).ind).orden+1)
            return new Tipo(true,false,false);
        else if(izq.p.equals(k) && izq.deep==2)
            return new Tipo(true,false,false);
        else if((izq.p instanceof Phi) && izq.deep==((ListaInd)((Phi)izq.p).ind).orden)
            return new Tipo(false,false,true);
        else if(izq.p.equals(k) && izq.deep==1)
            return new Tipo(false,false,true);
        else
            return new Tipo(false,false,false);
    }
    
    public Redex buscarRedexIzq(Term contexto,boolean pp){
        Tipo tipo=this.esRedexFinal();
        if(tipo.c || tipo.l || tipo.t){
            return new Redex(contexto,tipo,pp);
        }
        Redex r=p.buscarRedexIzq(this,true);
        if(r!=null)
            return r;
        else
            return q.buscarRedexIzq(this,false);
    }
    
    public Redex buscarRedexIzqFinal(Term contexto,boolean pp){
        Tipo tipo=this.esRedexFinal();
        if(tipo.c || tipo.l || tipo.t){
            return new Redex(contexto,tipo,pp);
        }
        Redex r=p.buscarRedexIzqFinal(this,true);
        if(r!=null)
            return r;
        else 
            return q.buscarRedexIzqFinal(this,false);
    }
    
    public Term invBraBD(int n)
    {
        Var xc=new Var(n);
        if(obtenerIzq(this,-1).p instanceof Phi){
            return new Bracket(xc, (new App(this,xc)).kappaIndexado(n,xc));
        }
        else
        {
            //Var x=new Var(this.maxVar()+1);
            return new Bracket(xc,(new App(this,xc)).kappaIndexado(n,xc));
        }
    }
    
    public Term invBD(){
        AppIzq izq=obtenerIzq(this,-1);
        if(izq.p instanceof Phi || (izq.p instanceof Const && ((Const)izq.p).con.equals("\\Phi_{K}"))){
            if(izq.p instanceof Phi && ((ListaInd)((Phi)izq.p).ind).orden == 0)
                return new App(izq.p.invBD(),izq.pq.q);
            AppIzq aux;
            if(izq.p instanceof Phi)
                aux=obtenerIzq(this,izq.deep-((ListaInd)((Phi)izq.p).ind).orden);
            else
                aux=obtenerIzq(this,izq.deep-1);
            if(aux.pqr == null)
                return this.invBraBD(0).invBD();
            else
            {
                aux.pqr.p=aux.pqr.p.invBraBD(0);
                return this.invBD();
            }
        }
        else{
            Term term = new App(p.invBD(),q.invBD());
            term.alias = this.alias;
            return term;
        }
    }
    
    public Term invBDOneStep(){
        Term izq=obtenerIzq(this,-1).p;
        if(izq instanceof Phi || izq instanceof Const)
            return this.invBraBD(0);
        else
            return new App(p.invBD(),q.invBD());
    }
    
    public Term sustitution(){
        if(p instanceof Bracket){
            return this;
        }
        else
            return this;
    }
    
    public int setAlias(int currentAlia){
        if (p.alias != null ){
            p.alias = p.alias+"@"+currentAlia;
            currentAlia++;
        }
        
        currentAlia = p.setAlias(currentAlia);
        
        if (q.alias != null){
            q.alias = q.alias+"@"+currentAlia;
            currentAlia++;
        }
        
        currentAlia = q.setAlias(currentAlia);
        return currentAlia;
    }
    
    public Term type(){
        return null;
    }
    
    public int nPhi()
    {
        return p.nPhi()+q.nPhi();
    }
    
    public boolean containTypedA()
    {
        return p.containTypedA() || q.containTypedA();
    }
 
    public boolean containT()
    {
        return p.containT() || q.containT();
    }
    
    public void getAxioms(List<String> l){
        p.getAxioms(l);
        q.getAxioms(l);
    }
    
    public Term leibniz(int z, String subtermId, String thisId){
        if (thisId.equals(subtermId))
            return new Var(z);
        else
            return new App(p.leibniz(z, subtermId, thisId+"1"),q.leibniz(z, subtermId, thisId+"2"));
    }
    
    /**
     * Returns a string formatted with variables codification (x_{}) and
     * constants codification (c_{}) with all possible parentheses (that could be
     * unnecesary, see toString method).
     */
    public String toStringAll(){
        String izq;
        String der;
        
        if(p.alias == null){
            if(p instanceof App)
                izq=p.toString();
            else
                izq=p.toStringAll();
        }
        else
            izq = p.alias.split("@")[0].replace("_", "\\_");
        
        if(q.alias == null)
            der=q.toStringAll();
        else
            der=q.alias.split("@")[0].replace("_","\\_");
        
        return "("+izq+" "+der+")";
    }
    
    private class IntXIntXString {
        public int x1;
        public int x2;
        public String x3;
        
        public IntXIntXString(int x, int y, String z) {
            x1 = x;
            x2 = y;
            x3 = z;
        }
    }

    /**
      * @param kind Type of string that we want to generate
      *     - 'S': simple
      *     - 'I': with inputs -> For the Substitution and Leibniz fields.
      *     - 'L': labeled -> For the last line of a proof.
      *     - 'A': abreviaton -> For aliases.
      * @param s
      * @param numTeo
      * @param position
      * @param rootId
      * @param z
      * @param t: The father of all the string that is going to be printed. We need to remember it in all recursive calls.
      * @param l
      * @param l2
      * @param id
      * @param nivel
      * @param tStr
      * @param pm
      * @return String representation in LaTeX Format.
      */
    private IntXIntXString privateToStringLaTeX(Character kind, SimboloManager s, String numTeo, String position, String appPosition, String rootId, int z, Term t, 
                                                List<Term> l, List<String> l2, Id id, int nivel, ToString tStr, PredicadoManager pm)
    {
        Boolean simpleOrAbrv = ('S' == kind || 'A' == kind);
        String setVar = ""; // Only used in the "labeled" case
        Stack<Term> stk = new Stack<>();
        Stack<String> stkS = new Stack<>();
        String appId = "";
        stk.push(q);
        Term aux = p;
        if ('L' == kind) {
           stkS.push(appPosition+"2");
           appId = appPosition+"1";
        }
        int j = 1;
        while ( aux instanceof App ){
            if ('L' == kind) {
               stkS.push(appId+"2");
               appId += "1";
            }
            stk.push(((App)aux).q);
            aux = ((App)aux).p;
            j++;
        }
        Simbolo sym = null;
        int opId;
        int nArgs;
        Const c = null;

        // This case of Var is not currently used in Symbolic Logic, only in Discrete Math to denote functions.
        // For example, the name "f" of a function could be a variable.
        if (aux instanceof Var) {
            //sym = new Simbolo(aux.toStringLaTeX(s,""), 1, false, 11, "%(op)(%(na1))", null);
            opId = -1;
            nArgs = 0; // This is to later enter in the case j > nArgs
        }
        else {
            c = (Const) aux;
            if (c.getId()==0) {
                sym = s.getSimbolo(1);
                opId = 1;
            }
            else {
                sym = s.getSimbolo(c.getId());
                opId = c.getId();
            }
            nArgs = sym.getArgumentos();
        }
        
        // This can only occur when what we read previously is a functional variable
        // ***** MISSING EXPLANATION
        if (j > nArgs) {
            App newTerm;
            if (simpleOrAbrv && p instanceof Var && p.occur(new Var('E'))) {
                sym = s.getSimbolo(s.getPropFunApp());
                newTerm = new App(new App(new Const(s.getPropFunApp(),"c_{"+s.getPropFunApp()+"}"),p),q);
            }
            else {
                sym = s.getSimbolo(s.getTermFunApp());
                newTerm = new App(new App(new Const(s.getTermFunApp(), "c_{"+s.getTermFunApp()+"}"),p),q);
            }
            if ('L' == kind){
                IntXIntXString result = newTerm.privateToStringLaTeX(kind,s,numTeo,position,appPosition,rootId,z,t,l,l2,id,nivel,tStr,pm);
                l.add(t.leibniz(z, appPosition, "")); //revisar ten cuidado
                return result;
            }
            return newTerm.privateToStringLaTeX(kind,s,numTeo,position,appPosition,rootId,z,t,l,l2,id,nivel,tStr,pm);
        }

        // This is to later replace the placeholders with StrSubstitutor
        Map<String,String> values = new HashMap<>();

        if ('I' == kind || (simpleOrAbrv && numTeo.equals("")) )
            values.put("op", sym.getNotacion_latex());
        else if ('L' == kind)
            values.put("op", "\\class{terminoClick}{"+sym.getNotacion_latex()+"}");
        else
            values.put("op", "\\cssId{click@"+numTeo+"}{\\class{operator}{\\style{cursor:pointer; color:#08c;}{"+sym.getNotacion_latex()+"}}}");

        String notation = sym.getNotacion();

        // CHECK This is only for Discrete Math
        // if (('A' == kind) && (j > nArgs))
        //     notation = "( "+notation+" )(%(na"+j+") )";

        int i = 1;
        while (!stk.empty()) {//int i=0; i < sym.getArgumentos(); i++)
            Term arg = stk.pop();
            if ('L' == kind) { appId = stkS.pop();}
            if (('A' == kind) && (arg.alias != null)){
                tStr.setNuevoAlias(arg.alias, arg, s, pm, numTeo);
                values.put("na"+i,tStr.term);
                values.put("a"+i,tStr.term);
                values.put("aa"+i,tStr.term);
            }
            else {
                if (c!=null && c.getId()==0) 
                    arg = arg.body();
                if (arg instanceof Bracket) {
                    Term aux_arg = arg;
                    int index = 1;
                    while (aux_arg instanceof Bracket) {
                        values.put("v"+index,((Bracket) aux_arg).x.toStringLaTeX(s, numTeo));
                        index++;
                        aux_arg = ((Bracket) aux_arg).t;
                    }
                }
                 
                if (notation.contains("%(na"+i+")")){
                    if ('A' == kind){
                        arg.toStringLaTeXAbrv(tStr,s,pm,"");
                        values.put("na"+i,tStr.term);
                    }
                    else{
                        values.put("na"+i,arg.toStringLaTeX(kind,s,"",position+i,appId,rootId,z,t,l,l2,id,nivel+1,tStr,pm));
                        if ('L' == kind){
                            setVar += l2.get(l2.size()-1);
                        }
                    }
                }
                else {
                    Boolean alwaysParentheses = notation.contains("%(a"+i+")");
                    Boolean conditionalParentheses = notation.contains("%(aa"+i+")");

                    if (alwaysParentheses || conditionalParentheses){
                        String prefix = alwaysParentheses ? "a" : "aa";

                        if (arg instanceof App){
                            IntXIntXString tuple = ((App) arg).privateToStringLaTeX(kind,s,"",position+i,appId,rootId,z,t,l,l2,id,nivel+1,tStr,pm);
                            String parenthesizedTuple = ('L' == kind) ? addParentheses(tuple.x3) : ("("+tuple.x3+")");

                            if ( (tuple.x1 == 25) && (opId == 21 || opId == 22 || opId == 23))
                                values.put(prefix + i, parenthesizedTuple);       
                            else
                                values.put(prefix + i, (tuple.x2 > sym.getPr() || (conditionalParentheses && tuple.x1==opId)) ? tuple.x3 : parenthesizedTuple);
                        }
                        else
                            values.put(prefix + i,arg.toStringLaTeX(kind, s,"",position+i,appId,rootId,z,t,l,l2,id,nivel+1,tStr,pm));

                        if ('L' == kind)
                            setVar += l2.get(l2.size()-1);
                    }
                }
            }
            i++;
        }
        
        StrSubstitutor sub = new StrSubstitutor(values, "%(",")");
        notation = ('I' == kind) ? ("\\ {"+notation+"}\\ ") : 
                    (('L' == kind) ? ("\\class{"+nivel+"}{"+notation+"}") : notation);
        String term = sub.replace(notation);

        if ('L' == kind){
            term = "\\cssId{"+id.id+"}{"+term+"}";
            
            l2.add(l2.size(),setVar+id.id+",");
            //l.add(t.leibniz(z, this).toStringFormatC(s,"",0).replace("\\", "\\\\"));
            //l2.add(t.leibniz(z, this).toStringWithInputs(s,"").replace("\\", "\\\\"));
            if (opId != s.getPropFunApp() && opId != s.getTermFunApp()){
                l.add(t.leibniz(z, appPosition, ""));
            }
            id.id++;       
        }
        else if ('A' == kind){
            tStr.term = term;
        }
        return new IntXIntXString(sym.getId(),sym.getPr(),term);
    }

    @Override
    public String toStringLaTeX(char kind, SimboloManager s, String numTeo, String position, String appPosition, String rootId, int z, Term t, 
                                                List<Term> l, List<String> l2, Id id, int nivel, ToString tStr, PredicadoManager pm)
    {
        return privateToStringLaTeX(kind,s,numTeo,position,appPosition,rootId,z,t,l,l2,id,nivel,tStr,pm).x3;
    }

    /**
     * Uses the symbols notation stored in the database to compute
     * the LaTeX format string.
     * @param s
     * @param numTeo
     * @return String representation in LaTeX Format.
     */
    public String toStringLaTeX(SimboloManager s, String numTeo){
        if (p instanceof App && ((App)p).p instanceof Const && ((Const)((App)p).p).getId()==0 
            && ((App)p).q.containT() )
            return q.toStringLaTeX(s,numTeo);
        else
            return privateToStringLaTeX('S',s,numTeo,"","",null,0,null,null,null,null,0,null,null).x3;
    }

    /**
     * Similar toStringLaTeX, but puts an HTML input in variables formulas
     * to be used in the sustitution.
     * @param s
     * @param position
     * @param rootId
     * @return String representation with HTML inputs.
     */
    public String toStringLaTeXWithInputs(SimboloManager s, String position, String rootId){
        if (p instanceof App && ((App)p).p instanceof Const && ((Const)((App)p).p).getId()==0 
            && ((App)p).q.containT() )
            return q.toStringLaTeXWithInputs(s, position, rootId);
        else
            return privateToStringLaTeX('I',s,null,position,"",rootId,0,null,null,null,null,0,null,null).x3;
    }

    /**
     * Creates a LaTeX string with the span HTML tags use to control the subexpresions
     * used for leibniz rule in the client.
     * @param s
     * @param z
     * @param t
     * @param l1: List of all possible Leibniz
     * @param l2
     * @param id
     * @param nivel
     * @return String representation in LaTeX format with span HTML tags for Mathjax.
     */
    @Override
    public String toStringLaTeXLabeled(SimboloManager s,int z, Term t, String appPosition, List<Term> l1, List<String> l2, Id id, int nivel){
        if (p instanceof App && ((App)p).p instanceof Const && ((Const)((App)p).p).getId()==0 
            && ((App)p).q.containT() )
            return q.toStringLaTeXLabeled(s, z, t, appPosition, l1, l2, id, nivel);
        else{
            return privateToStringLaTeX('L',s,null,"",appPosition,null,z,t,l1,l2,id,nivel,null,null).x3;
        }
    }

    @Override
    public ToString toStringLaTeXAbrv(ToString toString, SimboloManager s, PredicadoManager pm, String numTeo){
        if (p instanceof App && ((App)p).p instanceof Const && ((Const)((App)p).p).getId()==0 
            && ((App)p).q.containT() )
            q.toStringLaTeXAbrv(toString, s, pm, numTeo);
        else
            privateToStringLaTeX('A',s,numTeo,"","",null,0,null,null,null,null,0,toString,pm);
        return toString;
    } 
    
    /**
     * Creates a non curryfied format that doesn't allow wrong syntax formulas.
     * @param s
     * @param pos
     * @param id
     * @param rootId
     * @return String representation with non curryfied format.
     */
    @Override
    public String toStringFormatC(SimboloManager s, String pos, int id, String rootId) {
        
        if (p instanceof App && ((App)p).p instanceof Const && ((Const)((App)p).p).getId()==0 
            && ((App)p).q.containT() )
            return q.toStringFormatC(s, pos, id, rootId);
        
        Stack<Term> stk = new Stack<Term>();
        String term;
        stk.push(q);
        Term aux = p;
        int j = 1;
        while ( aux instanceof App ){
           stk.push(((App)aux).q);
           aux = ((App)aux).p;
           j++;
        }
        int nArgs;
        if (aux instanceof Var) {
            if (aux.occur(new Var('E')))
                id = s.getPropFunApp();
            else
                id = s.getTermFunApp();
            nArgs = 0;
        }
        else {
            Const c = (Const) aux;
            Simbolo sym = s.getSimbolo(c.getId());
            id = sym.getId();
            nArgs = sym.getArgumentos();
        }
        if ( j > nArgs) {
            Simbolo sym;
            App newTerm;
            if (false) { //p instanceof Var && p.occur(new Var('E'))) {
                sym = s.getSimbolo(s.getPropFunApp());
                newTerm = new App(new App(new Const(s.getPropFunApp(),s.propFunAppSym(),!sym.isEsInfijo(),sym.getPrecedencia(),sym.getAsociatividad()),p),q);
            }
            else {
                sym = s.getSimbolo(s.getTermFunApp());
                newTerm = new App(new App(new Const(s.getTermFunApp(),s.termFunAppSym(),!sym.isEsInfijo(),sym.getPrecedencia(),sym.getAsociatividad()),p),q);
            }
            return newTerm.toStringFormatC(s, pos, id, rootId);
        }
        /*if (id == 29)
            term = "C"+id+"("+aux.toStringFormatC(s,pos+1,29);
        else*/
        term = "C"+id;
        int i=1;
        while (!stk.empty()) {
            Term arg = stk.pop();
            /*if (i > nArgs)
             term = "C29("+term+"),"+arg.toStringFormatC(s,pos+i,0);
            else*/
            term += (i == 1/* && id != 29*/?"(":",")+arg.toStringFormatC(s,pos+i,id,rootId);
            i++;
        }
        System.out.println("Ya lo que voy a retornar es: "+term+")");
        return term+")";
    }
    
    public ToString toStringAbrv(ToString toString){
        String izq;
        String der;
        
        if(p.alias == null){
            if(p instanceof App)
                p.toStringAbrvFinal(toString);
            else
                p.toStringAbrv(toString);
            izq = toString.term;
        }
        else{
            toString.setNuevoAlias(p.alias, p);
            izq = toString.term;
        }
        
        if(q.alias == null){
            q.toStringAbrv(toString);
            der = toString.term;
        }
        else{
            toString.setNuevoAlias(q.alias, q);
            der = toString.term;
        }
        toString.term="("+izq+der+")";
        return toString;
    }
    
    public ToString toStringAbrvV1(ToString toString){   
        String izq;
        String der;
        
        if(p.alias == null){
            if(p instanceof App)
                p.toStringAbrvFinalV1(toString);
            else
                p.toStringAbrvV1(toString);
            
            izq = toString.term;
        }
        else{
            toString.setNuevoAliasV1(p.alias, p);
            izq = toString.term;
        }
        
        if(q.alias == null){
            q.toStringAbrvV1(toString);
            der = toString.term;
        }
        else{
            toString.setNuevoAliasV1(q.alias, q);
            der = toString.term;
        }
        
        toString.term="("+izq+der+")";
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
        final App other = (App) obj;
        if (this.p != other.p && (this.p == null || !this.p.equals(other.p))) {
            return false;
        }
        if (this.q != other.q && (this.q == null || !this.q.equals(other.q))) {
            return false;
        }
        return true;
    }

    @Override
    protected Object clone() throws CloneNotSupportedException {
        Term ter= new App((Term)p.clone(),(Term)q.clone());
        ter.alias=this.alias;
        return ter;
    }

    @Override
    public String aliases(String position) {
            // Get aliases from childred
            String aliases1 = p.aliases(position.concat("1"));
            String aliases2 = q.aliases(position.concat("2"));


            // Check if we have an alias right now and create a proper format string if so
            String currentAlias = "";
            if( this.alias != null) {
                    currentAlias = this.alias + ':' + position;	
                    if(!aliases1.equals("") || !aliases2.equals("") ) {
                            currentAlias = ", " + currentAlias;
                    }
            }

            // Check if we actually need a comma between alias1 and alias2
            String commaString = ", ";
            if( aliases1.equals("") || aliases2.equals("")) {
                    commaString = "";
            }

            // Return formated string
            return aliases1 + commaString + aliases2 + currentAlias;
    }
        
    @Override
    public String getType(HashMap<Integer, String> D, SimboloManager simboloManager) throws TypeVerificationException {
        String type_p = p.getType(D, simboloManager);
        String[] type_p_split = type_p.split("->"); // cambiar por un parser
        String param_type = type_p_split[0];
        String type_q;
        if (q instanceof Var) {
            Var qvar = (Var) q;
            if (!D.containsKey(qvar.indice)) {
                type_q = param_type;
                D.put(qvar.indice, param_type);
            }
            else {
                type_q = D.get(qvar.indice);
                if (type_q.equals("*") && !param_type.equals("*")) {
                    D.put(qvar.indice, param_type);
                }
            }
        }
        else {
            type_q = q.getType(D, simboloManager);
        }
        if (!type_q.equals(param_type) && !param_type.equals("*")) {
            throw new TypeVerificationException();
        }
        return type_p.substring(param_type.length()+2);
    }
}