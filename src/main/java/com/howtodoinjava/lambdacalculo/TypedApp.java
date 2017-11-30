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
public class TypedApp extends App{
    
    
    public TypedApp(Term t1, Term t2)  throws TypeVerificationException
    {
        super(t1, t2);
        Term t1Type = t1.type();
        Term t2Type = t2.type();
        
        if (t1Type instanceof Sust )
            ;
        else if (t1Type instanceof Bracket) //t2Type tiene que ser equiv
            ;
        else if (t1Type instanceof App)
        {
            Term t1Izq = ((App)t1Type).p;
            if (!t1Izq.equals(t2Type)) //verificar que son eq, = o ==>
            {
                try
                {
                  Term t1Der = ((App)((App)t1Type).p).q;
                  Term t2Izq = ((App)t2Type).q;
        
                  if (!t1Der.equals(t2Izq))
                    throw new TypeVerificationException();
                }
                catch (Exception e)
                {
                  throw new TypeVerificationException();
                }
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
            return qType.sustParall(((Sust)pType).vars, ((Sust)qType).terms);
        else if (pType instanceof Bracket)
            return (new App(pType, qType)).reducir();
        else
        {
           Term pIzq = ((App)p).q;
           if (pIzq.equals(qType))
               return ((App)((App)p)).q;
           Term qDer = ((App)((App)q).p).q;
        
           return new App(new App(((App)((App)q).p).p, qDer), pIzq);
           // verificar si compartir terminos no trae problemas con reducir
        }
    }
}
