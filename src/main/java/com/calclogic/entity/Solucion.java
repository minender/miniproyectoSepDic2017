package com.calclogic.entity;
// Generated Mar 20, 2017 12:50:11 PM by Hibernate Tools 3.2.1.GA

import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Const;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.lambdacalculo.TypedApp;
import com.calclogic.lambdacalculo.TypeVerificationException;
import com.calclogic.lambdacalculo.TypedA;
import com.calclogic.lambdacalculo.TypedM;
import com.calclogic.lambdacalculo.TypedTerm;
import com.calclogic.proof.CrudOperations;
import com.calclogic.proof.ProofBoolean;
import com.calclogic.parse.CombUtilities;
import com.calclogic.proof.GenericProofMethod;
import com.calclogic.service.SimboloManager;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Stack;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import org.apache.commons.lang3.text.StrSubstitutor;

/**
 * Solucion generated by hbm2java
 *
 * This table has the solutions (or attempted solutions)
 * to the demonstrations of theorems.
 */
public class Solucion implements java.io.Serializable {

    @Id
    @Column(name = "id")
    @GeneratedValue( strategy = GenerationType.SEQUENCE, generator = "solucion_id_seq")
    @SequenceGenerator(name = "solucion_id_seq", sequenceName = "solucion_id_seq")
    private int id;

    private Term typedTerm;
    private Resuelve resuelve;
    private boolean resuelto;
    private String demostracion;
    private String method;
    private CrudOperations proofCrudOperations;


    public Solucion() {
    }

    public void setResuelto(boolean resuelto) {
        this.resuelto = resuelto;
    }

    public boolean isResuelto() {
        return resuelto;
    }
    
    public void setTypedTerm(Term typedTerm)
    {
        this.typedTerm = typedTerm;
        this.demostracion = (typedTerm!=null?typedTerm.toString():"");
    }
    
    public void setTypedTermNotStrProof(Term typedTerm)
    {
        this.typedTerm = typedTerm;
    }
    
    public Term getTypedTerm()
    {
        return typedTerm;
    }
    
    public String getDemostracion() {
    	return demostracion;
    }
   
    public String getMetodo() {
        return method;
    }
    
    public String getMethod() {
        String[] arr = method.split(":");
        if (arr.length == 2)
            return arr[0];
        else
	    return method;
    }
    
    public String getCaseAnalysis() {
        String[] arr = method.split(":");
        if (arr.length == 2)
            return arr[1];
        else
	    return "";
    }
    
    public void eraseCaseAnalysis() {
        String[] arr = method.split(":");
        if (arr.length == 2)
            this.method = arr[0];
    }

    public void setMetodo(String metodo) {
        String[] arr;
        if (method != null ){
           arr = method.split(":");
           if (arr.length == 2)
	      this.method = metodo+":"+arr[1];
           else
              this.method = metodo;
        } else
           this.method = metodo;
    }
    
    public Solucion(Term typeTerm) {
        this.typedTerm = typeTerm;
    }
    
    public Solucion(Resuelve resuelve, boolean resuelto, Term typeTerm, String metodo,
                    CrudOperations proofCrudOperations) {
        this.resuelve = resuelve;
        this.resuelto = resuelto;
        this.typedTerm = typeTerm;
        this.demostracion = (typeTerm != null?typeTerm.toString():"");
        this.method = metodo;
        this.proofCrudOperations = proofCrudOperations;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setResuelve(Resuelve resuelve) {
        this.resuelve = resuelve;
    }
    
    public void setDemostracion(String demostracion) {
    	this.demostracion = demostracion;
    }
    
    public void setProofCrudOperations(CrudOperations proofCrudOperations) {
        this.proofCrudOperations = proofCrudOperations;
    }

    public int getId() {
        return id;
    }

    public Resuelve getResuelve() {
        return resuelve;
    }
    
    public boolean getResuelto() {
        return resuelto;
    }
    
    private Term branchedOneLineSubProof(Term formula,Term father, String user) {
        Map<String,String> values1 = new HashMap<>();
        values1.put("ST1",new App(new App(new Const(1,"c_{1}"),formula),formula).toString());
        values1.put("ST2", formula.toString());
        StrSubstitutor sub1 = new StrSubstitutor(values1, "%(",")");
        //String metaTheoT= "S (I^{[x_{113} := %(ST1)]} A^{c_{1} x_{113} (c_{1} x_{113} c_{8})}) (L^{\\lambda x_{122}.%(ST2)} A^{c_{1} x_{113} x_{113}})";
        String metaTheoT= "I^{[x_{113}:= %(ST2)]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})} (L^{\\lambda x_{122}. c_{1} x_{122} (%(ST2))} (L^{\\lambda x_{122}.%(ST2)} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})}))";
        String metaTheo = sub1.replace(metaTheoT);

        try {
          Term newProof = new TypedApp(((App)((App)((App)father).p).q).p, CombUtilities.getTerm(metaTheo,user,TypedA.sm_));
          newProof = new TypedApp(new TypedApp(((App)((App)father).p).p, newProof),((App)father).q);
          return newProof;
        }
        catch (TypeVerificationException e) {
            Logger.getLogger(Solucion.class.getName()).log(Level.SEVERE, null, e);
            return father;
        }
    }
    
    private Term mergeSubProofs(Term subProof, List<Term> fathers, String user) {
        if (fathers.size()==1)
            return subProof;
        else {
            Term auxProof;
            int i;
            if (subProof==null || !(subProof instanceof TypedTerm) ) {//subProof.type()==null) {
                i=2;
                auxProof =(subProof==null?((TypedApp)fathers.get(1)).q:branchedOneLineSubProof(subProof,fathers.get(1),user));
            }
            else {
                i=1;
                auxProof = subProof;
            }
            while (i < fathers.size()) {
                GenericProofMethod ai = proofCrudOperations.returnProofMethodObject("AI");
                auxProof = ai.finishedMethodProof(fathers.get(i), auxProof, user, null, null);
                i++;
            }
            return auxProof;
        }
    }
    
    public boolean thereIsAxiom(String axiom) {
        List<String> l = new ArrayList<>();
        typedTerm.getAxioms(l);
        
        return false;
    }
    
    public void deleteFinishStack(Term methodTerm, Term statement, Term caseAn) {
        Term[] T = proofCrudOperations.getCurrentMethodStack(typedTerm, methodTerm, statement, caseAn);
        if ( T != null && T[0] instanceof TypedTerm/*T[0].type()!=null*/ 
                && T[0].type().traducBD().equals(T[2].traducBD()) 
           ) 
        {
           Term aux = T[1];
           GenericProofMethod objectMethod;
           while (aux instanceof App) {
              objectMethod = proofCrudOperations.returnProofMethodObject(((App)aux).p.toString());
              typedTerm = objectMethod.deleteFinishProof(typedTerm);
              aux = ((App)aux).q;
           }
           objectMethod = proofCrudOperations.returnProofMethodObject(aux.toString());
           typedTerm = objectMethod.deleteFinishProof(typedTerm);
           demostracion =(typedTerm==null?"":typedTerm.toString());
        }
    }

    public int retrocederPaso(String user, Term methodTerm, GenericProofMethod objectMethod, 
                              SimboloManager s){
        String currentGroupMethod = objectMethod.getGroupMethod();
        List<Term> li = new ArrayList<>();
        li = proofCrudOperations.getFatherAndSubProof(typedTerm,methodTerm,li);
        Term auxTypedTerm = li.get(0);
        /*if( auxTypedTerm instanceof TypedM && ((TypedM)auxTypedTerm).getNumber() == 1)
                auxTypedTerm = ((TypedM)auxTypedTerm).getSubProof();
        if( objectMethod.getMethodStr().equals("SL") && auxTypedTerm instanceof TypedApp &&
            ((TypedApp)auxTypedTerm).inferType == 's' 
          )
            auxTypedTerm = ((App)auxTypedTerm).q;*/
        if (ProofBoolean.isOneLineProof(auxTypedTerm)){
            typedTerm= mergeSubProofs(null, li, user);
            demostracion =(typedTerm==null?"":typedTerm.toString());
            return 0;
        }
        if ( (
              !currentGroupMethod.equals("T") &&
              auxTypedTerm instanceof App && ((App)auxTypedTerm).p.containTypedA()
             ) 
             ||
              // next line checks if it is a no one step proof 
             (
                currentGroupMethod.equals("T")
                &&
                (
                    (auxTypedTerm instanceof TypedApp && ((TypedApp)auxTypedTerm).inferType=='t') ||
                    (auxTypedTerm instanceof TypedApp && ((TypedApp)auxTypedTerm).inferType=='e' &&
                     ((TypedApp)auxTypedTerm).p instanceof TypedApp &&
                     ((TypedApp)((TypedApp)auxTypedTerm).p).inferType=='l') ||
                    (auxTypedTerm instanceof TypedApp && ((TypedApp)auxTypedTerm).inferType=='m' &&
                        ((TypedApp)auxTypedTerm).p instanceof TypedApp && 
                        ((TypedApp)((TypedApp)auxTypedTerm).p).inferType=='m' && 
                        ((TypedApp)((TypedApp)auxTypedTerm).p).p instanceof TypedApp &&
                        ((TypedApp)((TypedApp)((TypedApp)auxTypedTerm).p).p).inferType=='i'
                    )
                )
             )
           )
        {
            if (currentGroupMethod.equals("T")&& 
                !(auxTypedTerm instanceof TypedApp && 
                   (((TypedApp)auxTypedTerm).inferType=='t' || ((TypedApp)auxTypedTerm).inferType=='e')
                 )    
               ) 
            {
                String axiom = "= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(ccb,)} c_{2} (\\Phi_{(bbb,cb)} c_{2}) (\\Phi_{c(cbbb,)} c_{1}))";
                if (((TypedA)((TypedApp)((TypedApp)((TypedApp)auxTypedTerm).p).p).q).getCombDBType().equals(axiom))
                   typedTerm = mergeSubProofs(((TypedM)((TypedApp)((TypedApp)auxTypedTerm).p).q).getSubProof(), li, user);
                else
                   typedTerm = mergeSubProofs(((App)((App)auxTypedTerm).p).q, li, user);
                // me parece que este if no va, ya que es imposible aqui que inferType=='e'
                if (auxTypedTerm instanceof TypedApp && ((TypedApp)auxTypedTerm).inferType=='e' &&
                        ((TypedApp)auxTypedTerm).p instanceof TypedApp && 
                        ((TypedApp)((TypedApp)auxTypedTerm).p).inferType=='s'     
                   )
                {
                    typedTerm = mergeSubProofs(((TypedApp)auxTypedTerm).q, li, user);
                }
            }
            else {
                if (auxTypedTerm instanceof TypedApp && ((TypedApp)auxTypedTerm).inferType=='e'
                    && ((TypedApp)auxTypedTerm).p instanceof TypedApp &&
                        ((TypedApp)((TypedApp)auxTypedTerm).p).inferType=='l'
                   )
                   typedTerm = mergeSubProofs(((App)auxTypedTerm).q, li, user);
                else
                   typedTerm = mergeSubProofs(((App)auxTypedTerm).p, li, user);
                /*if (auxTypedTerm instanceof TypedApp && ((TypedApp)auxTypedTerm).inferType=='e' &&
                        ((TypedApp)auxTypedTerm).p instanceof TypedApp && 
                        ((TypedApp)((TypedApp)auxTypedTerm).p).inferType=='s'     
                   )
                {
                    typedTerm = mergeSubProofs(((TypedApp)auxTypedTerm).q, li, user);
                }*/
            }
            demostracion = typedTerm.toString();
            return 2;
        }
        else {
            typedTerm = mergeSubProofs(((App)auxTypedTerm.type().setToPrint(s)).q, li, user);
            demostracion = typedTerm.toString();
            return 1;
        }
    }
}
