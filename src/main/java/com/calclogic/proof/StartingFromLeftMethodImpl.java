package com.calclogic.proof;

import com.calclogic.entity.Resuelve;
import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Bracket;
import com.calclogic.lambdacalculo.Const;
import com.calclogic.lambdacalculo.Term;
import static com.calclogic.lambdacalculo.Term.resultType;
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
public class StartingFromLeftMethodImpl extends GenericProofMethodImpl implements StartingFromLeftMethod {

    public StartingFromLeftMethodImpl(){
        setInitVariables("SL");
    }

    /**
     * Indicates the header that a proof that starts with starting from one side
     * method must have.
     *  
     * @param nTeo: Number of the theorem to be proved, expressed in a string
     * @return The header message to be added to the proof
     */
    @Override
    public String header(String nTeo, Term beginFormula){
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
        
        /* If the proof method is starting from one side, or the typedTerm is not an inference
           but just a functional application (an App) or is an equanimity inference */
        if (this.methodStr.equals("SL") || this.methodStr.equals("SR") ||
            !(typedTerm instanceof TypedApp) || ((TypedApp)typedTerm).inferType!='e') {
            if (solved) {//typedTerm instanceof TypedApp && ((TypedApp)typedTerm).inferType=='s'){
                iter = deleteFinishProof(typedTerm);//((TypedApp)typedTerm).q;
            }
            else{
                iter = typedTerm;
            }
            ultInfType = iter.type();
            Term aux = ((App)((App)iter.type()).p).q.body();       
            lastline = (solved?aux.toStringLaTeX(s,"",null)+closingComment(typedTerm)+"$":aux.toStringLaTeXLabeled(s));
        }
        // Case when direct method is applied and the starting point is the expression to be proved
        else { 
            String nTeo;
            String eqSust = ""; // Indicates the instantiation (if any) that was necessary to apply to the already proven theorem

            // Case when we need to instantiate the already proven theorem so it matches the final expression of the current proof
            if (((TypedApp)typedTerm).q instanceof TypedApp){
                nTeo = ((TypedA)((TypedApp)((TypedApp)typedTerm).q).q).getNSt();
                eqSust = "~with~"+ ((TypedApp)((TypedApp)typedTerm).q).p.type().toStringLaTeX(s,"",null);
            }
            else {
                // Note that here we have a less "q" respect of the previous case because in there 
                // there was an additional tree representing the instantiation
                nTeo = ((TypedA)((TypedApp)typedTerm).q).getNSt();  
            }
            

            // We get the Resuelve row associated to the demonstrated theorem in order that we can 
            // later get its current number (established by the user) to indicate that it is what
            // was used to end the demonstration
            Resuelve eqHintResuel = resuelveManager.getResuelveByUserAndTeorema(user, lastline, false);

            // Case when the user could only see the theorem but had not a Resuelve object associated to it
            if (eqHintResuel == null){
                eqHintResuel = resuelveManager.getResuelveByUserAndTeorema("AdminTeoremas", lastline, false);
            }

            equanimityHint = "~~~-~\\text{st}~("+nTeo+")"+eqSust;

            if( ((TypedApp)typedTerm).p instanceof TypedApp && 
                ((TypedApp)((TypedApp)typedTerm).p).inferType=='s' 
               ) 
            {
                iter = ((TypedApp)((TypedApp)typedTerm).p).q;       
                lastline = ((App)((App)iter.type()).p).q.toStringLaTeX(s,"",null)+equanimityHint+"$";
            }
            else  {
                iter = ((TypedApp)typedTerm).p;
                equanimity = true;
                lastline = ((App)((App)iter.type()).p).q.toStringLaTeX(s,"",null)+"$";
            }
        }

        Term ultInf = null;
        while (iter!=ultInf){
            if (iter instanceof TypedApp && ((TypedApp)iter).inferType=='t') {
                ultInf = ((TypedApp)iter).q;
                iter = ((TypedApp)iter).p;
                ultInfType = ultInf.type();
                primExp = ((App)ultInfType).q.toStringLaTeX(s,"",null); 
            }
            else {
                ultInf = iter;
                ultInfType = ultInf.type();
                primExp = ((App)ultInfType).q.toStringLaTeX(s,"",null);
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
        String teo, leib, z, inst, newStep, op, type;
        teo = leib = z = inst = newStep = "";
        Term st = null;
        type = resultType(((App)typedTerm.type()).q.type());
        if (type.equals("p"))
            op = "\\equiv";//s.getSimbolo(conId).getNotacion_latex();
        else
            op = "=";//s.getSimbolo(conId).getNotacion_latex();
        
        // if the inference is a modus pones that simulates natural deduction is true this
        boolean naturalInfer=typedTerm instanceof TypedApp && ((TypedApp)typedTerm).inferType=='m';
        Term ultInf = (naturalInfer?((TypedApp)typedTerm).p:typedTerm);

        if (ultInf instanceof App){
            if (((App)ultInf).q instanceof App){
                if (((App)((App)ultInf).q).q instanceof App){
                    // Term aux = ((App)ultInf.type()).q;
                    // primExp = aux.toStringInf(s,"")+(aux.equals(goal)?equanimityHint:"");
                    st = ((App)((App)((App)ultInf).q).q).q; //.type().traducBD().toString();
                    inst = ((App)((App)((App)ultInf).q).q).p.type().toStringLaTeX(s,"",null);
                    inst = "~\\text{with}~" + inst;
                    leib = ((App)((App)ultInf).q).p.type().toStringLaTeX(s,"",null);
                    z = (char)((Bracket)((App)((App)ultInf).q).p.type()).x.indice+"";
                    leib = "~\\text{and}~"+"E^{"+z+"}:" + leib;
                }
                else {
                    st = ((App)((App)ultInf).q).q;//.type().traducBD().toString();
                    if (((App)ultInf).p instanceof TypedS){
                        if (((App)((App)ultInf).q).p instanceof TypedI){
                            inst = ((App)((App)ultInf).q).p.type().toStringLaTeX(s,"",null);
                            inst = "~\\text{with}~" + inst;
                        }
                        else {
                            leib = ((App)((App)ultInf).q).p.type().toStringLaTeX(s,"",null);
                            z = (char)((Bracket)((App)((App)ultInf).q).p.type()).x.indice+"";
                            leib = "~\\text{and}~"+"E^{"+z+"}:" + leib;
                        }
                    } else {
                        inst = ((App)((App)ultInf).q).p.type().toStringLaTeX(s,"",null);
                        inst = "~\\text{with}~" + inst;
                        leib = ((App)ultInf).p.type().toStringLaTeX(s,"",null);
                        z = (char)((Bracket)((App)ultInf).p.type()).x.indice+"";
                        leib = "~\\text{and}~"+"E^{"+z+"}:" + leib;
                    }
                }
            } else {
                Term pType = ((App)ultInf).p.type();
                if (((App)ultInf).p instanceof TypedI){
                    inst = pType.toStringLaTeX(s,"",null);
                    inst = "~\\text{with}~" + inst;
                }
                else if (((App)ultInf).p instanceof TypedL){
                    z = (char)((Bracket)pType).x.indice+"";
                    leib = "~\\text{and}~"+"E^{"+z+"}:" + pType.toStringLaTeX(s,"",null);
                }
                // The SA case does not fulfill any of the two conditions above, and only "teo" is assigned
                st = ((App)ultInf).q; //.type().traducBD().toString();
            }
        } else {
            Term aux = ultInf;//.type().traducBD(); //CHECK se puede guardar el nTeo y no buscarlo
            st = aux; //.toString();
        } 

        int conId =(naturalInfer? ((Const)((App)((App)((App)((App)ultInf.type()).p).q).p).p).getId() 
                                :((Const)((App)((App)ultInf.type()).p).p).getId());
            
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
            if (((TypedM) st).getNumber() == 7 ) {
                Term typedMProof = ((App)((App)((TypedM)st).getProof()).p).q;
                if (!(typedMProof instanceof TypedA))
                    typedMProof = ((App)typedMProof).q;
                newStep = op+"~~~~~~\\langle \\text{st}~("+teo+",~"+((TypedA)typedMProof).getNSt()+")"+inst+leib+"\\rangle";
            }
            else if (((TypedM) st).getNumber() == 11) {
                Term typedMProof = ((App)((App)((TypedM)st).getProof()).p).q;
                if (!(typedMProof instanceof TypedA))
                    typedMProof = ((App)typedMProof).q;
                newStep = op+"~~~~~~\\langle \\text{st}~("+teo+")"+inst+leib+"\\rangle";         
            }
            else
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
        Term operatorTerm = ((App)((App)formulaBeingProved).p).p;
        // The Starting From One Side method only admits reflexive operators
        int resuelveKind = resuelveManager.isReflexiveOperatorForUser(username, operatorTerm.toString());
        new TypedM(resuelveKind, ((Const)operatorTerm).getId(), proof, "", username);
        return proof;
    }
    
    /**
     * This function returns the closing comment of the proof i.e. the conclusion of the proof
     * 
     * @param proof: The current proof
     * @return String with the closing comment of the proof
     */
    public String closingComment(Term proof) {
        return  "\\\\ ~ \\\\ \\therefore~"+proof.type().toStringLaTeX(simboloManager, "", null)+" ";
    }
    
    /**
     * This function delete the last part of the proof depends of the method
     * 
     * @param proof: The current proof
     * @return proof without the last part of the proof that finish the proof
     */
    public Term deleteFinishProof(Term proof) {
        return proof;
    }
}