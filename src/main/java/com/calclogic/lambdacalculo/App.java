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

/**
 *
 * @author federico
 */
public class App extends Term{
    
    public Term p;
    public Term q;
    
    public App(Term p1,Term q1)
    {
        p=p1;
        q=q1;
    }
    
    public boolean occur(Var x)
    {
        return p.occur(x) || q.occur(x);
    }
    
    public String position(Var x)
    {
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
    
    public Term sust(Var x,Term t)
    {
        Term t2;
        try{
            t2=(Term)t.clone();
        }
        catch(CloneNotSupportedException e)
        {   
            e.printStackTrace();
            return null;
        }
        return new App(p.sust(x, t),q.sust(x,t2));
    }
    
    public Term bracketAbsSH(Var x)
    {
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
    public Term checkApp() {
         
         Term termP = p.checkApp();
         if ( q instanceof Sust){
                 List<Var> varss = ((Sust) q).vars;
                 List<Term> termss = ((Sust) q).terms;  
                 //MakeTerm mk = new MakeTerm();
                 Term termQ = termP.sustParall((ArrayList<Var>) varss , (ArrayList<Term>) termss);
                 return termQ;
            }else{
             return new App(p.checkApp(),q.checkApp());
         }
    }

    
    private class Tripla
    {
        Indice i;
        Term r;
        Term resto;
        
        public Tripla(Indice ii,Term rr,Term rresto)
        {
            i=ii;
            r=rr;
            resto=rresto;
        }
    }
    
    public Tripla rEi(Var x)
    {
        boolean occup=p.occur(x);
        boolean occuq=q.occur(x);
        Indice i=null;
        Term r=null;
        Term resto=null;
        
        if(occup && !occuq)
        {
            i=new ConstInd("c");
            r=q;
            if(p instanceof Bracket)//no debes borrarlo
                p=((Bracket)p).bracketAbsBD();
            resto=p;
        }
        else if(!occup && occuq)
        {
            i=new ConstInd("b");
            r=p;
            if(q instanceof Bracket)//no debes borrarlo
                q=((Bracket)q).bracketAbsBD();
            resto=q;
        }
        else if(occup && occuq)
        {
            i=new ParInd();
            r=p;
            resto=q;
        }
        
        return new Tripla(i,r,resto);
    }
    
    public Term bracketAbsBD(Var x)
    {
        boolean occup=p.occur(x);
        boolean occuq=q.occur(x);
        
        if(!occup && !occuq)
            return new App(new Const("\\Phi_{K}"),this);
        else
        {
            Phi phi=new Phi();
            return bAbsBDIterat(x, phi.ind, phi, this/*,'n'*/);
        }
    }
    
    private Term bAbsBDIterat(Var x,ListaInd ind/*Phi phi*/,Term t0,Term t1/*,char c*/)
    {
            Term exit;
            exit=t0;
            Indice i=null;
            Term r=null;
            Term resto=t1;
            Tripla t=null;
            
            while(resto instanceof App)
            {
                //En la primera it al entrar en rEi estoy calculando denuevo occur
                t=((App)resto).rEi(x);
                /*if(c=='n')
                    ((ListaInd)phi.ind).empilarIndice(t.i);//pudiera fallar porque
                else if(c=='i')
                    ((ListaInd)phi.ind).empilarIndIzq(t.i);
                else if(c=='d')
                    ((ListaInd)phi.ind).empilarIndDer(t.i);*/
                
                
                
                if( !(t.i instanceof ParInd) )
                {
                    ind.empilarIndice(t.i);
                    exit=new App(exit,t.r);
                    resto=t.resto;
                }
                else
                {
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
    
    public int maxVar()
    {
        return Math.max(p.maxVar(), q.maxVar());
    }
    
    public Term traducBD()
    {
        return new App(p.traducBD(),q.traducBD());
    }
    
    public List<Term> contandotraducBD()
    {
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
    
    public Tipo esRedex()
    {
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
    
    public Tipo esRedexFinal()
    {
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
    
    public Redex buscarRedexIzq(Term contexto,boolean pp)
    {
        Tipo tipo=this.esRedexFinal();
        if(tipo.c || tipo.l || tipo.t)
        {
            return new Redex(contexto,tipo,pp);
        }
        Redex r=p.buscarRedexIzq(this,true);
        if(r!=null)
            return r;
        else
            return q.buscarRedexIzq(this,false);
    }
    
    public Redex buscarRedexIzqFinal(Term contexto,boolean pp)
    {
        Tipo tipo=this.esRedexFinal();
        if(tipo.c || tipo.l || tipo.t)
        {
            return new Redex(contexto,tipo,pp);
        }
        Redex r=p.buscarRedexIzqFinal(this,true);
        if(r!=null)
            return r;
        else
            return q.buscarRedexIzqFinal(this,false);
    }
    
    public Term invBraBD()
    {
        Var xc=new Var(0);
        if(obtenerIzq(this,-1).p instanceof Phi)
            return new Bracket(xc, (new App(this,xc)).kappaIndexado(0,xc));
        else
        {
            Var x=new Var(this.maxVar()+1);
            return new Bracket(x,(new App(this,x)).kappa());
        }
    }
    
    public Term invBD()
    {
        AppIzq izq=obtenerIzq(this,-1);
        if(izq.p instanceof Phi || (izq.p instanceof Const && ((Const)izq.p).con.equals("\\Phi_{K}")))
        {
            if(izq.p instanceof Phi && ((ListaInd)((Phi)izq.p).ind).orden == 0)
                return new App(izq.p.invBD(),izq.pq.q);
            AppIzq aux;
            if(izq.p instanceof Phi)
                aux=obtenerIzq(this,izq.deep-((ListaInd)((Phi)izq.p).ind).orden);
            else
                aux=obtenerIzq(this,izq.deep-1);
            if(aux.pqr == null)
                return this.invBraBD().invBD();
            else
            {
                aux.pqr.p=aux.pqr.p.invBraBD();
                return this.invBD();
            }
        }
        else
        {
            Term term = new App(p.invBD(),q.invBD());
            term.alias = this.alias;
            return term;
        }
    }
    
    public Term invBDOneStep()
    {
        Term izq=obtenerIzq(this,-1).p;
        if(izq instanceof Phi || izq instanceof Const)
            return this.invBraBD();
        else
            return new App(p.invBD(),q.invBD());
    }
    
    public Term sustitution()
    {
        if(p instanceof Bracket)
        {
            return this;
        }
        else
            return this;
    }
    
    public int setAlias(int currentAlia)
    {
        if (p.alias != null )
        {
            p.alias = p.alias+"@"+currentAlia;
            currentAlia++;
        }
        
        currentAlia = p.setAlias(currentAlia);
        
        if (q.alias != null)
        {
            q.alias = q.alias+"@"+currentAlia;
            currentAlia++;
        }
        
        currentAlia = q.setAlias(currentAlia);
        return currentAlia;
    }
    
    public Term type()
    {
        return null;
    }
    
    public boolean containTypedA()
    {
        return p.containTypedA() || q.containTypedA();
    }
    
    public void getAxioms(List<String> l)
    {
        p.getAxioms(l);
        q.getAxioms(l);
    }
    
    public Term leibniz(int z, Term subterm)
    {
       if (this == subterm)
           return new Var(z);
       else
           return new App(p.leibniz(z, subterm),q.leibniz(z, subterm));
    }
    
    /**
     * Returns a string formatted with variables codification (x_{}) and
     * constants codification (c_{}) with all possible parenthesis (that could be
     * unnecesary, see toStringFinal method).
     */
    public String toString()
    {
        String izq;
        String der;
        
        if(p.alias == null)
        {
            if(p instanceof App)
                izq=p.toStringFinal();
            else
                izq=p.toString();
        }
        else
            izq = p.alias.split("@")[0].replace("_", "\\_");
        
        if(q.alias == null)
            der=q.toString();
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
    
    private IntXIntXString privateToStringInf(SimboloManager s, String numTeo) {
        
        Stack<Term> stk = new Stack<Term>();
        stk.push(q);
        Term aux = p;
        int j = 1;
        while ( aux instanceof App )
        {
           stk.push(((App)aux).q);
           aux = ((App)aux).p;
           j++;
        }
        Simbolo sym = null;
        int opId;
        int nArgs;
        if (aux instanceof Var) {
            //sym = new Simbolo(aux.toStringInf(s,""), 1, false, 11, "%(op)(%(na1))", null);
            opId = -1;
            nArgs = 0;
        }
        else {
          Const c = (Const) aux;
          sym = s.getSimbolo(c.getId());
          opId = c.getId();
          nArgs = sym.getArgumentos();
        }
        
        if ( j > nArgs) {
           App newTerm;
           if (p instanceof Var && p.occur(new Var('E'))) {
            sym = s.getSimbolo(s.getPropFunApp());
            newTerm = new App(new App(new Const(s.getPropFunApp(),s.propFunAppSym(),!sym.isEsInfijo(),sym.getPrecedencia(),sym.getAsociatividad()),p),q);
           }
           else {
            sym = s.getSimbolo(s.getTermFunApp());
            newTerm = new App(new App(new Const(s.getTermFunApp(),s.termFunAppSym(),!sym.isEsInfijo(),sym.getPrecedencia(),sym.getAsociatividad()),p),q);
           }
           return newTerm.privateToStringInf(s, numTeo);
        }
        Map<String,String> values = new HashMap<String, String>();
        if (numTeo.equals(""))
           values.put("op", sym.getNotacion_latex());
        else
           values.put("op", "\\cssId{click@"+numTeo+"}{\\class{operator}{\\style{cursor:pointer; color:#08c;}{"+sym.getNotacion_latex()+"}}}");
        String notation = sym.getNotacion();
        int i = 1;
        while (!stk.empty()) {//int i=0; i < sym.getArgumentos(); i++)
         Term arg = stk.pop();
         if (notation.contains("%(na"+i+")"))
               values.put("na"+i,arg.toStringInf(s,""));
         else if (notation.contains("%(a"+i+")"))
         {
           if (arg instanceof App)
           {
            IntXIntXString tuple = ((App) arg).privateToStringInf(s,"");
            if (tuple.x1 == 25 && (opId == 21 || opId == 22 || opId == 23))
                values.put("a"+i, "("+tuple.x3+")");
            else
                values.put("a"+i, (tuple.x2 > sym.getPr())?tuple.x3:"("+tuple.x3+")");
           }
           else
            values.put("a"+i,arg.toStringInf(s,""));
         }
         else if (notation.contains("%(aa"+i+")"))
         {
          if (arg instanceof App)
          {
           IntXIntXString tuple = ((App) arg).privateToStringInf(s,"");
           if (tuple.x1 == 25 && (opId == 21 || opId == 22 || opId == 23))
                values.put("aa"+i, "("+tuple.x3+")");
            else
                values.put("aa"+i,(tuple.x2 > sym.getPr() || tuple.x1 == opId)?tuple.x3:"("+tuple.x3+")");
          }
          else
           values.put("aa"+i,arg.toStringInf(s,""));
         }
          i++;
        }
        
        StrSubstitutor sub = new StrSubstitutor(values, "%(",")");
        return new IntXIntXString(sym.getId(),sym.getPr(),sub.replace(notation));
    }

    /**
     * Uses the symbols notation stored in the database to compute
     * the LaTeX format string.
     * @param s
     * @param numTeo
     * @return String representation in LaTeX Format.
     */
    public String toStringInf(SimboloManager s, String numTeo)
    {
        return privateToStringInf(s,numTeo).x3;
        /*
        Stack<String> stk = new Stack<String>();
        Simbolo s1, s2;
        Const c1, c2;
        if ( p instanceof Const && q instanceof App && ((App) q).p instanceof Const && 
              (c1=(Const)p) != null && (c2=(Const)((App) q).p) != null &&
              (s1 = s.getSimbolo(c1.getId())) != null && (s2 = s.getSimbolo(c2.getId())) != null &&
             s1.isInf() && ( s2.getPr() > s1.getPr() || (s2.getPr() == s1.getPr() && s1.getAs() == 1) )    ) 
           // Const(Const p)
        {
           stk.push(q.toStringInfFinal(s));
           return "("+Term.notation(s1, stk)+")"; //"("+c1.toStringInf(s)+" "+q.toStringInfFinal(s)+")";
        }
        else if ( p instanceof Const && q instanceof App && ((App)q).p instanceof App && ((App)((App)q).p).p instanceof Const &&
                  (c1=(Const)p) != null && (c2=(Const)((App)((App)q).p).p) != null &&
                  (s1 = s.getSimbolo(c1.getId())) != null && (s2 = s.getSimbolo(c2.getId())) != null  && 
                  s1.isInf() && (s2.getPr() > s1.getPr() || (s2.getPr() == s1.getPr() && s1.getAs() == 1) ))
           // Const(Const p q)
        {
           stk.push(q.toStringInfFinal(s));
           return "("+Term.notation(s1, stk)+")";//"("+c1.toStringInf(s) +" "+ q.toStringInfFinal(s)+")";
        }
        else if ( p instanceof App && q instanceof App && ((App)p).p instanceof Const && ((App)q).p instanceof Const &&
                  (c1=(Const)((App)p).p)!=null && (c2=(Const)((App)q).p)!=null && 
                  (s1 = s.getSimbolo(c1.getId())) != null && (s2 = s.getSimbolo(c2.getId())) != null && 
                  s2.isInf() && (s2.getPr() > s1.getPr() || (s2.getPr() == s1.getPr() && s2.getAs()==0)))
           // Const p (Const q)
        {
           stk.push(q.toStringInfFinal(s));
           stk.push(((App)p).q.toStringInf(s));
           return "("+Term.notation(s1, stk)+")"; //("+q.toStringInfFinal(s)+ (new App(new App(c1,((App)p).q),new Const(""))).toStringInfFinal(s)+")";
        }
        else if ( p instanceof App && ((App)p).p instanceof Const && ((App)p).q instanceof App && ((App)((App)p).q).p instanceof Const &&
                  (c1 = (Const)((App)p).p) != null && (c2 = (Const)((App)((App)p).q).p) != null &&
                  (s1 = s.getSimbolo(c1.getId())) != null)
           // Const (Const p) q
        {
            stk.push(q.toStringInf(s));
            stk.push(((App)p).q.toStringInfFinal(s));
            return "("+Term.notation(s1, stk)+")"; //"("+new App(new App(c1,new Const("")),q).toStringInfFinal(s)+((App)p).q.toStringInfFinal(s)+")";
        }
        else if ( p instanceof Const )
           // Const p
        {
           stk.push(q.toStringInf(s));
           s1 = s.getSimbolo(((Const)p).getId());
           return "("+Term.notation(s1, stk)+")"; //"("+p.toStringInf(s)+" "+q.toStringInf(s)+")";
        }
        else if ( p instanceof App && ((App)p).p instanceof App )
           // (App p) q
        {
           stk.push(q.toStringInfFinal(s));
           Term aux = p;
           while ( aux instanceof App )
           {
             stk.push(((App)aux).q.toStringInfFinal(s));
             aux = ((App)aux).p;
           }
           String termStr = aux.toStringInf(s)+" ( "+stk.pop();
           while ( !stk.empty() )
              termStr = termStr + " , " + stk.pop();
           return termStr + " )";
        }
        else if ( p instanceof App && ((App)p).p instanceof Const && ((App)p).q instanceof App && 
                
                  ((App)((App)p).q).p instanceof App && ((App)((App)((App)p).q).p).p instanceof Const && 
                  (c1 = (Const)((App)p).p)!= null && (c2 = (Const)((App)((App)((App)p).q).p).p)!=null &&
                  (s1 = s.getSimbolo(c1.getId())) != null && (s2 = s.getSimbolo(c2.getId())) != null &&
                  (s2.getPr() > s1.getPr() ||(s2.getPr() == s1.getPr() && s2.getAs() == 1)))
           // Const (Const p q) r
        {
           stk.push(q.toStringInf(s));
           stk.push(((App)p).q.toStringInfFinal(s));
           return "("+Term.notation(s1, stk)+")"; //"("+new App(new App(c1,new Const("")),q).toStringInfFinal(s)+((App)p).q.toStringInfFinal(s)+")";
        }
        else if ( p instanceof App && ((App)p).p instanceof Const && q instanceof App && ((App)q).p instanceof App &&
                  ((App)((App)q).p).p instanceof Const && 
                  (c1 = (Const)((App)p).p)!= null && (c2 = (Const)((App)((App)q).p).p) != null &&
                  (s1 = s.getSimbolo(c1.getId())) != null && (s2 = s.getSimbolo(c2.getId())) != null &&
                  (s2.getPr() > s1.getPr() ||(s2.getPr() == s1.getPr() && s2.getAs() == 0)))
           // (Const p)(Const p q)
        {
           stk.push(q.toStringInfFinal(s));
           stk.push((((App)p).q).toStringInf(s));
           return "("+Term.notation(s1, stk)+")"; //"("+q.toStringInfFinal(s)+new App(new App(c1,((App)p).q),new Const("")).toStringInfFinal(s)+")";
        }
        else if ( p instanceof App && ((App)p).p instanceof Const )
           // Const p q
        {
           stk.push(q.toStringInf(s)); 
           stk.push(((App)p).q.toStringInf(s));
           s1 = s.getSimbolo(((Const)((App)p).p).getId());
           return "("+Term.notation(s1, stk)+")"; //"("+q.toStringInf(s)+" "+((App)p).p.toStringInf(s)+" "+((App)p).q.toStringInf(s)+")";
        }
        else
           return this.toString();
        */
    }
    
    private IntXIntXString privateToStringWithInputs(SimboloManager s, String position, String rootId) {
        
        Stack<Term> stk = new Stack<Term>();
        stk.push(q);
        Term aux = p;
        int j =1;
        while ( aux instanceof App )
        {
           stk.push(((App)aux).q);
           aux = ((App)aux).p;
           j++;
        }
        Simbolo sym = null;
        int opId;
        int nArgs;
        if (aux instanceof Var) {
            //sym = new Simbolo(aux.toStringInf(s,""), 1, false, 11, "%(op)(%(na1))", null);
            opId = -1;
            nArgs = 0;
        }
        else {
          Const c = (Const) aux;
          sym = s.getSimbolo(c.getId());
          opId = c.getId();
          nArgs = sym.getArgumentos();
        }
        
        if ( j > nArgs) {
           App newTerm;
           if (false) { //p instanceof Var && p.occur(new Var('E'))) {
            sym = s.getSimbolo(s.getPropFunApp());
            newTerm = new App(new App(new Const(s.getPropFunApp(),s.propFunAppSym(),!sym.isEsInfijo(),sym.getPrecedencia(),sym.getAsociatividad()),p),q);
           }
           else {
            sym = s.getSimbolo(s.getTermFunApp());
            newTerm = new App(new App(new Const(s.getTermFunApp(),s.termFunAppSym(),!sym.isEsInfijo(),sym.getPrecedencia(),sym.getAsociatividad()),p),q);
           }
           return newTerm.privateToStringWithInputs(s, position, rootId);
        }
        Map<String,String> values = new HashMap<String, String>();
        values.put("op", sym.getNotacion_latex());
        String notation = sym.getNotacion();
        int i = 1;
        while (!stk.empty()) {//int i=0; i < sym.getArgumentos(); i++)
         Term arg = stk.pop();
         if (notation.contains("%(na"+i+")"))
               values.put("na"+i,arg.toStringWithInputs(s,position+i,rootId));
         else if (notation.contains("%(a"+i+")"))
         {
           if (arg instanceof App)
           {
            IntXIntXString tuple = ((App) arg).privateToStringWithInputs(s,position+i,rootId);
            if (tuple.x1 == 25 && (opId == 21 || opId == 22 || opId == 23))
                values.put("a"+i, "("+tuple.x3+")");
            else
                values.put("a"+i, (tuple.x2 > sym.getPr())?tuple.x3:"("+tuple.x3+")");
           }
           else
            values.put("a"+i,arg.toStringWithInputs(s,position+i,rootId));
         }
         else if (notation.contains("%(aa"+i+")"))
         {
          if (arg instanceof App)
          {
           IntXIntXString tuple = ((App) arg).privateToStringWithInputs(s,position+i,rootId);
           if (tuple.x1 == 25 && (opId == 21 || opId == 22 || opId == 23))
                values.put("aa"+i, "("+tuple.x3+")");
            else
                values.put("aa"+i,(tuple.x2 > sym.getPr() || tuple.x1 == opId)?tuple.x3:"("+tuple.x3+")");
          }
          else
           values.put("aa"+i,arg.toStringWithInputs(s,position+i,rootId));
         }
          i++;
        }
        
        StrSubstitutor sub = new StrSubstitutor(values, "%(",")");
        return new IntXIntXString(sym.getId(),sym.getPr(),sub.replace("\\ {"+notation+"}\\ "));
    }

    /**
     * Similar toStringInf, but puts an HTML input in variables formulas
     * to be used in the sustitution.
     * @param s
     * @param position
     * @param rootId
     * @return String representation with HTML inputs.
     */
    public String toStringWithInputs(SimboloManager s, String position, String rootId)
    {
        return privateToStringWithInputs(s,position,rootId).x3;
    }
    
    private IntXIntXString privateToStringInfLabeled(SimboloManager s,int z, Term t, 
                                                     List<Term> l, List<String> l2, 
                                                     Id id, int nivel) {
        String setVar = "";
        Stack<Term> stk = new Stack<Term>();
        stk.push(q);
        Term aux = p;
        int j = 1;
        while ( aux instanceof App )
        {
           stk.push(((App)aux).q);
           aux = ((App)aux).p;
           j++;
        }
        Simbolo sym = null;
        int opId;
        int nArgs;
        if (aux instanceof Var) {
            //sym = new Simbolo(aux.toStringInf(s,""), 1, false, 11, "%(op)(%(na1))", null);
            opId = -1;
            nArgs = 0;
        }
        else {
          Const c = (Const) aux;
          sym = s.getSimbolo(c.getId());
          opId = c.getId();
          nArgs = sym.getArgumentos();
        }
        
        if ( j > nArgs) {
           App newTerm;
           if (false) { //p instanceof Var && p.occur(new Var('E'))) {
            sym = s.getSimbolo(s.getPropFunApp());   
            newTerm = new App(new App(new Const(s.getPropFunApp(),s.propFunAppSym(),!sym.isEsInfijo(),sym.getPrecedencia(),sym.getAsociatividad()),p),q);
           }
           else {
            sym = s.getSimbolo(s.getTermFunApp());
            newTerm = new App(new App(new Const(s.getTermFunApp(),s.termFunAppSym(),!sym.isEsInfijo(),sym.getPrecedencia(),sym.getAsociatividad()),p),q);
           }
           IntXIntXString result = newTerm.privateToStringInfLabeled(s,z, t, l, l2, id, nivel);
           l.add(t.leibniz(z, this));
           return result;
        }
        Map<String,String> values = new HashMap<String, String>();
        values.put("op", "\\class{terminoClick}{"+sym.getNotacion_latex()+"}");
        String notation = sym.getNotacion();
        int i = 1;
        while (!stk.empty()) {
         Term arg = stk.pop();
         if (notation.contains("%(na"+i+")")) {
               values.put("na"+i,arg.toStringInfLabeled(s,z,t,l,l2,id,nivel+1));
               setVar += l2.get(l2.size()-1);
         }
         else if (notation.contains("%(a"+i+")"))
         {
           if (arg instanceof App)
           {
            IntXIntXString tuple = ((App) arg).privateToStringInfLabeled(s,z,t,l,l2,id,nivel+1);
            if (tuple.x1 == 25 && (opId == 21 || opId == 22 || opId == 23))
                values.put("a"+i, addParenthesis(tuple.x3));
            else
                values.put("a"+i, (tuple.x2 > sym.getPr())?tuple.x3:addParenthesis(tuple.x3));
            setVar += l2.get(l2.size()-1);
           }
           else {
            values.put("a"+i,arg.toStringInfLabeled(s,z,t,l,l2,id,nivel+1));
            setVar += l2.get(l2.size()-1);
           }
         }
         else if (notation.contains("%(aa"+i+")"))
         {
          if (arg instanceof App)
          {
           IntXIntXString tuple = ((App) arg).privateToStringInfLabeled(s,z,t,l,l2,id,nivel+1);
           if (tuple.x1 == 25 && (opId == 21 || opId == 22 || opId == 23))
                values.put("aa"+i, addParenthesis(tuple.x3));
            else
                values.put("aa"+i,(tuple.x2 > sym.getPr() || tuple.x1 == opId)?tuple.x3:addParenthesis(tuple.x3));
           setVar += l2.get(l2.size()-1);
          }
          else {
           values.put("aa"+i,arg.toStringInfLabeled(s,z,t,l,l2,id,nivel+1));
           setVar += l2.get(l2.size()-1);
          }
         }
          i++;
        }
        
        StrSubstitutor sub = new StrSubstitutor(values, "%(",")");
        String term = sub.replace("\\class{"+nivel+"}{"+notation+"}");
        term = "\\cssId{"+id.id+"}{"+term+"}";
        l2.add(l2.size(),setVar+id.id+",");
        //l.add(t.leibniz(z, this).toStringFormatC(s,"",0).replace("\\", "\\\\"));
        //l2.add(t.leibniz(z, this).toStringWithInputs(s,"").replace("\\", "\\\\"));
        if (opId != s.getPropFunApp() && opId != s.getTermFunApp())
            l.add(t.leibniz(z, this));
        id.id++;
        return new IntXIntXString(sym.getId(),sym.getPr(),term);
    }
    
    /**
     * Creates a LaTeX string with the span HTML tags use to control the subexpresions
     * used for leibniz rule in the client.
     * @param s
     * @param z
     * @param t
     * @param l1
     * @param l2
     * @param id
     * @param nivel
     * @return String representation in LaTeX format with span HTML tags for Mathjax.
     */
    public String toStringInfLabeled(SimboloManager s,int z, Term t, List<Term> l1, List<String> l2, Id id, int nivel)
    {
        return privateToStringInfLabeled(s, z, t, l1, l2, id, nivel).x3;
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
        
        Stack<Term> stk = new Stack<Term>();
        String term;
        stk.push(q);
        Term aux = p;
        int j = 1;
        while ( aux instanceof App )
        {
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
        
        return term+")";
    }
    
    public ToString toStringAbrv(ToString toString)
    {
        
        String izq;
        String der;
        
        if(p.alias == null)
        {
            if(p instanceof App)
                p.toStringAbrvFinal(toString);
            else
                p.toStringAbrv(toString);
            
            izq = toString.term;
        }
        else
        {
            toString.setNuevoAlias(p.alias, p);
            izq = toString.term;
        }
        
        if(q.alias == null)
        {
            q.toStringAbrv(toString);
            der = toString.term;
        }
        else
        {
            toString.setNuevoAlias(q.alias, q);
            der = toString.term;
        }
        
        toString.term="("+izq+der+")";
        return toString;
    }
    
    private IntXIntXString privateToStringInfAbr(ToString tStr, SimboloManager s, PredicadoManager pm,
                                                 String numTeo) {
        Stack<Term> stk = new Stack<Term>();
        stk.push(q);
        Term aux = p;
        int j = 1;
        while ( aux instanceof App )
        {
           stk.push(((App)aux).q);
           aux = ((App)aux).p;
           j++;
        }
        Simbolo sym=null;
        int opId;
        int nArgs;
        if (aux instanceof Var) {
            // sym = new Simbolo(aux.toStringInf(s,""), 1, false, 11, "%(op)(%(na1))", null);
            opId = -1;
            nArgs = 0;
        }
        else {
          Const c = (Const) aux;
          sym = s.getSimbolo(c.getId());
          opId = c.getId();
          nArgs = sym.getArgumentos();
        }
        
        if ( j > nArgs) {
           App newTerm;
           if (p instanceof Var && p.occur(new Var('E'))) {
            sym = s.getSimbolo(s.getPropFunApp());
            newTerm = new App(new App(new Const(s.getPropFunApp(),s.propFunAppSym(),!sym.isEsInfijo(),sym.getPrecedencia(),sym.getAsociatividad()),p),q);
           }
           else {
            sym = s.getSimbolo(s.getTermFunApp());
            newTerm = new App(new App(new Const(s.getTermFunApp(),s.termFunAppSym(),!sym.isEsInfijo(),sym.getPrecedencia(),sym.getAsociatividad()),p),q);
           }
           return newTerm.privateToStringInf(s, numTeo);
        }
        
        Map<String,String> values = new HashMap<String, String>();
        if (numTeo.equals(""))
           values.put("op", sym.getNotacion_latex());
        else
           values.put("op", "\\cssId{click@"+numTeo+"}{\\class{operator}{\\style{cursor:pointer; color:#08c;}{"+sym.getNotacion_latex()+"}}}");
        String notation = sym.getNotacion();
        if ( j > nArgs)
           notation = "( "+notation+" )(%(na"+j+") )";
        int i = 1;
        while (!stk.empty()) {//int i=0; i < sym.getArgumentos(); i++)
         Term arg = stk.pop();
         if (arg.alias != null) {
             tStr.setNuevoAlias(arg.alias, arg, s,pm, numTeo);
             values.put("na"+i,tStr.term);
             values.put("a"+i,tStr.term);
             values.put("aa"+i,tStr.term);
         }
         else {
           if (notation.contains("%(na"+i+")")) {
             arg.toStringInfAbrv(tStr,s,pm,"");
             values.put("na"+i,tStr.term);
           }
           else if (notation.contains("%(a"+i+")"))
           {
             if (arg instanceof App)
             {
              IntXIntXString tuple = ((App) arg).privateToStringInfAbr(tStr,s,pm,"");
              if (tuple.x1 == 25 && (opId == 21 || opId == 22 || opId == 23))
                values.put("a"+i, "("+tuple.x3+")");
              else
                values.put("a"+i, (tuple.x2 > sym.getPr())?tuple.x3:"("+tuple.x3+")");
             }
             else 
              values.put("a"+i,arg.toStringInfAbrv(tStr,s,pm,"").term);
           }
           else if (notation.contains("%(aa"+i+")"))
           {
            if (arg instanceof App)
            {
             IntXIntXString tuple = ((App) arg).privateToStringInfAbr(tStr,s,pm,"");
             if (tuple.x1 == 25 && (opId == 21 || opId == 22 || opId == 23))
                values.put("aa"+i, "("+tuple.x3+")");
            else
                values.put("aa"+i,(tuple.x2 > sym.getPr() || tuple.x1 == opId)?tuple.x3:"("+tuple.x3+")");
            }
            else 
             values.put("aa"+i,arg.toStringInfAbrv(tStr,s,pm,"").term);
           }
         }
         i++;
        }
        
        StrSubstitutor sub = new StrSubstitutor(values, "%(",")");
        tStr.term = sub.replace(notation);
        return new IntXIntXString(sym.getId(),sym.getPr(),tStr.term);
    }
    
    @Override
    public ToString toStringInfAbrv(ToString toString, SimboloManager s, PredicadoManager pm, String numTeo)
    {
        privateToStringInfAbr(toString,s,pm,numTeo);
        return toString;
        
        /*String izq;
        String der;
        
        if(p.alias == null)
        {
            p.toStringInfAbrv(toString,s);
            
            izq = toString.term;
        }
        else
        {
            toString.setNuevoAlias(p.alias, p);
            izq = toString.term;
        }
        
        if(q.alias == null)
        {
            q.toStringInfAbrv(toString,s);
            der = toString.term;
        }
        else
        {
            toString.setNuevoAlias(q.alias, q);
            der = toString.term;
        }
        
        toString.term="("+izq+der+")";
        return toString;*/
    }
    
    public ToString toStringAbrvV1(ToString toString)
    {
        
        String izq;
        String der;
        
        if(p.alias == null)
        {
            if(p instanceof App)
                p.toStringAbrvFinalV1(toString);
            else
                p.toStringAbrvV1(toString);
            
            izq = toString.term;
        }
        else
        {
            toString.setNuevoAliasV1(p.alias, p);
            izq = toString.term;
        }
        
        if(q.alias == null)
        {
            q.toStringAbrvV1(toString);
            der = toString.term;
        }
        else
        {
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
    
    
    
}