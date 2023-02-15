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
    
    public TypedApp(Term t1, Term t2)  throws TypeVerificationException{
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
        if ( op.getId()!=0 ){
            throw new TypeVerificationException();
        }
        else if (t1Type instanceof Sust){
            inferType = 'i';
        }
        else if (t1Type instanceof Bracket){ //t2Type tiene que ser equiv
            inferType = 'l'; // Cuando se tipe hay que verificar si (t1Type t2Type) no dan error de tipo
        }
        else if (t1 instanceof TypedS){ // <== S operand created by the grammar
            if (t2Type.containT() && !(t2Type.dsc("2") instanceof Const && ((Const)t2Type.dsc("2")).id==8)){
                throw new TypeVerificationException();
            }
            inferType = 's';
        }
        else if (t1Type instanceof App){
            try{
                int op1 = ((Const)t1Type.dsc("11")).getId();
                if (op1 != 0){
                    throw new TypeVerificationException();
                }
                
                Term t1Izq = t1Type.dsc("2").body();
                if (t1Type.dsc("12").containT() && // esto dice que es un modus pones
                      !(t1Type.dsc("12").body() instanceof App) &&
                     !(t2Type.containT() && // esto dice que no es el caso [t1=T] T=true
                        t2Type.dsc("12") instanceof Const && 
                        ((Const)t2Type.dsc("12").body()).id==8
                      )
                   )
                {
                    t1Izq = t1Type.dsc("2").body().dsc("2");          
                    op1 = ((Const)t1Type.dsc("2").body().dsc("11")).getId();
                    if (op1 != 2) //&& !op1.equals("c_{3}"))// el c_{3} como que esta de mas
                        throw new TypeVerificationException();
                }
                
                if ( !(t2Type.dsc("12").containT() &&
                        !(t2Type.dsc("12").body() instanceof App) && 
                        t1Izq.equals(t2Type.dsc("2").body())
                      )
                   ) // Esto dice que no es modus pones ni equanimity
                {//(q==r)=q q=r pilas con este caso no se sabe si es equanimity o transitividad
                    if (op1 != 0) 
                        throw new TypeVerificationException();
                    
                    Term t1Der = t1Type.dsc("12");
                    Term t2Izq = t2Type.dsc("2");
                    
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
        Term t1Der = t1Type.dsc("12");
        Term t2Izq = t2Type.dsc("2");
        int nL1, nL2, maxVar, nMax;
        Term aux = t1Der;
        nL1 = 0;
        maxVar = 0;
        while (aux instanceof Bracket) {
            maxVar = ((Bracket)aux).x.indice;
            aux = aux.dsc("3");  
            nL1++;
        }
        aux = t2Izq;
        nL2 = 0;
        while (aux instanceof Bracket) {
            if ( ((Bracket)aux).x.indice > maxVar )
                maxVar = ((Bracket)aux).x.indice;
            aux = aux.dsc("3");
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
            aux = aux.dsc("3");
        }
        for (int i=0; i< nMax; i++) {
            aux = max;
            for (int j=0; j< nMax-1-i;j++) {
                aux = aux.dsc("3");
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
    
    public Term type() {
        Term pType = p.type();
        Term qType = q.type();

        if(inferType == 'i'){
            try {
                Term right = qType.dsc("12");      
                Term left  = qType.dsc("2");
                Term aux   = left;
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
                    aux = aux.dsc("3");
                }
                String vars = ";"+((TypedA)q).variables_.split(";")[0];
                return new App(new App(new Const(0,"="),right),left).evaluar(vars).abstractEq();
            }
            catch (CloneNotSupportedException e){
                e.printStackTrace();
            }
        }
        else if (inferType == 'l'){
            Term z = ((Bracket)pType).x;
            Term aux = qType.dsc("2");
            while (aux instanceof Bracket) {
                z = new App(z,((Bracket)aux).x);
                aux = aux.dsc("3");
            }
            Term E = pType.dsc("3").sust(((Bracket)pType).x,z);
            String[] boundVars = {""};
            qType.dsc("12").body().boundVars(boundVars);
            qType.dsc("2").body().boundVars(boundVars);
            Term t1 = E.sust(((Bracket)pType).x, qType.dsc("2"));   
            Term t2 = E.sust(((Bracket)pType).x, qType.dsc("12"));

            return  new App(new App(new Const(0,"="), t2),t1).evaluar(TermUtilities.arguments(boundVars[0])).abstractEq();
        }
        if (inferType == 's'){
            return new App(new App(new Const("="), qType.dsc("2")), qType.dsc("12"));
        }
        else if (inferType == 'm'){
            Const eq = (Const)pType.dsc("11");
            pType = pType.dsc("2").body().dsc("12");
            Const T = (Const)qType.dsc("12").body();
            return new App(new App(eq,T),pType).abstractEq();
        }
        else if (inferType == 'e'){
            Const eq = (Const)pType.dsc("11");      
            pType    = pType.dsc("12").body();
            Const T  = (Const)qType.dsc("12").body();
            return new App(new App(eq,T),pType).abstractEq();
        }
        else{
            Term pIzq = pType.dsc("2").body();        
            Term qDer = qType.dsc("12").body();
            Const op1 = (Const)pType.dsc("11");
           
            return new App(new App(op1, qDer), pIzq).abstractEq();
            // verificar si compartir terminos no trae problemas con reducir
        }
    }
    
    public String getCombDBType(){
        return "";
    }
}