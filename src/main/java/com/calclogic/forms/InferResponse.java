/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.forms;

import com.calclogic.controller.InferController;
import com.calclogic.proof.ProofBoolean;
import com.calclogic.entity.Resuelve;
import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Bracket;
import com.calclogic.lambdacalculo.Const;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.lambdacalculo.TypeVerificationException;
import com.calclogic.lambdacalculo.TypedA;
import com.calclogic.lambdacalculo.TypedApp;
import com.calclogic.lambdacalculo.TypedI;
import com.calclogic.lambdacalculo.TypedL;
import com.calclogic.lambdacalculo.TypedS;
import com.calclogic.lambdacalculo.Var;
import com.calclogic.service.DisponeManager;
import com.calclogic.service.ResuelveManager;
import com.calclogic.service.SimboloManager;
import com.calclogic.service.PlantillaTeoremaManager;
import com.calclogic.externalservices.MicroServices;
import com.calclogic.proof.CrudOperations;
import com.calclogic.proof.InferenceIndex;

import org.springframework.beans.factory.annotation.Autowired;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author francisco
 */
public class InferResponse {
    
    // Has all the proof made at this point, written in LaTeX.
    private String historial; 

    // Indicates if the proof there was an error in the "generarHistorial" function,
    private Boolean errorParser1 = false;

    private String errorParser2;
    private String errorParser3;

    // Indicates if the users are at a step in which they have to select the proof method.
    // When it is "0", the option to select method does not appear.
    // When it is "1", the option to select method appears, but not the button "Go back".
    // When it is "2", the option to select method appears and also the "Go back" button.
    private String cambiarMetodo; 

    // Each demonstration that is attempted will have a different value in the database,
    // despite that they are made by different users. "nSol" is that unique value.
    private String nSol; 

    // When the proof method is starting from one side, this indicates the side: 
    // 'd' for the right one (derecho) and 'i' for the left one (izquierdo).
    private String lado;

    // Determines if the proof was solved so a congratulatory message should be displayed
    private String resuelto;

    // This is not included in the JSON response. Its purpose is local for the "generarHistorial" method.
    private boolean valid;

    // Represents if the solution is ending a case.
    private boolean endCase = false;

    private CrudOperations proofCrudOperations;

    public InferResponse(CrudOperations proofCrudOperations) {
        this.proofCrudOperations = proofCrudOperations;
    }

    public void setEndCase(boolean endCase) {
        this.endCase = endCase;
    };

    public boolean getEndCase() {
        return endCase;
    }

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
    
    public boolean getValid() {
        return valid;
    }

    public void setHistorial(String formula) {
        this.historial = formula;
    }

    public Boolean getErrorParser1() {
        return errorParser1;
    }

    public void setErrorParser1(Boolean errorParser1) {
        this.errorParser1 = errorParser1;
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

    /**
     * This function adds a proof of just one step into a bigger proof, 
     * when the demonstration method is counter reciprocal
     * @param user 
     * @param typedTerm
     * @param resuelveManager
     * @param disponeManager
     * @param s
     * @param header
     * @param clickeable
     * @param metodo
     * @param valida
     * @param labeled
     * @param formula
     * @param nTeo
     * @return Nothing.
     */
    private void setCounterRecipProof(String user, Term typedTerm, ResuelveManager resuelveManager, DisponeManager disponeManager, 
        SimboloManager s, String header, String clickeable, Term metodo, Boolean valida, Boolean labeled, Term formula, String nTeo) {
        
        Term newFormula = proofCrudOperations.noRecursiveInitSt(formula, "CR");
        String statement = "";
        try {
           statement = "<center>$" + clickeableST(newFormula, clickeable, metodo, false, s) 
                              + "$</center>";
        }
        catch (Exception e) {
            this.setErrorParser1(true);
            return;
        }
        header+="By counter-reciprocal method, the following must be proved:<br>"+statement+"Sub Proof:<br>";
        if (metodo instanceof App) {
            if ( typedTerm!=null && typedTerm.type()!=null && typedTerm.type().equals(formula) //&& 
                 // InferController.isBaseMethod(((App)metodo).q)
               )
                typedTerm = ((App)typedTerm).q;
            privateGenerarHistorial(user, newFormula, header, nTeo, typedTerm, valida, labeled, ((App)metodo).q, 
                             resuelveManager, disponeManager, s, clickeable, false);
        }
        else
            this.setHistorial(header);
    }

    /**
     * This function adds a proof of just one step into a bigger proof, 
     * when the demonstration method is contradiction
     * @param user 
     * @param typedTerm
     * @param resuelveManager
     * @param disponeManager
     * @param s
     * @param header
     * @param clickeable
     * @param metodo
     * @param valida
     * @param labeled
     * @param formula
     * @param nTeo
     * @return Nothing.
     */
    private void setContradictionProof(String user, Term typedTerm, ResuelveManager resuelveManager, DisponeManager disponeManager, 
        SimboloManager s, String header, String clickeable, Term metodo, Boolean valida, Boolean labeled, Term formula, String nTeo) {

        Term newFormula = proofCrudOperations.noRecursiveInitSt(formula, "CO");
        System.out.println("newFormula = "+newFormula);
        String statement = "";
        try {
           statement = "<center>$" + clickeableST(newFormula, clickeable, metodo, false, s) 
                              + "$</center>";
        }
        catch (Exception e) {
            Logger.getLogger(InferResponse.class.getName()).log(Level.SEVERE, null, e);
            this.setErrorParser1(true);
            return;
        }
        
        header+="By contradiction method, the following must be proved:<br>"+statement+"Sub Proof:<br>";
        if (metodo instanceof App) {
            if ( typedTerm!=null && typedTerm.type()!=null && typedTerm.type().equals(formula) //&& 
                 // InferController.isBaseMethod(((App)metodo).q)
               ){
                typedTerm = ((App)typedTerm).q;
            }
            privateGenerarHistorial(user, newFormula, header, nTeo, typedTerm, valida, labeled, ((App)metodo).q, 
                             resuelveManager, disponeManager, s, clickeable, false);
        }
        else{
            this.setHistorial(header);
        }
    }

    /**
     * This function adds a proof of just one step into a bigger proof, 
     * when the demonstration method is "And Introduction" (Conjunction by parts)
     * @param user 
     * @param typedTerm
     * @param resuelveManager
     * @param disponeManager
     * @param s
     * @param header
     * @param clickeable
     * @param metodo
     * @param valida
     * @param labeled
     * @param formula
     * @param nTeo
     * @return Nothing.
     */
    private void setAIProof(String user, Term typedTerm, ResuelveManager resuelveManager, DisponeManager disponeManager, 
        SimboloManager s, String header, String clickeable, Term metodo, Boolean valida, Boolean labeled, Term formula, String nTeo) {

        String statement = "";
        boolean isAI = metodo.toStringFinal().substring(0, 2).equals("AI");
        String stOrCase = (isAI?"Statement":"Case");
        String methodName = (isAI?"Conjunction by parts":"Case Analysis");
        Term newFormula = ((App)formula).q;
        try {
           statement = "<center>$" + clickeableST(newFormula, clickeable, metodo, false, s) 
                                   + "$</center>";
        }
        catch (Exception e) {
            this.setErrorParser1(true);
            return;
        }
        header+="By "+methodName+" method:<br>"+stOrCase+" 1:<br>"+statement+"Sub Proof:<br>";
        if (metodo instanceof Const){
           historial = header;
        }
        else if ( ((App)metodo).p instanceof Const  ) {
            privateGenerarHistorial(user, newFormula, header, nTeo, typedTerm, valida, labeled, ((App)metodo).q, 
                                    resuelveManager, disponeManager, s, clickeable, false);
            if (!(typedTerm!=null && typedTerm.type()!=null && typedTerm.type().equals(newFormula))){
                cambiarMetodo = "0";
            }
            else {
                if (!clickeable.equals("n"))
                    cambiarMetodo = "0"; 
                newFormula = ((App)((App)formula).p).q;
                try {
                    statement = "<center>$" + clickeableST(newFormula, clickeable, new Const("AI"), false, s) 
                                   + "$</center>";
                }catch (Exception e) {
                    this.setErrorParser1(true);
                    return;
                }
                historial += stOrCase+" 2:<br>"+statement+"Sub Proof:<br>";
            }
        }
        else{
            privateGenerarHistorial(user, newFormula, header, nTeo,
                            (ProofBoolean.isAIProof2Started(metodo)?((App)typedTerm).q:typedTerm), 
                             valida, labeled, ((App)((App)metodo).p).q, resuelveManager, disponeManager, 
                             s, clickeable, false);
            newFormula = ((App)((App)formula).p).q;
            try {
                statement = "<center>$" + clickeableST(newFormula, clickeable, metodo, false, s) 
                                   + "$</center>";
            }catch (Exception e) {
                this.setErrorParser1(true);
                return;
            }
            header = historial + stOrCase+" 2:<br>"+statement+"Sub Proof:<br>";
            historial = "";
            Term newTypedTerm = null;
            newTypedTerm = proofCrudOperations.getSubProof(typedTerm, metodo);
            privateGenerarHistorial(user, newFormula, header, nTeo, newTypedTerm, valida, labeled, ((App)metodo).q, 
                             resuelveManager, disponeManager, s, clickeable, false);
        }
    }

    /**
     * Creates a LaTeX string that can be clicked by the user.
     * @param newTerm
     * @param clickeable
     * @param method
     * @param isRootTeorem
     * @return The string that the user can click.
     */
    private String clickeableST(Term newTerm, String clickeable, Term method, boolean isRootTeorem, 
                                SimboloManager s) throws Exception {

        if ( (method != null && !(method instanceof Const))||(isRootTeorem && method instanceof Const) ) // en plena recursion
            return newTerm.toStringInf(s,"");
        else if (clickeable.equals("DM"))  // final de la impresion
            return "\\cssId{teoremaMD}{\\style{cursor:pointer; color:#08c;}{"+ newTerm.toStringInf(s,"") + "}}";
        else if (clickeable.equals("SS")) { // final de la impresion
            String formulaDer = ((App)((App)newTerm).p).q.toStringInf(s,"");
            String formulaIzq = ((App)newTerm).q.toStringInf(s,"");
            Term operatorTerm = ((App)((App)newTerm).p).p;//resuelve.getTeorema().getOperador();
            String operator = operatorTerm.toStringInf(s,"");
            if(!operatorTerm.toString().startsWith("c_{1}") && !operatorTerm.toString().startsWith("c_{20}"))
               throw new Exception();
            
            formulaDer = "\\cssId{d}{\\class{teoremaClick}{\\style{cursor:pointer; color:#08c;}{"+ formulaDer + "}}}";
            formulaIzq = "\\cssId{i}{\\class{teoremaClick}{\\style{cursor:pointer; color:#08c;}{"+ formulaIzq + "}}}";
            return formulaIzq+"$ $"+ operator +"$ $" + formulaDer;
        }
        else // clickeable.equals("n")
            return newTerm.toStringInf(s,"");
    }
    
    /**
     * Calls function generarHistorial assuming that it is always a root theorem
     * and thus is doesn't contain identation.
     * @param user
     * @param formula
     * @param nTeo
     * @param typedTerm
     * @param valida
     * @param labeled
     * @param metodo
     * @param resuelveManager
     * @param disponeManager
     * @param s
     */
    public void generarHistorial(
        String user, 
        Term formula, 
        String nTeo, 
        Term typedTerm,  
        Boolean valida, 
        Boolean labeled, 
        Term metodo, 
        ResuelveManager resuelveManager, 
        DisponeManager disponeManager, 
        SimboloManager s
    ) {
        privateGenerarHistorial(
            user, 
            formula, 
            "",
            nTeo, 
            typedTerm, 
            valida, 
            labeled, 
            metodo, 
            resuelveManager, 
            disponeManager, 
            s, 
            "n",
            true
        );
        historial = MicroServices.transformLaTexToHTML(historial);
    }

    /**
     * Prints all the demonstration made at the moment. Note that if a new step will be added,
     * all the proof from the beginning will be printed again.
     * @param user
     * @param formula
     * @param header
     * @param nTeo
     * @param typedTerm
     * @param valida
     * @param labeled
     * @param metodo
     * @param resuelveManager
     * @param disponeManager
     * @param s
     * @param clickeable
     * @param isRootTeorem
     */
    public void generarHistorial(
        String user, 
        Term formula,
        String header,
        String nTeo, 
        Term typedTerm,  
        Boolean valida, 
        Boolean labeled, 
        Term metodo, 
        ResuelveManager resuelveManager, 
        DisponeManager disponeManager, 
        SimboloManager s,
        String clickeable,
        Boolean isRootTeorem
    ) { 
        privateGenerarHistorial(
            user, 
            formula, 
            header,
            nTeo, 
            typedTerm, 
            valida, 
            labeled, 
            metodo, 
            resuelveManager, 
            disponeManager, 
            s, 
            clickeable,
            isRootTeorem
        );
        historial = MicroServices.transformLaTexToHTML(historial);
    }

    /**
     * Prints all the demonstration made at the moment. Note that if a new step will be added,
     * all the proof from the beginning will be printed again.
     * @param user
     * @param formula
     * @param header
     * @param nTeo
     * @param typedTerm
     * @param valida
     * @param labeled
     * @param metodo
     * @param resuelveManager
     * @param disponeManager
     * @param s
     * @param clickeable
     * @param isRootTeorem
     */
    private void privateGenerarHistorial(
        String user, 
        Term formula,
        String header,
        String nTeo, 
        Term typedTerm,  
        Boolean valida, 
        Boolean labeled, 
        Term metodo, 
        ResuelveManager resuelveManager, 
        DisponeManager disponeManager, 
        SimboloManager s,
        String clickeable,
        Boolean isRootTeorem
    ) {        
        // siempre que el metodo sea vacio o se este esperando un metodo, hay 
        // que pedirlo, salvo cuando no se haya terminado la primera prueba de
        // un metodo binario
        if (isRootTeorem && metodo == null)
            cambiarMetodo = "1";
        else if (isRootTeorem && ProofBoolean.isWaitingMethod(metodo)) 
            cambiarMetodo = "2";
        else if(isRootTeorem)
            cambiarMetodo ="0";
        
        // If we're printing a root teorem, print it as a theorem.
        if (isRootTeorem) {
            this.setHistorial("");
            try {
                header = "Theorem " + nTeo + ":<br> <center>$" + 
                         clickeableST(formula, clickeable, metodo, isRootTeorem, s) + "$</center>" +
                         "Proof:<br>";
            }
            catch (Exception e) {
                this.setErrorParser1(true);
                return ;
            }
        }

        String strMethod = "   "; // We need substring(0,2) can always be applied
        if(metodo != null) {
            valid = valida;
            strMethod = metodo.toStringFinal();
        }
        boolean naturalDirect   = strMethod.equals("ND DM");
        boolean naturalSide     = strMethod.equals("ND SS");
        boolean counterRecip    = strMethod.substring(0, 2).equals("CR");
        boolean contradiction   = strMethod.substring(0, 2).equals("CO");
        boolean oneSide         = strMethod.equals("SS");
        boolean direct          = strMethod.equals("DM");
        boolean weakening       = strMethod.equals("WE");
        boolean strengthening   = strMethod.equals("ST");
        boolean transitivity    = strMethod.equals("TR");
        boolean andIntroduction = strMethod.substring(0, 2).equals("AI");
        boolean caseAnalysis = strMethod.substring(0, 2).equals("CA");

        boolean recursive = false;
        if (counterRecip || contradiction || andIntroduction || caseAnalysis)
            recursive = true;
        else if (direct) 
            header += "By direct method<br>";
        else if (oneSide) 
            header += "Starting from one side";
        else if (weakening) 
            header += "By weakening method<br>";
        else if (andIntroduction) // este caso es imposible
            header += "Proof of " + nTeo + ":<br><br>";
        else
            ;
        // header += "Proof:<br>";
        
        Term type = typedTerm==null?null:typedTerm.type();

        boolean solved;
        if (typedTerm==null && metodo == null && !recursive){
            this.setHistorial(this.getHistorial()+header);
            solved = false;
            return;
        }
        if (typedTerm!=null && type == null && !valida && !recursive){
            this.setHistorial(this.getHistorial()+header+"<center>$"+typedTerm.toStringInfLabeled(s)+MicroServices.transformLaTexToHTML("$\\text{No valid inference}$"));
            solved = false;
            return;
        }
        if (typedTerm!=null && type == null && valida && !recursive) { // Case where what we want to print is the first line
            solved = false;
            String firstLine = "";
            if(naturalSide){
                firstLine = ((App)((App)typedTerm).p).q.toStringInfLabeled(s);  
                this.setHistorial(this.getHistorial()+header+"<br>Assuming H1: $"+ ((App)typedTerm).q.toStringInf(s, "") +"$<center>$"+firstLine+"</center>");
            }else {
                firstLine = typedTerm.toStringInfLabeled(s);
                this.setHistorial(this.getHistorial()+header+"<center>$"+firstLine+"</center>");
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
        if (labeled && !recursive)
            solved = type.equals(formula);
        else
            solved = true; // importante: Se debe implementar setDirectProof y setWSProof sensible a
                           // si se pide labeled o no la ultima linea, aqui se cablea con solved = true

        // Here is where we really generate the proof record accoding to the demonstration method
        if (direct) {       
            setDirectProof(user, typedTerm, solved, resuelveManager, disponeManager, s, false);
        }
        else if (oneSide){
            setDirectProof(user, typedTerm, solved, resuelveManager, disponeManager, s, true);
        }
        else if (weakening || strengthening || transitivity)
            setWSProof(user, typedTerm, solved, resuelveManager, disponeManager, s);

        else if (counterRecip) {
            setCounterRecipProof(user, typedTerm, resuelveManager, disponeManager, s, header, clickeable, metodo, valida, labeled, formula, nTeo);
        }
        else if (contradiction) {
            setContradictionProof(user, typedTerm, resuelveManager, disponeManager, s, header, clickeable, metodo, valida, labeled, formula, nTeo);
        }
        else if (andIntroduction) {
            setAIProof(user, typedTerm, resuelveManager, disponeManager, s, header, clickeable, metodo, valida, labeled, formula, nTeo);
        }
        else if (caseAnalysis){
            Term newFormula = new App(new App(new Const(5,"c_{5}"),new App(new App(new Const(2,"c_{2}"),formula),new App(new Const(7,"c_{7}"),new Const(8,"c_{8}")))) ,new App(new App(new Const(2,"c_{2}"), formula),new Const(8,"c_{8}")));
            setAIProof(user, typedTerm, resuelveManager, disponeManager, s, header, clickeable, metodo, valida, labeled, newFormula, nTeo);
        }
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

        if (/*!andIntroduction &&*/ !recursive) {
            historial = header+"<center>$" +historial+"</center>";
            if (!valida) 
            historial = historial + MicroServices.transformLaTexToHTML("$\\text{No valid inference}$");
        }
        else if (/*!andIntroduction &&*/ recursive)
            ;
        //else 
        //    this.setHistorial(header +this.getHistorial());
        
        //this.setHistorial(this.getHistorial()+ "$$" +pasoPost + "$$");        
    }
    
}