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
start_rule[PredicadoId id, PredicadoManager pm, SimboloManager sm, String[] st]   
                           returns [Term value]: eq[id, pm, sm, st]           { $value=$eq.value;};

eq[PredicadoId id, PredicadoManager pm, SimboloManager sm, String[] st] returns [Term value]: 

       'C' NUMBER '(' explist[id,pm,sm,st] ')'   {Term aux;
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
                                                    int len = unboundVars.size();
                                                    j = 1;
                                                    for (Term base_term: unboundVars) {
                                                        Term t = base_term;
                                                        if (len<=2 || (j == 1 && !(t instanceof Var))
                                                            || j != 1
                                                           )
                                                        {
                                                          if (Integer.parseInt($NUMBER.text) == 62 && 
                                                              j == 1 &&
                                                              t instanceof App &&
                                                              ((App)t).q instanceof Var &&
                                                              ((App)((App)t).p).q instanceof Var
                                                             )
                                                          {
                                                              t = new Bracket((Var)((App)((App)t).p).q,new Bracket((Var)((App)t).q,t));
                                                          }
                                                          else {
                                                          for (Term var: boundVars) {
                                                            if (st[0].equals(""))
                                                                st[0] = "" + ((char) ((Var) var).indice);
                                                            else
                                                                st[0] = ((char) ((Var) var).indice) + "," + st[0];
                                                            t = new Bracket((Var) var, t);
                                                          }
                                                          }
                                                        }
                                                        abstractedTerms.add(t);
                                                        j = j+1;
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

     | WORD '(' explist[id,pm,sm,st] ')'         {id.setAlias($WORD.text); 
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

     | 'C'                                    {$value = new Var((new Integer((int)'C')).intValue());}

     | CAPITALLETTER                          {$value = new Var((new Integer((int)$CAPITALLETTER.text.charAt(0))).intValue());}

     | LETTER                                 {$value = new Var((new Integer((int)$LETTER.text.charAt(0))).intValue());};


explist[PredicadoId id, PredicadoManager pm, SimboloManager sm, String[] st] returns [ArrayList<Term> value]: 

     eq[id,pm,sm,st] explisttail[id,pm,sm,st]       {ArrayList<Term> aux = $explisttail.value;
                                               aux.add(0,$eq.value);
                                               $value = aux;
                                              }

     |                                        {$value = new ArrayList<Term>();};


explisttail[PredicadoId id, PredicadoManager pm, SimboloManager sm, String[] st] returns [ArrayList<Term> value]: 

     ',' eq[id,pm,sm,st] tail7=explisttail[id,pm,sm,st]         
                                              {ArrayList<Term> aux = $tail7.value;
                                               aux.add(0,$eq.value);
                                               $value =aux;
                                              }

     |                                        {$value = new ArrayList<Term>();};


lambda[PredicadoId id, PredicadoManager pm, SimboloManager sm, String[] st] returns [Term value]: 

                        'lambda' LETTER '.' eq[id,pm,sm,st]   {Var v=new Var((new Integer($LETTER.text.charAt(0))).intValue());
                                                            $value = new Bracket(v,$eq.value);
                                                           };


instantiate[PredicadoId id, PredicadoManager pm, SimboloManager sm, String[] st] 
     returns [ArrayList<Object> value]: 

     arguments ':=' explist[id,pm,sm,st]         {ArrayList<Object> arr=new ArrayList<Object>();
                                                  ArrayList<Var> args=new ArrayList<Var>();
                                                  ArrayList<Term> arguments = $arguments.value;
                                                  ArrayList<Term> explist = $explist.value;
                                               if (arguments.size() != explist.size())
                                                 throw new NoViableAltException(this);
                                               for (int i=0; i<arguments.size(); i++){
                                                 if (arguments.get(i) instanceof Var)
                                                    args.add((Var)arguments.get(i));
                                                 else{
                                                    Term t = explist.get(i);
                                                    Term aux = arguments.get(i);
                                                    while (aux instanceof App) {
                                                       t = new Bracket((Var)((App)aux).q,t);
                                                       aux = ((App)aux).p;
                                                    }
                                                    args.add((Var)aux);
                                                    explist.set(i,t);
                                                 }
                                               }
                                               arr.add(args);
                                               arr.add(explist);
                                               $value = arr;
                                              };

arguments returns [ArrayList<Term> value]: 
       
     L=(LETTER|CAPITALLETTER) argtail           {ArrayList<Term> list=$argtail.value;
                                                 Var v=new Var((int)$L.text.charAt(0));
                                                 Term first;
                                                 if (!list.isEmpty() && (first=list.get(0)) instanceof App) {
                                                   Term aux = first;
                                                   while ( ((App)aux).p instanceof App) {
                                                      aux = ((App)aux).p;
                                                   }
                                                   if (((App)aux).p instanceof Const)
                                                      ((App)aux).p = v;
                                                   else
                                                      list.add(0,v);
                                                 }
                                                 else
                                                   list.add(0,v);
                                                 $value=list;
                                                };
argtail returns [ArrayList<Term> value]:
                                          
       ',' arguments                            {$value=$arguments.value;} 

    | '(' arg1=arguments ')' ',' arg=arguments  {ArrayList<Term> list=$arg1.value;
                                                 Term aux = new Const("0");
                                                 for (int i=0; i< list.size(); i++)
                                                     aux = new App(aux,list.get(i));
                                                 ArrayList<Term> list2=$arg.value;
                                                 if (list2 != null) 
                                                  list2.add(0,aux);  
                                                 $value = list2;
                                                }

    | '(' arguments ')'                         {ArrayList<Term> list=$arguments.value;
                                                 Term aux = new Const("0");
                                                 for (int i=0; i< list.size(); i++)
                                                     aux = new App(aux,list.get(i));
                                                 ArrayList<Term> list2 = new ArrayList<Term>();
                                                 list2.add(0,aux);
                                                 $value = list2;
                                                }

    |                                           {$value = new ArrayList<Term>();};                               


CAPITALLETTER: 'A'..'Z';

LETTER: 'a'..'z';

NUMBER: [0-9]+;

WORD:   CAPITALLETTER (LETTER)+

      | CAPITALLETTER;

WHITESPACE: ' '+ -> channel(HIDDEN);
