/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.lambdacalculo;

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
        if (t1Type instanceof Sust)
            inferType = 'i';
        else if (t1Type instanceof Bracket) //t2Type tiene que ser equiv
        {
            try{
                String op = ((Const)((App)((App)t2Type).p).p).getCon().trim();
                if (!op.equals("="))
                    throw new TypeVerificationException();
            }
            catch (ClassCastException e){
                throw new TypeVerificationException();
            }
            inferType = 'l'; // Cuando se tipe hay que verificar si (t1Type t2Type) no dan error de tipo
        }
        else if (t1Type instanceof App)
        {
            Term t1Izq = ((App)t1Type).q;
            try
            {
                String op1 = ((Const)((App)((App)t1Type).p).p).getCon().trim();
                if (!op1.equals("="))
                    throw new TypeVerificationException();
                else if (((App)((App)t1Type).p).q.containT() && 
                         !(((App)((App)t1Type).p).q.body() instanceof App)
                        ){
                    t1Type = ((App)t1Type).q.body();
                    t1Izq = ((App)t1Type).q;
                    op1 = ((Const)((App)((App)t1Type).p).p).getCon();
                    if (!op1.equals("c_{2}")) //&& !op1.equals("c_{3}"))// el c_{3} como que esta de mas
                        throw new TypeVerificationException();
                }
                if ((!op1.equals("=") && !op1.equals("c_{2}")) || !t1Izq.equals(t2Type)) 
                {//(q==r)=q q=r pilas con este caso no se sabe si es equanimity o transitividad
                    Term t1Der = ((App)((App)t1Type).p).q;
                    Term t2Izq = ((App)t2Type).q;
                    String op2 = ((Const)((App)((App)t2Type).p).p).getCon().trim();
            
                    boolean eq = op1.equals("=") && op2.equals("=");
                    //t1Der = t1Der.traducBD();
                    //t2Izq = t2Izq.traducBD();
                    //boolean equiv = op1.equals("c_{1}") && op2.equals("c_{1}");
    //                boolean eqAndOp = op1.equals("c_{1}") && (op2.equals("c_{1}")
    //                        || op2.equals("c_{3}") || op2.equals("c_{2}"));
    //                boolean leftAndOp = op1.equals("c_{3}") && 
    //                        (op2.equals("c_{3}") || op2.equals("c_{1}"));
    //                boolean rightAndOp = op1.equals("c_{2}") && 
    //                        (op2.equals("c_{2}") || op2.equals("c_{1}"));
                    if (!(/*(eq || equiv)(eq || eqAndOp || leftAndOp || rightAndOp)*/
                            eq && t1Der.body().equals(t2Izq.body()))){
                        throw new TypeVerificationException();
                    }
                    else
                        inferType = 't';
                }
                else
                    inferType = (op1.equals("c_{2}")?'m':'e');
            }
            catch (ClassCastException e){
                throw new TypeVerificationException();
            }
        }
        else if (t1 instanceof TypedS) // <== S operand created by the grammar
        {   
            try {
                // type should be of the form r1==r2
                // extract r1, r2 and the operand
                App rootRight = (App)t2Type;
                App leftChild = (App)rootRight.p;
                Const op = (Const)leftChild.p;

                // check if it's deducting an equivalence or not
                if (!op.getCon().trim().equals("="))
                    throw new TypeVerificationException();
                /*
                Term r1 = leftChild.q;
                Term r2 = rootRight.q;  

                // create new tree with r2==r1
                App inverseApp = new App(new App(op, r2), r1);
                // (r1==r2)==(r2==r1)
                Term type = new App(new App(new Const(2,"c_{2}"), inverseApp), rootRight);
                // set the deducted type
                ((TypedS)t1).setSimetry(type);
                */
  
                // select type for simetry
                inferType = 's';

            } catch (ClassCastException e) {
                throw new TypeVerificationException();
            }
        }
        /*else if (t1 instanceof TypedU || (t1Type instanceof Const && t1Type.toString().equals("U"))){
            ;
        }*/
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
        if (p instanceof TypedS)
        {
            return new App(new App(new Const("="), ((App)qType).q), ((App)((App)qType).p).q);
        }
        else if(pType instanceof Sust)
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
            Term right = ((App)((App)qType).p).q.body().sustParall((Sust)pType);
            Term left = (((App)qType).q).body().sustParall((Sust)pType);
           
            return new App(new App(new Const("="),right),left).abstractEq();
        }
        else if (pType instanceof Bracket)
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
        /*else if (pType.toString().equals("U") || pType.toString().equals("U"))
        {
            return new Const("U");
        }*/
        else
        {
            Term pIzq = ((App)pType).q; //((App)((App)pType).p).q;
            if (pIzq.equals(qType))
                return ((App)((App)pType).p).q;
            Term qDer = ((App)((App)qType).p).q;
            Const op1 = (Const)((App)((App)pType).p).p;
            //Const op2 = (Const)((App)((App)qType).p).p;
           
            // incesario luego que se elminaron reglas de inferencias
            //if (op1.equals(op2)) {
                return new App(new App(op1, qDer), pIzq);
            /*}
            else if (op1.getCon().trim().equals("c_{1}")) // este no va
                return new App(new App(op2, qDer), pIzq);
            else                                          // este no va
                return new App(new App(op1, qDer), pIzq);
            // verificar si compartir terminos no trae problemas con reducir
            */
        }
    }
    
    public String getCombDBType()
    {
        return "";
    }
}