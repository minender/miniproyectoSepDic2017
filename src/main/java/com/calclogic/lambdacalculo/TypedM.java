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
        else if (id == 9) {
            /**
             * 1) Sum1+Sum2 se itera el num de veces igual al num de digitos de Sum2 y #Sum1>#Sum2
               Si no estoy sumando el ultimo digito de Sum2 con el ultimo de Sum1 se hace esto
                2) Se descompone Sum1 con ab=10*a+b
                3) Si Sum2 no es un digito se descompone Tambien con ab=10*a+b
                4) Se hace (a+b)+c=a+(b+c)
                Si Sum2 no es un digito se hace
                 5) Si Sum2 no es un digito se conmutan dos expresiones para que los digitos queden al lado
                 6) Se hace (a+b)+c=a+(b+c)
                 7) Se hace (a+b)+c=a+(b+c)
                 8) Se suman los digitos usando las tablas de la suma y se anota si se lleva una
                 9) Sacas factor comun 10
                 10) Haces asociatividad
                En cambio, Sum2 es un digito se hace
                 5A) Se suman los digitos usando las tablas de la suma y se anota si se lleva una
               Si estoy sumando el ultimo digito de Sum2 con el ultimo de Sum1 se hace esto
                2A) Se suman los digitos usando las tablas de la suma y se anota si se lleva una
               Si llevo una proveniente del paso 8) hago:
                11) Se descompone el operando de dos digitos resultante con ab=10*a+b
                12) Se hace (a+b)+c=a+(b+c)
                13) Sacas factor comun 10
                14) Se hace (a+b)+c=a+(b+c)
                15) Aqui queda un 1 sumado con otro digito que lo sumas con la tabla de la suma
               En cambio, si llevo una proveniente del paso 5A) o 2A) hago:
                11A) Se descompone el operando de dos digitos resultante con ab=10*a+b
                12A) Se hace (a+b)+c=a+(b+c)
                13A) Sacas factor comun 10
                14A) Aqui queda un 1 sumado con otro digito que lo sumas con la tabla de la suma
            **/
            int a, b;
            boolean carryOne1 = false;
            boolean carryOne2 = false;
            Term type2 = proof.type_;
            Term a1 = ((App)type2).q;
            Term a2 = ((App)((App)type2).p).q;
            Term aux = a1;
            Term ctxt = null;
            int nDigits = 1;
            while (aux instanceof App) {
                aux = ((App)((App)aux).p).q;
                nDigits++;
            }
            Term aux2 = a2;
            int nDigits2 = 1;
            while (aux2 instanceof App) {
                aux2 = ((App)((App)aux2).p).q;
                nDigits2++;
            }
            String A1;
            String I;
            String L = "";
            Term FirstSymmetry = null;
            if (nDigits < nDigits2) {
                A1 = "A^{= (\\Phi_{bb} \\Phi_{b} c_{55}) (\\Phi_{cb} c_{55} \\Phi_{cb})}";
                I = "I^{[x_{97},x_{98}:="+a1+","+a2+"]}";
                FirstSymmetry = CombUtilities.getTerm(I+" "+A1,user,sm_);
                aux = a1;
                a1 = a2;
                a2 = aux;
                nDigits2 = nDigits;
            }
            int n = 0;
            String ctx = "";
            boolean oneDigit = a2 instanceof Const;
            String ten = "";
            String mult = "";
            
            /*A1 = "A^{= (\\Phi_{ccbb} c_{57} (c_{54} c_{43} c_{42}) \\Phi_{bcb} c_{55}) (\\Phi_{cb} c_{54} \\Phi_{cb})}";
            // Si a1 es un App se tiene lo siguiente
            Term a11 = ((App)((App)a1).p).q;
            Term a12 = ((App)a1).q;
            I = "I^{[x_{98},x_{97}:="+a12+","+a11+"]}";
            String L = "L^{\\lambda x_{122}."+ctx+" (c_{55} ("+a2+") x_{122})}";
            proof_ = CombUtilities.getTerm(L+" ("+I+" "+A1+")",user,sm_);
            if (FirstSymmetry != null)
               proof_ = new TypedApp(FirstSymmetry, proof_); 
            if (!oneDigit) {
               L = "L^{\\lambda x_{122}."+ctx+" (c_{55} x_{122} ("+((App)((App)((App)proof_.type()).p).q).q+"))}";
               Term a21 = ((App)((App)a2).p).q;
               Term a22 = ((App)a2).q;
               I = "I^{[x_{98},x_{97}:="+a22+","+a21+"]}";
               proof_ = new TypedApp(proof_,CombUtilities.getTerm(L+" ("+I+" "+A1+")",user,sm_));
            }
            A1 = "A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})}";
            Term type2 = proof_.type();
            I = "I^{[x_{99},x_{98},x_{97}:="+((App)((App)((App)((App)type2).p).q).p).q+","+((App)((App)((App)((App)((App)type2).p).q).q).p).q+","+((App)((App)((App)((App)type2).p).q).q).q+"]}";
            proof_ = new TypedApp(proof_,CombUtilities.getTerm(I+" "+A1,user,sm_));
            A1 = "A^{= (\\Phi_{bb} \\Phi_{b} c_{55}) (\\Phi_{cb} c_{55} \\Phi_{cb})}";
            L = "L^{\\lambda x_{122}."+ctx+" (c_{55} x_{122} ("+((App)((App)((App)proof_.type()).p).q).q+"))}";
            type2 = ((App)((App)((App)((App)proof_.type()).p).q).p).q;
            I = "I^{[x_{97},x_{98}:="+((App)type2).q+","+((App)((App)type2).p).q+"]}";
            proof_ = new TypedApp(proof_,CombUtilities.getTerm(L+" ("+I+" "+A1+")",user,sm_));
            A1 = "A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})}";
            type2 = ((App)((App)((App)((App)proof_.type()).p).q).p).q;
            I = "I^{[x_{99},x_{98},x_{97}:="+((App)((App)type2).p).q+","+((App)((App)((App)type2).q).p).q+","+((App)((App)type2).q).q+"]}";
            proof_ = new TypedApp(proof_,CombUtilities.getTerm(L+" ("+I+" "+A1+")",user,sm_));
            type2 = ((App)((App)proof_.type()).p).q;
            I = "I^{[x_{99},x_{98},x_{97}:="+((App)((App)((App)((App)type2).p).q).p).q+","+((App)((App)((App)type2).p).q).q+","+((App)type2).q+"]}";
            proof_ = new TypedApp(proof_,CombUtilities.getTerm("S ("+I+" "+A1+")",user,sm_));
            type2 = ((App)((App)proof_.type()).p).q;
            L = "L^{\\lambda x_{122}."+ctx+"(c_{55} x_{122} ("+((App)type2).q+"))}";
            type2 = ((App)((App)type2).p).q;
            int a = ((Const)((App)type2).q).id-42;
            int b = ((Const)((App)((App)type2).p).q).id-42;
            A1 = "A^{= ("+type2+") c_{"+(a+b+42)+"}}";
            proof_ = new TypedApp(proof_,CombUtilities.getTerm("S ("+L+" "+A1+")",user,sm_));
            type2 = ((App)((App)proof_.type()).p).q;
            L = "L^{\\lambda x_{122}."+ctx+"(c_{55} ("+((App)((App)type2).p).q+") x_{122})}";
            I = "I^{[x_{99},x_{97},x_{98}:="+((App)((App)((App)((App)((App)type2).q).p).q).p).q+",c_{54} c_{43} c_{42},"+((App)((App)((App)((App)type2).q).q).p).q+"]}";
            A1 = "A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{57} \\Phi_{bcb} c_{55}) c_{57}) (\\Phi_{ccbb} \\Phi_{cbb} c_{57} \\Phi_{ccb} c_{55})}";
            proof_ = new TypedApp(proof_,CombUtilities.getTerm("S ("+L+" ("+I+" "+A1+"))",user,sm_));*/
            String[] ctxtStack = new String[nDigits];
            mult = "c_{57}";
            ten = "(c_{54} c_{43} c_{42})";
            while (n < nDigits2) {
            ctxt = type2;
            for (int k = 0; k < n; k++) {
                ctxt = ((App)type2).p;
                type2 = ((App)((App)((App)type2).q).p).q;
            }
            ctxtStack[n] = (n == 0?"":ctxt.toString());
            //ctx = ctxtStack[n];
            if (n != nDigits-1){
            if ( n !=0 ) {
               a1 = ((App)type2).q;
               a2 = ((App)((App)type2).p).q;
            }
            oneDigit = a2 instanceof Const;
            Term a11 = ((App)((App)a1).p).q;
            Term a12 = ((App)a1).q;
            // esto es ab=10*a+b
            A1 = "A^{= (\\Phi_{ccbb} c_{57} (c_{54} c_{43} c_{42}) \\Phi_{bcb} c_{55}) (\\Phi_{cb} c_{54} \\Phi_{cb})}";
            I = "I^{[x_{98},x_{97}:="+a12+","+a11+"]}";
            for (int k = 0; k <= n; k++)
                L = (k==0?"":ctxtStack[n-k+1])+(k==0?"":" ("+mult)+" ("+(k==0?"c_{55} ("+a2+") x_{122}":L)+") "+(k==0?"":ten+")");
            L = "L^{\\lambda x_{122}."+L+"}";
            if (n ==0)
                proof_ = CombUtilities.getTerm(L+" ("+I+" "+A1+")",user,sm_);
            else
                proof_ = new TypedApp(proof_,CombUtilities.getTerm(L+" ("+I+" "+A1+")",user,sm_));
            if (!oneDigit) {
               aux = ((App)((App)proof_.type()).p).q;
               for (int k =1; k<= n; k++)
                   aux = ((App)((App)((App)aux).q).p).q;
               aux = ((App)aux).q;
               for (int k = 0; k <= n; k++)
                   L =(k==0?"":ctxtStack[n-k+1])+(k==0?"":" ("+mult)+" ("+(k==0?"c_{55} x_{122} ("+aux+")":L)+") "+(k==0?"":ten+")");
               L = "L^{\\lambda x_{122}."+L+"}";//"L^{\\lambda x_{122}."+ctx+" ("+mult+" (c_{55} x_{122} ("+((App)((App)((App)proof_.type()).p).q).q+"))"+ten+")}";
               Term a21 = ((App)((App)a2).p).q;
               Term a22 = ((App)a2).q;
               I = "I^{[x_{98},x_{97}:="+a22+","+a21+"]}";
               proof_ = new TypedApp(proof_,CombUtilities.getTerm(L+" ("+I+" "+A1+")",user,sm_));
            }
            // esto es (a+b)+c=a+(b+c)
            A1 = "A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})}";
            type2 = ((App)((App)proof_.type()).p).q;
            for (int k = 0; k <= n; k++)
                L=(k==0?"":ctxtStack[n-k+1])+(k==0?"":" ("+mult)+" ("+(k==0?"x_{122}":L)+") "+(k==0?"":ten+")");
            L = "L^{\\lambda x_{122}."+L+"}";
            for (int k = 0; k < n; k++) {
                type2 = ((App)((App)((App)type2).q).p).q;
            }
            I = "I^{[x_{99},x_{98},x_{97}:="+((App)((App)type2).p).q+","+((App)((App)((App)type2).q).p).q+","+((App)((App)type2).q).q+"]}";
            proof_ = new TypedApp(proof_,CombUtilities.getTerm(L+" ("+I+" "+A1+")",user,sm_));
            if (!oneDigit) {
              // esto es a+b=b+a
              A1 = "A^{= (\\Phi_{bb} \\Phi_{b} c_{55}) (\\Phi_{cb} c_{55} \\Phi_{cb})}";
              aux = ((App)((App)proof_.type()).p).q;
              for (int k =1; k<= n; k++)
                  aux = ((App)((App)((App)aux).q).p).q;
              for (int k = 0; k <= n; k++)
                L=(k==0?"":ctxtStack[n-k+1])+(k==0?"":" ("+mult)+" ("+(k==0?"c_{55} x_{122} ("+((App)aux).q+")":L)+") "+(k==0?"":ten+")");
              L = "L^{\\lambda x_{122}."+L+"}";
              type2 = ((App)((App)aux).p).q;
              I = "I^{[x_{97},x_{98}:="+((App)type2).q+","+((App)((App)type2).p).q+"]}";
              proof_ = new TypedApp(proof_,CombUtilities.getTerm(L+" ("+I+" "+A1+")",user,sm_));
              // esto es (a+b)+c=a+(b+c)
              A1 = "A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})}";
              aux = ((App)((App)proof_.type()).p).q;
              for (int k =1; k<= n; k++)
                  aux = ((App)((App)((App)aux).q).p).q;
              type2 = ((App)((App)aux).p).q;
              I = "I^{[x_{99},x_{98},x_{97}:="+((App)((App)type2).p).q+","+((App)((App)((App)type2).q).p).q+","+((App)((App)type2).q).q+"]}";
              proof_ = new TypedApp(proof_,CombUtilities.getTerm(L+" ("+I+" "+A1+")",user,sm_));
              aux = ((App)((App)proof_.type()).p).q;
              for (int k =1; k<= n; k++)
                  aux = ((App)((App)((App)aux).q).p).q;
              type2 = aux;
              I = "I^{[x_{99},x_{98},x_{97}:="+((App)((App)((App)((App)type2).p).q).p).q+","+((App)((App)((App)type2).p).q).q+","+((App)type2).q+"]}";
              for (int k = 0; k <= n; k++)
                L=(k==0?"":ctxtStack[n-k+1])+(k==0?"":" ("+mult)+" ("+(k==0?"x_{122}":L)+") "+(k==0?"":ten+")");
              L = "L^{\\lambda x_{122}."+L+"}";
              proof_ = new TypedApp(proof_,CombUtilities.getTerm("S ("+L+" ("+I+" "+A1+"))",user,sm_));
              aux = ((App)((App)proof_.type()).p).q;
              for (int k =1; k<= n; k++)
                  aux = ((App)((App)((App)aux).q).p).q;
              type2 = aux;
              for (int k = 0; k <= n; k++)
                L=(k==0?"":ctxtStack[n-k+1])+(k==0?"":" ("+mult)+" ("+(k==0?"c_{55} x_{122} ("+((App)type2).q+")":L)+") "+(k==0?"":ten+")");
              L = "L^{\\lambda x_{122}."+L+"}";
              type2 = ((App)((App)type2).p).q;
              a = ((Const)((App)type2).q).id-42;
              b = ((Const)((App)((App)type2).p).q).id-42;
              if (a == 0) {
                    // esto es 0+a=a
                    A1 = "A^{= \\Phi_{} (\\Phi_{cb} c_{42} c_{55})}";
                    I = "I^{[x_{97} := c_{"+(b+42)+"}]}";
                    proof_ = new TypedApp(proof_,CombUtilities.getTerm(L+" ("+I+" "+A1+")",user,sm_));
              }
              else if (b == 0) {
                    // esto es a+0=a
                    A1 = "A^{= \\Phi_{} (\\Phi_{b} (c_{55} c_{42}))}";
                    I = "I^{[x_{97} := c_{"+(a+42)+"}]}";
                    proof_ = new TypedApp(proof_,CombUtilities.getTerm(L+" ("+I+" "+A1+")",user,sm_));
              }
              else {
                    carryOne1 = a+b > 9;
                    // estas dos son ecuaciones de la tabla de la suma, solo que  
                    // el resultado de la primera es de dos digitos
                    if (carryOne1)
                       A1 = "A^{= ("+type2+") (c_{54} c_{"+(((a+b)/10)+42)+"} c_{"+(((a+b)%10)+42)+"})}";
                    else
                       A1 = "A^{= ("+type2+") c_{"+(a+b+42)+"}}";
                    proof_ = new TypedApp(proof_,CombUtilities.getTerm("S ("+L+" "+A1+")",user,sm_));
              }
              //type2 = ((App)((App)proof_.type()).p).q;
              aux = ((App)((App)proof_.type()).p).q;
              for (int k =1; k<= n; k++)
                  aux = ((App)((App)((App)aux).q).p).q;
              type2 = aux;
              for (int k = 0; k <= n; k++)
                L=(k==0?"":ctxtStack[n-k+1])+(k==0?"":" ("+mult)+" ("+(k==0?"c_{55} ("+((App)((App)type2).p).q+") x_{122}":L)+") "+(k==0?"":ten+")");
              L = "L^{\\lambda x_{122}."+L+"}";
              // esto es para sacar factor comun 10
              I = "I^{[x_{99},x_{97},x_{98}:="+((App)((App)((App)((App)((App)type2).q).p).q).p).q+",c_{54} c_{43} c_{42},"+((App)((App)((App)((App)type2).q).q).p).q+"]}";
              // esto es a*(b+c)=a*b+a*c
              A1 = "A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{57} \\Phi_{bcb} c_{55}) c_{57}) (\\Phi_{ccbb} \\Phi_{cbb} c_{57} \\Phi_{ccb} c_{55})}";
              proof_ = new TypedApp(proof_,CombUtilities.getTerm("S ("+L+" ("+I+" "+A1+"))",user,sm_));
            } else {
                //type2 = ((App)((App)proof_.type()).p).q;
                aux = ((App)((App)proof_.type()).p).q;
                for (int k =1; k<= n; k++)
                  aux = ((App)((App)((App)aux).q).p).q;
                type2 = aux;
                /*for (int k = 0; k < n; k++) {
                    type2 = ((App)((App)((App)type2).q).p).q;
                }*/
                for (int k = 0; k <= n; k++) 
                  L=(k==0?"":ctxtStack[n-k+1])+(k==0?"":" ("+mult)+" ("+(k==0?"c_{55} x_{122} ("+((App)type2).q+")":L)+") "+(k==0?"":ten+")");
                L = "L^{\\lambda x_{122}."+L+"}";
                type2 = ((App)((App)type2).p).q;
                a = ((Const)((App)type2).q).id-42;
                b = ((Const)((App)((App)type2).p).q).id-42;
                if (a == 0) {
                    // esto es 0+a=a
                    A1 = "A^{= \\Phi_{} (\\Phi_{cb} c_{42} c_{55})}";
                    I = "I^{[x_{97} := c_{"+(b+42)+"}]}";
                    proof_ = new TypedApp(proof_,CombUtilities.getTerm(L+" ("+I+" "+A1+")",user,sm_));
                }
                else if (b == 0) {
                    // esto es a+0=a
                    A1 = "A^{= \\Phi_{} (\\Phi_{b} (c_{55} c_{42}))}";
                    I = "I^{[x_{97} := c_{"+(a+42)+"}]}";
                    proof_ = new TypedApp(proof_,CombUtilities.getTerm(L+" ("+I+" "+A1+")",user,sm_));
                }
                else {
                    carryOne2 = a+b > 9;
                    // estas dos son ecuaciones de la tabla de la suma, solo que  
                    // el resultado de la primera es de dos digitos
                    if (carryOne2)
                       A1 = "A^{= ("+type2+") (c_{54} c_{"+(((a+b)/10)+42)+"} c_{"+(((a+b)%10)+42)+"})}";
                    else
                       A1 = "A^{= ("+type2+") c_{"+(a+b+42)+"}}";
                    proof_ = new TypedApp(proof_,CombUtilities.getTerm("S ("+L+" "+A1+")",user,sm_));
                }
            }
            type2 = ((App)((App)proof_.type()).p).q;
            }
            else { 
                if (proof_ == null)
                   aux = type2;
                else
                   aux = ((App)((App)proof_.type()).p).q;
                for (int k =1; k<= n; k++)
                  aux = ((App)((App)((App)aux).q).p).q;
                type2 = aux;
                for (int k = 0; k <= n; k++)
                  L=(k==0?"":ctxtStack[n-k+1])+(k==0?"":" ("+mult)+" ("+(k==0?"x_{122}":L)+") "+(k==0?"":ten+")");
                L = "L^{\\lambda x_{122}."+L+"}";
                a = ((Const)((App)type2).q).id-42;
                b = ((Const)((App)((App)type2).p).q).id-42;
                if (a == 0) {
                    // esto es 0+a=a
                    A1 = "A^{= \\Phi_{} (\\Phi_{cb} c_{42} c_{55})}";
                    I = "I^{[x_{97} := c_{"+(b+42)+"}]}";
                    if (proof_ == null)
                       proof_ = CombUtilities.getTerm(L+" ("+I+" "+A1+")",user,sm_);
                    else
                       proof_ = new TypedApp(proof_,CombUtilities.getTerm(L+" ("+I+" "+A1+")",user,sm_));
                }
                else if (b == 0) {
                    // esto es a+0=a
                    A1 = "A^{= \\Phi_{} (\\Phi_{b} (c_{55} c_{42}))}";
                    I = "I^{[x_{97} := c_{"+(a+42)+"}]}";
                    if (proof_ == null)
                       proof_ = CombUtilities.getTerm(L+" ("+I+" "+A1+")",user,sm_);
                    else
                       proof_ = new TypedApp(proof_,CombUtilities.getTerm(L+" ("+I+" "+A1+")",user,sm_));
                }
                else {
                    carryOne2 = a+b > 9;
                    // estas dos son ecuaciones de la tabla de la suma, solo que  
                    // el resultado de la primera es de dos digitos
                    if (carryOne2)
                       A1 = "A^{= ("+type2+") (c_{54} c_{"+(((a+b)/10)+42)+"} c_{"+(((a+b)%10)+42)+"})}";
                    else
                       A1 = "A^{= ("+type2+") c_{"+(a+b+42)+"}}";
                    if (proof_ == null)
                       proof_ = CombUtilities.getTerm("S ("+L+" "+A1+")",user,sm_);
                    else
                       proof_ = new TypedApp(proof_,CombUtilities.getTerm("S ("+L+" "+A1+")",user,sm_));
                }
            }
            if (carryOne1) {
                aux = ((App)((App)proof_.type()).p).q;
                for (int k =1; k<= n; k++)
                  aux = ((App)((App)((App)aux).q).p).q;
                type2 = aux;
                for (int k = 0; k <= n; k++) 
                  L=(k==0?"":ctxtStack[n-k+1])+(k==0?"":" ("+mult)+" ("+(k==0?"c_{55} x_{122} ("+((App)type2).q+")":L)+") "+(k==0?"":ten+")");
                L = "L^{\\lambda x_{122}."+L+"}";
                // esto es ab=10*a+b
                A1 = "A^{= (\\Phi_{ccbb} c_{57} (c_{54} c_{43} c_{42}) \\Phi_{bcb} c_{55}) (\\Phi_{cb} c_{54} \\Phi_{cb})}";
                I = "I^{[x_{98},x_{97}:= c_{"+(((a+b)%10)+42)+"},c_{"+(((a+b)/10)+42)+"}]}";
                proof_ = new TypedApp(proof_,CombUtilities.getTerm(L+" ("+I+" "+A1+")",user,sm_));
                aux = ((App)((App)proof_.type()).p).q;
                for (int k =1; k<= n; k++)
                  aux = ((App)((App)((App)aux).q).p).q;
                type2 = aux;
                for (int k = 0; k <= n; k++) 
                  L=(k==0?"":ctxtStack[n-k+1])+(k==0?"":" ("+mult)+" ("+(k==0?"x_{122}":L)+") "+(k==0?"":ten+")");
                L = "L^{\\lambda x_{122}."+L+"}";
                // esto es (a+b)+c=a+(b+c)
                A1 = "A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})}";
                I = "I^{[x_{99},x_{98},x_{97}:="+((App)((App)((App)((App)type2).p).q).p).q+","+((App)((App)((App)type2).p).q).q+","+((App)type2).q+"]}";
                proof_ = new TypedApp(proof_,CombUtilities.getTerm("S ("+L+" ("+I+" "+A1+"))",user,sm_));
                aux = ((App)((App)proof_.type()).p).q;
                for (int k =1; k<= n; k++)
                  aux = ((App)((App)((App)aux).q).p).q;
                type2 = aux;
                for (int k = 0; k <= n; k++) 
                  L=(k==0?"":ctxtStack[n-k+1])+(k==0?"":" ("+mult)+" ("+(k==0?"c_{55} "+((App)((App)type2).p).q+" x_{122}":L)+") "+(k==0?"":ten+")");
                L = "L^{\\lambda x_{122}."+L+"}";
                // esto es a*(b+c)=a*b+a*c
                A1 = "A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{57} \\Phi_{bcb} c_{55}) c_{57}) (\\Phi_{ccbb} \\Phi_{cbb} c_{57} \\Phi_{ccb} c_{55})}";
                I = "I^{[x_{99},x_{97},x_{98}:="+((App)((App)((App)((App)((App)type2).q).p).q).p).q+",c_{54} c_{43} c_{42},"+((App)((App)((App)((App)type2).q).q).p).q+"]}";
                proof_ = new TypedApp(proof_,CombUtilities.getTerm("S ("+L+" ("+I+" "+A1+"))",user,sm_));
                aux = ((App)((App)proof_.type()).p).q;
                for (int k =1; k<= n; k++)
                  aux = ((App)((App)((App)aux).q).p).q;
                type2 = aux;
                ctxtStack[n+1] = "c_{55} "+((App)((App)type2).p).q;
                n++;
                for (int k = 0; k <= n; k++) 
                  L=(k==0?"":ctxtStack[n-k+1])+(k==0?"":" ("+mult)+" ("+(k==0?"x_{122}":L)+") "+(k==0?"":ten+")");
                L = "L^{\\lambda x_{122}."+L+"}";
                // esto es (a+b)+c=a+(b+c)
                A1 = "A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})}";
                I = "I^{[x_{99},x_{98},x_{97}:="+((App)((App)((App)((App)((App)type2).q).p).q).p).q+","+((App)((App)((App)((App)((App)((App)type2).q).p).q).q).p).q+","+((App)((App)((App)((App)((App)type2).q).p).q).q).q+"]}";
                proof_ = new TypedApp(proof_,CombUtilities.getTerm(L+" ("+I+" "+A1+")",user,sm_));
                aux = ((App)((App)proof_.type()).p).q;
                for (int k =1; k<= n; k++)
                  aux = ((App)((App)((App)aux).q).p).q;
                type2 = aux;
                for (int k = 0; k <= n; k++) 
                  L=(k==0?"":ctxtStack[n-k+1])+(k==0?"":" ("+mult)+" ("+(k==0?"c_{55} x_{122} ("+((App)type2).q+")":L)+") "+(k==0?"":ten+")");
                L = "L^{\\lambda x_{122}."+L+"}";
                a = ((Const)((App)((App)((App)type2).p).q).q).id;
                // esto es una ecuacion de las tablas de la suma
                if (a+1-42 == 10)
                    A1 = "A^{= (c_{55} c_{43} c_{"+a+"}) (c_{54} c_{43} c_{42})}";
                else
                A1 = "A^{= (c_{55} c_{43} c_{"+a+"}) c_{"+(a+1)+"}}";
                proof_ = new TypedApp(proof_,CombUtilities.getTerm("S ("+L+" "+A1+")",user,sm_));
                carryOne1 = false;
                n--;
                type2 = ((App)((App)proof_.type()).p).q;
            }
            else if (carryOne2) {    
                // esto es ab=10*a+b
                A1 = "A^{= (\\Phi_{ccbb} c_{57} (c_{54} c_{43} c_{42}) \\Phi_{bcb} c_{55}) (\\Phi_{cb} c_{54} \\Phi_{cb})}";
                I = "I^{[x_{98},x_{97} := c_{"+(((a+b)%10)+42)+"}, c_{"+(((a+b)/10)+42)+"}]}";
                proof_ = new TypedApp(proof_,CombUtilities.getTerm(L+" ("+I+" "+A1+")",user,sm_));
                aux = ((App)((App)proof_.type()).p).q;
                for (int k =1; k<= n; k++)
                  aux = ((App)((App)((App)aux).q).p).q;
                type2 = aux;
                for (int k = 0; k <= n; k++)
                  L=(k==0?"":ctxtStack[n-k+1])+(k==0?"":" ("+mult)+" ("+(k==0?"x_{122}":L)+") "+(k==0?"":ten+")");
                L = "L^{\\lambda x_{122}."+L+"}";
                // esto es (a+b)+c=a+(b+c)
                A1 = "A^{= (\\Phi_{bb} (\\Phi_{bbb} \\Phi_{b} c_{55}) c_{55}) (\\Phi_{cbbb} c_{55} \\Phi_{bb} \\Phi_{bb} c_{55})}";
                I = "I^{[x_{99},x_{98},x_{97} := "+((App)((App)((App)((App)type2).p).q).p).q+","+((App)((App)((App)type2).p).q).q+","+((App)type2).q+"]}";
                proof_ = new TypedApp(proof_,CombUtilities.getTerm("S ("+L+" ("+I+" "+A1+"))",user,sm_));
                aux = ((App)((App)proof_.type()).p).q;
                for (int k =1; k<= n; k++)
                  aux = ((App)((App)((App)aux).q).p).q;
                type2 = aux;
                for (int k = 0; k <= n; k++)
                  L=(k==0?"":ctxtStack[n-k+1])+(k==0?"":" ("+mult)+" ("+(k==0?"c_{55} "+((App)((App)type2).p).q+" x_{122}":L)+") "+(k==0?"":ten+")");
                L = "L^{\\lambda x_{122}."+L+"}";
                ctxtStack[n+1] = "c_{55} "+((App)((App)type2).p).q;
                // esto es a*(b+c)=a*b+a*c para sacar factor comun 10
                A1 = "A^{= (\\Phi_{bb} (\\Phi_{c(bbb,)} c_{57} \\Phi_{bcb} c_{55}) c_{57}) (\\Phi_{ccbb} \\Phi_{cbb} c_{57} \\Phi_{ccb} c_{55})}";
                I = "I^{[x_{99},x_{97},x_{98} := "+((App)((App)((App)((App)((App)type2).q).p).q).p).q+",c_{54} c_{43} c_{42},"+((App)((App)((App)((App)type2).q).q).p).q+"]}";
                proof_ = new TypedApp(proof_,CombUtilities.getTerm("S ("+L+" ("+I+" "+A1+"))",user,sm_));
                a = ((Const)((App)((App)((App)((App)type2).q).q).p).q).id;
                // esto es una ecuacion de las tablas de la suma
                if (a+1-42 == 10)
                    A1 = "A^{= (c_{55} c_{43} c_{"+a+"}) (c_{54} c_{43} c_{42})}";
                else
                    A1 = "A^{= (c_{55} c_{43} c_{"+a+"}) c_{"+(a+1)+"}}";
                aux = ((App)((App)proof_.type()).p).q;
                for (int k =1; k<= n; k++)
                  aux = ((App)((App)((App)aux).q).p).q;
                type2 = aux;
                n++;
                for (int k = 0; k <= n; k++)
                  L=(k==0?"":ctxtStack[n-k+1])+(k==0?"":" ("+mult)+" ("+(k==0?"x_{122}":L)+") "+(k==0?"":ten+")");
                L = "L^{\\lambda x_{122}."+L+"}";
                proof_ = new TypedApp(proof_,CombUtilities.getTerm("S ("+L+" "+A1+")",user,sm_));
                carryOne2 = false;
                n--;
            }
                
            n++;
            }
            type_ = proof_.type();
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
