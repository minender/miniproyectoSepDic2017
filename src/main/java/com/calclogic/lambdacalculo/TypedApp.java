/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.lambdacalculo;

import com.calclogic.parse.TermUtilities;
import java.util.List;

/**
 *
 * @author federico
 */
public class TypedApp extends App implements TypedTerm{

    /** Determines the kind of inference that is being applied. Can have the following values:
     * "t" -> transitivity.
     * "e" -> equanimity.
     * "l" -> the left term is a Leibniz application.
     * "i" -> the left term is an instantiation.
     */
    public char inferType;
    
    public TypedApp(Term t1, Term t2)  throws TypeVerificationException
    {
        super(t1, t2);
        Term t1Type = t1.type();
        Term t2Type = t2.type();
        Const op;
        try {

            App rootRight = (App)t2Type;
            App leftChild = (App)rootRight.p;
            op = (Const)leftChild.p;
        }
        catch (ClassCastException e) {
            throw new TypeVerificationException();
        }
        if ( op.getId()!=0 )
            throw new TypeVerificationException();
        else if (t1Type instanceof Sust)
            inferType = 'i';
        else if (t1Type instanceof Bracket) //t2Type tiene que ser equiv
        {
            inferType = 'l'; // Cuando se tipe hay que verificar si (t1Type t2Type) no dan error de tipo
        }
        else if (t1 instanceof TypedS) // <== S operand created by the grammar
        {
            if (t2.containT())
                throw new TypeVerificationException();
            inferType = 's';
        }
        else if (t1Type instanceof App)
        {
            try
            {
                int op1 = ((Const)((App)((App)t1Type).p).p).getId();
                if (op1 != 0)
                    throw new TypeVerificationException();
                
                Term t1Izq = ((App)t1Type).q.body();
                if (((App)((App)t1Type).p).q.containT() && 
                      !(((App)((App)t1Type).p).q.body() instanceof App)
                   )
                {
                    t1Izq = ((App)((App)t1Type).q.body()).q;
                    op1 = ((Const)((App)((App)((App)t1Type).q.body()).p).p).getId();
                    if (op1 != 2) //&& !op1.equals("c_{3}"))// el c_{3} como que esta de mas
                        throw new TypeVerificationException();
                }
                
                if ( !(((App)((App)t2Type).p).q.containT() && 
                        !(((App)((App)t2Type).p).q.body() instanceof App) && 
                        t1Izq.equals(((App)t2Type).q.body())
                      )
                   ) // Esto dice que no es modus pones ni equanimity
                {//(q==r)=q q=r pilas con este caso no se sabe si es equanimity o transitividad
                    if (op1 != 0) 
                        throw new TypeVerificationException();
                    
                    Term t1Der = ((App)((App)t1Type).p).q;
                    Term t2Izq = ((App)t2Type).q;
                    //int op2 = ((Const)((App)((App)t2Type).p).p).getId();
                    if (!t1Der.body().traducBD().equals(t2Izq.body().traducBD())){
                        throw new TypeVerificationException();
                    }
                    else{
                        inferType = 't';
                    }
                }
                else
                    inferType = (op1 == 2?'m':'e');
            }
            catch (ClassCastException e){
                throw new TypeVerificationException();
            }
        }
        else
            throw new TypeVerificationException();
    }
    
    public static Term tranE(Term t1Type, Term t2Type) {
        Term t1Der = ((App)((App)t1Type).p).q;
        Term t2Izq = ((App)t2Type).q;
        int nL1, nL2, maxVar, nMax;
        Term aux = t1Der;
        nL1 = 0;
        maxVar = 0;
        while (aux instanceof Bracket) {
            maxVar = ((Bracket)aux).x.indice;
            aux = ((Bracket)aux).t;
            nL1++;
        }
        aux = t2Izq;
        nL2 = 0;
        while (aux instanceof Bracket) {
            if ( ((Bracket)aux).x.indice > maxVar )
                maxVar = ((Bracket)aux).x.indice;
            aux = ((Bracket)aux).t;
            nL2++;
        }
        Term max, min;
        if (nL1<=nL2) {
            max = t2Izq;
            min = t1Der;
            nMax = nL2;
        }
        else {
            max = t1Der;
            min = t2Izq;
            nMax = nL1;
        }
        aux = min;
        Term E = (nL1<=nL2?t1Der:t2Izq);//new Var(maxVar+1);
        while (aux instanceof Bracket) {
               E = new App(E, ((Bracket)aux).x);
               aux = ((Bracket)aux).t;
        }
        for (int i=0; i< nMax; i++) {
            aux = max;
            for (int j=0; j< nMax-1-i;j++) {
                aux = ((Bracket)aux).t;
            }
            E = new Bracket(((Bracket)aux).x,E);
        }
        /*E = new Bracket(z,E);*/
        //ArrayList q = new ArrayList<Var>();
        //q.add(new Var(113));
        if (nL1<=nL2) 
            t1Der = E.evaluar();
        else 
            t2Izq = E.evaluar();
        
        return null;
    }
    
    public Term type()
    {
        Term pType = p.type();
        Term qType = q.type();
        if(inferType == 'i')
        {
            /*String[] vs = pType.stFreeVars().split(",");
            Var z = new Var((int)vs[vs.length-1].charAt(0)+1);
            Term t = z;
            for (int i = 0; i<((Sust)pType).vars.size();i++) {
                t = new App(t,((Sust)pType).terms.get(i));
            }
            for (int i=vs.length-1; i>=0;i--) { 
                t = new Bracket(new Var((int)vs[i].charAt(0)),t);
            }
            Term E = new Bracket(z, t);
            E = new App(new App(new Const("="),new App(E,((App)((App)qType).p).q)),new App(E,((App)qType).q)).evaluar();
            return E;*/
            //return qType.sustParall(((Sust)pType).vars, ((Sust)pType).terms).evaluar();
            try {
             Term right = ((App)((App)qType).p).q;
             Term left = ((App)qType).q;
             Term aux = left;
             int i = 0;
             while ( aux instanceof Bracket ) {
                Var var = ((Bracket)aux).x;
                Var v = (i<((Sust)pType).vars.size()?((Sust)pType).vars.get(i):null);
                if (v != null && var.indice == v.indice) {
                    Term t = ((Sust)pType).terms.get(i);
                    right = new App(right,t);
                    left = new App(left,(Term)t.clone());
                    i++;
                }
                else {
                    right = new App(right,var);
                    left = new App(left,var);
                }
                aux = ((Bracket)aux).t;
             }
             String vars = ";"+((TypedA)q).variables_.split(";")[0];
             //System.out.println(new App(new App(new Const(0,"="),right),left));
             //Term right = ((App)((App)qType).p).q.body().sustParall((Sust)pType).evaluar();
             //Term left = (((App)qType).q).body().sustParall((Sust)pType).evaluar();
             return new App(new App(new Const(0,"="),right),left).evaluar(vars).abstractEq();
            }
            catch (CloneNotSupportedException e){
                e.printStackTrace();
            }
        }
        else if (inferType == 'l')
        {
            Term z = ((Bracket)pType).x;
            Term aux = ((App)qType).q;
            while (aux instanceof Bracket) {
                z = new App(z,((Bracket)aux).x);
                aux = ((Bracket)aux).t;
            }
            Term E = ((Bracket)pType).t.sust(((Bracket)pType).x,z);
            Term t1 = E.sust(((Bracket)pType).x,((App)qType).q).evaluar();
            Term t2 = E.sust(((Bracket)pType).x,((App)((App)qType).p).q).evaluar();
            //Term op2 = ((App)((App)qType).p).p; 
            return new App(new App(new Const(0,"="), t2),t1).abstractEq();
        }
        if (inferType == 's')
        {
            return new App(new App(new Const("="), ((App)qType).q), ((App)((App)qType).p).q);
        }
        else if (inferType == 'm')
        {
            Const eq = (Const)((App)((App)pType).p).p;
            pType = ((App)((App)((App)pType).q.body()).p).q;
            Const T = (Const)((App)((App)qType).p).q.body();
            return new App(new App(eq,T),pType).abstractEq();
        }
        else if (inferType == 'e')
        {
            Const eq = (Const)((App)((App)pType).p).p;
            pType = ((App)((App)pType).p).q.body();
            Const T = (Const)((App)((App)qType).p).q.body();
            return new App(new App(eq,T),pType).abstractEq();
        }
        else
        {
            Term pIzq = ((App)pType).q.body(); 
            Term qDer = ((App)((App)qType).p).q.body();
            Const op1 = (Const)((App)((App)pType).p).p;
           
            return new App(new App(op1, qDer), pIzq).abstractEq();
            // verificar si compartir terminos no trae problemas con reducir
        }
    }
    
    public String getCombDBType()
    {
        return "";
    }
}