/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.lambdacalculo;

import com.calclogic.parse.CombUtilities;

/**
 *
 * @author feder
 */
public class TypedM extends TypedA implements TypedTerm {
    
    private int id_;
    private String proofTemplate_;
    private Term proof_;
    
    public TypedM(int opId,Term type, String user) throws TypeVerificationException {
        super(type, user);
        id_ = 1;
        if (((App)((App)type).p).q.containT()){
            proof_ = new TypedA(type,user);
            //A_ = (TypedA)proof_;
        }
        else{
            //A_ = new TypedA(type, variables_, nSt_, combDBType_);
            Term lambType = super.type(); //A_.type();
            String arg2 = ((App)((App)lambType).p).q.body().toString();
            Term aux = CombUtilities.getTerm("L^{\\lambda x_{122}. c_{"+opId+"} ("+arg2+") x_{122}}",user);
            aux = new TypedApp(aux,new TypedA(type, variables_, nSt_, combDBType_));
            proof_ = CombUtilities.getTerm("I^{[x_{112}:="+arg2+"]} A^{= (\\Phi_{K} T) (\\Phi_{(b,)} c_{"+opId+"})}", user);
            proof_ = new TypedApp(aux,proof_);          
        }
    }
    
    public TypedM(int id, int opId, Term proof, String type, String user) throws TypeVerificationException {
        super(proof.type(),type, user);
        id_ = id;
        if (id == 1 || id == 2) {
            // A_ = ((TypedA)proof);
            Term lambType = super.type();
            String arg2 = ((App)((App)lambType).p).q.body().toString();
            Term aux = CombUtilities.getTerm("L^{\\lambda x_{122}. c_{"+opId+"} ("+arg2+") x_{122}}",user);
            aux = new TypedApp(aux,proof);
            if (id == 1)
               proof_ = CombUtilities.getTerm("I^{[x_{112}:="+arg2+"]} A^{= (\\Phi_{K} T) (\\Phi_{(b,)} c_{"+opId+"})}", user);
            else
               proof_ = CombUtilities.getTerm("I^{[x_{112}:="+arg2+"]} (A^{= (\\Phi_{K} c_{8}) (\\Phi_{(b,)} c_{"+opId+"})} A^{= T c_{8}})", user);
            proof_ = new TypedApp(aux,proof_);
        }
        else
            proof_ = proof;
    }
    /*public TypedM(String proofTemplate, String usr, String arg1, String arg2) {
        super("M");
        proofTemplate_ = proofTemplate;
        Map<String,String> values = new HashMap<>();
        values.put("arg1",arg1);
        values.put("arg2",arg2);
        StrSubstitutor sub = new StrSubstitutor(values, "%(",")");
        String stProof = sub.replace(proofTemplate_);
        proof_ = (TypedTerm)CombUtilities.getTerm(stProof, usr);
        A = (TypedA)((TypedApp)((TypedApp)proof_).p).q;
    }*/
    
    @Override
    public Term type() {
        return proof_.type();
    }
    
    /*public TypedA getA() {
        return A_;
    }*/
    
    /*public String getCombDBType() {
        return type().traducBD().toString();
    }*/
    
    @Override
    public String toStringAll() {
        if (proof_ instanceof TypedA)
            return proof_.toString();
        else if (id_ == 1)
          return "(M_{"+id_+"}^{"+((Const)((App)((App)((App)((TypedA)((App)((App)proof_).q).q).type()).q.body()).p).p).id+"} A^{"+super.getCombDBType()+"})";
        else
          return "(M_{"+id_+"} A^{"+super.getCombDBType()+"})";
    }
}
