package com.calclogic.proof;

import com.calclogic.entity.Resuelve;
import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Const;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.lambdacalculo.TypeVerificationException;
import com.calclogic.lambdacalculo.TypedA;
import com.calclogic.lambdacalculo.TypedApp;
import com.calclogic.lambdacalculo.TypedI;
import com.calclogic.lambdacalculo.TypedL;
import com.calclogic.lambdacalculo.TypedM;
import com.calclogic.lambdacalculo.TypedS;
import com.calclogic.service.DisponeManager;
import com.calclogic.service.ResuelveManager;
import com.calclogic.service.SimboloManager;

import org.springframework.stereotype.Service;

/**
 *
 * @author ronald
 */
@Service
public class StartingOneSideMethodImpl extends GenericProofMethodImpl implements StartingOneSideMethod {

    public StartingOneSideMethodImpl(){
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
        String lastline = ""; // Plain string of the last line of the demonstration
        String st;
        Term iter; // Iterator over the lines of a demonstration

        boolean equanimity = false; // Indicates if equanimity was used
        String equanimityHint = ""; // Text that indicates in which already proven theorem the current demonstration finalized (if any)
        Term ultInfType = null;
        
        /* If the demonstrarion method is starting from one side, or the typedTerm is not an inference
           but just a functional application (an App) or is an equanimity inference */
        if (this.methodStr.equals("SS") || !(typedTerm instanceof TypedApp) || ((TypedApp)typedTerm).inferType!='e') {
            if (solved && typedTerm instanceof TypedApp && ((TypedApp)typedTerm).inferType=='s'){
                iter = typedTerm.dsc("2",true);  
            }
            else{
                iter = typedTerm;
            }
            ultInfType = iter.type();
            Term aux = ultInfType.dsc("12").body();       
            lastline = (solved?aux.toStringLaTeX(s,"")+"$":aux.toStringLaTeXLabeled(s));
        }
        // Case when direct method is applied and the starting point is the expression to be proved
        else { 
            String nTeo;
            String eqSust = ""; // Indicates the instantiation (if any) that was necessary to apply to the already proven theorem

            // Case when we need to instantiate the already proven theorem so it matches the final expression of the current proof
            if (typedTerm.dsc("2",true) instanceof TypedApp){  
                nTeo = ((TypedA)typedTerm.dsc("22",true)).getNSt();
                eqSust = "~with~"+ typedTerm.dsc("21",true).type().toStringLaTeX(s,"");
            }
            else {
                // Note that here we have a less "q" respect of the previous case because in there 
                // there was an additional tree representing the instantiation
                nTeo = ((TypedA)typedTerm.dsc("2",true)).getNSt();  
            }
            

            // We get the Resuelve row associated to the demonstrated theorem in order that we can 
            // later get its current number (established by the user) to indicate that it is what
            // was used to end the demonstration
            Resuelve eqHintResuel = resuelveManager.getResuelveByUserAndTeorema(user, lastline, false);

            // Case when the user could only see the theorem but had not a Resuelve object associated to it
            if (eqHintResuel == null){
                eqHintResuel = resuelveManager.getResuelveByUserAndTeorema("AdminTeoremas", lastline, false);
            }

            equanimityHint = "~~~-~\\text{st}~(" + nTeo + ")" + eqSust;

            if( typedTerm.dsc("1",true) instanceof TypedApp && 
                ((TypedApp)typedTerm.dsc("1",true)).inferType=='s' 
               ) 
            {
                iter = typedTerm.dsc("12",true);
                lastline = iter.type().dsc("12").toStringLaTeX(s,"") + equanimityHint + "$";
            }
            else  {
                iter = typedTerm.dsc("1",true);
                equanimity = true;
                lastline = iter.type().dsc("12").toStringLaTeX(s,"") + "$";
            }
        }

        Term ultInf = null;
        while (iter!=ultInf){
            if (iter instanceof TypedApp && ((TypedApp)iter).inferType=='t') {
                ultInf = iter.dsc("2",true);
                iter = iter.dsc("1",true);
                ultInfType = ultInf.type();
                primExp = ultInfType.dsc("2").toStringLaTeX(s,""); 
            }
            else {
                ultInf = iter;
                ultInfType = ultInf.type();
                primExp = ultInfType.dsc("2").toStringLaTeX(s,"");
                if (equanimity){
                    primExp += equanimityHint;
                }
            } 
            newStep = stepOneSideEq(user, ultInf, resuelveManager, disponeManager, s);
            historial = "~~~~~~" + primExp + " \\\\" + newStep + "\\\\" + historial;
            primExp = newStep = "";
            st = null;
        }
        return historial + "~~~~~~" + lastline;
    }

    /**
     * This generates a step in the proof of a theorem when we already have a side 
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
        Term st = null;

        // if the inference is a modus pones that simulates natural deduction is true this
        boolean naturalInfer=typedTerm instanceof TypedApp && ((TypedApp)typedTerm).inferType=='m';
        Term ultInf = (naturalInfer ? typedTerm.dsc("1",true) : typedTerm);

        if (ultInf instanceof App){
            if (ultInf.dsc("2") instanceof App){     
                if (ultInf.dsc("22") instanceof App){
                    // Term aux = ((App)ultInf.type()).q;
                    // primExp = aux.toStringInf(s,"")+(aux.equals(goal)?equanimityHint:"");
                    st = ultInf.dsc("222"); //.type().traducBD().toString();
                    inst = ultInf.dsc("221").type().toStringLaTeX(s,"");
                    inst = "~\\text{with}~" + inst;
                    leib = ultInf.dsc("21").type().toStringLaTeX(s,"");
                    leib = "~\\text{and}~"+"E^{z}:" + leib;
                }
                else {
                    st = ultInf.dsc("22"); //.type().traducBD().toString();
                    if (ultInf.dsc("1") instanceof TypedS){
                        if (ultInf.dsc("21") instanceof TypedI){
                            inst = ultInf.dsc("21").type().toStringLaTeX(s,"");
                            inst = "~\\text{with}~" + inst;
                        }
                        else {
                            leib = ultInf.dsc("21").type().toStringLaTeX(s,"");
                            leib = "~\\text{and}~"+"E^{z}:" + leib;
                        }
                    } else {
                        inst = ultInf.dsc("21").type().toStringLaTeX(s,"");
                        inst = "~\\text{with}~" + inst;
                        leib = ultInf.dsc("1").type().toStringLaTeX(s,"");
                        leib = "~\\text{and}~"+"E^{z}:" + leib;
                    }
                }
            } else {
                Term pType = ultInf.dsc("1").type();
                if (ultInf.dsc("1") instanceof TypedI){
                    inst = pType.toStringLaTeX(s,"");
                    inst = "~\\text{with}~" + inst;
                }
                else if (ultInf.dsc("1") instanceof TypedL){
                    leib = "~\\text{and}~"+"E^{z}:" + pType.toStringLaTeX(s,"");
                }
                // The SA case does not fulfill any of the two conditions above, and only "teo" is assigned
                st = ultInf.dsc("2"); //.type().traducBD().toString();
            }
        } else {
            Term aux = ultInf;//.type().traducBD(); //CHECK se puede guardar el nTeo y no buscarlo
            st = aux; //.toString();
        }

        int conId =(naturalInfer? ((Const)ultInf.type().dsc("1211")).getId() 
                                :((Const)ultInf.type().dsc("11")).getId());
        String op = "\\equiv";//s.getSimbolo(conId).getNotacion_latex();
            
        // Resuelve theo = resuelveManager.getResuelveByUserAndTeorema(user, teo, false);
        teo = ((TypedA)st).getNSt();
        /*Boolean entry = true;
        if (theo == null){
            theo = resuelveManager.getResuelveByUserAndTeorema("AdminTeoremas", teo, false);
        }*/
        /*if (theo == null){
            //********** This part will probably be removed
            teo = disponeManager.getDisponeByUserAndMetaeorema(user, teo).getNumerometateorema();
            newStep = op+"~~~~~~\\langle \\text{mt}~("+teo+")"+inst+leib+"\\rangle";
            entry = false;
        }*/
        if (st instanceof TypedM) {
            newStep = op+"~~~~~~\\langle \\text{st}~("+teo+")~\\text{and mt}~("+((TypedM) st).getNumber()+")"+inst+leib+"\\rangle";
        }else {
            //teo = theo.getNumeroteorema();
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
    public Term auxFinBaseMethodProof(Term formulaBeingProved, Term proof, String username,
                ResuelveManager resuelveManager, SimboloManager simboloManager, 
                Term expr, Term initialExpr, Term finalExpr) throws TypeVerificationException
    {
        // If Formula that the user is trying to prove in this proof/sub-proof is of the form H => A == B, then H /\ A ==  H /\ B must be given instead)
        if(initialExpr.equals(formulaBeingProved.dsc("12")) && finalExpr.equals(formulaBeingProved.dsc("2"))){
            proof = new TypedApp(new TypedS(proof.type()), proof);
        }
        Term operatorTerm = formulaBeingProved.dsc("11");
        // The Starting From One Side method only admits reflexive operators
        int resuelveKind = resuelveManager.isReflexiveOperatorForUser(username, operatorTerm.toString());
        new TypedM(resuelveKind, ((Const)operatorTerm).getId(), proof, "", username);
        return proof;
    }
}