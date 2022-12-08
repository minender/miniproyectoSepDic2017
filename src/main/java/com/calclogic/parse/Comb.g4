grammar Comb;   

@header{
    
package com.calclogic.parse; 

import com.calclogic.lambdacalculo.*;   
import java.util.LinkedList;
import com.calclogic.entity.Resuelve;   
    
}   


/*
 * Parser Rules
 */

// All kind of expresions
start_rule[String u] returns [Term value] : expr[u] { $value=$expr.value; };
  
expr[String u] returns [Term value]
    :   term[u]                                 { $value = $term.value; }
    |   O_BRACKET2 vl=variable_list ASSIGN el=term_list[u] C_BRACKET2  
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

term[String u] returns [Term value]
    :  term_base[u] term_tail[u] { 
                                    Term aux = $term_base.value; 
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

term_base[String u] returns [Term value]
    : constant[u]          { $value = $constant.value; }
    | variable         { $value = $variable.value; }
    | LAMBDA v=variable PERIOD e1=term[u]   { $value = new Bracket($v.value, $e1.value); }
    | O_PAR term[u] C_PAR  { $value = $term.value; };
    
term_tail[String u] returns [LinkedList<Term> value]
    : term_base[u] t=term_tail[u] { $t.value.add(0,$term_base.value); $value = $t.value; }
    |                             { $value = new LinkedList<Term>(); };
    
variable_list returns [LinkedList<Var> value]
    : variable vl=variable_list_tail    { $vl.value.add(0,$variable.value); $value = $vl.value; };
    
variable_list_tail returns [LinkedList<Var> value]
    :  COMMA variable_list { $value = $variable_list.value; }
    |                      { $value = new LinkedList<Var>(); };
    
term_list[String u] returns [LinkedList<Term> value]
    : term[u] el=term_list_tail[u]  { $el.value.add(0,$term.value); $value = $el.value; };   
    
term_list_tail[String u] returns [LinkedList<Term> value]
    : COMMA term_list[u]   { $value = $term_list.value; }   
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
constant[String u] returns [Term value]
    : C DIGITS C_BRACKET { int index = Integer.parseInt($DIGITS.text);
                          $value = new Const(index ,"c_{"+index+"}");
                        } 
    /*: CONSTANT_C    { String cons = $CONSTANT_C.text ; // Take string format of the constant
              int index = Integer.parseInt(cons.substring(3,cons.length()-1));// Take only the the index of the constant
              $value = new Const(index ,cons);
                    }*/
    | EQUAL             { String cons = $EQUAL.text ; // Take string format of the constant
                          $value = new Const(0 ,cons);
                        }
    | TRUE              { String cons = $TRUE.text ; // Take string format of the constant
                          $value = new Const(-1 ,cons);
                        }
    | constant_phi  { $value = $constant_phi.value; }
    | prove_base[u] { $value = $prove_base.value; };
 
// All forms of Phi constants for example \Phi_{(cbc,(cb,b))} 
constant_phi returns [Term value]
    :   PHI phi_tail  { $value = $phi_tail.value; };
    
phi_tail returns [Term value]
    :   K C_BRACKET      { $value = new Const("\\Phi_{K}"); }
    |   comb_index C_BRACKET { $value = new Phi(); ((Phi)$value).ind=$comb_index.value;};

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
 prove_base[String u] returns [Term value]
    : I expr[u] C_BRACKET { $value = new TypedI((Sust) $expr.value); }
    | L expr[u] C_BRACKET { $value = new TypedL((Bracket) $expr.value); }
    | S expr[u] C_BRACKET { 
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
    | A expr[u] C_BRACKET { $value = (u!=null ? new TypedA($expr.value,u) : new TypedA($expr.value)); }
    | M d=DIGITS EXP factorize { 
                            int id;
                            id = Integer.parseInt($d.text);
                            if ($factorize.value == null)
                               $value = new M(id, "0");
                            else
                               $value = new M(id, $factorize.value);
                        };

 factorize returns [String value]
    :  d=DIGITS C_BRACKET {$value = $d.text; }
    |  C_BRACKET          {$value = null; };

 
/*
 * Lexer Rules
 */
 
/*
 * fragments
 */
    
DIGITS : ( '1'..'9' [0-9]* | '0' );  
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
WHITESPACE: ' '+ -> channel(HIDDEN) ;


