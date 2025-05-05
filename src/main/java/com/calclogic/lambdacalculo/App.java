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
import java.util.Collections;
import java.util.HashSet;
import java.util.logging.Level;
import java.util.logging.Logger;

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
        if (p1 instanceof Var || q1 instanceof Var || p1.type() == null || q1.type() == null)
            type_ = null;
        else {
            //System.out.println(p1);
            //System.out.println(q1);
            if (p1 instanceof Const && ((Const)p1).id == 62) {
                p1.type_ = p1.type_.sust(new Var(1), new Var(Phi.stInd));
                Phi.stInd++;
            }
            Term pType = p1.type();
            if (q1 instanceof Const && ((Const)q1).id == 62) {
                q1.type_ = q1.type_.sust(new Var(1), new Var(Phi.stInd));
                Phi.stInd++;
            }
            Term qType = q1.type();
            Sust s = new Equation(((App)pType).q, qType).mgu(/*null,*/ true);
            if (s != null) 
                type_ = ((App)((App)pType).p).q.sustParall(s);
            else if ( ((App)pType).q.equals(qType) ) 
                type_ = ((App)((App)pType).p).q;
            else
                type_ = null;
            if (p instanceof App && ((App)p).p instanceof Const && ((Const)((App)p).p).id==0) {
                s = new Equation(qType,((App)p).q.type()).mgu(/*null,*/ true);
                q.setType(s!=null?qType.sustParall(s):qType);
            }
        }
    }
    
    public App(Term p1,Term q1,boolean computeType){
        p=p1;
        q=q1;
        if (computeType) {
            if (p1 instanceof Var || q1 instanceof Var || p1.type() == null || q1.type() == null)
                type_ = null;
            else {
                Term pType = p1.type();
                Term qType = q1.type();

                Sust s = new Equation(((App)pType).q, qType).mgu(/*null,*/ true);
                if (s != null)
                    type_ = ((App)((App)pType).p).q.sustParall(s);
                else if ( ((App)pType).q.equals(qType) ) 
                    type_ = ((App)((App)pType).p).q;
                else
                    type_ = null;
            }
        }
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
        Term t2 = t;
        if (!(t instanceof Var || t instanceof Const)) {
           try{
              t2=(Term)t.clone();
           }
           catch(CloneNotSupportedException e){   
              e.printStackTrace();
              return null;
           }
        }
        return new App(p.sust(x, t),q.sust(x,t2));
    }
    
    public Term sustWithoutClone(Var x,Term t) {
        return new App(p.sustWithoutClone(x, t),q.sustWithoutClone(x,t));
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
                !varsTerm.get(i).occur(new Var('P')) && 
                !varsTerm.get(i).occur(new Var('Q')) &&
                !(varsTerm.get(i).esRedexFinal().t) //&& 
                //!(varsTerm.get(i) instanceof Bracket)
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
    public Term inverseVars() {
        return new App(p.inverseVars(),q.inverseVars());
    }
    
    @Override
    public void freeVars(int[] set){
        p.freeVars(set);
        q.freeVars(set);
    }
    
    @Override
    public void freeVars(int[] set, int[] visitNum){
        p.freeVars(set, visitNum);
        q.freeVars(set, visitNum);
    }
    
    @Override
    public String stFreeVarsWithAnyIndex(String st) {
        st = p.stFreeVarsWithAnyIndex(st);
        return q.stFreeVarsWithAnyIndex(st);
    }
    
    @Override
    public void boundVars(String[] vars) {
        p.boundVars(vars);
        q.boundVars(vars);
    }
    
    @Override
    public Term replaceConstByVars() {
        return new App(p.replaceConstByVars(),q.replaceConstByVars());
    }
    
    @Override
    public Term abstractEq(Term[] varTypes) {
        String sVars = this.stFreeVars();
        if (sVars!=null) {
           q = q.abstractVars(sVars,varTypes);
           ((App)p).q = ((App)p).q.abstractVars(sVars,varTypes);
           if (((App)p).p.type_ != null) {
              ((App)((App)p).p.type_).q = ((App)p).q.type_;
              ((App)((App)((App)((App)p).p.type_).p).q).q = q.type_;
           }
        }
        return this;
    }
    
    public Term abstractEqAnyIndex(String vars) {
        if (!vars.equals("")) {
           q = q.abstractVarsAnyIndex(vars);
           ((App)p).q = ((App)p).q.abstractVarsAnyIndex(vars);
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
    
    public int fresh(int n, int[] max)
    {
        int i = p.fresh(n,max);
        int j = q.fresh(n,max);
        if (i == n && j == n)
            return n;
        else
            return max[0]+1;
        //return q.fresh(p.fresh(n));
    }
    
    public int absoluteFresh(int n, int[] max)
    {
        int i = p.absoluteFresh(n,max);
        int j = q.absoluteFresh(n,max);
        if (i == n && j == n)
            return n;
        else
            return max[0]+1;
        //return q.fresh(p.fresh(n));
    }
    
    public Term traducBD()
    {
        return new App(p.traducBD(),q.traducBD());
    }
    
    public Term traducBD(List<String> l)
    {
        return new App(p.traducBD(l),q.traducBD(l));
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
    
    public Term deleteLambdAtZScope(Var z) {
        Term p1, q1;
        p1 = p;
        q1 = q;
        if (p.occur(z))
            p1 = p.deleteLambdAtZScope(z);
        else if (q.occur(z))
            q1 = q.deleteLambdAtZScope(z);
        
        return new App(p1,q1);
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
    
    public Term invBraBD(Var x)
    {
        Var xc=x;//new Var(n);
        int[] max = new int[1];
        if(obtenerIzq(this,-1).p instanceof Phi){
            Term exit = new Bracket(xc, (new App(this,xc)).kappaIndexado(xc.indice,xc,max));
            exit.type_ = this.type_;
            return exit;
        }
        else
        {
            //Var x=new Var(this.maxVar()+1);
            Term exit = new Bracket(xc,(new App(this,xc)).kappaIndexado(xc.indice,xc,max));
            exit.type_ = this.type_;
            return exit;
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
                return this.invBraBD(new Var(0)).invBD();
            else
            {
                aux.pqr.p=aux.pqr.p.invBraBD(new Var(0));
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
            return this.invBraBD(new Var(0));
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
        return type_;
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
    
    public Term leibniz(int z, String subtermId, String thisId, SimboloManager s){
        App newTerm = (App) this.toFunApp(s);
        if (thisId.equals(subtermId))
            return new Var(z);
        else
            return new App(newTerm.p.leibniz(z, subtermId, thisId+"1", s), newTerm.q.leibniz(z, subtermId, thisId+"2", s));
    }
    
    @Override
    public Term etaReduc() {
        return this;
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
      *     - 'A': abbreviation -> For aliases.
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
    private IntXIntXString privateToStringLaTeX(Character kind, SimboloManager s, String numTeo, List<Simbolo> transOp, String position, String appPosition, String rootId, int z, Term t, 
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
                //HashMap<Integer, String> D = new HashMap<>();
                String tipo;
                /*try {
                    String t1 = stk.get(0).getType(D, s);
                    String t2 = stk.get(1).getType(D, s);
                    String t3 = Simbolo.matchTipo(t1, t2);
                    String[] tipo_split = Simbolo.splitTipo(t3);
                    tipo = tipo_split[tipo_split.length-1];
                } catch (TypeVerificationException ex) {
                    tipo = "*";
                    Logger.getLogger(App.class.getName()).log(Level.SEVERE, null, ex);
                }*/
                tipo = resultType(stk.get(0).type());
                if (tipo.equals("p")) {
                    sym = s.getSimbolo(1);
                    opId = 1;
                }
                else {
                    // poner aqui el id de la igualdad
                    sym = s.getSimbolo(15);
                    opId = 15;
                }
                nArgs = 2;
            }
            else {
                sym = s.getSimbolo(c.getId());
                opId = c.getId();
                nArgs = sym.getArgumentos();
                if (opId==62 &&//nArgs == 2 && 
                    stk.get(stk.size()-2) instanceof Bracket && stk.get(stk.size()-3) instanceof Bracket && 
                    ((Bracket)stk.get(stk.size()-2)).x.indice != ((Bracket)stk.get(stk.size()-3)).x.indice 
                   ) 
                {
                 int quantOp = ((Const)stk.get(stk.size()-1)).id;
                 int boundVId = ((Bracket)stk.get(stk.size()-3)).x.indice;
                 if ((quantOp==4 || quantOp==5) && ((Bracket)stk.get(stk.size()-2)).t instanceof Const 
                      && ((Const)((Bracket)stk.get(stk.size()-2)).t).id == 8)
                     ((Bracket)stk.get(stk.size()-2)).x.indice = boundVId;
                  else {
                    int[] max = new int[1];
                    if (((Bracket)stk.get(stk.size()-2)).t.absoluteFresh(boundVId,max) != boundVId || 
                      ((Bracket)stk.get(stk.size()-3)).t.absoluteFresh(boundVId,max) != boundVId
                     )
                      boundVId = max[0]+1;
                    //boundVId = new App(((Bracket)stk.get(stk.size()-2)).t,((Bracket)stk.get(stk.size()-3)).t).fresh(boundVId,new int[1]);
                    // this change the id of all occurrences of x, because x would be a pointer
                    ((Bracket)stk.get(stk.size()-2)).x.indice = boundVId;
                    ((Bracket)stk.get(stk.size()-3)).x.indice = boundVId;
                  }
                }
            }
        }
        
        // This can only occur when what we read previously is a functional variable
        // ***** MISSING EXPLANATION
        if (j > nArgs) {
            App newTerm;
            if ( p instanceof Var ){//&& p.occur(new Var('E'))) {

                  sym = s.getSimbolo(s.getPropFunApp());
                  newTerm = new App(new App(new Const(s.getPropFunApp(),"c_{"+s.getPropFunApp()+"}"),p),q);
            }
            else {
                if ( !(p instanceof App && ((App)p).p instanceof Var && ((Var)((App)p).p).indice == 115) ) {
                   sym = s.getSimbolo(s.getTermFunApp());
                   newTerm = new App(new App(new Const(s.getTermFunApp(), "c_{"+s.getTermFunApp()+"}"),p),q);
                }
                else {
                   sym = s.getVarBinaryOp();
                   newTerm = new App(new App(new Const(13,"c_{13}"),((App)p).q),q);
                }
            }
            if ('L' == kind){
                IntXIntXString result = newTerm.privateToStringLaTeX(kind,s,numTeo,transOp,position,appPosition,rootId,z,t,l,l2,id,nivel,tStr,pm);
                l.add(t.leibniz(z, appPosition, "", s)); //revisar ten cuidado
                return result;
            }
            return newTerm.privateToStringLaTeX(kind,s,numTeo,transOp,position,appPosition,rootId,z,t,l,l2,id,nivel,tStr,pm);
        }

        // This is to later replace the placeholders with StrSubstitutor
        Map<String,String> values = new HashMap<>();
        if ('I' == kind || 
              (simpleOrAbrv &&      
                (numTeo.equals("") || c.getId()!=0 && (transOp==null || !transOp.contains(sym)))
              ) 
           )
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
                tStr.setNuevoAlias(arg.alias, arg, s, pm, numTeo, transOp);
                values.put("na"+i,tStr.term);
                values.put("a"+i,tStr.term);
                values.put("aa"+i,tStr.term);
                values.put("ea"+i,tStr.term);
            }
            else {
                if (c!=null && c.getId()==0) 
                    arg = arg.body();
                if (arg instanceof Bracket) {
                    Term aux_arg = arg;
                    int index = 1;
                    while (aux_arg instanceof Bracket) {
                        if (kind != 'I')
                            values.put("v"+index,((Bracket) aux_arg).x.toStringLaTeX(s, numTeo, transOp));
                        else
                            values.put("v"+index,((Bracket) aux_arg).x.toStringLaTeX(kind,s,"",null,position+"-"+(index+nArgs),appId,rootId,z,t,l,l2,id,nivel+1,tStr,pm));
                        index++;
                        aux_arg = ((Bracket) aux_arg).t;
                    }
                }
                 
                if (notation.contains("%(na"+i+")")){
                    if ('A' == kind){
                        if (sym.getId() == 62 && i==2 && arg.body() instanceof Const && 
                              ((Const)arg.body()).getId()==8 
                           )
                           (new Const(0,"~")).toStringLaTeXAbrv(tStr,s,pm,"",null);
                        else
                           arg.toStringLaTeXAbrv(tStr,s,pm,"",null);
                        values.put("na"+i,tStr.term);
                    }
                    else{
                        if (kind != 'I' && sym.getId() == 62 && i==2 && arg.body() instanceof Const &&
                              ((Const)arg.body()).getId()==8 
                           )
                           values.put("na"+i,(new Const(0,"~")).toStringLaTeX(kind,s,"",null,position+"-"+i,appId,rootId,z,t,l,l2,id,nivel+1,tStr,pm));
                        else
                           values.put("na"+i,arg.toStringLaTeX(kind,s,"",null,position+"-"+i,appId,rootId,z,t,l,l2,id,nivel+1,tStr,pm));
                        if ('L' == kind){
                            setVar += l2.get(l2.size()-1);
                        }
                    }
                }
                else if (notation.contains("%(ea"+i+")")){
                    String etaSt;
                    if (kind == 'I') {
                       etaSt = arg.toStringLaTeX(kind,s,"",null,position+"-"+i,appId,rootId,z,t,l,l2,id,nivel+1,tStr,pm);
                    }else {
                       Term etaR = arg.etaReduc();
                       if (etaR instanceof Const && ((Const)etaR).id == 4)
                         etaSt = "\\exists";
                       else if (etaR instanceof Const && ((Const)etaR).id == 5)
                         etaSt = "\\forall";
                       else
                         etaSt = etaR.toStringLaTeX(kind,s,"",null,position+"-"+i,appId,rootId,z,t,l,l2,id,nivel+1,tStr,pm);
                    }
                       
                    values.put("ea"+i,etaSt);
                }
                else {
                    Boolean alwaysParentheses = notation.contains("%(a"+i+")");
                    Boolean conditionalParentheses = notation.contains("%(aa"+i+")");

                    if (alwaysParentheses || conditionalParentheses){
                        String prefix = alwaysParentheses ? "a" : "aa";

                        if (arg instanceof App){
                            IntXIntXString tuple = ((App) arg).privateToStringLaTeX(kind,s,"",null,position+"-"+i,appId,rootId,z,t,l,l2,id,nivel+1,tStr,pm);
                            String parenthesizedTuple = ('L' == kind) ? addParentheses(tuple.x3) : ("("+tuple.x3+")");

                            if ( (tuple.x1 == 25) && (opId == 21 || opId == 22 || opId == 23))
                                values.put(prefix + i, parenthesizedTuple);       
                            else
                                values.put(prefix + i, (tuple.x2 > sym.getPr() || (conditionalParentheses && tuple.x1==opId)) ? tuple.x3 : parenthesizedTuple);
                        }
                        else
                            values.put(prefix + i,arg.toStringLaTeX(kind, s,"",null,position+"-"+i,appId,rootId,z,t,l,l2,id,nivel+1,tStr,pm));

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
                l.add(t.leibniz(z, appPosition, "", s));
            }
            id.id++;
        }
        else if ('A' == kind){
            tStr.term = term;
        }
        return new IntXIntXString(sym.getId(),sym.getPr(),term);
    }

    @Override
    public String toStringLaTeX(char kind, SimboloManager s, String numTeo, List<Simbolo> transOp, String position, String appPosition, String rootId, int z, Term t, 
                                                List<Term> l, List<String> l2, Id id, int nivel, ToString tStr, PredicadoManager pm)
    {
        return privateToStringLaTeX(kind,s,numTeo,transOp,position,appPosition,rootId,z,t,l,l2,id,nivel,tStr,pm).x3;
    }

    /**
     * Uses the symbols notation stored in the database to compute
     * the LaTeX format string.
     * @param s
     * @param numTeo
     * @return String representation in LaTeX Format.
     */
    public String toStringLaTeX(SimboloManager s, String numTeo, List<Simbolo> transOp){
        if (p instanceof App && ((App)p).p instanceof Const && ((Const)((App)p).p).getId()==0 
            && ((App)p).q.containT() ) {
            if (transOp == null)
               return q.toStringLaTeX(s,numTeo,transOp);
            else
               return q.body().toStringLaTeX(s,numTeo,transOp);
        } else
            return privateToStringLaTeX('S',s,numTeo,transOp,"","",null,0,null,null,null,null,0,null,null).x3;
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
            return privateToStringLaTeX('I',s,null,null,position,"",rootId,0,null,null,null,null,0,null,null).x3;
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
            return privateToStringLaTeX('L',s,null,null,"",appPosition,null,z,t,l1,l2,id,nivel,null,null).x3;
        }
    }

    @Override
    public ToString toStringLaTeXAbrv(ToString toString, SimboloManager s, PredicadoManager pm, String numTeo, List<Simbolo> transOp){
        if (p instanceof App && ((App)p).p instanceof Const && ((Const)((App)p).p).getId()==0 
            && ((App)p).q.containT() )
            q.toStringLaTeXAbrv(toString, s, pm, numTeo, transOp);
        else
            privateToStringLaTeX('A',s,numTeo,transOp,"","",null,0,null,null,null,null,0,toString,pm);
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
        
        int eaArgument = -1;
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
        boolean isQuantifier;
        if (aux instanceof Var) {
            if (aux.occur(new Var('E')))
                id = s.getPropFunApp();
            else
                id = s.getTermFunApp();
            nArgs = 0;
            isQuantifier = false;
        }
        else {
            Const c = (Const) aux;
            Simbolo sym;
            if (c.getId() != 0)
                sym = s.getSimbolo(c.getId());
            else
                sym = s.getSimbolo(1);
            id = sym.getId();
            nArgs = sym.getArgumentos();
            isQuantifier = sym.isQuantifier();
            if (isQuantifier) {
                String[] splitArray = sym.getNotacion().split(".*%[(]ea");
                if (splitArray.length > 1)
                  eaArgument = Integer.parseInt(splitArray[1].split("[)]")[0]);
            }
        }
        if ( j > nArgs) {
            Simbolo sym;
            App newTerm;
            if (p instanceof Var){// && p.occur(new Var('E'))) {
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
        List<Var> boundVars = null;
        while (!stk.empty()) {
            Term arg = stk.pop();
            if (i!=eaArgument && arg instanceof Bracket && isQuantifier && boundVars == null) {
                boundVars = new ArrayList<Var>();
                Term aux_arg = arg;
                while (aux_arg instanceof Bracket) {
                    Bracket br = (Bracket) aux_arg;
                    boundVars.add(br.x);
                    aux_arg = br.t;
                }
            }
            /*if (i > nArgs)
             term = "C29("+term+"),"+arg.toStringFormatC(s,pos+i,0);
            else*/
            term += (i == 1/* && id != 29*/?"(":",")+arg.toStringFormatC(s,pos+"-"+i,id,rootId);
            i++;
        }
        if (boundVars != null) {
            for(Var v: boundVars) {
                term += (i == 1 ? "(" : ",") + v.toStringFormatC(s,pos+"-"+i,id,rootId);
                i++;
            }
        }
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
    
    public String toStringType(String v) {
        String st = v+"(";
        int boundV = 23;
        st = st+q.toStringType((char)(97+boundV)+"");
        Term aux = ((App)p).q;
        int i =1;
        while ( aux instanceof App ) {
            st = st+((App)aux).q.toStringType((char)(97+((boundV+i)%26) )+"");
            aux = ((App)((App)aux).p).q;
        }
        return st+")";
    }
    
    public String printType() {
        String opst = ((App)p).p.printType();
        String agr1st = q.printType();
        if (q instanceof App)
            agr1st = "("+agr1st+")";
        String arg2st = ((App)p).q.printType();
        return agr1st+" "+opst+" "+arg2st;
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
        boolean isQuant = false;
        List<Integer> boundVars = null;
        Term aux = this;
        Term abs = this.q;
        List<Term> args = new ArrayList<>();
        while (aux instanceof App) {
            args.add(((App)aux).q);
            aux = ((App)aux).p;
        } 
        Collections.reverse(args);
        String type_c;
        int cid;
        if (aux instanceof Const) {
            Const c = (Const) aux;
            type_c = c.getType(D, simboloManager);
            cid = c.getId();
            if (cid > 0) {
                isQuant = simboloManager.getSimbolo(cid).isQuantifier();
            }
        }
        else {
            cid = -1;
            type_c = "*";
            for (Term arg: args) {
                type_c = type_c + "->*";
            }
            type_c = aux.checkType(D, simboloManager, type_c);
        }
        if (isQuant) { 
            boundVars = new ArrayList<>();
            while (abs instanceof Bracket) {
                boundVars.add(((Bracket) abs).x.indice);
                abs = ((Bracket) abs).t;
            }
        }
        
        HashMap<Integer, String> D2;
        if (isQuant) {
            D2 = new HashMap<>();
            D2.putAll(D);
            for (Integer v: boundVars) {
                D2.remove(v);
            }
        }
        else {
            D2 = D;
        }
        
        String[] type_c_split = Simbolo.splitTipo(type_c);
        
        if (type_c_split.length-1 != args.size()) {
            System.out.println("La aridad esperada del simbolo: "+type_c+" no coincide con la expresion: "+this);
            throw new TypeVerificationException();
        }
        
        if (cid == 0) {
            String t1 = args.get(0).getType(D2, simboloManager);
            String t2 = args.get(1).getType(D2, simboloManager);
            Simbolo.matchTipo(t1, t2);
        }
        else {
            int i = 0;
            for (Term arg: args) {
                String param_type = type_c_split[i];
                arg.checkType(D2, simboloManager, param_type);
                i++;
            }
        }
        
        if (isQuant) {
            for (Integer v: boundVars) {
                D2.remove(v);
            }
            D.putAll(D2);
        }
        
        return type_c_split[type_c_split.length-1];
    }
    
    private Term toFunApp(SimboloManager s) {
        Term aux = this;
        while (aux instanceof App) {
            aux = ((App) aux).p;
        }
        if (aux instanceof Const)
            return this;
        else if ( p instanceof Var ){
                return new App(new App(new Const(s.getPropFunApp(),"c_{"+s.getPropFunApp()+"}"),p),q);
        }
        else {
            return new App(new App(new Const(s.getTermFunApp(), "c_{"+s.getTermFunApp()+"}"),p),q);
        }
    }
}