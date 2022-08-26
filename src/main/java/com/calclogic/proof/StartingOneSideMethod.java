package com.calclogic.proof;

import com.calclogic.entity.Resuelve;
import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Const;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.lambdacalculo.TypeVerificationException;
import com.calclogic.lambdacalculo.TypedApp;
import com.calclogic.lambdacalculo.TypedI;
import com.calclogic.lambdacalculo.TypedL;
import com.calclogic.lambdacalculo.TypedS;
import com.calclogic.service.DisponeManager;
import com.calclogic.service.ResuelveManager;
import com.calclogic.service.SimboloManager;

/**
 *
 * @author ronald
 */
public class StartingOneSideMethod extends GenericProofMethod {

    public StartingOneSideMethod(){
        setInitVariables("SS");
    }

    /**
     * Indicates the header that a proof that starts with starting from one side
     * method must have.
     *  
     * @param nTeo: Number of the theorem to be proved, expressed in a string
     * @return The header message to be added to the proof
     */
    @Override
    public String header(String nTeo){
        return "By starting from one side";
    }

    /**
     * This function adds a step of a proof into a bigger proof, when the
     * current method is the direct one or starting from one side.
     *
     * @param historial
     * @param user
     * @param typedTerm
     * @param solved
     * @param resuelveManager
     * @param disponeManager
     * @param s
     * @return 
     */
    @Override
    public String setBaseMethodProof(String historial, String user, Term typedTerm, boolean solved, 
                ResuelveManager resuelveManager, DisponeManager disponeManager, SimboloManager s)
    {   
        String primExp;
        String newStep; // New part of the proof that will be added
        String lastline; // Plain string of the last line of the demonstration
        Term iter; // Iterator over the lines of a demonstration

        boolean equanimity = false; // Indicates if equanimity was used
        String equanimityHint = ""; // Text that indicates in which already proven theorem the current demonstration finalized (if any)
        
        /* If the demonstrarion method is starting from one side, or the typedTerm is not an inference
           but just a functional application (an App) or is an equanimity inference */
        if (this.methodStr.equals("SS") || !(typedTerm instanceof TypedApp) || ((TypedApp)typedTerm).inferType!='e') {
            if (solved && typedTerm instanceof TypedApp && ((TypedApp)typedTerm).inferType=='s'){
                iter = ((TypedApp)typedTerm).q;
            }
            else{
                iter = typedTerm;
            }
            Term aux = ((App)((App)iter.type()).p).q;       
            lastline = (solved?aux.toStringLaTeX(s,"")+"$":aux.toStringLaTeXLabeled(s));
        }
        // Case when direct method is applied and the starting point is the expression to be proved
        else { 
            String eqSust = ""; // Indicates the instantiation (if any) that was necessary to apply to the already proven theorem

            // Case when we need to instantiate the already proven theorem so it matches the final expression of the current proof
            if (((TypedApp)typedTerm).q instanceof TypedApp){
                lastline = ((TypedApp)((TypedApp)typedTerm).q).q.type().toStringFinal();
                eqSust = "~with~"+ ((TypedApp)((TypedApp)typedTerm).q).p.type().toStringLaTeX(s,"");
            }
            else {
                // Note that here we have a less "q" respect of the previous case because in there 
                // there was an additional tree representing the instantiation
                lastline = ((TypedApp)typedTerm).q.type().toStringFinal();
            }

            // We get the Resuelve row associated to the demonstrated theorem in order that we can 
            // later get its current number (established by the user) to indicate that it is what
            // was used to end the demonstration
            Resuelve eqHintResuel = resuelveManager.getResuelveByUserAndTeorema(user, lastline, false);

            // Case when the user could only see the theorem but had not a Resuelve object associated to it
            if (eqHintResuel == null){
                eqHintResuel = resuelveManager.getResuelveByUserAndTeorema("AdminTeoremas", lastline, false);
            }

            equanimityHint = "~~~-~\\text{st}~("+eqHintResuel.getNumeroteorema()+")"+eqSust;

            if( ((TypedApp)typedTerm).p instanceof TypedApp && 
                ((TypedApp)((TypedApp)typedTerm).p).inferType=='s' 
               ) 
            {
                iter = ((TypedApp)((TypedApp)typedTerm).p).q;       
                lastline = ((App)((App)iter.type()).p).q.toStringLaTeX(s,"")+equanimityHint+"$";
            }
            else  {
                iter = ((TypedApp)typedTerm).p;
                equanimity = true;
                lastline = ((App)((App)iter.type()).p).q.toStringLaTeX(s,"")+"$";
            }
        }

        Term ultInf = null;
        while (iter!=ultInf){
            if (iter instanceof TypedApp && ((TypedApp)iter).inferType=='t') {
                ultInf = ((TypedApp)iter).q;
                iter = ((TypedApp)iter).p;
                Term ultInfType = ultInf.type();
                primExp = ((App)ultInfType).q.toStringLaTeX(s,""); 
            }
            else {
                ultInf = iter;
                Term ultInfType = ultInf.type();
                primExp = ((App)ultInfType).q.toStringLaTeX(s,"");
                if (equanimity){
                    primExp += equanimityHint;
                }
            } 
            newStep = stepOneSideEq(user, ultInf, resuelveManager, disponeManager, s);
            historial = "~~~~~~" + primExp + " \\\\" + newStep + "\\\\" + historial;
            primExp = newStep = "";
        }
        return historial + "~~~~~~" + lastline;
    }

    /**
     * This generates a step in the demonstration of a theorem when we already have a side 
     * of an equivalence and the next step is the other side. 
     * 
     * At first this might seem exclusive to the starting from one side method, but it is also
     * needed for the direct and transitive ones, and that's the reason they inherit from this.
     *
     * @param user 
     * @param typedTerm
     * @param resuelveManager
     * @param disponeManager
     * @param s
     * @return The new step of the demonstration as a string
     */
    protected String stepOneSideEq(String user, Term typedTerm, ResuelveManager resuelveManager, DisponeManager disponeManager, SimboloManager s) {
        String teo, leib, inst, newStep;
        teo = leib = inst = newStep = "";

        // if the inference is a modus pones that simulates natural deduction is true this
        boolean naturalInfer=typedTerm instanceof TypedApp && ((TypedApp)typedTerm).inferType=='m';
        Term ultInf = (naturalInfer?((TypedApp)typedTerm).p:typedTerm);

        if (ultInf instanceof App){
            if (((App)ultInf).q instanceof App){
                if (((App)((App)ultInf).q).q instanceof App){
                    teo = ((App)((App)((App)ultInf).q).q).q.type().toStringFinal();
                    inst = ((App)((App)((App)ultInf).q).q).p.type().toStringLaTeX(s,"");
                    inst = "~\\text{with}~" + inst;
                    leib = ((App)((App)ultInf).q).p.type().toStringLaTeX(s,"");
                    leib = "~\\text{and}~" + leib;
                }
                else {
                    teo = ((App)((App)ultInf).q).q.type().toStringFinal();
                    if (((App)ultInf).p instanceof TypedS){
                        if (((App)((App)ultInf).q).p instanceof TypedI){
                            inst = ((App)((App)ultInf).q).p.type().toStringLaTeX(s,"");
                            inst = "~\\text{with}~" + inst;
                        }
                        else {
                            leib = ((App)((App)ultInf).q).p.type().toStringLaTeX(s,"");
                            leib = "~\\text{and}~" + leib;
                        }
                    } else {
                        inst = ((App)((App)ultInf).q).p.type().toStringLaTeX(s,"");
                        inst = "~\\text{with}~" + inst;
                        leib = ((App)ultInf).p.type().toStringLaTeX(s,"");
                        leib = "~\\text{and}~" + leib;
                    }
                }
            } else {
                Term pType = ((App)ultInf).p.type();
                if (((App)ultInf).p instanceof TypedI){
                    inst = pType.toStringLaTeX(s,"");
                    inst = "~\\text{with}~" + inst;
                }
                else if (((App)ultInf).p instanceof TypedL){
                    leib = "~\\text{and}~" + pType.toStringLaTeX(s,"");
                }
                // The SA case does not fulfill any of the two conditions above, and only "teo" is assigned
                teo = ((App)ultInf).q.type().toStringFinal();
            }
        } else {
            Term aux = ultInf.type();
            teo = aux.toStringFinal();
        } 

        int conId =(naturalInfer? ((Const)((App)((App)((App)((App)ultInf.type()).p).q).p).p).getId() 
                                :((Const)((App)((App)ultInf.type()).p).p).getId());
        String op = s.getSimbolo(conId).getNotacion_latex();

        Resuelve theo = resuelveManager.getResuelveByUserAndTeorema(user, teo, false);
        Boolean entry = true;
        if (theo == null){
            theo = resuelveManager.getResuelveByUserAndTeorema("AdminTeoremas", teo, false);

            if (theo == null){
                //********** This part will probably be removed
                teo = disponeManager.getDisponeByUserAndMetaeorema(user, teo).getNumerometateorema();
                newStep = op+"~~~~~~\\langle \\text{mt}~("+teo+")"+inst+leib+"\\rangle";
                entry = false;
            }
        }

        if (entry){
            teo = theo.getNumeroteorema();
            newStep = op+"~~~~~~\\langle \\text{st}~("+teo+")"+inst+leib+"\\rangle";         
        }
        return newStep;
    }

    /**
     * Auxiliar method for "finishedBaseMethodProof" that implements the corresponding
     * logic according to the starting from one side method.
     * 
     * It assumes we have a proof that so far has proved A == ... == F
     * 
     * @param formulaBeingProved: Formula that the user is trying to prove in this proof/sub-proof
     * @param proof: The proof tree so far
     * @param username: name of the user doing the proof
     * @param expr: The root of the proof tree, which is the last line
     * @param initialExpr: The expression (could be a theorem) from which the user started the demonstration
     * @param finalExpr: The last line in the demonstration that the user has made
     * @return new proof if finished, else returns the same proof
     * @throws com.calclogic.lambdacalculo.TypeVerificationException
     */
    @Override
    protected Term auxFinBaseMethodProof(Term formulaBeingProved, Term proof, String username,
                ResuelveManager resuelveManager, SimboloManager simboloManager, 
                Term expr, Term initialExpr, Term finalExpr) throws TypeVerificationException
    {
        // If Formula that the user is trying to prove in this proof/sub-proof is of the form H => A == B, then H /\ A ==  H /\ B must be given instead)
        if(initialExpr.equals(((App)((App)formulaBeingProved).p).q) && finalExpr.equals(((App)formulaBeingProved).q)){
            return new TypedApp(new TypedS(proof.type()), proof);
        }
        return proof;
    }
}