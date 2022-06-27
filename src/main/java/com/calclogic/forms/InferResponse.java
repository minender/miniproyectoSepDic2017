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
import com.calclogic.proof.CrudOperations;
import com.calclogic.proof.GenericProofMethod;
import java.util.logging.Level;
import java.util.logging.Logger;

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
            statement = "<center>$" + clickableST(newFormula, clickable, methodTerm, false, s) 
                              + "$</center>";
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
            System.out.println("\n\n=======================\nEntré en setBranchedRecursiveMethodProof con methodTerm = "+methodTerm.toStringFinal());
            System.out.println("typedTerm = "+((typedTerm != null) ? typedTerm.toStringFinal() : null));
            String statement;
            Term newFormula = ((App)formula).q; // First branch

            System.out.println("\nformula = "+formula.toStringFinal());
            System.out.println("formula.p = "+((App)formula).p.toStringFinal());
            System.out.println("formula.q = "+((App)formula).q.toStringFinal());
            System.out.println("formula.p.p = "+((App)((App)formula).p).p.toStringFinal());
            System.out.println("formula.p.q = "+((App)((App)formula).p).q.toStringFinal());

            if (!(methodTerm instanceof Const)){
                System.out.println("\nmethodTerm.p = "+((App)methodTerm).p.toStringFinal());
                System.out.println("methodTerm.q = "+((App)methodTerm).q.toStringFinal());
            }
            System.out.println("    \nVoy a asignar el statement 1");
            statement = "<center>$" + clickableST(newFormula, clickable, methodTerm, false, s) 
                                    + "$</center>";
            System.out.println("    El cual es = "+statement);
            header += objectMethod.header("") + objectMethod.subProofInit(statement);

            if (methodTerm instanceof Const){
                System.out.println("    \nEntré al if");
                historial = header;
            }
            // Proof of the first sub-case
            else if ( ((App)methodTerm).p instanceof Const  ) {
                System.out.println("    \nEntré al else if");
                System.out.println("    Voy a llamar a privateGenerarHistorial 1");
                privateGenerarHistorial(user, newFormula, header, nTeo, typedTerm, valida, labeled, ((App)methodTerm).q, 
                                        resuelveManager, disponeManager, s, clickable, false);

                if (!(typedTerm!=null && typedTerm.type()!=null && typedTerm.type().equals(newFormula))){
                    System.out.println("        ---> Luego entré al if 1");
                    cambiarMetodo = "0";
                }
                else { // This only occurs when the user has just finalized the previous sub-proof
                    System.out.println("        ---> Luego entré al else 1");
                    if (!clickable.equals("n")){
                        cambiarMetodo = "0"; 
                    }
                    newFormula = ((App)((App)formula).p).q; // Second branch
                    System.out.println("    Voy a asignar el statement 2");
                    statement = "<center>$" + clickableST(newFormula, clickable, new Const("AI"), false, s) 
                                   + "$</center>";
                    System.out.println("    El cual es = "+statement);
                    historial += objectMethod.subProofInit(statement);
                }
            }
            // Proof of a sub-case that is not the first one (sure?)
            else{
                System.out.println("    \nEntré al else");
                System.out.println("    Voy a llamar a privateGenerarHistorial 2");
                
                privateGenerarHistorial(user, newFormula, header, nTeo,
                                (ProofBoolean.isBranchedProof2Started(methodTerm)?((App)typedTerm).q:typedTerm), 
                                 valida, labeled, ((App)((App)methodTerm).p).q, resuelveManager, disponeManager, 
                                 s, clickable, false);
                newFormula = ((App)((App)formula).p).q;
                System.out.println("    Voy a asignar el statement 3");
                statement = "<center>$" + clickableST(newFormula, clickable, methodTerm, false, s) 
                                   + "$</center>";
                System.out.println("    El cual es = "+statement);
                header = historial + objectMethod.subProofInit(statement);
                historial = "";
                Term newTypedTerm;
                newTypedTerm = proofCrudOperations.getSubProof(typedTerm, methodTerm);
                System.out.println("    Voy a llamar a privateGenerarHistorial 3");
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
    private String clickableST(Term newTerm, String clickable, Term method, boolean isRootTeorem, 
                                SimboloManager s) throws Exception
    {
        // In full recursion
        if ( (method != null && !(method instanceof Const))||(isRootTeorem && method instanceof Const) ){
            return newTerm.toStringInf(s,"");
        }     
        else if ("DM".equals(clickable)){ // End of the impression
            return "\\cssId{teoremaMD}{\\style{cursor:pointer; color:#08c;}{"+ newTerm.toStringInf(s,"") + "}}";
        }   
        else if ("SS".equals(clickable)) { // End of the impression
            String formulaDer = ((App)((App)newTerm).p).q.toStringInf(s,"");
            String formulaIzq = ((App)newTerm).q.toStringInf(s,"");

            Term operatorTerm = ((App)((App)newTerm).p).p;
            String operator   = operatorTerm.toStringInf(s,"");

            if(!operatorTerm.toString().startsWith("c_{1}") && !operatorTerm.toString().startsWith("c_{20}")){
                throw new Exception();
            }
            
            formulaDer = "\\cssId{d}{\\class{teoremaClick}{\\style{cursor:pointer; color:#08c;}{"+ formulaDer + "}}}";
            formulaIzq = "\\cssId{i}{\\class{teoremaClick}{\\style{cursor:pointer; color:#08c;}{"+ formulaIzq + "}}}";

            return formulaIzq+"$ $"+ operator +"$ $" + formulaDer;
        }
        else{ // clickable.equals("n")
            return newTerm.toStringInf(s,"");
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
        privateGenerarHistorial(user, formula, "", nTeo, typedTerm, valida, labeled, 
            methodTerm, resuelveManager, disponeManager, s, "n", true);
        historial = MicroServices.transformLaTexToHTML(historial);
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
        System.out.println("Entre a privateGenerarHistorial con typedTerm = "+((typedTerm!=null) ? typedTerm.toStringFinal() : null));
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
                header = "Theorem " + nTeo + ":<br> <center>$" + 
                         clickableST(formula, clickable, methodTerm, isRootTeorem, s) + "$</center>" +
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
            strMethod = methodTerm.toStringFinal();
        }

        strMethod = strMethod.substring(0, 2);
        GenericProofMethod objectMethod = proofCrudOperations.createProofMethodObject(strMethod);

        boolean recursive = objectMethod.getIsRecursiveMethod();

        // If the method is recursive, the header will be built in the "setRecursiveMethod"
        header += (!recursive) ? objectMethod.header(nTeo) : "";

        // PROVISIONAL <--- ESTO DEBE SER BORRADO
        Boolean naturalSide, naturalDirect;
        naturalSide = naturalDirect = false;
        // ---- FIN DE LO QUE DEBE SER BORRADO
        
        Term type = typedTerm==null?null:typedTerm.type();

        if (typedTerm==null && methodTerm == null && !recursive){
            this.setHistorial(this.getHistorial()+header);
            return;
        }
        if (typedTerm!=null && type == null && !valida && !recursive){
            this.setHistorial(this.getHistorial()+header+"<center>$"+typedTerm.toStringInfLabeled(s)+MicroServices.transformLaTexToHTML("$\\text{No valid inference}$"));
            return;
        }
        if (typedTerm!=null && type == null && valida && !recursive) { // Case where what we want to print is the first line
            String firstLine;
            if(naturalSide){
                firstLine = ((App)((App)typedTerm).p).q.toStringInfLabeled(s);  
                this.setHistorial(this.getHistorial()+header+"<br>Assuming H1: $"+ ((App)typedTerm).q.toStringInf(s, "") +"$<center>$"+firstLine+"</center>");
            }else {
                firstLine = typedTerm.toStringInfLabeled(s);
                this.setHistorial(this.getHistorial()+header+"<center>$"+firstLine+"</center>");
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
                System.out.println("editedFormula = "+editedFormula.toStringInf(s,""));
                //System.out.println("editedFormula = "+editedFormula.toStringFinal());

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

            historial = header + "<center>$" + historial + "</center>";

            if (!valida){
                historial = historial + MicroServices.transformLaTexToHTML("$\\text{No valid inference}$");
            }
        }

        //else if (naturalDirect)
        //    ; //setDirectProof(user, translateToDirect(typedTerm), resuelveManager, disponeManager, s, false);
        //else if (naturalSide)
        //    ; //setDirectProof(user, translateToOneSide(typedTerm), resuelveManager, disponeManager, s, true);
        
        // Add the hypothesis if we are doing natural deduction
        // if(naturalDirect || naturalSide) { 
        //     header += "<br>Assuming H1: $" +((App)((App)((App)type).p).q).q.toStringInf(s,"") + "$<br><br>";
        // }

        // if (!recursive) { // <--- It had commented (!andIntroduction) as a condition
        //     historial = header+"<center>$" +historial+"</center>";
        //     if (!valida){
        //         historial = historial + MicroServices.transformLaTexToHTML("$\\text{No valid inference}$");
        //     }
        // }

        //else if (/*!andIntroduction &&*/ recursive)
        //    ;
        //else 
        //    this.setHistorial(header +this.getHistorial());
        
        //this.setHistorial(this.getHistorial()+ "$$" +pasoPost + "$$");        
    }  
}