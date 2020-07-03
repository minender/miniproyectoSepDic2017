grammar Comb;	

@header{
	
package com.howtodoinjava.parse; 

import com.howtodoinjava.lambdacalculo.*;	
import java.util.LinkedList;	
	
}	


/*
 * Parser Rules
 */

// All kind of expresions
start_rule returns [Term value] : expr { $value=$expr.value; };
  
expr returns [Term value]
    :	term                                    { $value = $term.value; }
    |   LAMBDA v=variable PERIOD e1=expr 	{ $value = new Bracket($v.value, $e1.value); }
    |   O_BRACKET2 vl=variable_list ASSIGN el=term_list C_BRACKET2  
                                                { 
                                                  if ($vl.value.size() != $el.value.size()) {
                                                    try {
                                                        throw new TypeVerificationException();
                                                    }
                                                    catch (TypeVerificationException e) {
                                                        e.printStackTrace();
                                                        System.exit(1);
                                                    }
                                                  }
       						  else
                                                    $value = new Sust($vl.value, $el.value);
                                                };

term returns [Term value]
    :  term_base term_tail { Term aux = $term_base.value; 
                                try {
	                          for (Term it: $term_tail.value) {
                                    if (aux instanceof TypedTerm && it instanceof TypedTerm) 
                                          aux = new TypedApp(aux,it);
				    else if ( !(aux instanceof TypedTerm) && !(it instanceof TypedTerm))
					  aux = new App(aux,it);
                                    else
                                          throw new TypeVerificationException();
                                  }
				}
                                catch (TypeVerificationException e){
                                    e.printStackTrace();
                                    System.exit(1);
                                }
				$value = aux;  
                            };

term_base returns [Term value]
	: constant	       { $value = $constant.value; }
	| variable	       { $value = $variable.value; }
	| O_PAR term C_PAR     { $value = $term.value; };
	
term_tail returns [LinkedList<Term> value]
    : term_base t=term_tail       { $t.value.add(0,$term_base.value); $value = $t.value; }
    |                             { $value = new LinkedList<Term>(); };
	
variable_list returns [LinkedList<Var> value]
    : variable vl=variable_list_tail	{ $vl.value.add(0,$variable.value); $value = $vl.value; };
	
variable_list_tail returns [LinkedList<Var> value]
    :  COMMA variable_list { $value = $variable_list.value; }
    |                      { $value = new LinkedList<Var>(); };
	
term_list returns [LinkedList<Term> value]
    : term el=term_list_tail  { $el.value.add(0,$term.value); $value = $el.value; };   
	
term_list_tail returns [LinkedList<Term> value]
	: COMMA term_list   { $value = $term_list.value; }   
	|                   { $value = new LinkedList<Term>(); };

// Variables for example x_{34}
variable returns [Var value]
	: VARIABLE {String var = $VARIABLE.text ; // Take string format of the variable
                    int index = Integer.parseInt(var.substring(3,var.length()-1));// Take only the the index of the variable
                    $value = new Var(index);// Return a new Variable obeject with that index
		   };

// All kind of constants
constant returns [Term value]
    : CONSTANT_C 	{ String cons = $CONSTANT_C.text ; // Take string format of the constant
			  int index = Integer.parseInt(cons.substring(3,cons.length()-1));// Take only the the index of the constant
			  $value = new Const(index ,cons);
	                }
    | constant_phi 	{ $value = $constant_phi.value; }
    |   prove_base	{ $value = $prove_base.value; };
 
// All forms of Phi constants for example \Phi_{(cbc,(cb,b))} 
constant_phi returns [Term value]
    :	PHI phi_tail  { $value = $phi_tail.value; };
	
phi_tail returns [Term value]
    :   K C_BRACKET		 { $value = new Const("\\Phi_{K}"); }
    |   comb_index C_BRACKET { $value = new Phi(); ((Phi)$value).ind=$comb_index.value;};

// All kind of combinatory indexes for example cbcbcc(cc,cc)
comb_index returns [ListaInd value]
    :	cb_pair 	{$value = new ListaInd($cb_pair.value);}
    |	CB c1=comb_index{$value = $c1.value;// Take the ListaInd from c1 
			 ConstInd cb = new ConstInd($CB.text);// Crete a new c/b const
			 $value.list.add(cb);// Add it to the new value
			 $value.orden +=cb.orden;// update orden
			}				
	| 		{$value = new ListaInd();};

// Combinations of cb in pairs for example (cbc,(cb,b)) 
cb_pair	returns [Indice value]
    :	O_PAR c1=comb_index COMMA c2=comb_index C_PAR { $value = new ParInd($c1.value,$c2.value);};


/*
 * PROVE RELATED RULES
 */
 prove_base returns [Term value]
    : I expr C_BRACKET { $value = new TypedI((Sust) $expr.value); }
    | L expr C_BRACKET { $value = new TypedL((Bracket) $expr.value); }
    | S expr C_BRACKET { 
    			 try {
                           $value = new TypedS($expr.value,0); 
			 } catch (TypeVerificationException e) {
			   e.printStackTrace();
			   System.exit(1);
			 }
    			}
    | A expr C_BRACKET { $value = new TypedA($expr.value); };

 
/*
 * Lexer Rules
 */
 
/*
 * fragments
 */
    
fragment DIGITS : ( '1'..'9' [0-9]* | '0' );  
fragment C : ('C' | 'c' );
fragment X : ('X' | 'x' );


/*
 * tokens
 */
    
// Constants of type c_{N} where N is a digit
CONSTANT_C : C '_{' DIGITS '}' ; 

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
ASSIGN: ':=';

// Variables of type x_{N} where N is a digit
VARIABLE: X '_{' DIGITS '}';


// Neccesary for proves
A : 'A^{';
I : 'I^{';
L : 'L^{';
S : 'S^{';


// Allow whitespace but ignore it 
WHITESPACE: ' '+ -> channel(HIDDEN) ;


