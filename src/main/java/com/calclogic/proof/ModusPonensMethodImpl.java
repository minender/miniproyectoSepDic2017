/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.proof;

import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Bracket;
import com.calclogic.lambdacalculo.Const;
import com.calclogic.lambdacalculo.Equation;
import com.calclogic.lambdacalculo.Sust;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.lambdacalculo.TypeVerificationException;
import com.calclogic.lambdacalculo.TypedA;
import com.calclogic.lambdacalculo.TypedApp;
import com.calclogic.lambdacalculo.TypedI;
import com.calclogic.lambdacalculo.Var;
import com.calclogic.parse.CombUtilities;
import java.util.List;

/**
 *
 * @author feder
 */
public class ModusPonensMethodImpl extends GenericProofMethodImpl implements ModusPonensMethod{
    
        public ModusPonensMethodImpl(){
        setInitVariables("MP");
    }

    /**
     * The statement that is needed to be proven may change inside a sub proof,
     * so this function calculates which that new statement is.
     *  
     * @param beginFormula: general statement to be proved, is the base to calculate 
     *                      al de sub statement in the sub proofs.
     * @return Term that represents the statement to be proved in the current sub proof.
     */
    @Override
    public Term initFormula(Term beginFormula, Term proof, String usr){
        Term aux = null;
        try {
          String idTeo = usr.split(":")[0];
          usr = usr.substring(idTeo.length()+1);
          Term[] impl = new Term[1];
          Sust s = unificationSust(beginFormula, idTeo, usr, impl);
          Term ant = impl[0].type();
          Term cons;
          if (this.methodStr.equals("MP")) {
            ant = ((App)ant).q.body();
            cons = ((App)((App)ant).p).q;
            ant = ((App)ant).q;
          } else if (this.methodStr.equals("EL")) {
            cons = ((App)ant).q.body();
            ant = ((App)((App)ant).p).q.body();
          }else {
            cons = ((App)((App)ant).p).q.body();
            ant = ((App)ant).q.body();
          }
          
          String freeVars = ant.stFreeVars();
          String bndVars = ant.getBoundVarsComma();
          String variables = bndVars + ";" + freeVars;

          ant = ant.toEquality(freeVars);
        
          if (s != null) {
             Term I = CombUtilities.getTerm("I^{"+stSubst(variables, s)+"}", usr, TypedA.sm_);
             aux = new TypedApp(I,new TypedA(ant,variables,"-",ant.traducBD().toString())).type();
          }else if (cons.traducBD().equals(aux.traducBD()))
             aux = ant;
          else
             aux = null;
        } catch(TypeVerificationException e){aux = null;}
        
        return aux;
    }
    
    private String stSubst(String vars, Sust s) {
        String left = "";
        String right = "";
        String[] v = vars.split(";")[1].split(",");
        boolean find = false;
        int k = 0;
        while (k<v.length) {
           for (int i=0; i<s.getVars().size() ; i++) {
             if (s.getVars().get(i).indice == (int)v[k].charAt(0)) {
                left = left + s.getVars().get(i);
                right = right + s.getTerms().get(i);
                find = true;
                break;
             }
           }
           k++;
           if (find) break;
        }
        for (int j=k; j<v.length ; j++) {
            for (int i=0; i<s.getVars().size() ; i++) {
               if (s.getVars().get(i).indice == (int)v[j].charAt(0)) {
                 left = left + ", " + s.getVars().get(i);
                 right = right + ", " + s.getTerms().get(i);
               }
            }
        }
        return "["+left + ":= " + right+"]";
    }
    
    private Sust unificationSust(Term beginFormula, String idTeo, String usr, Term[] impl) 
            throws TypeVerificationException {
        Sust s = null;
        String teo = resuelveManager.getResuelveByUserAndTeorema(usr, Integer.parseInt(idTeo), true, simboloManager).getTeorema().getEnunciado();
        
        Term proof = CombUtilities.getTerm("A^{"+teo+"}",usr, simboloManager);
        impl[0] = proof;
        proof = proof.type();
        Term ant = ((App)proof).q.body();
        if (this.methodStr.equals("MP") && 
            !(beginFormula.containT() && proof.containT() && ant instanceof App && 
              ((App)ant).p instanceof App && ((App)((App)ant).p).p instanceof Const && 
               ((Const)((App)((App)ant).p).p).getId() == 2 ))
            throw new TypeVerificationException();
        if (!this.methodStr.equals("MP") &&
             !(beginFormula.containT()&&!proof.containT()&&
                Term.resultType(((App)proof).q.type()).equals("p")
              )
           )
            throw new TypeVerificationException();
        Term aux = ((App)beginFormula).q.body();
        Term cons;
        if (this.methodStr.equals("MP"))
           cons = ((App)((App)ant).p).q;
        else if (this.methodStr.equals("EL"))
           cons = ((App)proof).q.body();
        else
           cons = ((App)((App)proof).p).q.body();
        String vars = proof.stFreeVars(simboloManager);
        Equation eq = new Equation(cons,aux);
        s = eq.mgu(false);
        if (s == null && !(cons.traducBD().equals(aux.traducBD())))
            throw new TypeVerificationException();
        if (!vars.equals("")) {
            String[] varArr = vars.split(",");
            for (int i=0; i<varArr.length; i++) {
               if (varArr[i].length() > 1) {
                  int j=0;
                  while (j<s.getVars().size()) {
                   if ( (((char)s.getVars().get(j).indice)+"").equals(varArr[i].substring(0, 1)))
                        break;
                   j++;
                  }
                  if (j != s.getTerms().size() && aux instanceof App && ((App)aux).p instanceof App &&
                      ((App)((App)aux).p).p instanceof App && 
                      ((App)((App)((App)aux).p).p) instanceof App &&
                      ((Const)((App)((App)((App)aux).p).p).p).getId()==62 &&
                      cons instanceof App && ((App)cons).p instanceof App && 
                      ((App)((App)cons).p).p instanceof App && 
                      ((App)((App)((App)cons).p).p) instanceof App &&
                      ((Const)((App)((App)((App)cons).p).p).p).getId()==62) {
                     s.getTerms().add(j,new Bracket(((Bracket)((App)aux).q).x,s.getTerms().get(j)));
                     s.getTerms().remove(j+1);
                    }
                    else if (cons.toString().equals("x_{80} x_{101}")){
                      Var var = new Var(aux.stFreeVars().split(",")[0].charAt(0));
                      s.getTerms().add(j,new Bracket(var,s.getTerms().get(j)));
                      s.getTerms().remove(j+1);
                      s.getVars().add(new Var(101));
                      s.getTerms().add(var);
                    }
               }
            }
        }
        
        return s;
    }

    /**
     * Indicates the header that a proof that starts with contradiction
     * method must have.
     *  
     * @param statement: New statement that needs to be proved according to this method
     * @return The header message to be added to the proof
     */
    @Override
    public String header(String statement, Term beginFormula, String usr){
        try {
        String idTeo = statement.split(":")[0];
        statement = statement.substring(idTeo.length()+1);
        Term[] impl = new Term[1];
        Sust s = unificationSust(beginFormula, idTeo, usr, impl);
        idTeo = resuelveManager.getResuelveByUserAndTeorema(usr, Integer.parseInt(idTeo), true, simboloManager).getNumeroteorema();
        String vars = "";
        String exprs = "";
        String aux = "";
        if (s != null)
           for (int i=0; i<s.getVars().size(); i++) {
             if (s.getTerms().get(i) instanceof Bracket) {
                Term t = ((Bracket)s.getTerms().get(i)).t;
                aux = "("+((char)((Bracket)s.getTerms().get(i)).x.indice);
                while (t instanceof Bracket) {
                    t = ((Bracket)s.getTerms().get(i)).t;
                    aux = aux+","+((char)((Bracket)t).x.indice);
                }
                aux = aux + ")";
             }
             vars = vars + (vars.length()==0?"":",") + s.getVars().get(i).toStringLaTeX(simboloManager, "", null)+aux;
             exprs = exprs + (exprs.length()==0?"":",") + s.getTerms().get(i).toStringLaTeX(simboloManager, "", null);
             aux = "";
           }
        //String funcVar = ((char)((Bracket)((App)((App)beginFormula).q.body()).q).x.indice)+"";
        //String exp = ((App)((App)beginFormula).q.body()).q.toStringLaTeX(simboloManager, "", null);
        return "By "+(this.methodStr.equals("MP")?"Modus Ponens":"Equanimity")+" using the statement "+idTeo+(s==null?"":" with \\( "+vars+":"+(s.getVars().size()==1?"\\equiv ":"= ")+exprs+" \\)")+", the following must be proved:<br>"+statement+"Sub Proof:<br>";
        } catch (TypeVerificationException e){e.printStackTrace();return null;}
    }

    /**
     * Auxiliar method for "finishedLinearRecursiveMethodProof" that implements the corresponding
     * logic according to the contradiction method.
     * 
     * @param formulaBeingProved: Formula that the user is trying to prove in this proof/sub-proof 
     *        formulaBeingProved is not the result of initFormula or the current statement to proof
     *        in this sub-proof. Instead formulaBeingProved is the argument formula of initFormula 
     *        to produce de current statement to proof in this sub-proof
     * @param vars: List of variables for doing parallel substitution
     * @param terms: List of terms for doing parallel substitution
     * @return axiom tree that will later be used to build the complete proof
     */
    @Override
    protected Term auxFinLinearRecursiveMethodProof(String user, Term formulaBeingProved, List<Var> vars, List<Term> terms) 
            throws TypeVerificationException
    {
        /*Term proof = CombUtilities.getTerm("A^{= (\\Phi_{K} T) (\\Phi_{(bbb,(bb(cb,),c))} c_{2} (c_{62} c_{5} (\\Phi_{K} c_{8})) \\Phi_{b} c_{5} (c_{62} c_{5} (\\Phi_{K} c_{8})) c_{96} (\\Phi_{(bbb,b)} c_{2}) c_{97})}",user, simboloManager);
        Term aux = ((App)formulaBeingProved).q.body();
        Term ant = ((App)proof.type()).q.body();
        Term cons = ((App)((App)ant).p).q;
        Equation eq = new Equation(cons,aux);
        Sust s = eq.mgu(false);
        s.getTerms().add(0,new Bracket(((Bracket)((App)aux).q).x,s.getTerms().get(0)));
        s.getTerms().remove(1);*/
        String idTeo = user.split(":")[0];
        user = user.substring(idTeo.length()+1);
        Term[] impl = new Term[1];
        Sust s = unificationSust(formulaBeingProved, idTeo, user, impl);
        
        return new TypedApp(new TypedI(s),impl[0]);//proof);
    }
    
    /**
     * This function returns the closing comment of the proof i.e. the conclusion of the proof
     * 
     * @param proof: The current proof
     * @return String with the closing comment of the proof
     */
    @Override
    public String closingComment(Term proof, Term beginFormula, String usr) {
        String idTeo = usr.split(":")[0];
        usr = usr.substring(idTeo.length()+1);
        idTeo = resuelveManager.getResuelveByUserAndTeorema(usr, Integer.parseInt(idTeo), true, simboloManager).getNumeroteorema();
        return "By "+(this.methodStr.equals("MP")?"Modus Ponens":"Equanimity")+" using the statement "+idTeo+" $\\therefore~"+proof.type().toStringLaTeX(simboloManager, "",null)+"$";
    }
    
    /**
     * This function delete the last part of the proof depends of the method
     * 
     * @param proof: The current proof
     * @return proof without the last part of the proof that finish the proof
     */
    public Term deleteFinishProof(Term proof) {
        return ((App)proof).q;
    }
}
