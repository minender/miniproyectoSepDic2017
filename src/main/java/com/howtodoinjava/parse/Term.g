grammar Term;


@header{package com.howtodoinjava.parse; 

import com.howtodoinjava.entity.Termino;
import com.howtodoinjava.entity.TerminoId;
import com.howtodoinjava.entity.Simbolo;
import com.howtodoinjava.lambdacalculo.*;
import com.howtodoinjava.service.TerminoManager;
import com.howtodoinjava.service.SimboloManager;
import java.util.Iterator;}

// Parser Rules
start_rule[TerminoId terminoid, TerminoManager terminoManager, SimboloManager sm]   
                           returns [Term value]: eq[sm]           { $value=$eq.value;};

eq[SimboloManager sm] 
     returns [Term value]: term[sm] eqtail[sm]  { Term aux=$term.value;
                                                for(Iterator<Term> i = $eqtail.value.iterator(); i.hasNext();)
                                                {
                                                   Simbolo s = sm.getSimbolo(1); 
                                                   if (s == null)
                                                      throw new IsNotInDBException(this,"");
                                                   aux=new App(new App(new Const(1,s.getNotacion_latex(),!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),i.next()),aux);
                                                }

                                                $value=aux;
                                              };

eqtail[SimboloManager sm] 
        returns [ArrayList<Term> value]:    
    ('=='| '\\equiv') term[sm] tail1=eqtail[sm] {ArrayList<Term> aux=$tail1.value; aux.add(0,$term.value); $value=aux;}

   |                                            {$value=new ArrayList<Term>();};

term[SimboloManager sm] returns [Term value]: 
    disyconj[sm] disyconjtail[sm]                 { 
                                                    if ($disyconjtail.value == null)
                                                       $value = $disyconj.value;
                                                    else
                                                       $value = new App($disyconjtail.value,$disyconj.value);
                                                  };

disyconjtail[SimboloManager sm] returns [Term value]:  

   ('==>'| '\\Rightarrow') disyconj[sm] tail2=disyconjtail[sm]{
                                               if ($tail2.value == null)
                                               {
                                                  Simbolo s = sm.getSimbolo(2); 
                                                  if (s == null)
                                                     throw new IsNotInDBException(this,"");
                                                  $value = new App(new Const(2,s.getNotacion_latex(),!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),$disyconj.value);
                                               }
                                               else
                                               {
                                                  Simbolo s = sm.getSimbolo(2); 
                                                  if (s == null)
                                                     throw new IsNotInDBException(this,"");
                                                  $value=new App(new Const(2,s.getNotacion_latex(),!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),new App($tail2.value,$disyconj.value));
                                               }
                                              }

   |                                          {$value=null;};

disyconj[SimboloManager sm] 
returns [Term value]: conc[sm] conctail[sm]  { Term aux=$conc.value;
                                                for(Iterator<Term> i = $conctail.value.iterator(); i.hasNext();) 
                                                {
                                                   Simbolo s = sm.getSimbolo(3); 
                                                   if (s == null)
                                                      throw new IsNotInDBException(this,"");
                                                   aux=new App(new App(new Const(3,s.getNotacion_latex(),!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),i.next()),aux);
                                                }
                                                $value=aux;
                                              };

conctail[SimboloManager sm] returns [ArrayList<Term> value]:

    ('<=='| '\\Leftarrow') conc[sm] tail3=conctail[sm]
                                              {ArrayList<Term> aux=$tail3.value; 
                                               aux.add(0,$conc.value); $value=aux;
                                              }

   |                                          {$value=new ArrayList<Term>();};

conc[SimboloManager sm] 
   returns [Term value]: neq[sm] disytail[sm]      { Term aux=$neq.value; 
                                                     for(Iterator<ParserPair> i = $disytail.value.iterator(); i.hasNext();)
                                                     {
                                                        ParserPair pair = i.next();
                                                        if (pair.symbol.equals("\\vee "))
                                                        {
                                                           Simbolo s = sm.getSimbolo(4); 
                                                           if (s == null)
                                                              throw new IsNotInDBException(this,"");
                                                           aux=new App(new App(new Const(4,pair.symbol,!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),pair.term),aux); 
                                                        }
                                                        else if (pair.symbol.equals("\\wedge "))
                                                        {
                                                           Simbolo s = sm.getSimbolo(5); 
                                                           if (s == null)
                                                              throw new IsNotInDBException(this,"");
                                                           aux=new App(new App(new Const(5,pair.symbol,!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),pair.term),aux); 
                                                        }
                                                     }
                                                     $value=aux;
                                                   };

disytail[SimboloManager sm] returns [ArrayList<ParserPair> value]:

  ('\\/'| '\\vee') neq[sm] tail4=disytail[sm] {ArrayList<ParserPair> aux=$tail4.value;
                                               Simbolo s = sm.getSimbolo(4); 
                                               if (s == null)
                                                  throw new IsNotInDBException(this,"");
                                               aux.add(0,new ParserPair(s.getNotacion_latex(),$neq.value)); $value=aux;
                                              }

| ('/\\'| '\\wedge') neq[sm] tail5=disytail[sm] {ArrayList<ParserPair> aux=$tail5.value; 
                                                 Simbolo s = sm.getSimbolo(5); 
                                                 if (s == null)
                                                    throw new IsNotInDBException(this,"");
                                                 aux.add(0,new ParserPair(s.getNotacion_latex(),$neq.value)); $value=aux;
                                                }

   |                                          {$value=new ArrayList<ParserPair>();};

neq[SimboloManager sm] 
  returns [Term value]: neg[sm] neqtail[sm]   { Term aux=$neg.value;
                                                for(Iterator<Term> i = $neqtail.value.iterator(); i.hasNext();) 
                                                {
                                                   Simbolo s = sm.getSimbolo(6); 
                                                   if (s == null)
                                                      throw new IsNotInDBException(this,"");
                                                   aux=new App(new App(new Const(6,s.getNotacion_latex(),!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),i.next()),aux);
                                                }
                                                $value=aux;
                                              };

neqtail[SimboloManager sm] returns [ArrayList<Term> value]:

 ('!=='| '\\not\\equiv') neg[sm] tail6=neqtail[sm] {ArrayList<Term> aux=$tail6.value; 
                                                    aux.add(0,$neg.value); $value=aux;
                                                   }

   |                                          {$value=new ArrayList<Term>();};

neg[SimboloManager sm] returns [Term value]: 

      ('!' | '\\neg') n=neg[sm]               {Simbolo s = sm.getSimbolo(7); if (s == null)throw new IsNotInDBException(this,""); 
                                               $value=new App(new Const(7,s.getNotacion_latex(),!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),$n.value);}

     | CAPITALLETTER                          {$value = new Var((new Integer((int)$CAPITALLETTER.text.charAt(0))).intValue());}

     | LETTER                                 {$value = new Var((new Integer((int)$LETTER.text.charAt(0))).intValue());}

     | 'true'                                 {Simbolo s = sm.getSimbolo(8); if (s == null)throw new IsNotInDBException(this,"");
                                               $value = new Const(8,s.getNotacion_latex(),!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad());
                                              }

     | 'false'                                {Simbolo s = sm.getSimbolo(9); if (s == null)throw new IsNotInDBException(this,"");
                                               $value = new Const(9,s.getNotacion_latex(),!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad());}

 | CAPITALLETTER '_{' eq[sm] '}^{' LETTER '}' {Var letter = new Var((new Integer((int)$LETTER.text.charAt(0))).intValue());
                                               Var capl = new Var((new Integer((int)$CAPITALLETTER.text.charAt(0))).intValue());
                                               List<Var> vars = new ArrayList<Var>();
                                               List<Term> terms = new ArrayList<Term>();
                                               vars.add(0,letter);
                                               terms.add(0,$eq.value );    
                                               $value = new App(capl,new Sust(vars, terms));
                                              } 

     | WORD '(' arguments ')'                 {Term aux = new Const(-1,$WORD.text,true,-1,-1);
                                               for(Iterator<Var> i = $arguments.value.iterator(); i.hasNext();) 
                                                  aux=new App(aux,i.next());
                                               $value=aux;
                                              }

     | '(' eq[sm] ')'                         {$value=$eq.value;};

instantiate[TerminoId terminoid, TerminoManager terminoManager, SimboloManager sm] 
     returns [ArrayList<Object> value]: 

     arguments ':=' explist[sm]               {ArrayList<Object> arr=new ArrayList<Object>();
                                               arr.add($arguments.value);
                                               arr.add($explist.value);
                                               $value = arr;
                                              };

explist[SimboloManager sm] returns [ArrayList<Term> value]: 

     eq[sm]  explisttail[sm]                  {ArrayList<Term> aux = $explisttail.value;
                                               aux.add(0,$eq.value);
                                               $value = aux;
                                              };

explisttail[SimboloManager sm] returns [ArrayList<Term> value]: 

     ',' eq[sm] tail7=explisttail[sm]         {ArrayList<Term> aux = $tail7.value;
                                               aux.add(0,$eq.value);
                                               $value =aux;
                                              }

     |                                        {$value = new ArrayList<Term>();};

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

lambda[TerminoId terminoid, TerminoManager terminoManager, SimboloManager sm] returns [Term value]: 
                             'lambda' LETTER '.' eq[sm]    {Var v=new Var((new Integer($LETTER.text.charAt(0))).intValue());
                                                            $value = new Bracket(v,$eq.value);
                                                           };

CAPITALLETTER: 'A'..'Z';

LETTER: 'a'..'z';

WORD:   CAPITALLETTER (LETTER)+

      | CAPITALLETTER;

WHITESPACE: (' ' | '\r')+ -> channel(HIDDEN);
