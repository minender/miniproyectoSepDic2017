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
    
    public TypedM(int opId, String nTeo, String user) throws TypeVerificationException {
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
            String arg2 = ((App)lambType).q.body().toString();
            Term aux = CombUtilities.getTerm("L^{\\lambda x_{122}. c_{"+opId+"} x_{122} ("+arg2+")}",user,sm_);
            aux = new TypedApp(aux,new TypedA(type, variables_, nSt_, combDBType_));
            proof_ = CombUtilities.getTerm("I^{[x_{113}:="+arg2+"]} A^{= (\\Phi_{K} T) (\\Phi_{(b,)} c_{"+opId+"})}", user,sm_);
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
            String arg2 = ((App)lambType).q.body().toString();
            Term aux = CombUtilities.getTerm("L^{\\lambda x_{122}. c_{"+opId+"} x_{122} ("+arg2+")}",user,sm_);
            aux = new TypedApp(aux,new TypedA(type, variables_, nSt_, combDBType_));
            proof_ = CombUtilities.getTerm("I^{[x_{113}:="+arg2+"]} A^{= (\\Phi_{K} T) (\\Phi_{(b,)} c_{"+opId+"})}", user,sm_);
            proof_ = new TypedApp(aux,proof_);          
        }
    }
    
    /*
     *(E^{lambda z.z/\E.Q1}(I^{p:=H}A^{3.39}))
     * (L^{lambda z.(H/\z)/\E.Q1}(I^{?}(M_{3}^{1} A^{?})))
     *  (E^{lambda z.(H/\z)/\E.Q1}(I^{p,q:=H,Q1==Q2}A^{3.66}))
     *   (I^{p,q,r:=H,Q1==Q2,E.Q1}A^{3.37})
     *    (E^{lambda z.H/\z}(I^{e,f:=Q1,Q2}A^{3.84.a}))
     *     (I^{p,q,r:=H,Q1==Q2,E.Q2}A^{3.37})
     *      (E^{lambda z.(H/\z)/\E.Q2}(I^{p,q:=H,Q1==Q2}A^{3.66}))
     *       (E^{lambda z.(H/\z)/\E.Q2}(I^{?}(M_{3} A^{?})))
     *        (E^{lambda z.z/\E.Q2}(I^{p:=H}A^{3.39}))
     */
    
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
        super(proof.type(), type, user);
        if (!(proof instanceof TypedA) || proof instanceof TypedM) 
            variables_ = ";"+proof.type().freeVarsFromAbstractedEq();
        id_ = id;
        if (id == 1 || id == 2) {
            // A_ = ((TypedA)proof);
            Term lambType = super.type();
            String arg2 = ((App)lambType).q.body().toString();
            Term aux = CombUtilities.getTerm("L^{\\lambda x_{122}. c_{"+opId+"} x_{122} ("+arg2+")}",user,sm_);
            aux = new TypedApp(aux,proof);
            if (id == 1)
               proof_ = CombUtilities.getTerm("I^{[x_{113}:="+arg2+"]} A^{= (\\Phi_{K} T) (\\Phi_{(b,)} c_{"+opId+"})}", user,sm_);
            else
               proof_ = CombUtilities.getTerm("I^{[x_{113}:="+arg2+"]} (A^{= (\\Phi_{K} c_{8}) (\\Phi_{(b,)} c_{"+opId+"})} A^{= T c_{8}})", user,sm_);
            proof_ = new TypedApp(aux,proof_);
        }
        else if (id == 3) {
            String template = "(S A^{= T c_{8}})";
            proof_ = CombUtilities.getTerm(template, user, sm_);
            //if (proof.containT()) 
            proof_ = new TypedApp(proof ,proof_);
            /*else{
                proof = new TypedM(1,1,proof,type,user);
            }*/
        }
        else if (id == 4) {
            Term proofType = proof.type();
            String t1 = ((App)((App)proofType).q.body()).q.toString();
            String t2 = ((App)((App)((App)proofType).q.body()).p).q.toString();
            String template1="L^{\\lambda x_{122}. c_{1} ("+t2+") x_{122}} (M_{3} ("+proof+")) (I^{[x_{113}:="+t2+"]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})})";
            String template2="S (I^{[x_{114},x_{113},x_{112}:="+t2+","+t2+","+t1+"]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{1}) c_{1}) (\\Phi_{cbbb} c_{1} \\Phi_{bb} \\Phi_{bb} c_{1})})";
            String template3="L^{\\lambda x_{122}. c_{1} x_{122} ("+t1+")} (I^{[x_{113}:="+t2+"]} A^{= (\\Phi_{(b,)} c_{1}) (\\Phi_{K} c_{8})})";
            String template4="S ((I^{[x_{112},x_{113}:="+t1+",c_{8}]} A^{= (\\Phi_{bb} \\Phi_{b} c_{1}) (\\Phi_{cb} c_{1} \\Phi_{cb})}) (I^{[x_{113}:="+t1+"]} A^{= \\Phi_{} (\\Phi_{cb} c_{8} c_{1})}))";
            Term T1 = CombUtilities.getTerm(template1, user,sm_);
            Term T2 = CombUtilities.getTerm(template2, user,sm_);
            Term T3 = CombUtilities.getTerm(template3, user,sm_);
            Term T4 = CombUtilities.getTerm(template4, user,sm_);
            proof_ = new TypedApp(T4,new TypedApp(T3,new TypedApp(T2,T1)));
        }
        else if (id == 5) { // igual que id=1 pero para identificar que el 2 branch del AI no ha terminado y la prueba hasta ahora tiene raiz [p=q]
            Term lambType = super.type();
            String arg2 = ((App)lambType).q.body().toString();
            Term aux = CombUtilities.getTerm("L^{\\lambda x_{122}. c_{"+opId+"} x_{122} ("+arg2+")}",user,sm_);
            aux = new TypedApp(aux,proof);
            proof_ = CombUtilities.getTerm("I^{[x_{113}:="+arg2+"]} A^{= (\\Phi_{K} T) (\\Phi_{(b,)} c_{"+opId+"})}", user,sm_);
            proof_ = new TypedApp(aux,proof_);
            
            String template = "(S A^{= T c_{8}})";
            //if (proof.containT()) 
            proof_ = new TypedApp(proof_, CombUtilities.getTerm(template, user,sm_));
        }
        else if (id == 6) {
            //opId = ((Const)((App)((App)((App)proof.type()).q.body()).p).q).getId();
            Term p = ((App)((App)((App)proof.type()).q.body()).q).q;
            Term q = ((App)((App)((App)((App)proof.type()).q.body()).q).p).q;
            Term r = ((App)((App)((App)proof.type()).q.body()).p).q;
            proof_ = CombUtilities.getTerm("I^{[x_{114}, x_{113}, x_{112} := "+r+", "+q+", "+p+"]} A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{2}) c_{2}) (\\Phi_{cbbb} c_{5} \\Phi_{bb} \\Phi_{bb} c_{2})}",user,sm_);
            proof_ = new TypedApp(proof_,proof);
        }   
        else if (id == 7) {
            String opId2 = "";
            String isSymetr = "";
            if (opId == 2) {
                opId2 = "c_{3}";
                isSymetr = "sc_{3}";
            } else if (opId == 3) {
                opId2 = "c_{2}";
                isSymetr = "yc_{3}";
            } else {
                isSymetr = sm_.isSymetric(opId);
                if (isSymetr.charAt(0)=='y' || isSymetr.charAt(0)=='s')
                   opId2 = isSymetr.substring(1);
                else if (isSymetr.charAt(0)=='n')
                   throw new TypeVerificationException();
            }
            Term p = ((App)((App)((App)proof.type()).q.body()).p).q;
            Term q = ((App)((App)proof.type()).q.body()).q;
            proof_ = CombUtilities.getTerm("A^{= (\\Phi_{bb} \\Phi_{b} "+(/*isSymetr.equals("")||*/isSymetr.charAt(0)=='s'?"c_{"+opId+"}":opId2)+") (\\Phi_{cb} "+(/*isSymetr.equals("")||*/isSymetr.charAt(0)=='s'?opId2:"c_{"+opId+"}")+" \\Phi_{cb})}",user,sm_);
            String[] vars = ((TypedA)proof_).getVariables().split(";")[1].split(",");
            String x112 = "x_{"+((int)vars[0].charAt(0))+"}";
            String x113 = "x_{"+((int)vars[1].charAt(0))+"}";
            proof_ = CombUtilities.getTerm("I^{["+x112+", "+x113+" := "+(isSymetr.equals("")||isSymetr.charAt(0)=='s'?p+", "+q:q+", "+p)+"]} A^{= (\\Phi_{bb} \\Phi_{b} "+(isSymetr.equals("")||isSymetr.charAt(0)=='s'?"c_{"+opId+"}":opId2)+") (\\Phi_{cb} "+(isSymetr.equals("")||isSymetr.charAt(0)=='s'?opId2:"c_{"+opId+"}")+" \\Phi_{cb})}",user,sm_);
            if (opId == 2 || (!isSymetr.equals("") && isSymetr.charAt(0)=='s'))
               proof_ = new TypedApp(new TypedApp(new TypedS(),proof_),proof);
            else if (opId == 3 || (!isSymetr.equals("") && isSymetr.charAt(0)=='y'))
               proof_ = new TypedApp(proof_,proof);
        }
        else if (id == 8) {
            String axiomSt = "A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{2} \\Phi_{b(bb,cb)} c_{5} (\\Phi_{c(ccbbb,)} c_{"+opId+"}) c_{"+opId+"} c_{"+opId+"})}";
            Term transtAx = CombUtilities.getTerm(axiomSt,user,sm_);
            Term tree;
            Term S = null;
            int opId2 = ((Const)((App)((App)((App)proof.type()).q.body()).p).p).getId(); 
            if (proof instanceof TypedApp) {
                S = ((TypedApp)proof).p;
                proof = ((TypedApp)proof).q;
            }
            String[] vars = ((TypedA)proof).getVariables().split(";")[1].split(",");
            String p = "x_{"+((int)vars[0].charAt(0))+"}";
            String q = "x_{"+((int)vars[1].charAt(0))+"}";
            vars = ((TypedA)transtAx).getVariables().split(";")[1].split(",");
            String R = "x_{"+((int)vars[0].charAt(0))+"}";
            String P = "x_{"+((int)vars[1].charAt(0))+"}";
            String Q = "x_{"+((int)vars[2].charAt(0))+"}";
            proof_ = CombUtilities.getTerm("L^{\\lambda x_{-122}.c_{2} (c_{"+opId2+"} "+R+" "+P+") (c_{5} (c_{"+opId2+"} "+R+" "+Q+") x_{-122})}",user,sm_);
            if (S != null)
               proof_ = new TypedApp(proof_,new TypedApp(CombUtilities.getTerm("I^{["+p+","+q+":="+Q+","+P+"]}",user,sm_),proof));
            else
               proof_ = new TypedApp(proof_,new TypedApp(CombUtilities.getTerm("I^{["+p+","+q+":="+P+","+Q+"]}",user,sm_),proof));
            if (S != null)
                proof_ = new TypedApp(S,proof_);
            tree = new TypedApp(CombUtilities.getTerm("I^{["+p+","+q+" := "+(S==null?Q+","+R:R+","+Q)+"]}",user,sm_),proof);
            tree = new TypedApp(CombUtilities.getTerm("L^{\\lambda x_{-122}.c_{2} (c_{"+opId2+"} "+R+" "+P+") (c_{5} x_{-122} (c_{"+opId+"} "+P+" "+Q+"))}",user,sm_),tree);
            if (S != null)
                tree = new TypedApp(S,tree);
            proof_ = new TypedApp(proof_,tree);
            tree = new TypedApp(CombUtilities.getTerm("I^{["+(S==null?p+","+q+" := "+P+","+R:p+","+q+" := "+R+","+P)+"]}",user,sm_),proof);
            tree = new TypedApp(CombUtilities.getTerm("L^{\\lambda x_{-122}.c_{2} x_{-122} (c_{5} (c_{"+opId+"} "+Q+" "+R+") (c_{"+opId+"} "+P+" "+Q+"))}", user, sm_),tree);
            if (S != null)
                tree = new TypedApp(S,tree);
            proof_ = new TypedApp(proof_,tree);
            tree = CombUtilities.getTerm("A^{= (\\Phi_{bb} \\Phi_{b} c_{5}) (\\Phi_{cb} c_{5} \\Phi_{cb})}",user,sm_);
            tree = new TypedApp(CombUtilities.getTerm("I^{[x_{112},x_{113} := (c_{"+opId+"} "+P+" "+Q+"),(c_{"+opId+"} "+Q+" "+R+")]}",user,sm_),tree);
            tree = new TypedApp(CombUtilities.getTerm("L^{\\lambda x_{-122}.c_{2} (c_{"+opId+"} "+P+" "+R+") x_{-122}}",user,sm_),tree);
            proof_ = new TypedApp(proof_,tree);
            proof_ = new TypedApp(new TypedS(),proof_);
            String sol = "I^{["+R+","+P+" := "+P+","+R+"]}";
            //sol += "A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{2} \\Phi_{b(bb,cb)} c_{5} (\\Phi_{c(ccbbb,)} c_{"+opId+"}) c_{"+opId+"} c_{"+opId+"})})";
            proof_ = new TypedApp(proof_,new TypedApp(CombUtilities.getTerm(sol,user,sm_),transtAx));
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
    
    public Term getSubProof() {
        if (id_ == 1) 
            return ((App)((App)proof_).p).q;
        else if (id_ == 2)
            return ((App)((App)proof_).p).q;
        else if (id_ == 3)
            return ((App)proof_).p;
        else if (id_ == 4)
            return ((App)((TypedM)((App)((App)((App)((App)((App)proof_).q).q).q).p).q).getProof()).p;
        else if (id_ == 5)
            return ((App)((App)((App)proof_).p).p).q;
        else if (id_ == 6)
            return ((App)proof_).q;
        else if (id_ == 7)
            return ((App)proof_).q;
        else if (id_ == 8)
            return ((App)((App)((App)((App)((App)((App)proof_).p).q).p).q).q).q;
        else
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
          return "(M_{"+id_+"}^{"+((Const)((App)((App)((App)((TypedA)((App)((App)proof_).q).q).type()).q.body()).p).p).id+"} ("+((App)((App)proof_).p).q+"))";
        else if (id_ == 3)
          return "(M_{"+id_+"} ("+((App)proof_).p+"))";
        else if (id_ == 4)
          return "(M_{"+id_+"} ("+((App)((TypedM)((App)((App)((App)((App)((App)proof_).q).q).q).p).q).getProof()).p+"))";
        else if (id_ == 5)
          return "(M_{"+id_+"}^{"+((Const)((App)((App)((App)((TypedA)((App)((App)((App)proof_).p).q).q).type()).q.body()).p).p).id+"} ("+((App)((App)((App)proof_).p).p).q+"))";
        else if (id_ == 6)
          return "(M_{"+id_+"} ("+((App)proof_).q+"))";
        else if (id_ == 7)
          return "(M_{"+id_+"}^{"+((Const)((App)((App)((App)((App)proof_).q.type()).q.body()).p).p).getId()+"} ("+((App)proof_).q+"))";
        else if (id_ == 8) {
          Term proof = ((App)((App)((App)((App)((App)((App)proof_).p).q).p).q).q).q;
          int opId;
          if (proof instanceof TypedA)
              opId = ((Const)((App)((App)((App)((App)proof.type()).p).q.body()).p).p).getId();
          else 
              opId = ((Const)((App)((App)((App)proof.type()).q.body()).p).p).getId();
          return "(M_{"+id_+"}^{"+opId+"} ("+(proof instanceof TypedA?proof:"S "+((App)proof).q)+"))";
        }else 
          return "(M_{"+id_+"} ("+proof_+"))";
    }
}
