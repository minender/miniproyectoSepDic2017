grammar ProofMethod;

@header{

package com.calclogic.parse;

import com.calclogic.lambdacalculo.Const;
import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Term;
import java.util.LinkedList;

}

//Parser Rules
start_rule returns [Term value] : method { $value=$method.value; };

method returns [Term value]
    :  method_base method_tail {
                                Term aux = $method_base.value; 
	                        for (Term it: $method_tail.value) 
                                    aux = new App(aux,it);
				$value = aux;  
                               };

method_tail returns [LinkedList<Term> value]
    : method_base t=method_tail   { $t.value.add(0,$method_base.value); $value = $t.value; }
    |                             { $value = new LinkedList<Term>(); };


method_base returns [Term value]: 
         DM {$value = new Const("DM");}
       | EO {$value = new Const("EO");}
       | OE {$value = new Const("OE");}
       | SS {$value = new Const("SS");}
       | TL {$value = new Const("TL");}
       | TR {$value = new Const("TR");}
       | WL {$value = new Const("WL");}
       | WR {$value = new Const("WR");}
       | ND {$value = new Const("ND");}
       | CO {$value = new Const("CO");}
       | CR {$value = new Const("CR");}
       | AI {$value = new Const("AI");}
       | MI {$value = new Const("MI");}
       | CA {$value = new Const("CA");}
       | GE {$value = new Const("GE");}
       | WI {$value = new Const("WI");}
       | O_PAR method C_PAR { $value = $method.value; };

/*
 * Lexer Rules
 */

DM: 'DM';

EO: 'EO';

OE: 'OE';

SS: 'SS';

TL: 'TL';

TR: 'TR';

WL: 'WL';

WR: 'WR';

ND: 'ND';

CO: 'CO';

CR: 'CR';

AI: 'AI';

MI: 'MI';

CA: 'CA';

GE: 'GE';

WI: 'WI';

O_PAR: '(';

C_PAR: ')';

// Allow whitespace but ignore it 
WHITESPACE: (' '|'\r'|'\n'|'\t')+ -> channel(HIDDEN) ;