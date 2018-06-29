/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.forms;
import com.howtodoinjava.entity.Resuelve;
import com.howtodoinjava.lambdacalculo.App;
import com.howtodoinjava.lambdacalculo.Const;
import com.howtodoinjava.lambdacalculo.PasoInferencia;
import com.howtodoinjava.lambdacalculo.Term;
import com.howtodoinjava.lambdacalculo.TypedApp;
import com.howtodoinjava.lambdacalculo.TypedI;
import com.howtodoinjava.lambdacalculo.TypedL;
import com.howtodoinjava.lambdacalculo.TypedS;
import com.howtodoinjava.service.DisponeManager;
import com.howtodoinjava.service.ResuelveManager;
import java.util.List;

/**
 *
 * @author francisco
 */
public class InferResponse {
    
    private String historial;
    private String errorParser2;
    private String errorParser3;
    private String cambiarMetodo;
    private String nSol;
    private String lado;
    private String resuelto;

    public String getResuelto() {
        return resuelto;
    }

    public void setResuelto(String resuelto) {
        this.resuelto = resuelto;
    }

    public String getLado() {
        return lado;
    }

    public void setLado(String lado) {
        this.lado = lado;
    }

    public String getnSol() {
        return nSol;
    }

    public void setnSol(String nSol) {
        this.nSol = nSol;
    }

    public String getCambiarMetodo() {
        return cambiarMetodo;
    }

    public void setCambiarMetodo(String cambiarMetodo) {
        this.cambiarMetodo = cambiarMetodo;
    }

    public String getHistorial() {
        return historial;
    }

    public void setHistorial(String formula) {
        this.historial = formula;
    }

    public String getErrorParser2() {
        return errorParser2;
    }

    public void setErrorParser2(String errorParser2) {
        this.errorParser2 = errorParser2;
    }

    public String getErrorParser3() {
        return errorParser3;
    }

    public void setErrorParser3(String errorParser3) {
        this.errorParser3 = errorParser3;
    }
    

    public void generarHistorial(String formula, String nTeo,String pasoPost, Boolean valida, Term typedTerm) {//List<PasoInferencia> inferencias){
        
        this.setHistorial("Theorem "+nTeo+":<br> <center>$"+formula+"$</center> Proof:");  
        
        String primExp = "";
        String teo = "";
        String leib = "";
        String inst = "";
        String hint = "";
        /*for (PasoInferencia x: inferencias) {*/
        if (typedTerm instanceof App)
            if (((App)typedTerm).q instanceof App)
                if (((App)((App)typedTerm).q).q instanceof App)
                {
                    teo = ((App)((App)((App)typedTerm).q).q).q.type().toStringInfFinal();
                    inst = ((App)((App)((App)typedTerm).q).q).p.type().toStringInfFinal();
                    leib = ((App)((App)typedTerm).q).p.type().toStringInfFinal();
                }
                else
                {
                    teo = ((App)((App)typedTerm).q).q.type().toStringInfFinal();
                    if (((App)typedTerm).p instanceof TypedS)
                      if (((App)((App)typedTerm).q).p instanceof TypedI)
                      {
                        inst = ((App)((App)typedTerm).q).p.type().toStringInfFinal();
                        leib = "";
                      }
                      else
                      {
                        inst = "";
                        leib = ((App)((App)typedTerm).q).p.type().toStringInfFinal();
                      }
                }
            else
            {
                Term aux = typedTerm.type();
                teo = aux.toStringInfFinal();
                primExp = ((App)aux).q.toStringInfFinal();
                pasoPost = ((App)((App)aux).p).q.toStringInfFinal();
            }
        else
        {
            Term aux = typedTerm.type();
            teo = aux.toStringInfFinal();
            primExp = ((App)aux).q.toStringInfFinal();
            pasoPost = ((App)((App)aux).p).q.toStringInfFinal();
        }
        hint = "\\equiv<"+teo+"-"+inst+"-"+leib+">";
            this.setHistorial("$$" + primExp + " $$" +
                              " $$"+ hint +"$$"+this.getHistorial());
            /*this.setHistorial(this.getHistorial()+ "$$" +
                                    x.getExpresion().toStringInfFinal()+" $$" + " $$ \\equiv< " + 
                                    new App(new App(new Const("\\equiv "),x.getTeoDer()), x.getTeoIzq()).toStringInfFinal() + 
                                    " - " + x.getLeibniz().toStringInfFinal() + 
                                    " - " + x.getInstancia().toString()+" > $$");
            ultimaExp = x.getResult().toStringInfFinal();
        }*/
        if(valida) {
            this.setHistorial(this.getHistorial()+ "$$" +pasoPost + "$$");
        } else {
            this.setHistorial(this.getHistorial()+ "$$" +pasoPost + "$$" + "$$" + pasoPost + "$$");
        }
    }
    
    public void generarHistorial(String user, String formula, String nTeo, Term typedTerm,  Boolean valida, ResuelveManager resuelveManager, DisponeManager disponeManager) {//List<PasoInferencia> inferencias){
        
        this.setHistorial("");
        String header = "Theorem "+nTeo+":<br> <center>$"+formula+"$</center> Proof:<br>";  
        
        Term type = typedTerm==null?null:typedTerm.type();
        if (typedTerm==null)
        {
            this.setHistorial(header);
        }
        else if (type == null && !valida)
        {
            this.setHistorial(header+"<center>$"+typedTerm.toStringInfLabeled()+"$$Regla~de~inferencia~no~valida$$");
        }
        else if(type == null && valida)
        {
            this.setHistorial(header+"<center>$"+typedTerm.toStringInfLabeled()+"</center>");
        }
        else
        {
          boolean equanimity;
          try{
            if (!(((TypedApp)typedTerm).p instanceof TypedS) && ((App)((TypedApp)typedTerm).p.type()).q.equals(((TypedApp)typedTerm).q.type()))
                equanimity = true;
            else
                equanimity = false;
          }
          catch (ClassCastException e){
              equanimity = false;
          }
          
          String equanimityHint = "";
          Term goal = null;
          if (equanimity)
          {
              goal = (((TypedApp)typedTerm).q).type();
              typedTerm = ((TypedApp)typedTerm).p;
              type = typedTerm.type();
              Resuelve eqHintResuel = resuelveManager.getResuelveByUserAndTeorema(user, goal.toStringFinal());
              if (eqHintResuel == null)
              {
                  equanimityHint = disponeManager.getDisponeByUserAndMetaeorema(user, goal.toStringFinal()).getNumerometateorema();
                  equanimityHint = "~~~-~mt~("+equanimityHint+")";
              }
              else
              {    
                equanimityHint = eqHintResuel.getNumeroteorema();
                equanimityHint = "~~~-~st~("+equanimityHint+")";
              }
          }

          String pasoPost="";
          if (equanimity && typedTerm instanceof TypedApp && ((TypedApp)typedTerm).p instanceof TypedS)
          {
            typedTerm = ((TypedApp)typedTerm).q;
            type = typedTerm.type();
            pasoPost= ((App)((App)type).p).q.toStringInfFinal()+equanimityHint+"$";
          }
          else
            pasoPost= ((App)((App)type).p).q.toStringInfLabeled();
        /*this.setHistorial("Theorem "+nTeo+":<br> <center>$"+formula+"$</center> Proof:");  
        String ultimaExp = "";
        for (PasoInferencia x: inferencias) {
            this.setHistorial(this.getHistorial()+ "$$" +
                                    x.getExpresion().toStringInfFinal()+" $$" + " $$ \\equiv< " + 
                                    new App(new App(new Const("\\equiv "),x.getTeoDer()), x.getTeoIzq()).toStringInfFinal() + 
                                    " - " + x.getLeibniz().toStringInfFinal() + 
                                    " - " + x.getInstancia()+" > $$");
                ultimaExp = x.getResult().toStringInfFinal();
        }
        if(!ultimaExp.equals("")){
            this.setHistorial(this.getHistorial()+ "$$" +ultimaExp + "$$");
        }*/
            String primExp = "";
            String teo = "";
            String leib = "";
            String inst = "";
            String hint = "";
            Term iter = typedTerm;
            Term ultInf = null;
            while (iter!=ultInf) 
            {
              if (iter instanceof App && ((App)iter).p.containTypedA())
              {
                ultInf = ((App)iter).q;
                iter = ((App)iter).p;
              }
              else
                ultInf = iter;
              if (ultInf instanceof App)
                if (((App)ultInf).q instanceof App)
                  if (((App)((App)ultInf).q).q instanceof App)
                  {
                    Term aux = ((App)ultInf.type()).q;
                    primExp = aux.toStringInfFinal()+(aux.equals(goal)?equanimityHint:"");
                    teo = ((App)((App)((App)ultInf).q).q).q.type().toStringFinal();
                    inst = ((App)((App)((App)ultInf).q).q).p.type().toStringInfFinal();
                    inst = "~with~" + inst.substring(1, inst.length()-1);
                    leib = ((App)((App)ultInf).q).p.type().toStringInfFinal();
                    leib = "~and~" + leib;
                  }
                  else
                  {
                    Term aux = ((App)ultInf.type()).q;
                    primExp = aux.toStringInfFinal()+(aux.equals(goal)?equanimityHint:"");
                    teo = ((App)((App)ultInf).q).q.type().toStringFinal();
                    if (((App)ultInf).p instanceof TypedS)
                      if (((App)((App)ultInf).q).p instanceof TypedI)
                      {
                        inst = ((App)((App)ultInf).q).p.type().toStringInfFinal();
                        inst = "~with~" + inst.substring(1, inst.length()-1);
                      }
                      else
                      {
                        leib = ((App)((App)ultInf).q).p.type().toStringInfFinal();
                        leib = "~and~" + leib;
                      }
                    else
                    {
                        inst = ((App)((App)ultInf).q).p.type().toStringInfFinal();
                        inst = "~with~" + inst.substring(1, inst.length()-1);
                        leib = ((App)ultInf).p.type().toStringInfFinal();
                        leib = "~and~" + leib;
                    }
                  }
                else
                {
                  if (((App)ultInf).p instanceof TypedI)
                  {
                    inst = ((App)ultInf).p.type().toStringInfFinal();
                    inst = "~with~" + inst.substring(1, inst.length()-1);
                  }
                  else if (((App)ultInf).p instanceof TypedL)
                    leib = "~and~" + ((App)ultInf).p.type().toStringInfFinal();
                  teo = ((App)ultInf).q.type().toStringFinal();
                  Term aux = ((App)ultInf.type()).q;
                  primExp = aux.toStringInfFinal()+(aux.equals(goal)?equanimityHint:"");
                }
              else
              {
                Term aux = ultInf.type();
                teo = aux.toStringFinal();
                primExp = ((App)aux).q.toStringInfFinal()+(aux.equals(goal)?equanimityHint:"");
              } 
          
              String op = ((Const)((App)((App)ultInf.type()).p).p).getCon().trim();
              Resuelve theo = resuelveManager.getResuelveByUserAndTeorema(user, teo);
              if (theo == null)
              {
                teo = disponeManager.getDisponeByUserAndMetaeorema(user, teo).getNumerometateorema();
                hint = op+"~~~~~~\\langle mt~("+teo+")"+inst+leib+"\\rangle";
              }
              else
              {
                teo = theo.getNumeroteorema();
                hint = op+"~~~~~~\\langle st~("+teo+")"+inst+leib+"\\rangle";
              }
              this.setHistorial("~~~~~~" + primExp +" \\\\"+ hint +"\\\\"+this.getHistorial());
              primExp = "";
              teo = "";
              leib = "";
              inst = "";
              hint = "";
            }
            this.setHistorial(header+"<center>$"+this.getHistorial()+"~~~~~~"+pasoPost+"</center>");
            if (!valida)
              this.setHistorial("$"+this.getHistorial()+"$"+"$$Regla~de~inferencia~no~valida$$");
        //this.setHistorial(this.getHistorial()+ "$$" +pasoPost + "$$");
          
        }
    }
    
}
