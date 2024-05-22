grammar Type;   

@header{
    
package com.calclogic.parse; 

import com.calclogic.lambdacalculo.*;   
    
}   


/*
 * Parser Rules
 */
start_rule returns [Term value]
   : term    {$value = $term.value;};

term returns [Term value]
   : head tail  {if($tail.value==null){$value=$head.value;}else{$value=new App($tail.value,$head.value);}};

tail returns [Term value]
   : TO term   {$value=new App(new Const(-3,"->"),$term.value);}
   |           {$value=null;};

head returns [Term value]
   : P                 { if($P.text.equals("p") || $P.text.equals("b")){$value=new Const(-4,"p");}
                         else if($P.text.equals("t")){$value=new Const(-5,"t");}
                       }
   | X DIGITS          {$value=new Var(Integer.parseInt($DIGITS.text));}
   | O_PAR term C_PAR  {$value=$term.value;};

/*
 * Lexer Rules
 */

X : ('X' | 'x');
DIGITS : ( '1'..'9' [0-9]* | '0' );
P : ('b' | 'p' | 't');
TO : '->';
O_PAR : '(';
C_PAR : ')';

// Allow whitespace but ignore it 
WHITESPACE: (' '|'\r'|'\n'|'\t')+ -> channel(HIDDEN) ;

/*
* Grammar Resume
* S ::= A 
* A ::= T T'
* T' ::= lamb | to A
* T ::= p | t | (A)
*/
