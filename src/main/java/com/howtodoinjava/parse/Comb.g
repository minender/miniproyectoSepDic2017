grammar Comb;

//Parser Rules
c returns [Term value]: X { $value =new Var((new Integer($X.text.substring(1))).intValue());}
       | K {$value = new Const("K");}
       | P '{' indice '}' {$value=new Phi(); ((Phi)$value).ind=$indice.ind; }
       | '(' ci=c cd=c ')' {$value=new App($ci.value,$cd.value);};

indice returns [ListaInd ind]: con=CONSTINDICE i=indice {$i.ind.list.add($i.ind.list.size(),new ConstInd($con.text)); $ind = $i.ind;}
      | '(' izq=indice ',' der=indice ')' {$ind =new ListaInd(new ParInd(izq,der));}
      |{$ind = new ListaInd();};

//Lexer Rules

CONSTINDICE: 'c' | 'b';

P: '\\Phi_';

K: 'K';

X: 'x' NUMBER;

INITIALDIGIT: '1'..'9';

DIGIT: '0'|INITIALDIGIT;

NUMBER: '0' | INITIALDIGIT+(DIGIT)*;

WHITESPACE: (' ' | '\r')+ {$channel = HIDDEN;};
