grammar Comb;	

@header{
	
package com.howtodoinjava.parse; 

import com.howtodoinjava.lambdacalculo.*;	
	
	
}	

/*
 * Parser Rules
 */

// All kind of expresions  
expr returns [Term value]
	:	aux_expr		 	{ $value = $aux_expr.value; }
	|  	e1=expr e2=aux_expr { $value = new App($e1.value, $e2.value); };


aux_expr returns [Term value]
	:   constant	{ $value = $constant.value; }
	| 	variable 	{ $value = $variable.value; }
	| 	par_expr	{ $value = $par_expr.value; };

// Variables for example x_{34}
variable returns [Term value]
	:	VARIABLE 			{String var = $VARIABLE.text ; // Take string format of the variable
							int index = Integer.parseInt(var.substring(3,var.length()-1));// Take only the the index of the variable
							$value = new Var(index);// Return a new Variable obeject with that index
							};
// 	Expression within parenthesis		
par_expr returns [Term value]
	: O_PAR expr C_PAR 		{ $value = $expr.value; };

// All kind of constants
constant returns [Term value]
	:	CONSTANT_C 	 		{ $value = new Const($CONSTANT_C.text);}
	|	constant_phi 		{ $value = $constant_phi.value;}; 
 
// All forms of Phi constants for example \Phi_{(cbc,(cb,b))} 
constant_phi returns [Term value]
	:	PHI K C_BRACKET			 { $value = new Const("\\Phi_{K}"); }
	|	PHI comb_index C_BRACKET { $value = new Phi(); ((Phi)$value).ind=$comb_index.value;};

// All kind of combinatory indexes for example cbcbcc(cc,cc)
comb_index returns [ListaInd value]
	:	CB 							{$value = new ListaInd(new ConstInd($CB.text));}
	|	cb_pair 					{$value = new ListaInd($cb_pair.value);}
	|	CB c1=comb_index 			{$value = $c1.value;// Take the ListaInd from c1 
									ConstInd cb = new ConstInd($CB.text);// Crete a new c/b const
									$value.list.add(cb);// Add it to the new value
									$value.orden +=cb.orden;// update orden
									}				
	| 								{$value = new ListaInd();};

// Combinations of cb in pairs for example (cbc,(cb,b)) 
cb_pair	returns [Indice value]
	:	O_PAR c1=comb_index COMMA c2=comb_index C_PAR { $value = new ParInd($c1.value,$c2.value);};
	   
	   
 
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
K : 'K';
CB : ('c' | 'b');
O_PAR : '(';
C_PAR : ')';
COMMA : ',';
C_BRACKET: '}' ;

// Variables of type x_{N} where N is a digit
VARIABLE: X '_{' DIGITS '}';

// Allow whitespace but ignore it 
WHITESPACE: ' '+ -> channel(HIDDEN) ;


