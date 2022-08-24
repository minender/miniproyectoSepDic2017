grammar Term;


@header{package com.calclogic.parse; 

import com.calclogic.entity.Predicado;
import com.calclogic.entity.Simbolo;
import com.calclogic.entity.PredicadoId;
import com.calclogic.entity.Simbolo;
import com.calclogic.lambdacalculo.*;
import com.calclogic.service.PredicadoManager;
import com.calclogic.service.SimboloManager;
import org.antlr.v4.runtime.misc.Pair;
import java.util.Collections;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;}

// Parser Rules
start_rule[PredicadoId id, PredicadoManager pm, SimboloManager sm]   
                           returns [Term value]: eq[id, pm, sm]           { $value=$eq.value;};

eq[PredicadoId id, PredicadoManager pm, SimboloManager sm] returns [Term value]: 

       'C' NUMBER '(' explist[id,pm,sm] ')'   {Term aux;
                                               if (Integer.parseInt($NUMBER.text) == sm.getPropFunApp() 
                                                   || Integer.parseInt($NUMBER.text) == sm.getTermFunApp()
                                                  ) {
                                                Iterator<Term> i = $explist.value.iterator();
                                                aux = i.next();
                                                for(i = i; i.hasNext();)
                                                   aux=new App(aux,i.next());
                                               }
                                               else {
                                                Simbolo s = sm.getSimbolo(Integer.parseInt($NUMBER.text)); 
                                                if (s == null)throw new IsNotInDBException(this,"");
                                                int nArg = s.getArgumentos();
                                                if (s.isQuantifier()) {
                                                    ArrayList<Term> boundVars = new ArrayList<Term>();
                                                    ArrayList<Term> unboundVars = new ArrayList<Term>();
                                                    int j = 1;
                                                    for(Iterator<Term> i = $explist.value.iterator(); i.hasNext();) {
                                                        if (j > nArg) {
                                                            boundVars.add(i.next());
                                                        }
                                                        else {
                                                            unboundVars.add(i.next());
                                                        }
                                                        j++;
                                                    }
                                                    Collections.reverse(boundVars);
                                                    ArrayList<Term> abstractedTerms = new ArrayList<Term>();
                                                    for (Term base_term: unboundVars) {
                                                        Term t = base_term;
                                                        for (Term var: boundVars) {
                                                            t = new Bracket((Var) var, t);
                                                        }
                                                        abstractedTerms.add(t);
                                                    }
                                                    aux = new Const(Integer.parseInt($NUMBER.text),"c_{"+$NUMBER.text+"}",
                                                                     !s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad());
                                                    for (Term t: abstractedTerms) {
                                                        aux = new App(aux, t);
                                                    }
                                                }
                                                else {
                                                    if ($explist.value.size() != nArg)
                                                      throw new NoViableAltException(this);
                                                    aux = new Const(Integer.parseInt($NUMBER.text),"c_{"+$NUMBER.text+"}",
                                                                         !s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad());
                                                    for(Iterator<Term> i = $explist.value.iterator(); i.hasNext();)
                                                       aux=new App(aux,i.next());
                                                }
                                               }
                                               $value = aux;
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

     | CAPITALLETTER                          {$value = new Var((new Integer((int)$CAPITALLETTER.text.charAt(0))).intValue());}

     | LETTER                                 {$value = new Var((new Integer((int)$LETTER.text.charAt(0))).intValue());};


explist[PredicadoId id, PredicadoManager pm, SimboloManager sm] returns [ArrayList<Term> value]: 

     eq[id,pm,sm] explisttail[id,pm,sm]       {ArrayList<Term> aux = $explisttail.value;
                                               aux.add(0,$eq.value);
                                               $value = aux;
                                              }

     |                                        {$value = new ArrayList<Term>();};


explisttail[PredicadoId id, PredicadoManager pm, SimboloManager sm] returns [ArrayList<Term> value]: 

     ',' eq[id,pm,sm] tail7=explisttail[id,pm,sm]         
                                              {ArrayList<Term> aux = $tail7.value;
                                               aux.add(0,$eq.value);
                                               $value =aux;
                                              }

     |                                        {$value = new ArrayList<Term>();};


lambda[PredicadoId id, PredicadoManager pm, SimboloManager sm] returns [Term value]: 

                        'lambda' LETTER '.' eq[id,pm,sm]   {Var v=new Var((new Integer($LETTER.text.charAt(0))).intValue());
                                                            $value = new Bracket(v,$eq.value);
                                                           };


instantiate[PredicadoId id, PredicadoManager pm, SimboloManager sm] 
     returns [ArrayList<Object> value]: 

     arguments ':=' explist[id,pm,sm]         {ArrayList<Object> arr=new ArrayList<Object>();
                                               if ($arguments.value.size() != $explist.value.size())
                                                 throw new NoViableAltException(this);
                                               arr.add($arguments.value);
                                               arr.add($explist.value);
                                               $value = arr;
                                              };


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


CAPITALLETTER: 'A'..'Z';

LETTER: 'a'..'z';

NUMBER: [0-9]+;

WORD:   CAPITALLETTER (LETTER)+

      | CAPITALLETTER;

WHITESPACE: (' ' | '\r')+ -> channel(HIDDEN);
