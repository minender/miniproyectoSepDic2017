/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.forms;
import com.fasterxml.jackson.annotation.ObjectIdGenerators.IntSequenceGenerator;
import com.howtodoinjava.entity.Resuelve;
import com.howtodoinjava.lambdacalculo.App;
import com.howtodoinjava.lambdacalculo.Bracket;
import com.howtodoinjava.lambdacalculo.Const;
import com.howtodoinjava.lambdacalculo.Corrida;
import com.howtodoinjava.lambdacalculo.PasoInferencia;
import com.howtodoinjava.lambdacalculo.Term;
import com.howtodoinjava.lambdacalculo.TypeVerificationException;
import com.howtodoinjava.lambdacalculo.TypedA;
import com.howtodoinjava.lambdacalculo.TypedApp;
import com.howtodoinjava.lambdacalculo.TypedI;
import com.howtodoinjava.lambdacalculo.TypedL;
import com.howtodoinjava.lambdacalculo.TypedS;
import com.howtodoinjava.lambdacalculo.Var;
import com.howtodoinjava.service.DisponeManager;
import com.howtodoinjava.service.ResuelveManager;
import com.howtodoinjava.service.SimboloManager;
import com.sun.org.apache.bcel.internal.generic.NEW;

import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

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
    

/*    public void generarHistorial(String formula, String nTeo,String pasoPost, Boolean valida, Term typedTerm, SimboloManager s) {//List<PasoInferencia> inferencias){
        
        this.setHistorial("Theorem "+nTeo+":<br> <center>$"+formula+"$</center> Proof:");  
        
        String primExp = "";
        String teo = "";
        String leib = "";
        String inst = "";
        String hint = "";
        //for (PasoInferencia x: inferencias) {
        if (typedTerm instanceof App)
            if (((App)typedTerm).q instanceof App)
                if (((App)((App)typedTerm).q).q instanceof App)
                {
                    teo = ((App)((App)((App)typedTerm).q).q).q.type().toStringInfFinal(s);
                    inst = ((App)((App)((App)typedTerm).q).q).p.type().toStringInfFinal(s);
                    leib = ((App)((App)typedTerm).q).p.type().toStringInfFinal(s);
                }
                else
                {
                    teo = ((App)((App)typedTerm).q).q.type().toStringInfFinal(s);
                    if (((App)typedTerm).p instanceof TypedS)
                      if (((App)((App)typedTerm).q).p instanceof TypedI)
                      {
                        inst = ((App)((App)typedTerm).q).p.type().toStringInfFinal(s);
                        leib = "";
                      }
                      else
                      {
                        inst = "";
                        leib = ((App)((App)typedTerm).q).p.type().toStringInfFinal(s);
                      }
                }
            else
            {
                Term aux = typedTerm.type();
                teo = aux.toStringInfFinal(s);
                primExp = ((App)aux).q.toStringInfFinal(s);
                pasoPost = ((App)((App)aux).p).q.toStringInfFinal(s);
            }
        else
        {
            Term aux = typedTerm.type();
            teo = aux.toStringInfFinal(s);
            primExp = ((App)aux).q.toStringInfFinal(s);
            pasoPost = ((App)((App)aux).p).q.toStringInfFinal(s);
        }
        hint = "\\equiv<"+teo+"-"+inst+"-"+leib+">";
            this.setHistorial("$$" + primExp + " $$" +
                              " $$"+ hint +"$$"+this.getHistorial());
            //this.setHistorial(this.getHistorial()+ "$$" +
            //                        x.getExpresion().toStringInfFinal()+" $$" + " $$ \\equiv< " + 
            //                        new App(new App(new Const("\\equiv "),x.getTeoDer()), x.getTeoIzq()).toStringInfFinal() + 
            //                        " - " + x.getLeibniz().toStringInfFinal() + 
            //                        " - " + x.getInstancia().toString()+" > $$");
            //ultimaExp = x.getResult().toStringInfFinal();
        //}
        if(valida) {
            this.setHistorial(this.getHistorial()+ "$$" +pasoPost + "$$");
        } else {
            this.setHistorial(this.getHistorial()+ "$$" +pasoPost + "$$" + "$$" + pasoPost + "$$");
        }
    }*/
    
    public boolean isIAA(Term root, SimboloManager s) {
    	
    	if(!(root instanceof App)) return false;
    	
    	Term leftSide = ((App)root).p.type();
    	
    	if( ((App)root).q instanceof TypedA &&
    	    ((App)root).p instanceof App &&
    	    ((App)((App)root).p).p instanceof TypedI &&
    	    ((App)((App)root).p).q instanceof TypedA &&
    	    										 
    	    leftSide instanceof App && ((App)leftSide).p instanceof App &&
    	    (((App)((App)leftSide).p).p).toStringInf(s, "").equals("\\Rightarrow") && 
    	    ((App)leftSide).q.equals(((App)root).q.type())
    	    
    	) return true;
    	
    	return false;
    	
    }
    
    public boolean isIAIA(Term root, SimboloManager s) {
    	
    	if(!(root instanceof App)) return false;
    	
    	Term leftSide = ((App)root).p.type();
    	
    	if( ((App)root).q instanceof App &&
        	((App)((App)root).q).p instanceof TypedI &&
        	((App)((App)root).q).q instanceof TypedA &&
    	    ((App)root).p instanceof App &&
    	    ((App)((App)root).p).p instanceof TypedI &&
    	    ((App)((App)root).p).q instanceof TypedA &&
    	    
    	    leftSide instanceof App && ((App)leftSide).p instanceof App &&
    	    (((App)((App)leftSide).p).p).toStringInf(s, "").equals("\\Rightarrow") && 
    	    ((App)leftSide).q.equals(((App)root).q.type())
    	    
    	) return true;
    	
    	return false;    	
    	
    }
    
    /**
     * This functions checks if the given Term represents a modus ponens hint
     * @param root root node of the hint 
     * @param s
     * @return "Nomodus" if is not modus ponens, another string depending on the case
     */
    public String isModusPonens(Term root, SimboloManager s) {
    	
    	if(!(root instanceof App)) return "NoModus";
    	
    	// Case 1: IAA
    	if(isIAA(root, s)) return "IAA";
    	
    	// Case 2: IAIA
    	if(isIAIA(root, s)) return "IAIA";
    	
    	// Case 3: S(IAIA)
    	if( ((App)root).p instanceof TypedS && isIAIA(((App)root).q, s)) return "S(IAIA)";
    	
    	// Case 4: S(IAA)
    	if( ((App)root).p instanceof TypedS && isIAA(((App)root).q, s)) return "S(IAA)";
    	
    	return "NoModus";
    }
    
    /**
     * return the index (counting in reverse) of the first inference that is not a 
     * equiv or = in a Transitivity method
     * @param typedTerm derivation tree that code a Transitivity proof
     * @return index of the first no =inference
     */
    private int wsFirstOpInferIndex(Term typedTerm) {
        Term iter = typedTerm;
    	Term ultInf = null;
        int i = 0;
        int firstOpInf = 0;
        while (iter!=ultInf)
        {
            if (iter instanceof TypedApp && ((TypedApp)iter).inferType=='t') {// TT
               ultInf = ((TypedApp)iter).q;
               iter = ((TypedApp)iter).p;   
            }
            else if (iter instanceof TypedApp && ((TypedApp)iter).inferType=='m' &&
                     ((TypedApp)iter).p instanceof TypedApp && 
                     ((TypedApp)((TypedApp)iter).p).inferType=='m' && 
                     ((TypedApp)((TypedApp)iter).p).p instanceof TypedApp &&
                     ((TypedApp)((TypedApp)((TypedApp)iter).p).p).inferType=='i'
                    ) { // ((IA)T)T
               ultInf = ((TypedApp)iter).q;
               iter = ((TypedApp)((TypedApp)iter).p).q;
            }
            else { // first inference
                ultInf = iter;
            }
            i++;
            Term ultInfType = ultInf.type();
            if (ultInfType instanceof App && ((App)ultInfType).p instanceof App &&
                   !(((App)((App)ultInfType).p).p.toStringFinal().equals("c_{1}") ||
                     ((App)((App)ultInfType).p).p.toStringFinal().equals("c_{10}")
                    )
               )
                firstOpInf = i;
        }
        return firstOpInf;
    }
    
    private String hintOneSide(String user, Term typedTerm, ResuelveManager resuelveManager, DisponeManager disponeManager, SimboloManager s) {
        
            String teo = "";
            String leib = "";
            String inst = "";
            String hint = "";
            // if the inference is a modus pones that simulates natural deduction is true this
            boolean naturalInfer=typedTerm instanceof TypedApp && ((TypedApp)typedTerm).inferType=='m';
            Term ultInf = (naturalInfer?((TypedApp)typedTerm).p:typedTerm);
            
            if (ultInf instanceof App)
                if (((App)ultInf).q instanceof App)
                  if (((App)((App)ultInf).q).q instanceof App)
                  {
                  //  Term aux = ((App)ultInf.type()).q;
        //            primExp = aux.toStringInf(s,"")+(aux.equals(goal)?equanimityHint:"");
                    teo = ((App)((App)((App)ultInf).q).q).q.type().toStringFinal();
                    inst = ((App)((App)((App)ultInf).q).q).p.type().toStringInf(s,"");
                    inst = "~\\text{with}~" + inst;
                    leib = ((App)((App)ultInf).q).p.type().toStringInf(s,"");
                    leib = "~\\text{and}~" + leib;
                  }
                  else
                  {
                    //Term aux = ((App)ultInf.type()).q;
          //          primExp = aux.toStringInf(s,"")+(aux.equals(goal)?equanimityHint:"");
                    teo = ((App)((App)ultInf).q).q.type().toStringFinal();
                    if (((App)ultInf).p instanceof TypedS)
                      if (((App)((App)ultInf).q).p instanceof TypedI)
                      {
                        inst = ((App)((App)ultInf).q).p.type().toStringInf(s,"");
                        inst = "~\\text{with}~" + inst;
                      }
                      else
                      {
                        leib = ((App)((App)ultInf).q).p.type().toStringInf(s,"");
                        leib = "~\\text{and}~" + leib;
                      }
                    else
                    {
                        inst = ((App)((App)ultInf).q).p.type().toStringInf(s,"");
                        inst = "~\\text{with}~" + inst;
                        leib = ((App)ultInf).p.type().toStringInf(s,"");
                        leib = "~\\text{and}~" + leib;
                    }
                  }
                else
                {
                  Term pType = ((App)ultInf).p.type();
                  if (((App)ultInf).p instanceof TypedI)
                  {
                    inst = pType.toStringInf(s,"");
                    inst = "~\\text{with}~" + inst;
                  }
                  else if (((App)ultInf).p instanceof TypedL)
                    leib = "~\\text{and}~" + pType.toStringInf(s,"");
                  // El caso SA no entra en ninguna de estas dos guardias y solo se asigna teo
                  teo = ((App)ultInf).q.type().toStringFinal();
                  
                }
            else
            {
              Term aux = ultInf.type();
              teo = aux.toStringFinal();
              //  primExp = ((App)aux).q.toStringInf(s,"")+(aux.equals(goal)?equanimityHint:"");
            } 
          
            int conId =(naturalInfer? ((Const)((App)((App)((App)((App)ultInf.type()).p).q).p).p).getId() 
                                    :((Const)((App)((App)ultInf.type()).p).p).getId());
            String op = s.getSimbolo(conId).getNotacion_latex();
            Resuelve theo = resuelveManager.getResuelveByUserAndTeorema(user, teo);
            if (theo == null)
            {
               teo = disponeManager.getDisponeByUserAndMetaeorema(user, teo).getNumerometateorema();
               hint = op+"~~~~~~\\langle \\text{mt}~("+teo+")"+inst+leib+"\\rangle";
            }
            else
            {
              teo = theo.getNumeroteorema();
              hint = op+"~~~~~~\\langle \\text{st}~("+teo+")"+inst+leib+"\\rangle";
            }
            return hint;
    }

    private String hintWSEqInfer(String user, Term ultInf, ResuelveManager resuelveManager, DisponeManager disponeManager, SimboloManager s) {
        Term aux = ((TypedApp)ultInf).q;
        int z = ((Bracket)((TypedApp)ultInf).p.type()).x();
        Term t = ((App)((App)((Bracket)((TypedApp)ultInf).p.type()).t).p).q;
        Term typedTerm;
        try {
          typedTerm = (t instanceof Var?aux:new TypedApp(new TypedL(new Bracket(new Var(z),t)),aux));
        }
        catch (TypeVerificationException e) {
            Logger.getLogger(InferResponse.class.getName()).log(Level.SEVERE, null, e);
            return "";
	}
        return hintOneSide(user, typedTerm, resuelveManager, disponeManager, s);
    }
    
    private String hintWSOpInfer(String user, Term typedTerm, ResuelveManager resuelveManager, DisponeManager disponeManager, SimboloManager s) {
        
        Term iter, ultInf;
        iter = typedTerm;
        ultInf = null;
        Term leibniz = new Var('z');
        String hint = "";
        
        while (iter != ultInf) {
            //iter of the form (TT)T
            if (iter instanceof TypedApp && ((TypedApp)iter).p instanceof TypedApp) {
                boolean modusPones = ((TypedApp)iter).inferType=='m';
                ultInf = ((TypedApp)iter).p;
                iter = ((TypedApp)iter).q;
                
                Term t;
                if ( modusPones ) {
                    App aux = (App)((App)((App)((App)((TypedApp)ultInf).q.type()).p).q).q;
                    if ( ((Var)aux.q).indice == 112 ) {
                        t = new App(((App)aux).p,new Var('z'));
                    }
                    else {
                        t = new App(new App(((App)((App)aux).p).p,new Var('z')),((App)aux).q);
                    }
                }
                else {
                    t = new App(new Const(7,"c_{7}"),new Var('z'));
                }
                leibniz = leibniz.sust(new Var('z'), t);
                
            }
            else { // iter must be of the form IA or A
                ultInf = iter;
            }
        }
        hint = hintOneSide(user, ultInf, resuelveManager, disponeManager, s);
        hint = ((App)((App)typedTerm.type()).p).p.toStringInf(s,"")+hint.substring(hint.indexOf("~"));
        if (leibniz.toStringFinal().equals("x_{122}") )
            return hint;
        else
            return hint.substring(0, hint.length()-7)+"~and~E^z:"+leibniz.toStringInf(s, "")+"\\rangle";
    }
    
    private void setDirectProof(String user, Term typedTerm, boolean solved, ResuelveManager resuelveManager, DisponeManager disponeManager, SimboloManager s, boolean oneSide) {
        String primExp = "";
    	String hint = "";
        boolean equanimity = false;
        String equanimityHint = "";
        Term iter;
        String lastline = "";
        
        if (oneSide || !(typedTerm instanceof TypedApp) || ((TypedApp)typedTerm).inferType!='e') {
            if (solved && typedTerm instanceof TypedApp && ((TypedApp)typedTerm).inferType=='s') 
               iter = ((TypedApp)typedTerm).q;
            else
               iter = typedTerm;
            Term aux = ((App)((App)iter.type()).p).q;
            lastline = (solved?aux.toStringInf(s,"")+"$":aux.toStringInfLabeled(s));  
        }
        else if( ((TypedApp)typedTerm).p instanceof TypedApp && 
                 ((TypedApp)((TypedApp)typedTerm).p).inferType=='s' 
               ) 
        {
            iter = ((TypedApp)((TypedApp)typedTerm).p).q;
            Resuelve eqHintResuel = resuelveManager.getResuelveByUserAndTeorema(user, ((TypedApp)typedTerm).q.type().toStringFinal());
            equanimityHint = "~~~-~\\text{st}~("+eqHintResuel.getNumeroteorema()+")";
            lastline = ((App)((App)iter.type()).p).q.toStringInf(s,"")+equanimityHint+"$";
        }
        else  {
            iter = ((TypedApp)typedTerm).p;
            Resuelve eqHintResuel = resuelveManager.getResuelveByUserAndTeorema(user, ((TypedApp)typedTerm).q.type().toStringFinal());
            equanimityHint = "~~~-~\\text{st}~("+eqHintResuel.getNumeroteorema()+")";
            equanimity = true;
            lastline = ((App)((App)iter.type()).p).q.toStringInf(s,"")+"$";
        }
        
    	Term ultInf = null;
        while (iter!=ultInf)
        {
            if (iter instanceof TypedApp && ((TypedApp)iter).inferType=='t' ) {
                ultInf = ((TypedApp)iter).q;
                iter = ((TypedApp)iter).p;
                Term ultInfType = ultInf.type();
                primExp = ((App)ultInfType).q.toStringInf(s,""); 
            }
            else {
                ultInf = iter;
                Term ultInfType = ultInf.type();
                primExp = ((App)ultInfType).q.toStringInf(s,"");
                if ( equanimity)
                    primExp += equanimityHint;
            } 
            hint = hintOneSide(user, ultInf, resuelveManager, disponeManager, s);
            
            this.setHistorial("~~~~~~" + primExp +" \\\\"+ hint +"\\\\"+this.getHistorial());
            primExp = "";
            hint = "";
        }
        this.setHistorial(this.getHistorial()+"~~~~~~"+lastline);
    }
    
    private void setWSProof(String user, Term typedTerm, ResuelveManager resuelveManager, DisponeManager disponeManager, SimboloManager s) {
        String primExp = "";
    	String hint = "";
    	Term iter = typedTerm;
    	Term ultInf = null;
        int i = 0;
        int firstOpInf = wsFirstOpInferIndex(typedTerm);
        String lastline = ((App)((App)iter.type()).p).q.toStringInfLabeled(s)+"$";
        while (iter!=ultInf)
        {
            // iter is of the form TT with transitivity
            if (iter instanceof TypedApp && ((TypedApp)iter).inferType=='t') {
               ultInf = ((TypedApp)iter).q;
               iter = ((TypedApp)iter).p;   
            }
            else if (iter instanceof TypedApp && ((TypedApp)iter).inferType=='m' &&
                     ((TypedApp)iter).p instanceof TypedApp && 
                     ((TypedApp)((TypedApp)iter).p).inferType=='m' && 
                     ((TypedApp)((TypedApp)iter).p).p instanceof TypedApp &&
                     ((TypedApp)((TypedApp)((TypedApp)iter).p).p).inferType=='i'
                    ) { // iter is of the form ((IA)T)T wit modus pones
               ultInf = ((TypedApp)iter).q;
               iter = ((TypedApp)((TypedApp)iter).p).q;
            }
            else { // first inference
                ultInf = iter;
            }
            i++;
            // if ultInf is a no =inference do this
            Term ultInfType = ultInf.type();
            if (ultInfType instanceof App && ((App)ultInfType).p instanceof App &&
                   !(((App)((App)ultInfType).p).p.toStringFinal().equals("c_{1}") ||
                     ((App)((App)ultInfType).p).p.toStringFinal().equals("c_{10}")
                    )
               )
            {
                primExp = ((App)ultInfType).q.toStringInf(s,""); 
                hint = hintWSOpInfer(user, ultInf, resuelveManager, disponeManager, s);
            }
            else if (ultInf == iter){ // ultInf is a =inference and the first one
                // ultInf is a no =inference folowing with a matatheorem of true
                if ( ultInf instanceof TypedApp && ((TypedApp)ultInf).inferType=='e' &&
                     ((TypedApp)ultInf).p instanceof TypedApp && 
                     ((TypedApp)((TypedApp)ultInf).p).p instanceof TypedS
                   )// query that verify if metatheorem was used i.e ultInf of the form 
                    // (S(T)).T with . equanimity
                {
                   primExp = ((App)  ((App)((App)ultInfType).p).q  ).q.toStringInf(s,""); 
                   hint = hintWSOpInfer(user, ((App)ultInf).q, resuelveManager, disponeManager, s);
                } else { // ultInf is a =inference of one side method
                    primExp = ((App)ultInfType).q.toStringInf(s,""); 
                    hint = hintOneSide(user, ultInf, resuelveManager, disponeManager, s);
                }
            } else if (i<firstOpInf){ // ultInf is a =inference and not the first one and  
                                    // after at least one no =inference
                primExp = ((App)((App)((App)ultInfType).q).p).q.toStringInf(s,""); 
                hint = hintWSEqInfer(user, ultInf, resuelveManager, disponeManager, s);
            } else { // ultInf is a =inference and not the first one
                   // and before the first no =inference
                primExp = ((App)ultInfType).q.toStringInf(s,""); 
                hint = hintOneSide(user, ultInf, resuelveManager, disponeManager, s);
            }
            
            this.setHistorial("~~~~~~" + primExp +" \\\\"+ hint +"\\\\"+this.getHistorial());
            primExp = "";
            hint = "";
        }
        this.setHistorial(this.getHistorial()+"~~~~~~"+lastline);
    }
    
    public void generarHistorial(String user, Term formula, String nTeo, Term typedTerm,  Boolean valida,String metodo, ResuelveManager resuelveManager, DisponeManager disponeManager, SimboloManager s) {//List<PasoInferencia> inferencias){
        
        this.setHistorial("");
        String header = "Theorem "+nTeo+":<br> <center>$"+formula.toStringInf(s,"")+"$</center> Proof:<br>";  
                
        String[] metodos = metodo.split(",");
        
        // Must check if we are doing Natural deduction
        boolean naturalDirect = metodos.length > 1 && metodos[0].equals("Natural Deduction") && metodos[1].equals("direct");
        boolean naturalSide = metodos.length > 1 && metodos[0].equals("Natural Deduction") && metodos[1].equals("one-sided");
        boolean oneSide = metodo.equals("Starting from one side");
        boolean direct = metodo.equals("Direct method");
        boolean weakening = metodo.equals("Weakening");
        boolean strengthening = metodo.equals("Strengthening");
        
        Term type = typedTerm==null?null:typedTerm.type();
        boolean solved;
        if (typedTerm==null)
        {
            this.setHistorial(header);
            solved = false;
            return;
        }
        if (type == null && !valida)
        {
            this.setHistorial(header+"<center>$"+typedTerm.toStringInfLabeled(s)+"$$\\text{No valid inference rule}$$");
            solved = false;
            return;
        }
        if(type == null && valida)// Case where what we want to print is the first line
        {
                solved = false;
        	String firstLine = "";
        	if(naturalSide){
    			firstLine = ((App)((App)typedTerm).p).q.toStringInfLabeled(s);	
    			this.setHistorial(header+"<br>Assuming H1: $"+ ((App)typedTerm).q.toStringInf(s, "") +"$<center>$"+firstLine+"</center>");
    		}else {
    			firstLine = typedTerm.toStringInfLabeled(s);
    			this.setHistorial(header+"<center>$"+firstLine+"</center>");
    		}
            return;
        }
 
        // In case natural deduction direct just started
        /*if( naturalDirect && (((TypedApp)typedTerm).p instanceof TypedI || ( ((App)type).q.toString().equals("c_{8}") && ((TypedApp)((TypedApp)((TypedApp)typedTerm).p).p).p instanceof TypedI) )) {
        	// Just print the first expression and ignore the rest of the hints
        	String firstLine = ((App)((App)((App)((App)((App)((App)type).p).q).p).q).p).q.toStringInf(s, "");
        	this.setHistorial(header+"<br>Assuming H1: $"+ ((App)((App)((App)type).p).q).q.toStringInf(s, "") +"$<center>$"+firstLine+"$</center>");
        	
        	return;
        }*/

        // CHECK IF EQUANIMITY HAPPENED
    	/*boolean equanimity;
    	try{
    		if (!(((TypedApp)typedTerm).p instanceof TypedS) && ((App)((TypedApp)typedTerm).p.type()).q.equals(((TypedApp)typedTerm).q.type()) 
    				&& ((App)((App)((TypedApp)typedTerm).p.type()).p).p.toString().equals("c_{1}"))
    			equanimity = true;
    		else
    			equanimity = false;
    	}
    	catch (ClassCastException e){
    		equanimity = false;
    	}

    	String equanimityHint = ""; // This will be printed if equanimity needs to be printed at the ending of the proof (or begging in certain cases)
    	Boolean equanimity2 = false; // will be true if the proof started with the theorem needed to be printed
    	Term goal = null;
    	*/
    	
    	// CREATE EQUANIMITY HINT STRING TO PRINT
    	// Case1: when natural deduction direct finished 
    	/*if(equanimity && naturalDirect) {
    		if(((TypedApp)((TypedApp) typedTerm).p).p instanceof TypedS ) {// started with theorem being proved 
    			goal = ((App)((App)((TypedApp)((TypedApp)((TypedApp)((TypedApp)typedTerm).p).q).p).p.type()).p).q;
    			goal = ((App)((App)((App)((App)goal).p).q).p).q;
    			typedTerm = ((TypedApp)((TypedApp)((TypedApp)((TypedApp)((TypedApp)typedTerm).p).q).p).p).p;
    			
    		}else {// started with another theorem
    			
    			// In this case finding the goal will require going to the start of the proof
    			goal = typedTerm;
    			while( ! (((TypedApp)((TypedApp)((TypedApp)goal).p).p).p instanceof TypedI)) {
    				goal = ((TypedApp)goal).p;
    			}
    			goal = ((App)((App)(((TypedApp)goal).q).type()).p).q;
    			goal = ((App)((App)((App)((App)goal).p).q).p).q;
    			typedTerm = ((TypedApp)((TypedApp)typedTerm).p).p;
    			
    			equanimity2 = true;
    		}
    	// Case2: when natural deduction one side finished
    	}else if(equanimity && naturalSide) {
    		typedTerm = ((TypedApp)typedTerm).q;
    		type = typedTerm.type();
    		// If doing one side demostration and started from the right side
        	if(naturalSide && ((TypedApp)typedTerm).p instanceof TypedS) {
        		// Be really sure the S is there coz we started from the right
        		// So check if the initial expression is the right side and the final one the left side of the theorem
        		Resuelve res = resuelveManager.getResuelveByUserAndTeoNum(user, nTeo);
        		Term teoProved = res.getTeorema().getTeoTerm();
        		Term initialExpr = ((App)((App)((App)((App)((App)((TypedApp)typedTerm).q.type()).q).p).q).p).q;
        		Term finalExpr = ((App)((App)((App)((App)((App)((App)((TypedApp)typedTerm).q.type()).p).q).p).q).p).q;
        		if(initialExpr.equals(((App)((App)((App)((App)teoProved).p).q).p).q) && finalExpr.equals(((App)((App)((App)teoProved).p).q).q) ) {
        			typedTerm = ((TypedApp)typedTerm).q;
        			type = typedTerm.type();	
        		}
        	}
    		// ignore equanimity in this case since it wont be printed
    		equanimity = false;
    	// Case3: when direct method finished and started from the theorem being proved
    	}else if (equanimity && typedTerm instanceof TypedApp && ((TypedApp)typedTerm).p instanceof TypedS){
    		goal = (((TypedApp)typedTerm).q).type();	
    		typedTerm = ((TypedApp)typedTerm).p;
    		typedTerm = ((TypedApp)typedTerm).q;
    	// Case4: when direct method finished and started from another theorem
    	}else if (equanimity){
    		goal = (((TypedApp)typedTerm).q).type();	
    		typedTerm = ((TypedApp)typedTerm).p;
    		equanimity2 = true;
    	}*/
    	
    	/*if(equanimity) {
    		type = typedTerm.type();
    		Resuelve eqHintResuel = resuelveManager.getResuelveByUserAndTeorema(user, goal.toStringFinal());
    		if (eqHintResuel == null) {
    			equanimityHint = disponeManager.getDisponeByUserAndMetaeorema(user, goal.toStringFinal()).getNumerometateorema();
    			equanimityHint = "~~~-~mt~("+equanimityHint+")";
    		}
    		else
    		{    
    			equanimityHint = eqHintResuel.getNumeroteorema();
    			equanimityHint = "~~~-~st~("+equanimityHint+")";
    		}
    	}*/
    
    	// Save last expression to append it later
    	/*String pasoPost="";
	if(naturalDirect) {
            Term aux= ((App)((App)((App)((App)((App)((App)type).p).q).p).q).p).q;
            pasoPost= (solved?aux.toStringInf(s,""):aux.toStringInfLabeled(s))+(equanimity2?"":equanimityHint)+(solved?"$":"");
	}else if(naturalSide){
            Term aux=((App)((App)((App)((App)type).p).q).p).q;
            pasoPost= (solved?aux.toStringInf(s,""):aux.toStringInfLabeled(s))+(equanimity2?"":equanimityHint)+(solved?"$":"");	
	}else {
            Term aux= ((App)((App)type).p).q;
            pasoPost= (solved?aux.toStringInf(s,""):aux.toStringInfLabeled(s))+(equanimity2?"":equanimityHint)+(solved?"$":"");	
	}*/
    	solved = type.equals(formula);
        if (direct)
            setDirectProof(user, typedTerm, solved, resuelveManager, disponeManager, s, false);
        else if (oneSide)
            setDirectProof(user, typedTerm, solved, resuelveManager, disponeManager, s, true);
        else if (weakening || strengthening)
            setWSProof(user, typedTerm, resuelveManager, disponeManager, s);
        else if (naturalDirect)
            ; //setDirectProof(user, translateToDirect(typedTerm), resuelveManager, disponeManager, s, false);
        else if (naturalSide)
            ; //setDirectProof(user, translateToOneSide(typedTerm), resuelveManager, disponeManager, s, true);
    	/*while (iter!=ultInf) 
    	{
    		// In case we reach the start of natural deduction direct
            if( naturalDirect && (((TypedApp)iter).p instanceof TypedI || ( ((App)type).q.toString().equals("c_{8}") && ((TypedApp)((TypedApp)((TypedApp)iter).p).p).p instanceof TypedI) )) {
            	// skip the rest of the hints
            	break;
//>>>>>>> origin/metodoField
            }
    		
    		// If there are still hints (TypedA)
    		if (iter instanceof App && ((App)iter).p.containTypedA())
    		{
    			// Must check if is naturalDeduction special hint which has a typedA on the left 
    			if((naturalDirect || naturalSide)  && !isModusPonens(iter, s).equals("NoModus") ){
    				ultInf = iter;
    			}else {
    				ultInf = ((App)iter).q;
    				iter = ((App)iter).p;
    			}
    		}
    		else
    			ultInf = iter;

    		// Check if the current hint is a modus pones
    		String isModusPonens = isModusPonens(ultInf, s);
    		
    		boolean ultInfApp = ultInf instanceof App;
    		
    		// CASE 1 : ultInf.q.q is App
    		if(ultInfApp && ((App)ultInf).q instanceof App  && ((App)((App)ultInf).q).q instanceof App) {
    			
    			Term aux = ((App)ultInf.type()).q;

				if(naturalDirect) {
					aux = ((App)((App)((App)((App)aux).p).q).p).q;
				}else if(naturalSide){
					aux = ((App)((App)aux).p).q;	
				}
				primExp = aux.toStringInf(s, "")+(aux.equals(goal)?equanimityHint:"");
				teo = ((App)((App)((App)ultInf).q).q).q.type().toStringFinal();
				inst = ((App)((App)((App)ultInf).q).q).p.type().toStringInf(s, "");
				inst = "~with~" + inst;
				if((naturalDirect || naturalSide)  && isModusPonens.equals("S(IAIA)")){// Modus ponens case S(IAIA)
					// Leib will be in the TypedI intance, in the 4th Sust variable E
				    Term phiTerm =  new App((Term)( ((TypedI)((App)((App)((App)ultInf).q).p).p).getInstantiation().getTerms().get(3).clone2()), new Var(122)).reducir();
					leib = "E^{z}:~" + phiTerm.toStringInf(s,"");
				}else if(naturalDirect) {
					Bracket ndLeiBracket = new Bracket(new Var('z'), ((App)((App)((App)((App)((Bracket)((App)((App)ultInf).q).p.type()).t).p).q).p).q);
					leib = ndLeiBracket.toStringInf(s, "");
				}else if(naturalSide){
					Bracket nsLeiBracket = new Bracket(new Var('z'), ((App)((App)((Bracket)((App)((App)ultInf).q).p.type()).t).p).q);
					leib = nsLeiBracket.toStringInf(s, "");
				}else {
					leib = ((App)((App)ultInf).q).p.type().toStringInf(s, "");
				}
				
				leib = "~and~" + leib;
				// If leibniz is z dont print it
				if(leib.equals("~and~(E^{z}: z)") || leib.equals("~and~E^{z}: z")) {
					leib = "";
				}
				
			// CASE 2 : ultInf.q is App
    		}else if (ultInfApp && ((App)ultInf).q instanceof App) {
    			
    			Term aux = ((App)ultInf.type()).q;
				if(naturalDirect) {
					aux = ((App)((App)((App)((App)aux).p).q).p).q;
				}else if(naturalSide){
					aux = ((App)((App)aux).p).q;	
				}
				primExp = aux.toStringInf(s, "")+(aux.equals(goal)?equanimityHint:"");
				teo = ((App)((App)ultInf).q).q.type().toStringFinal();
				if (((App)ultInf).p instanceof TypedS)
					if (((App)((App)ultInf).q).p instanceof TypedI)
					{
						inst = ((App)((App)ultInf).q).p.type().toStringInf(s, "");
						inst = "~with~" + inst;
					}
					else
					{
						if((naturalDirect || naturalSide)  && isModusPonens.equals("S(IAA)")) {
							// Leib will be in the TypedI intance, in the 4th Sust variable E
						    Term phiTerm =  new App((Term)( ((TypedI)((App)((App)((App)ultInf).q).p).p).getInstantiation().getTerms().get(3).clone2()), new Var(122)).reducir();
							leib = "E^{z}:~" + phiTerm.toStringInf(s,"");
						}else if(naturalDirect) {
							Bracket ndLeiBracket = new Bracket(new Var('z'), ((App)((App)((App)((App)((Bracket)((App)((App)ultInf).q).p.type()).t).p).q).p).q);
							leib = ndLeiBracket.toStringInf(s, "");
						}else if(naturalSide){
							Bracket nsLeiBracket = new Bracket(new Var('z'), ((App)((App)((Bracket)((App)((App)ultInf).q).p.type()).t).p).q);
							leib = nsLeiBracket.toStringInf(s, "");
						}else {
							leib = ((App)((App)ultInf).q).p.type().toStringInf(s, "");
						}
						leib = "~and~" + leib;
						// If leibniz is z dont print it
						if(leib.equals("~and~(E^{z}: z)") || leib.equals("~and~E^{z}: z")) {
							leib = "";
						}

					}
				else
				{
					inst = ((App)((App)ultInf).q).p.type().toStringInf(s, "");
					inst = "~with~" + inst;
					
					if((naturalDirect || naturalSide)  && isModusPonens.equals("IAIA")) {
						// Leib will be in the TypedI intance, in the 4th Sust variable E
					    Term phiTerm =  new App((Term)(((TypedI)((App)((App)ultInf).p).p).getInstantiation().getTerms().get(3).clone2()), new Var(122)).reducir();
						leib = "E^{z}:~" + phiTerm.toStringInf(s,"");
					}else if(naturalDirect) {
						Bracket ndLeiBracket = new Bracket(new Var('z'), ((App)((App)((App)((App)((Bracket)((App)ultInf).p.type()).t).p).q).p).q);
						leib = ndLeiBracket.toStringInf(s, "");
					}else if(naturalSide){
						Bracket nsLeiBracket = new Bracket(new Var('z'), ((App)((App)((Bracket)((App)ultInf).p.type()).t).p).q);
						leib = nsLeiBracket.toStringInf(s, "");
					}else {
						leib = ((App)ultInf).p.type().toStringInf(s, "");
					}
					leib = "~and~" + leib;
					// If leibniz is z dont print it
					if(leib.equals("~and~(E^{z}: z)") || leib.equals("~and~E^{z}: z")) {
						leib = "";
					}
				}
    		
			// CASE 3 : ultInf is App
    		}else if (ultInfApp) {
    			
    			teo = ((App)ultInf).q.type().toStringFinal();
				if (((App)ultInf).p instanceof TypedI)
				{
					inst = ((App)ultInf).p.type().toStringInf(s,"");
					inst = "~with~" + inst;

				}
				else if (((App)ultInf).p instanceof TypedL) {
					leib = "~and~" + ((App)ultInf).p.type().toStringInf(s,"");
					if(naturalDirect) {
						Bracket ndLeiBracket = new Bracket(new Var('z'), ((App)((App)((App)((App)((Bracket)((App)ultInf).p.type()).t).p).q).p).q);
						leib = "~and~" + ndLeiBracket.toStringInf(s, "");
					}else if(naturalSide){
						Bracket nsLeiBracket = new Bracket(new Var('z'), ((App)((App)((Bracket)((App)ultInf).p.type()).t).p).q);
						leib = "~and~" + nsLeiBracket.toStringInf(s, "");
					}
					// If leibniz is z dont print it
					if(leib.equals("~and~(E^{z}: z)") || leib.equals("~and~E^{z}: z")) {
						leib = "";
					}
				}
				else if ((naturalDirect || naturalSide)  && isModusPonens.equals("IAA")){ // In case we are seeing a naturalDeduction special hint
					// Leib will be in the TypedI intance, in the 4th Sust variable E
				    Term phiTerm =  new App((Term)(((TypedI)((App)((App)ultInf).p).p).getInstantiation().getTerms().get(3).clone2()), new Var(122)).reducir();
					leib = "~and~E^{z}:~" + phiTerm.toStringInf(s,"");
				} 
				Term aux = ((App)ultInf.type()).q;

				if(naturalDirect) {
					aux = ((App)((App)((App)((App)aux).p).q).p).q;
				}else if(naturalSide){
					aux = ((App)((App)aux).p).q;	
				}
				primExp = aux.toStringInf(s,"")+(aux.equals(goal)?equanimityHint:"");
				
			// CASE 4 : ultInf is not App	
    		}else {
    			Term aux = ultInf.type();

    			if(naturalDirect) {
    				aux = ((App)((App)((App)((App)aux).p).q).p).q;
    			}else if(naturalSide){
    				aux = ((App)((App)aux).p).q;	
    			}

    			teo = aux.toStringFinal();
    			primExp = ((App)aux).q.toStringInf(s,"")+(aux.equals(goal)?equanimityHint:"");
    		}


    		int conId = ((Const)((App)((App)ultInf.type()).p).p).getId();
    		String op = s.getSimbolo(conId).getNotacion_latex();

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
    	} */
    	
    	// Add the hypothesis if we are doing natural deduction
    	if(naturalDirect || naturalSide) { 
    		header += "<br>Assuming H1: $" +((App)((App)((App)type).p).q).q.toStringInf(s,"") + "$<br><br>";
    	}

    	this.setHistorial(header+"<center>$"+this.getHistorial()+"</center>");
    	if (!valida)
    		this.setHistorial(this.getHistorial()+"$$\\text{No valid inference rule}$$");

    	//this.setHistorial(this.getHistorial()+ "$$" +pasoPost + "$$");        
    }
    
}
