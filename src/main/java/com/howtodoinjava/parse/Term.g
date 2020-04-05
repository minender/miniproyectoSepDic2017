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
  returns [Term value]: term[id,pm,sm] eqtail[id,pm,sm]  
                                              { Term aux=$term.value;
                                                for(Iterator<Term> i = $eqtail.value.iterator(); i.hasNext();)
                                                {
                                                   Simbolo s = sm.getSimbolo(1); 
                                                   if (s == null)
                                                      throw new IsNotInDBException(this,"");
                                                   aux=new App(new App(new Const(1,s.getNotacion_latex(),!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),i.next()),aux);
                                                }

                                                $value=aux;
                                              };

eqtail[PredicadoId id, PredicadoManager pm, SimboloManager sm] 
        returns [ArrayList<Term> value]:    
  ('=='| '\\equiv') term[id,pm,sm] tail1=eqtail[id,pm,sm] 
                                                {ArrayList<Term> aux=$tail1.value; aux.add(0,$term.value); $value=aux;}

   |                                            {$value=new ArrayList<Term>();};

term[PredicadoId id, PredicadoManager pm, SimboloManager sm] returns [Term value]: 
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

disyconj[PredicadoId id, PredicadoManager pm, SimboloManager sm] 
returns [Term value]: conc[id,pm,sm] conctail[id,pm,sm]  
                                              { Term aux=$conc.value;
                                                for(Iterator<Term> i = $conctail.value.iterator(); i.hasNext();) 
                                                {
                                                   Simbolo s = sm.getSimbolo(3); 
                                                   if (s == null)
                                                      throw new IsNotInDBException(this,"");
                                                   aux=new App(new App(new Const(3,s.getNotacion_latex(),!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),i.next()),aux);
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
                                                           aux=new App(new App(new Const(4,s.getNotacion_latex(),!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),pair.term),aux); 
                                                        }
                                                        else if (pair.symbolId==5)
                                                        {
                                                           Simbolo s = sm.getSimbolo(5); 
                                                           if (s == null)
                                                              throw new IsNotInDBException(this,"");
                                                           aux=new App(new App(new Const(5,s.getNotacion_latex(),!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),pair.term),aux); 
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
                                                   aux=new App(new App(new Const(6,s.getNotacion_latex(),!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),i.next()),aux);
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
                                               $value=new App(new Const(7,s.getNotacion_latex(),!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),$n.value);}

     | CAPITALLETTER                          {$value = new Var((new Integer((int)$CAPITALLETTER.text.charAt(0))).intValue());}

     | LETTER                                 {$value = new Var((new Integer((int)$LETTER.text.charAt(0))).intValue());}

     | 'true'                                 {Simbolo s = sm.getSimbolo(8); if (s == null)throw new IsNotInDBException(this,"");
                                               $value = new Const(8,s.getNotacion_latex(),!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad());
                                              }

     | 'false'                                {Simbolo s = sm.getSimbolo(9); if (s == null)throw new IsNotInDBException(this,"");
                                               $value = new Const(9,s.getNotacion_latex(),!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad());}

 | CAPITALLETTER '_{' eq[id,pm,sm] '}^{' LETTER '}' 
                                              {Var letter = new Var((new Integer((int)$LETTER.text.charAt(0))).intValue());
                                               Var capl = new Var((new Integer((int)$CAPITALLETTER.text.charAt(0))).intValue());
                                               List<Var> vars = new ArrayList<Var>();
                                               List<Term> terms = new ArrayList<Term>();
                                               vars.add(0,letter);
                                               terms.add(0,$eq.value );    
                                               $value = new App(capl,new Sust(vars, terms));
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

     | '(' eq[id,pm,sm] ')'                         {$value=$eq.value;};

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
                                              };

explisttail[PredicadoId id, PredicadoManager pm, SimboloManager sm] returns [ArrayList<Term> value]: 

     ',' eq[id,pm,sm] tail7=explisttail[id,pm,sm]         
                                              {ArrayList<Term> aux = $tail7.value;
                                               aux.add(0,$eq.value);
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
                         'lambda' LETTER '.' eq[id,pm,sm]  {Var v=new Var((new Integer($LETTER.text.charAt(0))).intValue());
                                                            $value = new Bracket(v,$eq.value);
                                                           };

CAPITALLETTER: 'A'..'Z';

LETTER: 'a'..'z';

WORD:   CAPITALLETTER (LETTER)+

      | CAPITALLETTER;

WHITESPACE: (' ' | '\r')+ -> channel(HIDDEN);
