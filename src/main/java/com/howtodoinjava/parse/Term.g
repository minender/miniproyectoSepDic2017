grammar Term;


@header{package com.howtodoinjava.parse; 

import com.howtodoinjava.entity.Termino;
import com.howtodoinjava.entity.TerminoId;
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
                                                   aux=new App(new App(new Const("\\equiv ",false,1,1),i.next()),aux);
                                                if (((Const)((App)((App)aux).p).p).getCon().equals("hola"))
                                                   throw new IsNotInDBException(this,"");
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
                                                  $value = new App(new Const("\\Rightarrow ",false,2,2),$disyconj.value);
                                               else
                                               $value=new App(new Const("\\Rightarrow ",false,2,2),new App($tail2.value,$disyconj.value));
                                              }

   |                                          {$value=null;};

disyconj[SimboloManager sm] 
returns [Term value]: conc[sm] conctail[sm]  { Term aux=$conc.value;
                                                for(Iterator<Term> i = $conctail.value.iterator(); i.hasNext();) 
                                                   aux=new App(new App(new Const("\\Leftarrow ",false,2,1),i.next()),aux);
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
                                                           aux=new App(new App(new Const(pair.symbol,false,3,1),pair.term),aux); 
                                                        else if (pair.symbol.equals("\\wedge "))
                                                           aux=new App(new App(new Const(pair.symbol,false,3,1),pair.term),aux); 
                                                     }
                                                     $value=aux;
                                                   };

disytail[SimboloManager sm] returns [ArrayList<ParserPair> value]:

  ('\\/'| '\\vee') neq[sm] tail4=disytail[sm] {ArrayList<ParserPair> aux=$tail4.value;
                                               aux.add(0,new ParserPair("\\vee ",$neq.value)); $value=aux;
                                              }

| ('/\\'| '\\wedge') neq[sm] tail5=disytail[sm] {ArrayList<ParserPair> aux=$tail5.value; 
                                                 aux.add(0,new ParserPair("\\wedge ",$neq.value)); $value=aux;
                                                }

   |                                          {$value=new ArrayList<ParserPair>();};

neq[SimboloManager sm] 
  returns [Term value]: neg[sm] neqtail[sm]   { Term aux=$neg.value;
                                                for(Iterator<Term> i = $neqtail.value.iterator(); i.hasNext();) 
                                                   aux=new App(new App(new Const("\\not\\equiv ",false,4,1),i.next()),aux);
                                                $value=aux;
                                              };

neqtail[SimboloManager sm] returns [ArrayList<Term> value]:

 ('!=='| '\\not\\equiv') neg[sm] tail6=neqtail[sm] {ArrayList<Term> aux=$tail6.value; 
                                                    aux.add(0,$neg.value); $value=aux;
                                                   }

   |                                          {$value=new ArrayList<Term>();};

neg[SimboloManager sm] returns [Term value]: 

      ('!' | '\\neg') n=neg[sm]               {$value=new App(new Const("\\neg ",false,5,2),$n.value);}

     | CAPITALLETTER                          {$value = new Var((new Integer((int)$CAPITALLETTER.text.charAt(0))).intValue());}

     | LETTER                                 {$value = new Var((new Integer((int)$LETTER.text.charAt(0))).intValue());}

     | 'true'                                 {$value = new Const("true ");}

     | 'false'                                {$value = new Const("false ");}

 | CAPITALLETTER '_{' eq[sm] '}^{' LETTER '}' {Var letter = new Var((new Integer((int)$LETTER.text.charAt(0))).intValue());
                                               Var capl = new Var((new Integer((int)$CAPITALLETTER.text.charAt(0))).intValue());
                                               List<Var> vars = new ArrayList<Var>();
                                               List<Term> terms = new ArrayList<Term>();
                                               vars.add(0,letter);
                                               terms.add(0,$eq.value );    
                                               $value = new App(capl,new Sust(vars, terms));
                                              } 

     | WORD '(' arguments ')'                 {Term aux = new Const($WORD.text,true,-1,-1);
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
