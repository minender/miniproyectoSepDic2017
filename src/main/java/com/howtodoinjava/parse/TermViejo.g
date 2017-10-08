grammar Term;

@header {package com.howtodoinjava.parse; 

import com.howtodoinjava.entity.Termino;
import com.howtodoinjava.entity.TerminoId;
import com.howtodoinjava.lambdacalculo.*;
import com.howtodoinjava.service.TerminoManager;
import java.util.Iterator;}


// Parser Rules
start_rule[TerminoId terminoid, TerminoManager terminoManager] returns [Term value]: eq           { $value=$eq.value;};

eq returns [Term value]: term eqtail          { Term aux=$term.value;
                                                for(Iterator<Term> i = $eqtail.value.iterator(); i.hasNext();) 
                                                   aux=new App(new App(new Const("\\equiv "),i.next()),aux);
                                                $value=aux;
                                              };

eqtail returns [ArrayList<Term> value]:    
    '===' term tail1=eqtail                    {ArrayList<Term> aux=$tail1.value; aux.add(0,$term.value); $value=aux;}

   |                                          {$value=new ArrayList<Term>();};

term returns [Term value]: disyconj disyconjtail  { Term aux=$disyconj.value; 
                                                    ArrayList<ParserPair> rightList = new ArrayList<ParserPair>();
                                                    Term aux2=null;
                                                    boolean left, right;
                                                    left = false;
                                                    right = false;
                                                    for(Iterator<ParserPair> i = $disyconjtail.value.iterator(); i.hasNext();)
                                                    {
                                                       ParserPair pair = i.next();
                                                       if (pair.symbol.equals("\\Leftarrow "))
                                                       {
                                                          if (right)
                                                          {
                                                            if (rightList.size() > 0) aux2 = rightList.remove(0).term;
                                                            for(Iterator<ParserPair> j = rightList.iterator(); j.hasNext();)
                                                            {
                                                              ParserPair pair2 = j.next();
                                                              aux2=new App(new App(new Const(pair2.symbol),aux2),pair2.term);
                                                              if (!j.hasNext())
                                                                 aux = new App(new App(new Const(pair2.symbol),aux2),aux);
                                                            }
                                                            rightList = new ArrayList<ParserPair>();
                                                          }
                                                          left = true;
                                                          right = false;
                                                          aux=new App(new App(new Const(pair.symbol),pair.term),aux); 
                                                       }
                                                       else if (pair.symbol.equals("\\Rightarrow "))
                                                       {
                                                          if (left)
                                                             rightList = new ArrayList<ParserPair>();
                                                          left = false;
                                                          right = true;
                                                          rightList.add(0,pair);
                                                       }
                                                    }
                                                    if (rightList.size() > 0) aux2 = rightList.remove(0).term;
                                                    for(Iterator<ParserPair> j = rightList.iterator(); j.hasNext();)
                                                    {
                                                       ParserPair pair2 = j.next();
                                                       aux2=new App(new App(new Const(pair2.symbol),aux2),pair2.term);
                                                       if (!j.hasNext())
                                                          aux = new App(new App(new Const(pair2.symbol),aux2),aux);
                                                    }
                                                    $value=aux;
                                                  };

disyconjtail returns [ArrayList<ParserPair> value]:  

     '==>' disyconj tail2=disyconjtail        {ArrayList<ParserPair> aux=$tail2.value; 
                                               aux.add(0,new ParserPair("\\Rightarrow ",$disyconj.value)); $value=aux;
                                              }

   | '<==' disyconj tail3=disyconjtail        {ArrayList<ParserPair> aux=$tail3.value; 
                                               aux.add(0,new ParserPair("\\Leftarrow ", $disyconj.value)); $value=aux;
                                              }

   |                                          {$value=new ArrayList<ParserPair>();};

disyconj returns [Term value]: neg negtail         { Term aux=$neg.value; 
                                                     for(Iterator<ParserPair> i = $negtail.value.iterator(); i.hasNext();)
                                                     {
                                                        ParserPair pair = i.next();
                                                        if (pair.symbol.equals("\\vee "))
                                                           aux=new App(new App(new Const(pair.symbol),pair.term),aux); 
                                                        else if (pair.symbol.equals("\\wedge "))
                                                           aux=new App(new App(new Const(pair.symbol),pair.term),aux); 
                                                     }
                                                     $value=aux;
                                                   };

negtail returns [ArrayList<ParserPair> value]:

     '\\/' neg tail4=negtail                  {ArrayList<ParserPair> aux=$tail4.value;
                                               aux.add(0,new ParserPair("\\vee ",$neg.value)); $value=aux;
                                              }

   | '/\\' neg tail5=negtail                  {ArrayList<ParserPair> aux=$tail5.value; 
                                               aux.add(0,new ParserPair("\\wedge ",$neg.value)); $value=aux;
                                              }

   |                                          {$value=new ArrayList<ParserPair>();};

neg returns [Term value]: 

      '!' n=neg                               {$value=new App(new Const("\\neg "),$n.value);}

     | '(' eq ')'                             {$value=$eq.value;}

     | X                                      {$value =new Var((new Integer($X.text.substring(1))).intValue());}

     | WORD '(' arguments ')'                 {Term aux = new Const($WORD.text+" ");
                                               for(Iterator<Term> i = $arguments.value.iterator(); i.hasNext();) 
                                                  aux=new App(aux,i.next());
                                               $value=aux;
                                              };

X:
   'X' NUMBER

  | 'x' NUMBER;

arguments returns [ArrayList<Term> value]: X ',' arg=arguments {ArrayList<Term> aux=$arg.value; 
                                                             aux.add(0,new Var((new Integer($X.text.substring(1))).intValue())); 
                                                             $value=aux;
                                                            }

                                         | X                {ArrayList<Term> list=new ArrayList<Term>();
                                                             list.add(0,new Var((new Integer($X.text.substring(1))).intValue()));
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
