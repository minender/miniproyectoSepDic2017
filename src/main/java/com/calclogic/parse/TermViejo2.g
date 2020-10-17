grammar Term;


@header{package com.howtodoinjava.parse; 

import com.howtodoinjava.entity.Predicado;
import com.howtodoinjava.entity.Simbolo;
import com.howtodoinjava.entity.PredicadoId;
import com.howtodoinjava.entity.Simbolo;
import com.howtodoinjava.lambdacalculo.*;
import com.howtodoinjava.service.PredicadoManager;
import com.howtodoinjava.service.SimboloManager;
import java.util.Iterator;}

// Parser Rules
start_rule[PredicadoId id, PredicadoManager pm, SimboloManager sm]   
                           returns [Term value]: eq[id, pm, sm]           { $value=$eq.value;};

eq[PredicadoId id, PredicadoManager pm, SimboloManager sm] 
  returns [Term value]: form[id,pm,sm] eqtail[id,pm,sm]  
                                              { Term aux=$form.value;
                                                for(Iterator<Term> i = $eqtail.value.iterator(); i.hasNext();)
                                                {
                                                   Simbolo s = sm.getSimbolo(1); 
                                                   if (s == null)
                                                      throw new IsNotInDBException(this,"");
                                                   aux=new App(new App(new Const(1,"c_{1}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),i.next()),aux);
                                                }

                                                $value=aux;
                                              };

eqtail[PredicadoId id, PredicadoManager pm, SimboloManager sm] 
        returns [ArrayList<Term> value]:    
  ('=='| '\\equiv') form[id,pm,sm] tail1=eqtail[id,pm,sm] 
                                                {ArrayList<Term> aux=$tail1.value; aux.add(0,$form.value); $value=aux;}

   |                                            {$value=new ArrayList<Term>();};

form[PredicadoId id, PredicadoManager pm, SimboloManager sm] returns [Term value]: 
    disyconj[id,pm,sm] disyconjtail[id,pm,sm]     { 
                                                    if ($disyconjtail.value == null)
                                                       $value = $disyconj.value;
                                                    else
                                                       $value = new App($disyconjtail.value,$disyconj.value);
                                                  };

disyconjtail[PredicadoId id, PredicadoManager pm, SimboloManager sm] returns [Term value]:  

   ('==>'| '\\Rightarrow') disyconj[id,pm,sm] tail2=disyconjtail[id,pm,sm]{
                                               if ($tail2.value == null)
                                               {
                                                  Simbolo s = sm.getSimbolo(2); 
                                                  if (s == null)
                                                     throw new IsNotInDBException(this,"");
                                                  $value = new App(new Const(2,"c_{2}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),$disyconj.value);
                                               }
                                               else
                                               {
                                                  Simbolo s = sm.getSimbolo(2); 
                                                  if (s == null)
                                                     throw new IsNotInDBException(this,"");
                                                  $value=new App(new Const(2,"c_{2}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),new App($tail2.value,$disyconj.value));
                                               }
                                              }

   |                                          {$value=null;};

disyconj[PredicadoId id, PredicadoManager pm, SimboloManager sm] 
returns [Term value]: conc[id,pm,sm] conctail[id,pm,sm]  
                                              { Term aux=$conc.value;
                                                for(Iterator<Term> i = $conctail.value.iterator(); i.hasNext();) 
                                                {
                                                   Simbolo s = sm.getSimbolo(3); 
                                                   if (s == null)
                                                      throw new IsNotInDBException(this,"");
                                                   aux=new App(new App(new Const(3,"c_{3}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),i.next()),aux);
                                                }
                                                $value=aux;
                                              };

conctail[PredicadoId id, PredicadoManager pm, SimboloManager sm] returns [ArrayList<Term> value]:

    ('<=='| '\\Leftarrow') conc[id,pm,sm] tail3=conctail[id,pm,sm]
                                              {ArrayList<Term> aux=$tail3.value; 
                                               aux.add(0,$conc.value); $value=aux;
                                              }

   |                                          {$value=new ArrayList<Term>();};

conc[PredicadoId id, PredicadoManager pm, SimboloManager sm] 
   returns [Term value]: neq[id,pm,sm] disytail[id,pm,sm]      
                                                   { Term aux=$neq.value; 
                                                     for(Iterator<ParserPair> i = $disytail.value.iterator(); i.hasNext();)
                                                     {
                                                        ParserPair pair = i.next();
                                                        if (pair.symbolId==4)
                                                        {
                                                           Simbolo s = sm.getSimbolo(4); 
                                                           if (s == null)
                                                              throw new IsNotInDBException(this,"");
                                                           aux=new App(new App(new Const(4,"c_{4}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),pair.term),aux); 
                                                        }
                                                        else if (pair.symbolId==5)
                                                        {
                                                           Simbolo s = sm.getSimbolo(5); 
                                                           if (s == null)
                                                              throw new IsNotInDBException(this,"");
                                                           aux=new App(new App(new Const(5,"c_{5}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),pair.term),aux); 
                                                        }
                                                     }
                                                     $value=aux;
                                                   };

disytail[PredicadoId id, PredicadoManager pm, SimboloManager sm] returns [ArrayList<ParserPair> value]:

  ('\\/'| '\\vee') neq[id,pm,sm] tail4=disytail[id,pm,sm] 
                                              {ArrayList<ParserPair> aux=$tail4.value;
                                               Simbolo s = sm.getSimbolo(4); 
                                               if (s == null)
                                                  throw new IsNotInDBException(this,"");
                                               aux.add(0,new ParserPair(s.getId(),$neq.value)); $value=aux;
                                              }

| ('/\\'| '\\wedge') neq[id,pm,sm] tail5=disytail[id,pm,sm] 
                                                {ArrayList<ParserPair> aux=$tail5.value; 
                                                 Simbolo s = sm.getSimbolo(5); 
                                                 if (s == null)
                                                    throw new IsNotInDBException(this,"");
                                                 aux.add(0,new ParserPair(s.getId(),$neq.value)); $value=aux;
                                                }

   |                                          {$value=new ArrayList<ParserPair>();};

neq[PredicadoId id, PredicadoManager pm, SimboloManager sm] 
  returns [Term value]: neg[id,pm,sm] neqtail[id,pm,sm]   
                                              { Term aux=$neg.value;
                                                for(Iterator<Term> i = $neqtail.value.iterator(); i.hasNext();) 
                                                {
                                                   Simbolo s = sm.getSimbolo(6); 
                                                   if (s == null)
                                                      throw new IsNotInDBException(this,"");
                                                   aux=new App(new App(new Const(6,"c_{6}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),i.next()),aux);
                                                }
                                                $value=aux;
                                              };

neqtail[PredicadoId id, PredicadoManager pm, SimboloManager sm] returns [ArrayList<Term> value]:

 ('!=='| '\\not\\equiv') neg[id,pm,sm] tail6=neqtail[id,pm,sm] 
                                                   {ArrayList<Term> aux=$tail6.value; 
                                                    aux.add(0,$neg.value); $value=aux;
                                                   }

   |                                          {$value=new ArrayList<Term>();};

neg[PredicadoId id, PredicadoManager pm, SimboloManager sm] returns [Term value]: 

      ('!' | '\\neg') n=neg[id,pm,sm]         {Simbolo s = sm.getSimbolo(7); if (s == null)throw new IsNotInDBException(this,""); 
                                               $value=new App(new Const(7,"c_{7}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),$n.value);}

     | CAPITALLETTER                          {$value = new Var((new Integer((int)$CAPITALLETTER.text.charAt(0))).intValue());}

     | LETTER                                 {$value = new Var((new Integer((int)$LETTER.text.charAt(0))).intValue());}

     | 'true'                                 {Simbolo s = sm.getSimbolo(8); if (s == null)throw new IsNotInDBException(this,"");
                                               $value = new Const(8,"c_{8}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad());
                                              }

     | 'false'                                {Simbolo s = sm.getSimbolo(9); if (s == null)throw new IsNotInDBException(this,"");
                                               $value = new Const(9,"c_{9}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad());}

 | CAPITALLETTER '_{' eq[id,pm,sm] '}^{' LETTER '}' 
                                              {Var letter = new Var((new Integer((int)$LETTER.text.charAt(0))).intValue());
                                               Var capl = new Var((new Integer((int)$CAPITALLETTER.text.charAt(0))).intValue());
                                               List<Var> vars = new ArrayList<Var>();
                                               List<Term> terms = new ArrayList<Term>();
                                               vars.add(0,letter);
                                               terms.add(0,$eq.value );    
                                               $value = new App(capl,new Sust(vars, terms));
                                              } 

    | t1=term[id,pm,sm] '=' t2=term[id,pm,sm] {Simbolo s = sm.getSimbolo(10); if (s == null)throw new IsNotInDBException(this,"");
                                               Term c = new Const(10,"c_{10}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad());
                                               $value = new App(new App(c,$t2.value), $t1.value);
                                              }

     | WORD '(' explist[id,pm,sm] ')'         {id.setAlias($WORD.text); 
                                               Predicado preInBD=pm.getPredicado(id);
                                               if(preInBD==null) {
                                                 throw new IsNotInDBException(this,"");
                                               } 
                                               Term aux = preInBD.getTerm();
                                               int nArg = preInBD.getArgumentos().split(",").length;
                                               if ($explist.value.size() != nArg)
                                                 throw new NoViableAltException(this);
                                               for(Iterator<Term> i = $explist.value.iterator(); i.hasNext();) 
                                                  aux=new App(aux,i.next());
                                               aux = aux.evaluar();
                                               aux.setAlias(id.getAlias());
                                               $value=aux;
                                              }

     | 'C' NUMBER '(' explist[id,pm,sm] ')'   {Simbolo s = sm.getSimbolo(Integer.parseInt($NUMBER.text)); 
                                               if (s == null)throw new IsNotInDBException(this,"");
                                               int nArg = s.getArgumentos();
                                               if ($explist.value.size() != nArg)
                                                 throw new NoViableAltException(this);
                                               Term aux = new Const(Integer.parseInt($NUMBER.text),"c_{"+$NUMBER.text+"}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad());
                                               for(Iterator<Term> i = $explist.value.iterator(); i.hasNext();)
                                                  aux=new App(aux,i.next());
                                               $value = aux;
                                              }

     | '(' eq[id,pm,sm] ')'                         {$value=$eq.value;};

term[PredicadoId id, PredicadoManager pm, SimboloManager sm] returns [Term value]: 
    sumsus[id,pm,sm] sumsustail[id,pm,sm]       { 
                                                    if ($sumsustail.value == null)
                                                       $value = $sumsus.value;
                                                    else
                                                       $value = new App($sumsustail.value,$sumsus.value);
                                                  };

sumsustail[PredicadoId id, PredicadoManager pm, SimboloManager sm] returns [Term value]:  

   '+' sumsus[id,pm,sm] tail2=sumsustail[id,pm,sm]{
                                               if ($tail2.value == null)
                                               {
                                                  Simbolo s = sm.getSimbolo(11); 
                                                  if (s == null)
                                                     throw new IsNotInDBException(this,"");
                                                  $value = new App(new Const(11,"c_{11}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),$sumsus.value);
                                               }
                                               else
                                               {
                                                  Simbolo s = sm.getSimbolo(11); 
                                                  if (s == null)
                                                     throw new IsNotInDBException(this,"");
                                                  $value=new App(new Const(11,"c_{11}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),new App($tail2.value,$sumsus.value));
                                               }
                                              }

   | '-' sumsus[id,pm,sm] tail2=sumsustail[id,pm,sm]{
                                               if ($tail2.value == null)
                                               {
                                                  Simbolo s = sm.getSimbolo(12); 
                                                  if (s == null)
                                                     throw new IsNotInDBException(this,"");
                                                  $value = new App(new Const(12,"c_{12}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),$sumsus.value);
                                               }
                                               else
                                               {
                                                  Simbolo s = sm.getSimbolo(12); 
                                                  if (s == null)
                                                     throw new IsNotInDBException(this,"");
                                                  $value=new App(new Const(12,"c_{12}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),new App($tail2.value,$sumsus.value));
                                               }
                                              }

   |                                          {$value=null;};

sumsus[PredicadoId id, PredicadoManager pm, SimboloManager sm] returns [Term value]: 
    multdiv[id,pm,sm] multdivtail[id,pm,sm]       { 
                                                    if ($multdivtail.value == null)
                                                       $value = $multdiv.value;
                                                    else
                                                       $value = new App($multdivtail.value,$multdiv.value);
                                                  };

multdivtail[PredicadoId id, PredicadoManager pm, SimboloManager sm] returns [Term value]:  

   '.' multdiv[id,pm,sm] tail2=multdivtail[id,pm,sm]{
                                               if ($tail2.value == null)
                                               {
                                                  Simbolo s = sm.getSimbolo(13); 
                                                  if (s == null)
                                                     throw new IsNotInDBException(this,"");
                                                  $value = new App(new Const(13,"c_{13}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),$multdiv.value);
                                               }
                                               else
                                               {
                                                  Simbolo s = sm.getSimbolo(13); 
                                                  if (s == null)
                                                     throw new IsNotInDBException(this,"");
                                                  $value=new App(new Const(13,"c_{13}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),new App($tail2.value,$multdiv.value));
                                               }
                                              }

   | '/' multdiv[id,pm,sm] tail2=multdivtail[id,pm,sm]{
                                               if ($tail2.value == null)
                                               {
                                                  Simbolo s = sm.getSimbolo(14); 
                                                  if (s == null)
                                                     throw new IsNotInDBException(this,"");
                                                  $value = new App(new Const(14,"c_{14}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),$multdiv.value);
                                               }
                                               else
                                               {
                                                  Simbolo s = sm.getSimbolo(14); 
                                                  if (s == null)
                                                     throw new IsNotInDBException(this,"");
                                                  $value=new App(new Const(14,"c_{14}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),new App($tail2.value,$multdiv.value));
                                               }
                                              }

   |                                          {$value=null;};

multdiv[PredicadoId id, PredicadoManager pm, SimboloManager sm] returns [Term value]: 

    cons[id,pm,sm] constail[id,pm,sm]             { 
                                                    if ($constail.value == null)
                                                       $value = $cons.value;
                                                    else
                                                       $value = new App($constail.value,$cons.value);
                                                  };

constail[PredicadoId id, PredicadoManager pm, SimboloManager sm] returns [Term value]:  

   '^{' cons[id,pm,sm] '}' tail2=constail[id,pm,sm]{
                                               if ($tail2.value == null)
                                               {
                                                  Simbolo s = sm.getSimbolo(16); 
                                                  if (s == null)
                                                     throw new IsNotInDBException(this,"");
                                                  $value = new App(new Const(16,"c_{16}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),$cons.value);
                                               }
                                               else
                                               {
                                                  Simbolo s = sm.getSimbolo(16); 
                                                  if (s == null)
                                                     throw new IsNotInDBException(this,"");
                                                  $value=new App(new Const(16,"c_{16}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),new App($tail2.value,$cons.value));
                                               }
                                              }

   |                                          {$value=null;};

cons[PredicadoId id, PredicadoManager pm, SimboloManager sm] returns [Term value]: 

      '-' n=cons[id,pm,sm]                    {Simbolo s = sm.getSimbolo(15); if (s == null)throw new IsNotInDBException(this,""); 
                                               $value=new App(new Const(15,"c_{15}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),$n.value);}

     | '0'                                    {Simbolo s = sm.getSimbolo(17); if (s == null)throw new IsNotInDBException(this,"");
                                               $value = new Const(17,"c_{17}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad());
                                              }

     | LETTER                                 {$value = new Var((int)$LETTER.text.charAt(0));}

| 'C' NUMBER '(' explist[id,pm,sm] ')'   {Simbolo s = sm.getSimbolo(Integer.parseInt($NUMBER.text)); 
                                               if (s == null)throw new IsNotInDBException(this,"");
                                               int nArg = s.getArgumentos();
                                               if ($explist.value.size() != nArg)
                                                 throw new NoViableAltException(this);
                                               Term aux = new Const(Integer.parseInt($NUMBER.text),"c_{"+$NUMBER.text+"}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad());
                                               for(Iterator<Term> i = $explist.value.iterator(); i.hasNext();)
                                                  aux=new App(aux,i.next());
                                               $value = aux;
                                              }

     | 'sin' '(' term[id,pm,sm] ')'           {Simbolo s = sm.getSimbolo(19); 
                                               if (s == null)throw new IsNotInDBException(this,"");
                                               Term aux = new Const(19,"c_{19}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad());
                                               aux=new App(aux,$term.value);
                                               $value = aux;
                                              }

     | 'cos' '(' term[id,pm,sm] ')'           {Simbolo s = sm.getSimbolo(20); 
                                               if (s == null)throw new IsNotInDBException(this,"");
                                               Term aux = new Const(20,"c_{20}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad());
                                               aux=new App(aux,$term.value);
                                               $value = aux;
                                              }

     | '(' term[id,pm,sm] ')'                 {$value=$term.value;};

instantiate[PredicadoId id, PredicadoManager pm, SimboloManager sm] 
     returns [ArrayList<Object> value]: 

     arguments ':=' explist[id,pm,sm]         {ArrayList<Object> arr=new ArrayList<Object>();
                                               arr.add($arguments.value);
                                               arr.add($explist.value);
                                               $value = arr;
                                              };

explist[PredicadoId id, PredicadoManager pm, SimboloManager sm] returns [ArrayList<Term> value]: 

     eq[id,pm,sm]  explisttail[id,pm,sm]      {ArrayList<Term> aux = $explisttail.value;
                                               aux.add(0,$eq.value);
                                               $value = aux;
                                              }

   | term[id,pm,sm]  termtail[id,pm,sm]       {ArrayList<Term> aux = $termtail.value;
                                               aux.add(0,$term.value);
                                               $value = aux;
                                              };

explisttail[PredicadoId id, PredicadoManager pm, SimboloManager sm] returns [ArrayList<Term> value]: 

     ',' eq[id,pm,sm] tail7=explisttail[id,pm,sm]         
                                              {ArrayList<Term> aux = $tail7.value;
                                               aux.add(0,$eq.value);
                                               $value =aux;
                                              }

     |                                        {$value = new ArrayList<Term>();};

termtail[PredicadoId id, PredicadoManager pm, SimboloManager sm] returns [ArrayList<Term> value]: 

     ',' term[id,pm,sm] tail7=termtail[id,pm,sm]         
                                              {ArrayList<Term> aux = $tail7.value;
                                               aux.add(0,$term.value);
                                               $value =aux;
                                              }

     |                                        {$value = new ArrayList<Term>();};

arguments returns [ArrayList<Var> value]: 
                                           LETTER ',' arg=arguments 
                                                           {ArrayList<Var> aux=$arg.value; 
                                                            Var v=new Var((new Integer((int)$LETTER.text.charAt(0))).intValue());
                                                            aux.add(0,v); 
                                                            $value=aux;
                                                           }

                                         | CAPITALLETTER ',' arg=arguments
                                                    {ArrayList<Var> aux=$arg.value; 
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

lambda[PredicadoId id, PredicadoManager pm, SimboloManager sm] returns [Term value]: 
                        'lambda' LETTER '.' eq[id,pm,sm]   {Var v=new Var((new Integer($LETTER.text.charAt(0))).intValue());
                                                            $value = new Bracket(v,$eq.value);
                                                           }

                      | 'lambda' LETTER '.' term[id,pm,sm] {Var v=new Var((new Integer($LETTER.text.charAt(0))).intValue());
                                                            $value = new Bracket(v,$term.value);
                                                           };

CAPITALLETTER: 'A'..'Z';

LETTER: 'a'..'z';

NUMBER: [0-9]+;

WORD:   CAPITALLETTER (LETTER)+

      | CAPITALLETTER;

WHITESPACE: (' ' | '\r')+ -> channel(HIDDEN);
