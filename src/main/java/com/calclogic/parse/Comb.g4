grammar Comb;   

@header{
    
package com.calclogic.parse; 

import com.calclogic.lambdacalculo.*;   
import java.util.LinkedList;
import com.calclogic.entity.Resuelve; 
import com.calclogic.service.SimboloManager;  
    
}   


/*
 * Parser Rules
 */

// All kind of expresions
start_rule[String u,SimboloManager s] returns [Term value] : expr[u,s] { $value=$expr.value; };
  
expr[String u,SimboloManager s] returns [Term value]
    :   term[u,s]                               { $value = $term.value; }
    |   O_BRACKET2 vl=variable_list ASSIGN el=term_list[u,s] C_BRACKET2  
                                                { 
                                                    if ($vl.value.size() != $el.value.size()) {
                                                        try {
                                                            throw new TypeVerificationException();
                                                        }
                                                        catch (TypeVerificationException e) {
                                                            e.printStackTrace();
                                                            return null;
                                                        }
                                                    }
                                                    else{
                                                        $value = new Sust($vl.value, $el.value);
                                                    }
                                                };

term[String u,SimboloManager s] returns [Term value]
    :  term_base[u,s] term_tail[u,s] { 
                                    Term aux = $term_base.value; 
                                    if (aux instanceof Const && ((Const)aux).getId()==0 && !((Const)aux).getCon().equals("\\Phi_{K}"))
                                       ((Const)aux).setType("x"+Phi.stInd+"->x"+Phi.stInd+"->p");
                                    try {
                                        for (Term it: $term_tail.value) {
                                            if (aux instanceof TypedTerm && 
                                                (it instanceof TypedTerm)) //|| it instanceof Const || it instanceof App))
                                            {
                                                aux = new TypedApp(aux,it);
                                            }
                                            else if (aux instanceof M && it instanceof TypedTerm) {
                                                aux = new TypedM(((Const)aux).getId(), Integer.parseInt(((Const)aux).getCon()), it, ((TypedTerm)it).getCombDBType(), u);
                                            } else if ( !(aux instanceof TypedTerm) && !(it instanceof TypedTerm)){
                                                aux = new App(aux,it);
                                            }
                                            else{
                                                throw new TypeVerificationException();
                                            }
                                        }
                                    }
                                    catch (TypeVerificationException e){
                                        e.printStackTrace();
                                        return null;
                                    }
                                    $value = aux;  
                                };

term_base[String u,SimboloManager s] returns [Term value]
    : constant[u,s]          { $value = $constant.value; }
    | variable               { $value = $variable.value; }
    | LAMBDA v=variable PERIOD e1=term[u,s]   { $value = new Bracket($v.value, $e1.value); }
    | O_PAR term[u,s] C_PAR  { $value = $term.value; };
    
term_tail[String u,SimboloManager s] returns [LinkedList<Term> value]
    : term_base[u,s] t=term_tail[u,s] { $t.value.add(0,$term_base.value); $value = $t.value; }
    |                                 { $value = new LinkedList<Term>(); };
    
variable_list returns [LinkedList<Var> value]
    : variable vl=variable_list_tail    { $vl.value.add(0,$variable.value); $value = $vl.value; };
    
variable_list_tail returns [LinkedList<Var> value]
    :  COMMA variable_list { $value = $variable_list.value; }
    |                      { $value = new LinkedList<Var>(); };
    
term_list[String u,SimboloManager s] returns [LinkedList<Term> value]
    : term[u,s] el=term_list_tail[u,s]  { $el.value.add(0,$term.value); $value = $el.value; };   
    
term_list_tail[String u,SimboloManager s] returns [LinkedList<Term> value]
    : COMMA term_list[u,s]   { $value = $term_list.value; }   
    |                      { $value = new LinkedList<Term>(); };

// Variables for example x_{34}
variable returns [Var value]
    :  X DIGITS C_BRACKET {
                          int index = Integer.parseInt($DIGITS.text);// Take the index of the variable
                          $value = new Var(index);// Return a new Variable object with that index
                         };
    /* : VARIABLE {String var = $VARIABLE.text ; // Take string format of the variable
                    int index = Integer.parseInt(var.substring(3,var.length()-1));// Take only the the index of the variable
                    $value = new Var(index);// Return a new Variable object with that index
           };*/

// All kind of constants
constant[String u,SimboloManager s] returns [Term value]
    : C DIGITS C_BRACKET { int index = Integer.parseInt($DIGITS.text);
                          if (s == null)
                             $value = new Const(index ,"c_{"+index+"}");
                          else
                             $value = new Const(index ,"c_{"+index+"}",s.getSimbolo(index).getTipo());
                        } 
    /*: CONSTANT_C    { String cons = $CONSTANT_C.text ; // Take string format of the constant
              int index = Integer.parseInt(cons.substring(3,cons.length()-1));// Take only the the index of the constant
              $value = new Const(index ,cons);
                    }*/
    | EQUAL             { String cons = $EQUAL.text ; // Take string format of the constant
                          $value = new Const(0 ,cons);
                        }
    | TRUE              { String cons = $TRUE.text ; // Take string format of the constant
                          $value = new Const(-1 ,cons, "p");
                        }
    | constant_phi[s]  { $value = $constant_phi.value; }
    | prove_base[u,s] { $value = $prove_base.value; };
 
// All forms of Phi constants for example \Phi_{(cbc,(cb,b))} 
constant_phi[SimboloManager s] returns [Term value]
    :   PHI phi_tail[s]  { $value = $phi_tail.value; };
    
phi_tail[SimboloManager s] returns [Term value]
    :   K C_BRACKET      { if (s != null) {
                              int i = Phi.stInd;
                              Phi.stInd = Phi.stInd+2;
                              Term type = new App(new App(new Const(-3,"->"),new App(new App(new Const(-3,"->"),new Var(i)),
                                          new Var(i+1))),new Var(i));
                              $value = new Const("\\Phi_{K}",type); 
                           } else
                              $value = new Const("\\Phi_{K}"); 
                         }
    |   comb_index C_BRACKET { $value = new Phi(); ((Phi)$value).ind=$comb_index.value;
                               if (s != null){
                                  ((Phi)$value).computeType();
                               }
                             };

// All kind of combinatory indexes for example cbcbcc(cc,cc)
comb_index returns [ListaInd value]
    :   cb_pair     {$value = new ListaInd($cb_pair.value);}
    |   CB c1=comb_index{$value = $c1.value;// Take the ListaInd from c1 
             ConstInd cb = new ConstInd($CB.text);// Crete a new c/b const
             $value.list.add(cb);// Add it to the new value
             $value.orden +=cb.orden;// update orden
            }               
    |           {$value = new ListaInd();};

// Combinations of cb in pairs for example (cbc,(cb,b)) 
cb_pair returns [Indice value]
    :   O_PAR c1=comb_index COMMA c2=comb_index C_PAR { $value = new ParInd($c1.value,$c2.value);};


/*
 * PROVE RELATED RULES
 */
 prove_base[String u,SimboloManager s] returns [Term value]
    : I expr[u,s] C_BRACKET { $value = new TypedI((Sust) $expr.value); }
    | L expr[u,s] C_BRACKET { $value = new TypedL((Bracket) $expr.value); }
    | S expr[u,s] C_BRACKET { 
                            try {
                                $value = new TypedS($expr.value,0); 
                            } catch (TypeVerificationException e) {
                                e.printStackTrace();
                                return null;
                            }
                        }
    | Si {
            try {
                $value = new TypedS(); 
            } catch (TypeVerificationException e) {
                e.printStackTrace();
                return null;
            } 
        }
    | A expr[u,s] C_BRACKET { $value = (u!=null ? new TypedA($expr.value,u) : new TypedA($expr.value)); }
    | M d=DIGITS factorize { 
                            int id;
                            id = Integer.parseInt($d.text);
                            $value = new M(id, $factorize.value);
                        };

 factorize returns [String value]
    :  EXP d=DIGITS C_BRACKET {$value = $d.text; }
    |  C_BRACKET          {$value = "0"; };

 
/*
 * Lexer Rules
 */
 
/*
 * fragments
 */
    
DIGITS : ('-'|)( '1'..'9' [0-9]* | '0' );  
C : ('C_{' | 'c_{' );
X : ('X_{' | 'x_{' );


/*
 * tokens
 */
    
EQUAL : '=' ;
TRUE : 'T' ;

// Neccesary for phi constant 
PHI : '\\Phi_{' ;
LAMBDA : '\\lambda';
PERIOD : '.';
K : 'K';
CB : ('c' | 'b');
O_PAR : '(';
C_PAR : ')';
COMMA : ',';
C_BRACKET: '}' ;
O_BRACKET2: '[';
C_BRACKET2: ']';
EXP: '}^{';
ASSIGN: ':=';


// Neccesary for proofs
A : 'A^{';
M : 'M_{';
I : 'I^{';
L : 'L^{';
S : 'S^{';
Si: 'S';


// Allow whitespace but ignore it 
WHITESPACE: (' '|'\r'|'\n'|'\t')+ -> channel(HIDDEN) ;

/*
* Grammar Resume
* S -> E
* E -> T | [ VL := TL ]
* T -> TB TT
* TB -> C | V | lamb V . T | (T)
* TT -> TB TT | epsilon
* VL -> V VLT
* VLT -> , VL | epsilon
* TL -> T TLT
* TLT -> , TL | epsilon
* V -> x dig }
* C -> c dig } | = | t | CPH | PB
* CPH -> ph PHT
* PHT -> k } | CI }
* CI -> CP | cb CI | epsilon
* CP -> ( CI , CI )  
* PB -> i E } | l E } | si | a E } | m dig F
* F -> exp dig } | }
*/


