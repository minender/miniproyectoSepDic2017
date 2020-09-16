grammar FOScheme;

@header{package com.howtodoinjava.parse; 

import com.howtodoinjava.service.TerminoManager;
import com.howtodoinjava.entity.Termino;
import com.howtodoinjava.entity.TerminoId;
import com.howtodoinjava.entity.Predicado;
import com.howtodoinjava.entity.PredicadoId;
import com.howtodoinjava.lambdacalculo.*;
import com.howtodoinjava.service.PredicadoManager;
import java.util.Iterator;}

// Parser Rules [PredicadoId predicadoid, PredicadoManager predicadoManager]
start_rule[TerminoId terminoid, TerminoManager terminoManager]  returns [Term value]: eq           { $value=$eq.value;};

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
                                                   aux=new App(new App(new Const("\\not\\equiv "),i.next()),aux);
                                                $value=aux;
                                              };

neqtail returns [ArrayList<Term> value]:

    ('!=='| '\\not\\equiv') neg tail6=neqtail     {ArrayList<Term> aux=$tail6.value; 
                                               aux.add(0,$neg.value); $value=aux;
                                              }

   |                                          {$value=new ArrayList<Term>();};

neg returns [Term value]: 

      ('!' | '\\neg') n=neg               {$value=new App(new Const("\\neg "),$n.value);}

     | CAPITALLETTER sust                 {Term aux = new Var((new Integer((int)$CAPITALLETTER.text.charAt(0))).intValue());
                                           for(Iterator<Sust> i = $sust.value.iterator(); i.hasNext();)
                                              aux=new App(aux,i.next()); 
                                           $value=aux;
                                          }

     | 'true' sust                        {Term aux = new Const("true ");
                                           for(Iterator<Sust> i = $sust.value.iterator(); i.hasNext();)
                                              aux=new App(aux,i.next()); 
                                           $value=aux;
                                          }

     | 'false' sust                       {Term aux = new Const("false ");
                                           for(Iterator<Sust> i = $sust.value.iterator(); i.hasNext();)
                                              aux=new App(aux,i.next()); 
                                           $value=aux;
                                          }

     | '(' 'forall' LETTER '|'  ':' b1=eq ')' sust {Var v = new Var((int)$LETTER.text.charAt(0));
                                                    Term aux =new Bracket(v,$b1.value);
                                                    for(Iterator<Sust> i = $sust.value.iterator(); i.hasNext();)
                                                       aux=new App(aux,i.next()); 
                                                    $value=aux;
                                                   }

     | '(' 'forall' LETTER '|' ran1=eq ':' b1=eq ')' sust {Var v = new Var((int)$LETTER.text.charAt(0));
                                               Term aux = new Bracket(v,new App(new App(new I(),$ran1.value),$b1.value));
                                                           for(Iterator<Sust> i = $sust.value.iterator(); i.hasNext();)
                                                               aux=new App(aux,i.next()); 
                                                           $value=aux;
                                                          }

     | '(' 'exists' LETTER '|' ':' b2=eq ')' sust {Var v = new Var((int)$LETTER.text.charAt(0));
                                                   Term aux = (new Bracket(v,$b2.value));
                                                   for(Iterator<Sust> i = $sust.value.iterator(); i.hasNext();)
                                                       aux=new App(aux,i.next()); 
                                                   $value=aux;
                                                  }

     | '(' 'exists' LETTER '|' ran2=eq ':' b2=eq ')' sust {Var v = new Var((int)$LETTER.text.charAt(0));
                                                     Term aux = new Bracket(v,new App(new App(new I(),$ran2.value),$b2.value));
                                                           for(Iterator<Sust> i = $sust.value.iterator(); i.hasNext();)
                                                              aux=new App(aux,i.next()); 
                                                           $value=aux;
                                                          }

     | WORD '(' arguments ')' sust            {Term aux = new Const($WORD.text);
                                               for(Iterator<Var> i = $arguments.value.iterator(); i.hasNext();) 
                                                  aux=new App(aux,i.next());
                                               for(Iterator<Sust> i = $sust.value.iterator(); i.hasNext();)
                                                  aux=new App(aux,i.next()); 
                                               $value=aux;
                                              }

     | '(' eq ')' sust                        {Term aux=$eq.value;
                                                 for(Iterator<Sust> i = $sust.value.iterator(); i.hasNext();)
                                                    aux=new App(aux,i.next()); 
                                               $value=aux;
                                              };

sust returns [ArrayList<Sust> value]:

   '[' lei=LETTER ':=' led=LETTER ']' su=sust {Var letter = new Var((int)$lei.text.charAt(0));
                                            Var le = new Var((int)$led.text.charAt(0));
                                            ArrayList<Var> varlist = new ArrayList<Var>();
                                            varlist.add(0,letter);
                                            ArrayList<Term> termlist = new ArrayList<Term>();
                                            termlist.add(0,le);
                                            ArrayList<Sust> sus = $su.value;
                                            sus.add(0,new Sust(varlist,termlist));
                                            $value = sus;
                                           } 

     |                                     {$value = new ArrayList<Sust>();};

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

arguments returns [ArrayList<Var> value]: CAPITALLETTER ',' arg=arguments {ArrayList<Var> aux=$arg.value; 
                                                     Var v=new Var((new Integer((int)$CAPITALLETTER.text.charAt(0))).intValue());
                                                            aux.add(0,v); 
                                                            $value=aux;
                                                           }

                                         | CAPITALLETTER   {ArrayList<Var> list=new ArrayList<Var>();
                                                       Var v=new Var((new Integer($CAPITALLETTER.text.charAt(0))).intValue());
                                                             list.add(0,v);
                                                             $value = list;
                                                           };

lambda returns [Term value]: 'lambda' LETTER '.' eq        {Var v=new Var((new Integer($LETTER.text.charAt(0))).intValue());
                                                            $value = new Bracket(v,$eq.value);
                                                           };

INITIALDIGIT: '1'..'9';

DIGIT: '0'|INITIALDIGIT;

NUMBER: '0' | INITIALDIGIT (DIGIT)*;

CAPITALLETTER: 'A'..'Z';

LETTER: 'a'..'z';

WORD:   CAPITALLETTER (LETTER)+

      | CAPITALLETTER;

WHITESPACE: (' ' | '\r')+ {$channel = HIDDEN;};
