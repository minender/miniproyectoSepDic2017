/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.forms;

import com.calclogic.proof.ProofBoolean;
import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Const;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.service.DisponeManager;
import com.calclogic.service.ResuelveManager;
import com.calclogic.service.SimboloManager;
import com.calclogic.externalservices.MicroServices;
import com.calclogic.lambdacalculo.TypedA;
import com.calclogic.lambdacalculo.TypedM;
import com.calclogic.parse.CombUtilities;
import com.calclogic.parse.TermUtilities;
import com.calclogic.proof.CrudOperations;
import com.calclogic.proof.GenericProofMethod;
import java.util.logging.Level;
import java.util.logging.Logger;
import com.calclogic.service.ProofTemplateManager;

/**
 *
 * @author francisco
 */
public class InferResponse extends GenericResponse{
    
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
    // It is also "1" when a clickable statement must be splitted into two sides.
    private String lado;

    // Determines if the proof was solved so a congratulatory message should be displayed
    private String resuelto;

    // This is not included in the JSON response. Its purpose is local for the "generarHistorial" method.
    private boolean valid;

    // Represents if the solution is ending a case.
    private boolean endCase = false;

    // Portion of HTML to center a formula, but also the formula is aligned to the left in its own block
    private final String centerBegin = "<center style='display:flex; flex-direction:row'><div style='flex-grow:1'></div>";
    private final String centerEnd = "<div style='flex-grow:1'></div></center>";

    private String centeredBlock(String content){
        return this.centerBegin + content + this.centerEnd;
    }

    private final CrudOperations proofCrudOperations;

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

    // We need to have the same name as in the other response classes
    @Override
    public String getError() {
        return getErrorParser2();
    }

    // We need to have the same name as in the other response classes
    @Override
    public void setError(String error) {
        setErrorParser2(error);
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
     * when the demonstration method is "And Introduction" (Conjunction by parts) or "Case Analysis"
     * @param user 
     * @param typedTerm
     * @param resuelveManager
     * @param disponeManager
     * @param s
     * @param header
     * @param clickable
     * @param methodTerm
     * @param valida
     * @param labeled
     * @param formula
     * @param nTeo
     * @param objectMethod
     * @return Nothing.
     */
    private void setLinearRecursiveMethodProof(String user, Term typedTerm, ResuelveManager resuelveManager, 
            DisponeManager disponeManager, SimboloManager s, String header, String clickable, 
            Term methodTerm, Boolean valida, Boolean labeled, Term formula, String nTeo, GenericProofMethod objectMethod) 
    {
        Term newFormula = objectMethod.initFormula(formula);
        String statement;
        try {
            statement = centeredBlock("$" + clickableST(user, newFormula, clickable, methodTerm, false, s) + "$");
        }
        catch (Exception e) {
            Logger.getLogger(InferResponse.class.getName()).log(Level.SEVERE, null, e);
            this.setErrorParser1(true);
            return;
        }
        // By <current> method, the following must be proved: <statement> 
        header += objectMethod.header(statement);   
        
        if (methodTerm instanceof App) {
            if ( typedTerm!=null && typedTerm.type()!=null && typedTerm.type().equals(formula)){
                typedTerm = ((App)typedTerm).q;
            }
            privateGenerarHistorial(user, newFormula, header, nTeo, typedTerm, valida, labeled, ((App)methodTerm).q, 
                            resuelveManager, disponeManager, s, clickable, false);
        }
        else{
            this.setHistorial(header);
        }
    }

    /**
     * This function adds a proof of just one step into a bigger proof, 
     * when the demonstration method is "And Introduction" (Conjunction by parts) or "Case Analysis"
     * @param user 
     * @param typedTerm
     * @param resuelveManager
     * @param disponeManager
     * @param s
     * @param header
     * @param clickable
     * @param methodTerm
     * @param valida
     * @param labeled
     * @param formula
     * @param nTeo
     * @return Nothing.
     */
    private void setBranchedRecursiveMethodProof(String user, Term typedTerm, ResuelveManager resuelveManager, 
        DisponeManager disponeManager, SimboloManager s, String header, String clickable, Term methodTerm, 
        Boolean valida, Boolean labeled, Term formula, String nTeo, GenericProofMethod objectMethod)
    {
        try{
            String statement;
            Term newFormula = ((App)formula).q; // First branch
            statement = centeredBlock("$" + clickableST(user, newFormula, clickable, methodTerm, false, s) + "$");
            header += objectMethod.header("") + objectMethod.subProofInit(statement);

            if (methodTerm instanceof Const){
                historial = header;
            }
            // Proof of the first sub-case
            else if ( ((App)methodTerm).p instanceof Const  ) {
                privateGenerarHistorial(user, newFormula, header, nTeo, typedTerm, valida, labeled, ((App)methodTerm).q, 
                                        resuelveManager, disponeManager, s, clickable, false);

                if (typedTerm == null || typedTerm.type()==null || !typedTerm.type().equals(newFormula)){
                    if (typedTerm != null)
                       cambiarMetodo = "0";
                }
                else { // This only occurs when the user has just finalized the previous sub-proof
                    if (!clickable.equals("n")){
                        cambiarMetodo = "0"; 
                    }
                    newFormula = ((App)((App)formula).p).q; // Second branch
                    statement = centeredBlock("$" + clickableST(user, newFormula, clickable, new Const("AI"), false, s) + "$");
                    historial += objectMethod.subProofInit(statement);
                }
            }
            // Proof of a sub-case that is not the first one (sure?)
            else{
                privateGenerarHistorial(user, newFormula, header, nTeo,
                                (ProofBoolean.isBranchedProof2Started(methodTerm)?((App)typedTerm).q:typedTerm), 
                                 valida, labeled, ((App)((App)methodTerm).p).q, resuelveManager, disponeManager, 
                                 s, clickable, false);
                newFormula = ((App)((App)formula).p).q;
                statement = centeredBlock("$" + clickableST(user, newFormula, clickable, methodTerm, false, s) + "$");
                header = historial + objectMethod.subProofInit(statement);
                historial = "";
                Term newTypedTerm;
                newTypedTerm = proofCrudOperations.getSubProof(typedTerm, methodTerm);
                privateGenerarHistorial(user, newFormula, header, nTeo, newTypedTerm, valida, labeled, ((App)methodTerm).q, 
                                 resuelveManager, disponeManager, s, clickable, false);
            }
        } catch (Exception e) {
            this.setErrorParser1(true);
            return;
        }
    }

    /**
     * Creates a LaTeX string that can be clicked by the user.
     * @param newTerm
     * @param clickable
     * @param method
     * @param isRootTeorem
     * @return The string that the user can click.
     */
    private String clickableST(String user, Term newTerm, String clickable, Term method, boolean isRootTeorem, 
                                SimboloManager s) throws Exception {
        //Term newTerm = new TypedA(newTerm,user).type();
        if ( (method != null && !(method instanceof Const))||(isRootTeorem && method instanceof Const) ){ // en plena recursion
            return newTerm.toStringLaTeX(s,"");
        }
        else if ("DM".equals(clickable))  // End of the impression
            return "\\cssId{teoremaMD}{\\style{cursor:pointer; color:#08c;}{"+ newTerm.toStringLaTeX(s,"") + "}}";
        else if ("SS".equals(clickable)) { // End of the impression
            String formulaDer = ((App)((App)newTerm).p).q.body().toStringLaTeX(s,"");
            String formulaIzq = ((App)newTerm).q.body().toStringLaTeX(s,"");

            Term operatorTerm = ((App)((App)newTerm).p).p;
            String operator = operatorTerm.toStringLaTeX(s,"");

            // THIS IS NOT USED BECAUSE generarHistorial always receives the formula as in the previous version
            //if(!operatorTerm.toString().startsWith("=") || ((App)((App)newTerm).p).q.containT()){ 
            if(!operatorTerm.toString().startsWith("c_{1}") && !operatorTerm.toString().startsWith("c_{20}")){
                throw new Exception();
            }
            
            formulaDer = "\\cssId{d}{\\class{teoremaClick}{\\style{cursor:pointer; color:#08c;}{"+ formulaDer + "}}}";
            formulaIzq = "\\cssId{i}{\\class{teoremaClick}{\\style{cursor:pointer; color:#08c;}{"+ formulaIzq + "}}}";

            return formulaIzq+"$ $"+ operator +"$ $" + formulaDer;
        }
        else{ // clickable.equals("n")
            return newTerm.toStringLaTeX(s,"");
        }
    }
    
    /**
     * Calls function privateGenerarHistorial assuming that it is always a root theorem and thus it 
     * doesn't contain identation. It tries to convert the LaTeX code of the result into HTML.
     * 
     * @param user
     * @param formula
     * @param nTeo
     * @param typedTerm
     * @param valida
     * @param labeled
     * @param methodTerm
     * @param resuelveManager
     * @param disponeManager
     * @param s
     */
    public void generarHistorial(String user, Term formula, String nTeo, Term typedTerm, Boolean valida, Boolean labeled, 
                Term methodTerm, ResuelveManager resuelveManager, DisponeManager disponeManager, SimboloManager s)
    {
        generarHistorial(user, formula, "", nTeo, typedTerm, valida, labeled, methodTerm, resuelveManager, disponeManager, s, "n", true); 
    }

    /**
     * Prints all the demonstration made at the moment. Note that if a new step will be added, all the proof
     * from the beginning will be printed again. It tries to convert the LaTeX code of the result into HTML.
     * 
     * @param user
     * @param formula
     * @param header
     * @param nTeo
     * @param typedTerm
     * @param valida
     * @param labeled
     * @param methodTerm
     * @param resuelveManager
     * @param disponeManager
     * @param s
     * @param clickable
     * @param isRootTeorem
     */
    public void generarHistorial(String user, Term formula, String header, String nTeo, Term typedTerm, Boolean valida, 
                Boolean labeled, Term methodTerm, ResuelveManager resuelveManager, DisponeManager disponeManager, 
                SimboloManager s, String clickable,Boolean isRootTeorem)
    { 
        privateGenerarHistorial(user, formula, header, nTeo, typedTerm, valida, labeled, 
            methodTerm, resuelveManager, disponeManager, s, clickable, isRootTeorem);
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
     * @param methodTerm
     * @param resuelveManager
     * @param disponeManager
     * @param s
     * @param clickable
     * @param isRootTeorem
     */
    private void privateGenerarHistorial(String user, Term formula, String header, String nTeo, Term typedTerm, Boolean valida, 
        Boolean labeled, Term methodTerm, ResuelveManager resuelveManager, DisponeManager disponeManager, 
        SimboloManager s, String clickable, Boolean isRootTeorem)
    {   
        // siempre que el metodo sea vacio o se este esperando un metodo, hay 
        // que pedirlo, salvo cuando no se haya terminado la primera prueba de
        // un metodo binario
        if (isRootTeorem && methodTerm == null)
            cambiarMetodo = "1";
        else if (isRootTeorem && ProofBoolean.isWaitingMethod(methodTerm)) 
            cambiarMetodo = "2";
        else if(isRootTeorem)
            cambiarMetodo ="0";
        
        // If we're printing a root teorem, print it as a theorem.
        if (isRootTeorem) {
            this.setHistorial("");
            try {
                header = "Theorem " + nTeo + ":<br> "+  
                         centeredBlock("$" + clickableST(user, formula, clickable, methodTerm, isRootTeorem, s) + "$") +
                         "Proof:<br>";
            }
            catch (Exception e) {
                this.setErrorParser1(true);
                return ;
            }
        }

        String strMethod = "   "; // We need substring(0,2) can always be applied
        if(methodTerm != null) {
            valid = valida;
            strMethod = methodTerm.toString();
        }

        strMethod = strMethod.substring(0, 2);
        GenericProofMethod objectMethod = proofCrudOperations.returnProofMethodObject(strMethod);

        boolean recursive = objectMethod.getIsRecursiveMethod();

        // If the method is recursive, the header will be built in the "setRecursiveMethod"
        header += (!recursive) ? objectMethod.header(nTeo) : "";

        // PROVISIONAL <--- ESTO DEBE SER BORRADO
        Boolean naturalSide, naturalDirect;
        naturalSide = naturalDirect = false;
        // ---- FIN DE LO QUE DEBE SER BORRADO
        
        Term type = typedTerm==null?null:typedTerm.type();

        if (typedTerm==null && methodTerm == null && !recursive){
            this.setHistorial(this.getHistorial() + header);
            return;
        }
        // This occurs when there is only one line in the demonstration and the first inference is invalid
        if (typedTerm!=null && type == null && !valida && !recursive){
            this.setHistorial(this.getHistorial() + header + centeredBlock("$"+typedTerm.toStringLaTeXLabeled(s)) + noValidInference());
            return;
        }
        if (typedTerm!=null && type == null && valida && !recursive) { // Case where what we want to print is the first line
            String firstLine;
            if(naturalSide){
                firstLine = ((App)((App)typedTerm).p).q.toStringLaTeXLabeled(s);  
                this.setHistorial(this.getHistorial() + header + "<br>Assuming H1: $" + ((App)typedTerm).q.toStringLaTeX(s, "") + "$" + centeredBlock("$"+firstLine));
            }else {
                firstLine = typedTerm.toStringLaTeXLabeled(s);
                this.setHistorial(this.getHistorial() + header + centeredBlock("$"+firstLine));
            }
            return;
        }

        boolean solved;
        if (labeled && !recursive){
            solved = type.equals(formula);
        }
        else
            solved = true; // importante: Se debe implementar setDirectProof y setWSProof sensible a
                           // si se pide labeled o no la ultima linea- Aqui se cablea con solved = true
                           // OJO: Recordar que ahora esas funciones se llaman "setProofMethod" y están
                           // en la respectiva clase del método 
        // -- Here is where we really generate the proof record accoding to the demonstration method ---

        if (recursive){
            if ("B".equals(objectMethod.getGroupMethod())){


                // ******* I AM NOT SURE IF THIS LINE WILL ALWAYS REMAIN HERE
                Term editedFormula = objectMethod.initFormula(formula);

                setBranchedRecursiveMethodProof(user, typedTerm, resuelveManager, disponeManager, s, header, 
                    clickable, methodTerm, valida, labeled, editedFormula, nTeo, objectMethod);        
            }
            else {
                setLinearRecursiveMethodProof(user, typedTerm, resuelveManager, disponeManager, s, header, 
                    clickable, methodTerm, valida, labeled, formula, nTeo, objectMethod);  
            }
        } else {
            this.setHistorial(objectMethod.setBaseMethodProof(
                this.getHistorial(), user, typedTerm, solved, resuelveManager, disponeManager, s
            ));

            historial = header + centeredBlock("$"+historial);

            // This occurs when there is more than one line in the demonstration, and the next tried inference is invalid
            if (!valida){
                historial = historial + noValidInference();
            }
        }      
    }

    // Returns a HTML centered block with the text "No valid inference"
    private String noValidInference(){
        return centeredBlock(MicroServices.transformLaTexToHTML("$\\text{No valid inference}$"));
    }
}