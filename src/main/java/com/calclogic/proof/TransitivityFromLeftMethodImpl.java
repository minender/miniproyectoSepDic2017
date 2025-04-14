package com.calclogic.proof;

import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Bracket;
import com.calclogic.lambdacalculo.Const;
import com.calclogic.lambdacalculo.Var;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.lambdacalculo.TypeVerificationException;
import com.calclogic.lambdacalculo.TypedA;
import com.calclogic.lambdacalculo.TypedApp;
import com.calclogic.lambdacalculo.TypedL;
import com.calclogic.lambdacalculo.TypedM;
import com.calclogic.lambdacalculo.TypedS;
import com.calclogic.lambdacalculo.TypedTerm;
import com.calclogic.parse.CombUtilities;
import com.calclogic.service.ResuelveManager;
import com.calclogic.service.SimboloManager;
import com.calclogic.service.DisponeManager;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.springframework.stereotype.Service;



/**
 *
 * @author ronald
 */
@Service
public class TransitivityFromLeftMethodImpl extends StartingFromLeftMethodImpl implements TransitivityFromLeftMethod {

    protected boolean Bool;
    
    public TransitivityFromLeftMethodImpl(){
        Bool = true;
        setInitVariables("TL");
    }

    /**
     * Indicates the header that a proof that starts with transitivity method must have.
     *  
     * @param nTeo: Number of the theorem to be proved, expressed in a string
     * @return The header message to be added to the proof
     */
    @Override
    public String header(String nTeo, Term formulaBeingProved){
        return "By transitivity method<br>";
    }

    /**
     * Checks if the two arguments are of the form p op q and q op^{-1} p
     * 
     * @param t1: Term that represent a formula
     * @param t2: Term that represent a formula
     * @return true if and only if t1 and t2 are of the form p op q and q op^{-1} p respectively
     */    
    protected boolean isInverseImpl(Term t1, Term t2) {
        if ( !(t1 instanceof App) || !(((App)t1).p instanceof App)) {
            return false;
        }
        String op1 = ((App)((App)t1).p).p.toString();
        return (op1.equals("c_{2}") || op1.equals("c_{3}")) && 
                t2 instanceof App && ((App)t2).p instanceof App &&
                ((App)t1).q.equals(((App)((App)t2).p).q) && 
               ((App)((App)t1).p).q.equals(((App)t2).q) && 
               ((App)((App)t2).p).p.toString().equals((op1.equals("c_{2}")?"c_{3}":"c_{2}"));
    }

    /**
     * This function adds a step of a proof into a bigger proof, when 
     * the current method is a transitive one.
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

        //boolean reversed = solved && typedTerm instanceof TypedApp && ((TypedApp)typedTerm).inferType=='e' &&
        //              isInverseImpl(((TypedApp)typedTerm).q.type().setToPrint(simboloManager),
        //                                                                 typedTerm.type().setToPrint(simboloManager));
        iter = typedTerm;//(reversed?((TypedApp)typedTerm).q:typedTerm);
        //boolean lastEquan = solved && iter instanceof TypedApp && ((TypedApp)iter).inferType=='e' &&
        //              ((TypedApp)iter).q.type().setToPrint(simboloManager).toString().equals("c_{8}");
        iter = (solved?deleteFinishProof(iter):iter);
        int i = 0;
        int firstOpInf = transFirstOpInferIndex(iter, true);

        Term ultInf = null;
        while (iter!=ultInf){
            // iter is of the form TT with transitivity
            if (iter instanceof TypedApp && ((TypedApp)iter).inferType=='t') {
               ultInf = ((TypedApp)iter).q;
               iter = ((TypedApp)iter).p;   
            }
            else if (iter instanceof TypedApp && ((TypedApp)iter).inferType=='e' &&
                     ((TypedApp)iter).p instanceof TypedApp &&
                     ((TypedApp)((TypedApp)iter).p).inferType=='l'
                    ) {
               ultInf = ((TypedApp)iter).p;
               iter = ((TypedApp)iter).q;
            }
            else if (iter instanceof TypedApp && ((TypedApp)iter).inferType=='m' &&
                     ((TypedApp)iter).p instanceof TypedApp && 
                     ((TypedApp)((TypedApp)iter).p).inferType=='m' && 
                     ((TypedApp)((TypedApp)iter).p).p instanceof TypedApp &&
                     ((TypedApp)((TypedApp)((TypedApp)iter).p).p).inferType=='i'
                    ) { // iter is of the form ((IA)T)T wit modus pones
               ultInf = ((TypedApp)iter).q;//el axioma es (e==f)=>E.f=>E.e
               String axiom = "= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(ccb,)} c_{2} (\\Phi_{(bbb,cb)} c_{2}) (\\Phi_{c(cbbb,)} c_{1}))";
               if (((TypedA)((TypedApp)((TypedApp)((TypedApp)iter).p).p).q).getCombDBType().equals(axiom))
                   iter = ((TypedM)((TypedApp)((TypedApp)iter).p).q).getSubProof();
               else
                   iter = ((TypedApp)((TypedApp)iter).p).q;
            }
            else { // first inference
                // ultInf is a no =inference folowing with a matatheorem of true
                if ( iter instanceof TypedApp && ((TypedApp)iter).inferType=='e' &&
                     ((TypedApp)iter).p instanceof TypedApp && 
                     ((TypedApp)((TypedApp)iter).p).p instanceof TypedS && Bool
                   )// query that verifies if metatheorem was used i.e ultInf of the form 
                    // (S(T)).T with . equanimity
                    iter = ((TypedApp)iter).q;
                ultInf = iter;
                
            }
            i++;
            // if ultInf is a no =inference do this
            Term ultInfType = ultInf.type();
            if (ultInfType.containT())
                ultInfType = ((App)ultInfType).q.body();
            //Term ultInfType = ultInf.type().setToPrint(simboloManager);
            if (ultInfType instanceof App && ((App)ultInfType).p instanceof App &&
                   !(((App)((App)ultInfType).p).p.toString().equals("=") //||
                     //((App)((App)ultInfType).p).p.toString().equals("c_{20}")
                    )
               )
            {
                primExp = ((App)ultInfType).q.toStringLaTeX(s,"",null); 
                newStep = stepTransOpInfer(user, ultInf, resuelveManager, disponeManager, s);
            }
            else if (ultInf == iter){ // ultInf is a =inference or opinference and the first one
                    primExp = ((App)ultInfType).q.toStringLaTeX(s,"",null); 
                    newStep = stepOneSideEq(user, ultInf, resuelveManager, disponeManager, s);
            } else if (i<firstOpInf){ // ultInf is a =inference and not the first one and  
                                    // after at least one no =inference
                primExp = ((App)((App)((App)ultInfType).q.body()).p).q.toStringLaTeX(s,"",null); 
                newStep = stepTransEqInfer(user, ultInf, resuelveManager, disponeManager, s);
            } else { // ultInf is a =inference and not the first one
                   // and before the first no =inference
                primExp = ((App)ultInfType).q.toStringLaTeX(s,"",null); 
                newStep = stepOneSideEq(user, ultInf, resuelveManager, disponeManager, s);
            }
            historial = "~~~~~~" + primExp + " \\\\" + newStep + "\\\\" + historial;
            primExp = newStep = "";
        }
        if ( firstOpInf == 0 || i == 1)
        {
            //Term last = (reversed?((App)typedTerm.type().setToPrint(simboloManager)).q:
                                    // ((App)((App)typedTerm.type().setToPrint(simboloManager)).p).q);
            Term last = (solved?((App)((App)deleteFinishProof(typedTerm).type().setToPrint(simboloManager)).p).q:
                                   ((App)((App)typedTerm.type().setToPrint(simboloManager)).p).q);
            lastline = (solved?last.toStringLaTeX(s,"",null)+"$":last.toStringLaTeXLabeled(s));
        }
        else {
            Term last = (solved?deleteFinishProof(typedTerm):typedTerm);//(reversed?((TypedApp)typedTerm).q:typedTerm);
            //last = ((App)((App)((App)((App)(lastEquan?((TypedApp)last).p:last).type().setToPrint(simboloManager)).p).q).p).q;
            //last = ((App)((App)(lastEquan?((TypedApp)last).p:last).type().setToPrint(simboloManager)).p).q;
            last = ((App)((App)last.type().setToPrint(simboloManager)).p).q;
            lastline = (solved?last.toStringLaTeX(s,"",null)+"$":last.toStringLaTeXLabeled(s));
        }
        return historial + "~~~~~~" + lastline;  
    }

    /**
     * This function generates the step of a proof when the proof method is 
     * a transitive one, and the current step was generated by the current transitive operator
     *
     * @param user 
     * @param ultInf
     * @param resuelveManager
     * @param disponeManager
     * @param s
     * @return The step of the step as a string.
     */
    private String stepTransOpInfer(String user, Term typedTerm, ResuelveManager resuelveManager, DisponeManager disponeManager, SimboloManager s) {
        
        Term iter, ultInf;
        iter = typedTerm;
        ultInf = null;
        Term leibniz = new Var('z');
        String step;
        
        while (iter != ultInf) {
            //iter of the form (TT)T
            if (iter instanceof TypedApp && ((TypedApp)iter).p instanceof TypedApp) {
                boolean modusPonens = ((TypedApp)iter).inferType=='m';
                ultInf = ((TypedApp)iter).p;
                iter = ((TypedApp)iter).q;
                
                Term t;
                if ( modusPonens ) {
                    App aux1 = (App)((App)((App)((App)((App)ultInf).q.type().setToPrint(simboloManager)).p).q).q;
                    App aux2 = (App)((App)((App)((App)ultInf.type().setToPrint(simboloManager)).p).q).q;
                    if ( aux1.q instanceof Bracket && ((Var)((App)((Bracket)aux1.q).t).p).indice == 81 ) {
                        t = new App(new App(new App(new Const(62,"c_{62}"),((App)((App)((App)aux2).p).p).q),((App)((App)aux2).p).q),new Var('z'));
                        if (iter instanceof TypedM && ((TypedM)iter).getNumber()==11 )
                           iter = ((TypedM)iter).getSubProof();
                    }
                    else if ( aux1.q instanceof Bracket && ((Var)((App)((Bracket)aux1.q).t).p).indice == 82 ) {
                        t = new App(new App(new App(new Const(62,"c_{62}"),((App)((App)((App)aux2).p).p).q),new Var('z')),((App)aux2).q);
                        if (iter instanceof TypedM && ((TypedM)iter).getNumber()==11 )
                           iter = ((TypedM)iter).getSubProof();
                    }
                    else if ( ((Var)aux1.q).indice == 112 ) {
                        t = new App(((App)aux2).p,new Var('z'));
                    }
                    else {
                        t = new App(new App(((App)((App)aux2).p).p,new Var('z')),((App)aux2).q);
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
        step = stepOneSideEq(user, ultInf, resuelveManager, disponeManager, s);
        step = ((App)((App)typedTerm.type().setToPrint(simboloManager)).p).p.toStringLaTeX(s,"",null)+step.substring(step.indexOf("~"));
        if (leibniz.toString().equals("x_{122}") )
            return step;
        else
            return step.substring(0, step.length()-7)+"~and~E:"+leibniz.toStringLaTeX(s, "",null)+"\\rangle";
    }

    /**
     * This function generates the step of a demonstration when the proof method is 
     * a transitive one, but the current step was generated by an equivalence, not the current
     * transitive operator.
     * @param user 
     * @param ultInf
     * @param resuelveManager
     * @param disponeManager
     * @param s
     * @return The step as a string.
     */
    private String stepTransEqInfer(String user, Term ultInf, ResuelveManager resuelveManager, DisponeManager disponeManager, SimboloManager s) {
        Term aux = ((TypedApp)ultInf).q;
        int z = ((Bracket)((TypedApp)ultInf).p.type()).x();
        Term t = ((App)((App)((Bracket)((TypedApp)ultInf).p.type()).t).p).q;
        Term typedTerm;
        try {
            typedTerm = (t instanceof Var?aux:new TypedApp(new TypedL(new Bracket(new Var(z),t)),aux));
        }
        catch (TypeVerificationException e) {
            Logger.getLogger(TransitivityFromLeftMethod.class.getName()).log(Level.SEVERE, null, e);
            return "";
        }
        return stepOneSideEq(user, typedTerm, resuelveManager, disponeManager, s);
    }

    /**
     * Returns the index of the first inference that is not a 
     * equiv or = in a Transitivity method
     * 
     * @param typedTerm Derivation tree that code a Transitivity proof
     * @param reverse Determines if we want the index but counting in reverse
     * @return index of the first no =inference
     */
    @Override
    public int transFirstOpInferIndex(Term typedTerm, Boolean reverse) {
        Term iter;
        iter = typedTerm;
        Term ultInf = null;
        int i = 0;
        int firstOpInf = 0;
        while (iter!=ultInf){
            if (iter instanceof TypedApp && ((TypedApp)iter).inferType=='t') {// TT
               ultInf = ((TypedApp)iter).q;
               iter = ((TypedApp)iter).p;
            }
            else if (iter instanceof TypedApp && ((TypedApp)iter).inferType=='e' &&
                     ((TypedApp)iter).p instanceof TypedApp &&
                     ((TypedApp)((TypedApp)iter).p).inferType=='l'
                    ) {// TT
               ultInf = ((TypedApp)iter).p;
               iter = ((TypedApp)iter).q;
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
                if ( iter instanceof TypedApp && ((TypedApp)iter).inferType=='e' &&
                     ((TypedApp)iter).p instanceof TypedApp && 
                     ((TypedApp)((TypedApp)iter).p).inferType=='s'
                   ) 
                    iter = ((TypedApp)iter).q;
                ultInf = iter;
            }
            i++;
            Term ultInfType = ultInf.type();
            if (ultInfType.containT())
                ultInfType = ((App)ultInfType).q.body();
            if (ultInfType instanceof App && ((App)ultInfType).p instanceof App &&
                ((App)((App)ultInfType).p).p instanceof Const &&    
                   !(((Const)((App)((App)ultInfType).p).p).getCon().equals("=") //||
                     //((App)((App)ultInfType).p).p.toString().equals("c_{20}")
                    )
               )
                firstOpInf = i;
        }
        if (!reverse && (firstOpInf != 0))
            firstOpInf = i+1-firstOpInf;
        return firstOpInf;
    } 

    /**
     * Auxiliar method for "finishedBaseMethodProof" that implements the corresponding
     * logic according to the transitivity method.It assumes we have a proof that so far has proved A == ...== F
     * 
     * 
     * @param formulaBeingProved: Formula that the user is trying to prove in this proof/sub-proof
     * @param proof: The proof tree so far
     * @param username: name of the user doing the proof
     * @param resuelveManager
     * @param simboloManager
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
            return proof;
    }
    
    protected Term auxFinBaseMethodReversed(Term formulaBeingProved, Term proof, String username,
                ResuelveManager resuelveManager, SimboloManager simboloManager, 
                Term expr, Term initialExpr, Term finalExpr) throws TypeVerificationException
    {
        // If at least one opInference was made and reaches the goal
        if (proof instanceof TypedTerm) {
           if(finalExpr.containT()) {
              finalExpr = ((App)((App)initialExpr.body()).p).q;
              Term op = ((App)((App)initialExpr.body()).p).p;
              initialExpr = ((App)initialExpr.body()).q;
              if (((App)((App)formulaBeingProved).q.body()).q.traducBD().equals(finalExpr.traducBD()) &&
                  ((App)((App)((App)formulaBeingProved).q.body()).p).q.traducBD().equals(initialExpr.traducBD()) 
                 ) 
                 {
                   int id = ((Const)((App)((App)((App)formulaBeingProved).q.body()).p).p).getId();
                   String opSt;
                   if (id == 2)
                       opSt = "sc_{3}";
                   else if (id == 3)
                       opSt = "yc_{2}";
                   else
                       opSt = TypedA.sm_.isSymetric(id);
                   if (opSt.charAt(0) != 'n' && opSt.substring(1).equals(((Const)op).getCon())) {
                      String st = "A^{= (\\Phi_{bb} \\Phi_{b} "+(opSt.charAt(0)=='y'?opSt.substring(1):"c_{"+id+"}")+") (\\Phi_{cb} "+(opSt.charAt(0)=='y'?"c_{"+id+"}":opSt.substring(1))+" \\Phi_{cb})}";
                      Term Ax = CombUtilities.getTerm(st,username,TypedA.sm_);
                      String[] vars = ((TypedA)Ax).getVariables().split(";")[1].split(",");
                      if (opSt.charAt(0)=='y') {
                        st = "I^{[x_{"+(int)vars[0].charAt(0)+"},x_{"+(int)vars[1].charAt(0)+"}:="+finalExpr+","+initialExpr+"]}";
                        return new TypedApp(new TypedApp(new TypedS(),new TypedApp(CombUtilities.getTerm(st,username,TypedA.sm_),Ax)),proof);
                      } else {
                        st = "I^{[x_{"+(int)vars[0].charAt(0)+"},x_{"+(int)vars[1].charAt(0)+"}:="+initialExpr+","+finalExpr+"]}";
                        return new TypedApp(new TypedApp(CombUtilities.getTerm(st,username,TypedA.sm_),Ax),proof);
                      }
                   } else
                     return proof;
                 }
                 else
                   return proof;
           }
           else
             return proof;
        }
        else
            return proof;
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
    
    public void setSimboloManager(SimboloManager simboloManager) {
        this.simboloManager = simboloManager;
    }
    
    public SimboloManager getSimboloManager() {
        return simboloManager;
    }
}