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
    
    private String proofTemplate_;
    private Term proof_;
    private TypedA A;
    
    public TypedM(Term type, String user) throws TypeVerificationException {
        super(type, user);
        if (((App)((App)type).p).q.containT()){
            proof_ = new TypedA(type,user);
            A = (TypedA)proof_;
        }
        else{
            A = new TypedA(type, variables_, nSt_, combDBType_);
            Term lambType = A.type();
            String arg2 = ((App)((App)lambType).p).q.body().toString();
            Term aux = CombUtilities.getTerm("L^{\\lambda x_{122}. c_{1} ("+arg2+") x_{122}}",user);
            aux = new TypedApp(aux,A);
            proof_ = CombUtilities.getTerm("I^{[x_{112}:="+arg2+"]} A^{= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})}", user);
            proof_ = new TypedApp(aux,proof_);          
        }
    }
    
    public TypedM(Term proof, Term type, String user) throws TypeVerificationException {
        super(type, user);
        //A = new TypedA(type, variables_, nSt_, combDBType_);
        Term lambType = type;
        String arg2 = ((App)((App)lambType).p).q.body().toString();
        Term aux = CombUtilities.getTerm("L^{\\lambda x_{122}. c_{1} ("+arg2+") x_{122}}",user);
        aux = new TypedApp(aux,proof);
        proof_ = CombUtilities.getTerm("I^{[x_{112}:="+arg2+"]} A^{= (\\Phi_{K} T) (\\Phi_{(b,)} c_{1})}", user);
        proof_ = new TypedApp(aux,proof_);
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
    
    public TypedA getA() {
        return A;
    }
    
    public String getCombDBType() {
        return type().traducBD().toString();
    }
    
    public String toString() {
        System.out.println("    Entré al toString de TypedM");
        return "M^{"+A.getCombDBType()+"}";
    }
}
