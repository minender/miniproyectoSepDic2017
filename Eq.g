grammar Eq;

@header{import java.util.Iterator;}

// Parser Rules
start_rule  returns [Term value]: eq           { $value=$eq.value;};

eq returns [Term value]: term eqtail          { Term aux=$term.value;
                                                for(Iterator<Term> i = $eqtail.value.iterator(); i.hasNext();) 
                                                   aux=new App(new App(new Const("\\equiv "),i.next()),aux);
                                                $value=aux;
                                              };

eqtail returns [ArrayList<Term> value]:    
    ('=='| '\\equiv') term tail1=eqtail       {ArrayList<Term> aux=$tail1.value; aux.add(0,$term.value); $value=aux;}

   |                                          {$value=new ArrayList<Term>();};

term returns [Term value]: disyconj disyconjtail  { 
                                                    if ($disyconjtail.value == null)
                                                       $value = $disyconj.value;
                                                    else
                                                       $value = new App($disyconjtail.value,$disyconj.value);
                                                  };

disyconjtail returns [Term value]:  

     ('==>'| '\\Rightarrow') disyconj tail2=disyconjtail{
                                               if ($tail2.value == null)
                                                  $value = new App(new Const("\\Rightarrow "),$disyconj.value);
                                               else
                                               $value=new App(new Const("\\Rightarrow "),new App($tail2.value,$disyconj.value));
                                              }

   |                                          {$value=null;};

disyconj returns [Term value]: conc conctail  { Term aux=$conc.value;
                                                for(Iterator<Term> i = $conctail.value.iterator(); i.hasNext();) 
                                                   aux=new App(new App(new Const("\\Leftarrow "),i.next()),aux);
                                                $value=aux;
                                              };

conctail returns [ArrayList<Term> value]:

    ('<=='| '\\Leftarrow') conc tail3=conctail{ArrayList<Term> aux=$tail3.value; 
                                               aux.add(0,$conc.value); $value=aux;
                                              }

   |                                          {$value=new ArrayList<Term>();};

conc returns [Term value]: neq disytail             { Term aux=$neq.value; 
                                                     for(Iterator<ParserPair> i = $disytail.value.iterator(); i.hasNext();)
                                                     {
                                                        ParserPair pair = i.next();
                                                        if (pair.symbol.equals("\\vee "))
                                                           aux=new App(new App(new Const(pair.symbol),pair.term),aux); 
                                                        else if (pair.symbol.equals("\\wedge "))
                                                           aux=new App(new App(new Const(pair.symbol),pair.term),aux); 
                                                     }
                                                     $value=aux;
                                                   };

disytail returns [ArrayList<ParserPair> value]:

     ('\\/'| '\\vee') neq tail4=disytail      {ArrayList<ParserPair> aux=$tail4.value;
                                               aux.add(0,new ParserPair("\\vee ",$neq.value)); $value=aux;
                                              }

   | ('/\\'| '\\wedge') neq tail5=disytail    {ArrayList<ParserPair> aux=$tail5.value; 
                                               aux.add(0,new ParserPair("\\wedge ",$neq.value)); $value=aux;
                                              }

   |                                          {$value=new ArrayList<ParserPair>();};

neq returns [Term value]: neg neqtail         { Term aux=$neg.value;
                                                for(Iterator<Term> i = $neqtail.value.iterator(); i.hasNext();) 
                                                   aux=new App(new App(new Const("\\nequiv "),i.next()),aux);
                                                $value=aux;
                                              };

neqtail returns [ArrayList<Term> value]:

    ('!=='| '\\nequiv') neg tail6=neqtail {ArrayList<Term> aux=$tail6.value; 
                                               aux.add(0,$neg.value); $value=aux;
                                              }

   |                                          {$value=new ArrayList<Term>();};

neg returns [Term value]: 

      ('!' | '\\neg') n=neg                   {$value=new App(new Const("\\neg "),$n.value);}

     | CAPITALLETTER                          {$value = new Var((new Integer((int)$CAPITALLETTER.text.charAt(0))).intValue());}

     | LETTER                                 {$value = new Var((new Integer((int)$LETTER.text.charAt(0))).intValue());}

     | 'true'                                 {$value = new Const("true ");}

     | 'false'                                {$value = new Const("false ");}

     | CAPITALLETTER '_{' eq '}^{' LETTER '}' {Var letter = new Var((new Integer((int)$LETTER.text.charAt(0))).intValue());
                                               Var capl = new Var((new Integer((int)$CAPITALLETTER.text.charAt(0))).intValue());
                                               $value = new App(new Bracket(letter,capl),$eq.value);
                                              } 

     | WORD '(' arguments ')'                 {Term aux = new Const($WORD.text);
                                               for(Iterator<Var> i = $arguments.value.iterator(); i.hasNext();) 
                                                  aux=new App(aux,i.next());
                                               $value=aux;
                                              }

     | '(' eq ')'                             {$value=$eq.value;};

instantiate returns [ArrayList<Object> value]: 

     arguments ':=' explist                   {ArrayList<Object> arr=new ArrayList<Object>();
                                               arr.add($arguments.value);
                                               arr.add($explist.value);
                                               $value = arr;
                                              };

explist returns [ArrayList<Term> value]: 

     eq  explisttail                          {ArrayList<Term> aux = $explisttail.value;
                                               aux.add(0,$eq.value);
                                               $value = aux;
                                              };

explisttail returns [ArrayList<Term> value]: 

     ',' eq tail7=explisttail                 {ArrayList<Term> aux = $tail7.value;
                                               aux.add(0,$eq.value);
                                               $value =aux;
                                              }

     |                                        {$value = new ArrayList<Term>();};

X:
   'X' NUMBER

  | 'x' NUMBER;

arguments returns [ArrayList<Var> value]: LETTER ',' arg=arguments {ArrayList<Var> aux=$arg.value; 
                                                            Var v=new Var((new Integer((int)$LETTER.text.charAt(0))).intValue());
                                                            aux.add(0,v); 
                                                            $value=aux;
                                                           }

                                         | CAPITALLETTER ',' arg=arguments {ArrayList<Var> aux=$arg.value; 
                                                     Var v=new Var((new Integer((int)$CAPITALLETTER.text.charAt(0))).intValue());
                                                            aux.add(0,v); 
                                                            $value=aux;
                                                           }

                                         | LETTER          {ArrayList<Var> list=new ArrayList<Var>();
                                                            Var v=new Var((new Integer($LETTER.text.charAt(0))).intValue());
                                                            list.add(0,v);
                                                            $value = list;
                                                           }

                                         | CAPITALLETTER   {ArrayList<Var> list=new ArrayList<Var>();
                                                       Var v=new Var((new Integer($CAPITALLETTER.text.charAt(0))).intValue());
                                                             list.add(0,v);
                                                             $value = list;
                                                           };

INITIALDIGIT: '1'..'9';

DIGIT: '0'|INITIALDIGIT;

NUMBER: '0' | INITIALDIGIT (DIGIT)*;

CAPITALLETTER: 'A'..'Z';

LETTER: 'a'..'z';

WORD:   CAPITALLETTER (LETTER)+

      | CAPITALLETTER;

WHITESPACE: (' ' | '\r')+ {$channel = HIDDEN;};
