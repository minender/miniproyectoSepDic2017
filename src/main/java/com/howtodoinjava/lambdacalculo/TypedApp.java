/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.lambdacalculo;

/**
 *
 * @author federico
 */
public class TypedApp extends App implements TypedTerm{
    
    
    public TypedApp(Term t1, Term t2)  throws TypeVerificationException
    {
        super(t1, t2);
        Term t1Type = t1.type();
        Term t2Type = t2.type();
        
        if (t1Type instanceof Sust )
            ;
        else if (t1Type instanceof Bracket) //t2Type tiene que ser equiv
        {
            try
            {
              String op = ((Const)((App)((App)t2Type).p).p).getCon().trim();
              if (!op.equals("c_{1}") && !op.equals("c_{10}"))
                  throw new TypeVerificationException();
            }
            catch (ClassCastException e)
            {
                throw new TypeVerificationException();
            }
        }
        else if (t1Type instanceof App)
        {
            Term t1Izq = ((App)t1Type).q;
            try
            {
              String op1 = ((Const)((App)((App)t1Type).p).p).getCon().trim();
              if (!op1.equals("c_{1}") && !op1.equals("c_{10}") && !op1.equals("\\Rightarrow") && !op1.equals("\\Leftarrow"))
                  throw new TypeVerificationException();
              if (!op1.equals("c_{1}") || !t1Izq.equals(t2Type)) 
              {
                Term t1Der = ((App)((App)t1Type).p).q;
                Term t2Izq = ((App)t2Type).q;
                String op2 = ((Const)((App)((App)t2Type).p).p).getCon().trim();
        
                boolean eq = op1.equals("c_{10}") && op2.equals("c_{10}");
                boolean eqAndOp = op1.equals("c_{1}") && (op2.equals("c_{1}")
                        || op2.equals("\\Leftarrow") || op2.equals("\\Rightarrow"));
                boolean leftAndOp = op1.equals("\\Leftarrow") && 
                        (op2.equals("\\Leftarrow") || op2.equals("c_{1}"));
                boolean rightAndOp = op1.equals("\\Rightarrow") && 
                        (op2.equals("\\Rightarrow") || op2.equals("c_{1}"));
                if (!((eq || eqAndOp || leftAndOp || rightAndOp) && t1Der.equals(t2Izq)))
                  throw new TypeVerificationException();
              }
            }
            catch (ClassCastException e)
            {
              throw new TypeVerificationException();
            }
        }
        else
            throw new TypeVerificationException();
    }
    
    public Term type()
    {
        Term pType = p.type();
        Term qType = q.type();
        if (pType instanceof Sust )
            return qType.sustParall(((Sust)pType).vars, ((Sust)pType).terms);
        else if (pType instanceof Bracket)
        {
            Term t1 = new App(pType,((App)qType).q).reducir();
            Term t2 = new App(pType,((App)((App)qType).p).q).reducir();
            Term op2 = ((App)((App)qType).p).p; // incluir paridad aqui
            return new App(new App(op2, t2),t1);
        }
        else
        {
           Term pIzq = ((App)pType).q; //((App)((App)pType).p).q;
           if (pIzq.equals(qType))
               return ((App)((App)pType).p).q;
           Term qDer = ((App)((App)qType).p).q;
           Const op1 = (Const)((App)((App)pType).p).p;
           Const op2 = (Const)((App)((App)qType).p).p;
           
           if (op1.equals(op2))
               return new App(new App(op1, qDer), pIzq);
           else if (op1.getCon().trim().equals("c_{1}"))
               return new App(new App(op2, qDer), pIzq);
           else
               return new App(new App(op1, qDer), pIzq);
           // verificar si compartir terminos no trae problemas con reducir
        }
    }
}
