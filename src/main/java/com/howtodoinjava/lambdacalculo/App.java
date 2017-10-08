/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.lambdacalculo;

import java.util.ArrayList;
import java.util.List;

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
    
    public Term sust(Var x,Term t)
    {
        Term t2;
        try{
            t2=(Term)t.clone();
        }
        catch(CloneNotSupportedException e)
        {   
            System.out.println(e);
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
    public Term sustParall(ArrayList<Var> Vars, ArrayList<Term> varsTerm) {
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
        Tipo tipo=this.esRedex();
        if(tipo.c || tipo.l)
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
        if(izq.p instanceof Phi || izq.p instanceof Const)
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
    
    public String toStringInf()
    {
        String izq; 
        String der; 
        boolean pp =  p instanceof App;
        boolean qq = q instanceof App;
        if( ((p.alias == null) && (q.alias == null) ) ) {      
           if((p instanceof App) && (q instanceof App)){
               return q.toStringInf()+" "+p.toStringInf();  
               
           }else if(!(p instanceof App) && (q instanceof App)){
                 if( ((App) q).p instanceof Const ){
                     return p.toStringInf()+" "+q.toStringInf();
                 }else{
                     return p.toStringInf()+" ("+q.toStringInf()+")" ;
                 } 
                 
           }else if( (p instanceof App) && !(q instanceof App)){ 
                String sim = ((App) p).p.toStringInf();
                if (((App) p).p instanceof Const ) {    
                    if ( (((App) p).q instanceof Var) | (((App) p).q instanceof Bracket)){
                        return q.toStringInf()+" "+sim+" "+((App) p).q.toStringInf();
                    }else{
                        return q.toStringInf()+" "+sim+" ("+((App) p).q.toStringInf()+")";
                    }                       
               }else{
                    return "("+q.toStringInf()+" "+sim+" "+((App) p).q.toStringInf()+")";
               }
           }else{
                return p.toStringInf()+" "+q.toStringInf();
            }   
           
        }else if( (q.alias == null) &&  (p.alias != null)) {
            return q.toStringInf()+" "+p.alias;
            
        }else if( (q.alias != null) && (p.alias == null)) {
            return q.alias +" "+p.toStringInf();
            
        }else{ 
            return p.alias+" "+q.alias;
        }    
    }
    
    public String toStringInFin() {
        
        String izq; 
        String der; 
        boolean pp =  p instanceof App;
        boolean qq = q instanceof App;
        System.out.println(pp +"+++++++++++++++++"+qq);
        if( ((p.alias == null) && (q.alias == null) ) ) {      
           if((p instanceof App) && (q instanceof App)){
               System.out.println("+++++++++++++111111111111111+++++++++++++++++"); 
               return q.toStringInFin()+" "+p.toStringInFin();  
               
           }else if(!(p instanceof App) && (q instanceof App)){
                 System.out.println("++++++++++++++222222222222222222++++++++++++++++"); 
                 if( ((App) q).p instanceof Const ){
                     System.out.println("++++++++++2222aaaaaaaaaaaa++++++++++++++++++++"); 
                     return p.toStringInFin()+" "+q.toStringInFin();
                 }else{
                     System.out.println("++++++++++++2222bbbbbb++++++++++++++++++"); 
                     return p.toStringInFin()+" ("+q.toStringInFin()+")" ;
                 } 
                 
           }else if( (p instanceof App) && !(q instanceof App)){ 
                System.out.println("+++++++++++++++3333333333333+++++++++++++++"); 
                String sim = ((App) p).p.toStringInFin();
                if (((App) p).p instanceof Const ) {    
                    System.out.println("+++aaaaaaaaaaaaaaaaaaaaaa+++++");
                    if ( (((App) p).q instanceof Var) | (((App) p).q instanceof Bracket)){
                        return q.toStringInFin()+" "+sim+" "+((App) p).q.toStringInFin();
                    }else{
                        return q.toStringInFin()+" "+sim+" ("+((App) p).q.toStringInFin()+")";
                    }                       
               }else{
                    System.out.println("+++bbbbbbbbbbbbb+++++");
                    return "("+q.toStringInFin()+" "+sim+" "+((App) p).q.toStringInFin()+")";
               }
           }else{
                System.out.println("+++++++++++++44444444+++++++++++++++++"); 
                return p.toStringInFin()+" "+q.toStringInFin();
            }   
           
        }else if( (q.alias == null) &&  (p.alias != null)) {
            return q.toStringInFin()+" "+p.alias;
            
        }else if( (q.alias != null) && (p.alias == null)) {
            return q.alias +" "+p.toStringInFin();
            
        }else{ 
            return p.alias+" "+q.alias;
        }    
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
    
    public ToString toStringInfAbrv(ToString toString)
    {
        
        String izq;
        String der;
        
        if(p.alias == null)
        {
/*            if(p instanceof App)
                p.toStringInfAbrvFinal(toString);
            else
*/
                p.toStringInfAbrv(toString);
            
            izq = toString.term;
        }
        else
        {
            toString.setNuevoAlias(p.alias, p);
            izq = toString.term;
        }
        
        if(q.alias == null)
        {
            q.toStringInfAbrv(toString);
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
    
    
    
}
