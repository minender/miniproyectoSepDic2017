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
    
    public TypedM(int opId,String nTeo, String user) throws TypeVerificationException {
        super(nTeo, user);
        Term type = super.type_;
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
    
    /*
     * @param type The empty string can be passed when we are not referring to an axiom
    The Metatheorem 4 is:
                                                                     t1==t2 = t      
                                                                     -----------
                                         (p==q)==r = p==(q==r)       t1==t2 = true                  true==q = q
                                        -----------------------I     ---------------L              --------------- I
p==q=q==p   true==q=q   true = q==q     (t1==t2)==t2 = t1==(t2==t2)  (t1==t2)==t2 = true==t2        true==t2 = t2
--------I   --------I   -----------I      ---------------------------S  --------------------------------------------
t1==t=t==t1 true==t1=t1 true = t2==t2     t1==(t2==t2) = (t1==t2)==t2                     (t1==t2)==t2 = t2
---------------------   -------------L    -----------------------------------------------------------------
       t1==true=t1      t1==true = t1==(t2==t2)               t1==(t2==t2) = t2
       ----------S     -------------------------------------------------------
       t1=t1==true                 t1==true = t2
	   -----------------------------------------
	                  t1=t2
     */
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
        else if (id == 3) {
            String template = "(S A^{= T c_{8}})";
            proof_ = CombUtilities.getTerm(template, user);
            proof_ = new TypedApp(proof ,proof_);
        }
        else if (id == 4) {
            Term proofType = proof.type();
            String t1 = ((App)((App)proofType).q.body()).q.toString();
            String t2 = ((App)((App)((App)proofType).q.body()).p).q.toString();
            String template1="L^{\\lambda x_{122}. c_{1} ("+t2+") x_{122}} (M_{3} ("+proof+")) (I^{[x_{113}:="+t2+"]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})";
            String template2="S (I^{[x_{112},x_{113},x_{114}:="+t1+","+t2+","+t2+"]} A^{= (\\Phi_{bcb} (\\Phi_{cb} c_{1}) c_{1} \\Phi_{cbcb}) (\\Phi_{cb} c_{1} (\\Phi_{cbcb} c_{1} \\Phi_{cb}))})";
            String template3="L^{\\lambda x_{122}. c_{1} x_{122} ("+t1+")} (I^{[x_{113}:="+t2+"]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})})";
            String template4="S ((I^{[x_{112},x_{113}:="+t1+",c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (I^{[x_{113}:="+t1+"]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})}))";
            Term T1 = CombUtilities.getTerm(template1, user);
            Term T2 = CombUtilities.getTerm(template2, user);
            Term T3 = CombUtilities.getTerm(template3, user);
            Term T4 = CombUtilities.getTerm(template4, user);
            proof_ = new TypedApp(T4,new TypedApp(T3,new TypedApp(T2,T1)));
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
    
    public int getNumber() {
        return id_;
    }
    
    public Term getProof() {
        return proof_;
    }
    
    /*public String getCombDBType() {
        return type().traducBD().toString();
    }*/
    
    @Override
    public String toStringAll() {
        if (proof_ instanceof TypedA)
            return proof_.toString();
        else if (id_ == 1 || id_ == 2)
          return "(M_{"+id_+"}^{"+((Const)((App)((App)((App)((TypedA)((App)((App)proof_).q).q).type()).q.body()).p).p).id+"} A^{"+super.getCombDBType()+"})";
        else if (id_ == 3)
          return "(M_{"+id_+"} ("+((App)proof_).p+"))";
        else if (id_ == 4)
          return "(M_{"+id_+"} ("+((App)((TypedM)((App)((App)((App)((App)((App)proof_).q).q).q).p).q).getProof()).p+"))";
        else 
          return "(M_{"+id_+"} ("+proof_+"))";
    }
}
