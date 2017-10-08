// $ANTLR 3.2 Sep 23, 2009 12:02:23 FOScheme.g 2017-03-31 17:37:48
package com.howtodoinjava.parse; 

import com.howtodoinjava.service.TerminoManager;
import com.howtodoinjava.entity.Termino;
import com.howtodoinjava.entity.TerminoId;
import com.howtodoinjava.entity.Predicado;
import com.howtodoinjava.entity.PredicadoId;
import com.howtodoinjava.lambdacalculo.*;
import com.howtodoinjava.service.PredicadoManager;
import java.util.Iterator;

import org.antlr.runtime.*;
import java.util.Stack;
import java.util.List;
import java.util.ArrayList;

public class FOSchemeParser extends Parser {
    public static final String[] tokenNames = new String[] {
        "<invalid>", "<EOR>", "<DOWN>", "<UP>", "CAPITALLETTER", "LETTER", "WORD", "INITIALDIGIT", "DIGIT", "NUMBER", "WHITESPACE", "'=='", "'\\\\equiv'", "'==>'", "'\\\\Rightarrow'", "'<=='", "'\\\\Leftarrow'", "'\\\\/'", "'\\\\vee'", "'/\\\\'", "'\\\\wedge'", "'!=='", "'\\\\nequiv'", "'!'", "'\\\\neg'", "'true'", "'false'", "'('", "'forall'", "'|'", "':'", "')'", "'exists'", "'['", "':='", "']'", "','", "'lambda'", "'.'"
    };
    public static final int T__29=29;
    public static final int T__28=28;
    public static final int T__27=27;
    public static final int T__26=26;
    public static final int T__25=25;
    public static final int T__24=24;
    public static final int LETTER=5;
    public static final int T__23=23;
    public static final int T__22=22;
    public static final int T__21=21;
    public static final int T__20=20;
    public static final int NUMBER=9;
    public static final int CAPITALLETTER=4;
    public static final int INITIALDIGIT=7;
    public static final int WHITESPACE=10;
    public static final int EOF=-1;
    public static final int WORD=6;
    public static final int T__30=30;
    public static final int T__19=19;
    public static final int T__31=31;
    public static final int T__32=32;
    public static final int T__33=33;
    public static final int T__16=16;
    public static final int T__34=34;
    public static final int T__15=15;
    public static final int T__35=35;
    public static final int T__18=18;
    public static final int T__36=36;
    public static final int T__17=17;
    public static final int T__37=37;
    public static final int T__12=12;
    public static final int T__38=38;
    public static final int T__11=11;
    public static final int T__14=14;
    public static final int T__13=13;
    public static final int DIGIT=8;

    // delegates
    // delegators


        public FOSchemeParser(TokenStream input) {
            this(input, new RecognizerSharedState());
        }
        public FOSchemeParser(TokenStream input, RecognizerSharedState state) {
            super(input, state);
             
        }
        

    public String[] getTokenNames() { return FOSchemeParser.tokenNames; }
    public String getGrammarFileName() { return "FOScheme.g"; }



    // $ANTLR start "start_rule"
    // FOScheme.g:15:1: start_rule[TerminoId terminoid, TerminoManager terminoManager] returns [Term value] : eq ;
    public final Term start_rule(TerminoId terminoid, TerminoManager terminoManager) throws RecognitionException {
        Term value = null;

        Term eq1 = null;


        try {
            // FOScheme.g:15:85: ( eq )
            // FOScheme.g:15:87: eq
            {
            pushFollow(FOLLOW_eq_in_start_rule21);
            eq1=eq();

            state._fsp--;

             value =eq1;

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return value;
    }
    // $ANTLR end "start_rule"


    // $ANTLR start "eq"
    // FOScheme.g:17:1: eq returns [Term value] : term eqtail ;
    public final Term eq() throws RecognitionException {
        Term value = null;

        Term term2 = null;

        ArrayList<Term> eqtail3 = null;


        try {
            // FOScheme.g:17:24: ( term eqtail )
            // FOScheme.g:17:26: term eqtail
            {
            pushFollow(FOLLOW_term_in_eq44);
            term2=term();

            state._fsp--;

            pushFollow(FOLLOW_eqtail_in_eq46);
            eqtail3=eqtail();

            state._fsp--;

             Term aux=term2;
                                                            for(Iterator<Term> i = eqtail3.iterator(); i.hasNext();) 
                                                               aux=new App(new App(new Const("\\equiv "),i.next()),aux);
                                                            value =aux;
                                                          

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return value;
    }
    // $ANTLR end "eq"


    // $ANTLR start "eqtail"
    // FOScheme.g:23:1: eqtail returns [ArrayList<Term> value] : ( ( '==' | '\\\\equiv' ) term tail1= eqtail | );
    public final ArrayList<Term> eqtail() throws RecognitionException {
        ArrayList<Term> value = null;

        ArrayList<Term> tail1 = null;

        Term term4 = null;


        try {
            // FOScheme.g:23:39: ( ( '==' | '\\\\equiv' ) term tail1= eqtail | )
            int alt1=2;
            int LA1_0 = input.LA(1);

            if ( ((LA1_0>=11 && LA1_0<=12)) ) {
                alt1=1;
            }
            else if ( (LA1_0==EOF||(LA1_0>=30 && LA1_0<=31)||LA1_0==36) ) {
                alt1=2;
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 1, 0, input);

                throw nvae;
            }
            switch (alt1) {
                case 1 :
                    // FOScheme.g:24:5: ( '==' | '\\\\equiv' ) term tail1= eqtail
                    {
                    if ( (input.LA(1)>=11 && input.LA(1)<=12) ) {
                        input.consume();
                        state.errorRecovery=false;
                    }
                    else {
                        MismatchedSetException mse = new MismatchedSetException(null,input);
                        throw mse;
                    }

                    pushFollow(FOLLOW_term_in_eqtail83);
                    term4=term();

                    state._fsp--;

                    pushFollow(FOLLOW_eqtail_in_eqtail87);
                    tail1=eqtail();

                    state._fsp--;

                    ArrayList<Term> aux=tail1; aux.add(0,term4); value =aux;

                    }
                    break;
                case 2 :
                    // FOScheme.g:26:47: 
                    {
                    value =new ArrayList<Term>();

                    }
                    break;

            }
        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return value;
    }
    // $ANTLR end "eqtail"


    // $ANTLR start "term"
    // FOScheme.g:28:1: term returns [Term value] : disyconj disyconjtail ;
    public final Term term() throws RecognitionException {
        Term value = null;

        Term disyconjtail5 = null;

        Term disyconj6 = null;


        try {
            // FOScheme.g:28:26: ( disyconj disyconjtail )
            // FOScheme.g:28:28: disyconj disyconjtail
            {
            pushFollow(FOLLOW_disyconj_in_term155);
            disyconj6=disyconj();

            state._fsp--;

            pushFollow(FOLLOW_disyconjtail_in_term157);
            disyconjtail5=disyconjtail();

            state._fsp--;

             
                                                                if (disyconjtail5 == null)
                                                                   value = disyconj6;
                                                                else
                                                                   value = new App(disyconjtail5,disyconj6);
                                                              

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return value;
    }
    // $ANTLR end "term"


    // $ANTLR start "disyconjtail"
    // FOScheme.g:35:1: disyconjtail returns [Term value] : ( ( '==>' | '\\\\Rightarrow' ) disyconj tail2= disyconjtail | );
    public final Term disyconjtail() throws RecognitionException {
        Term value = null;

        Term tail2 = null;

        Term disyconj7 = null;


        try {
            // FOScheme.g:35:34: ( ( '==>' | '\\\\Rightarrow' ) disyconj tail2= disyconjtail | )
            int alt2=2;
            int LA2_0 = input.LA(1);

            if ( ((LA2_0>=13 && LA2_0<=14)) ) {
                alt2=1;
            }
            else if ( (LA2_0==EOF||(LA2_0>=11 && LA2_0<=12)||(LA2_0>=30 && LA2_0<=31)||LA2_0==36) ) {
                alt2=2;
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 2, 0, input);

                throw nvae;
            }
            switch (alt2) {
                case 1 :
                    // FOScheme.g:37:6: ( '==>' | '\\\\Rightarrow' ) disyconj tail2= disyconjtail
                    {
                    if ( (input.LA(1)>=13 && input.LA(1)<=14) ) {
                        input.consume();
                        state.errorRecovery=false;
                    }
                    else {
                        MismatchedSetException mse = new MismatchedSetException(null,input);
                        throw mse;
                    }

                    pushFollow(FOLLOW_disyconj_in_disyconjtail186);
                    disyconj7=disyconj();

                    state._fsp--;

                    pushFollow(FOLLOW_disyconjtail_in_disyconjtail190);
                    tail2=disyconjtail();

                    state._fsp--;


                                                                   if (tail2 == null)
                                                                      value = new App(new Const("\\Rightarrow "),disyconj7);
                                                                   else
                                                                   value =new App(new Const("\\Rightarrow "),new App(tail2,disyconj7));
                                                                  

                    }
                    break;
                case 2 :
                    // FOScheme.g:44:47: 
                    {
                    value =null;

                    }
                    break;

            }
        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return value;
    }
    // $ANTLR end "disyconjtail"


    // $ANTLR start "disyconj"
    // FOScheme.g:46:1: disyconj returns [Term value] : conc conctail ;
    public final Term disyconj() throws RecognitionException {
        Term value = null;

        Term conc8 = null;

        ArrayList<Term> conctail9 = null;


        try {
            // FOScheme.g:46:30: ( conc conctail )
            // FOScheme.g:46:32: conc conctail
            {
            pushFollow(FOLLOW_conc_in_disyconj251);
            conc8=conc();

            state._fsp--;

            pushFollow(FOLLOW_conctail_in_disyconj253);
            conctail9=conctail();

            state._fsp--;

             Term aux=conc8;
                                                            for(Iterator<Term> i = conctail9.iterator(); i.hasNext();) 
                                                               aux=new App(new App(new Const("\\Leftarrow "),i.next()),aux);
                                                            value =aux;
                                                          

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return value;
    }
    // $ANTLR end "disyconj"


    // $ANTLR start "conctail"
    // FOScheme.g:52:1: conctail returns [ArrayList<Term> value] : ( ( '<==' | '\\\\Leftarrow' ) conc tail3= conctail | );
    public final ArrayList<Term> conctail() throws RecognitionException {
        ArrayList<Term> value = null;

        ArrayList<Term> tail3 = null;

        Term conc10 = null;


        try {
            // FOScheme.g:52:41: ( ( '<==' | '\\\\Leftarrow' ) conc tail3= conctail | )
            int alt3=2;
            int LA3_0 = input.LA(1);

            if ( ((LA3_0>=15 && LA3_0<=16)) ) {
                alt3=1;
            }
            else if ( (LA3_0==EOF||(LA3_0>=11 && LA3_0<=14)||(LA3_0>=30 && LA3_0<=31)||LA3_0==36) ) {
                alt3=2;
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 3, 0, input);

                throw nvae;
            }
            switch (alt3) {
                case 1 :
                    // FOScheme.g:54:5: ( '<==' | '\\\\Leftarrow' ) conc tail3= conctail
                    {
                    if ( (input.LA(1)>=15 && input.LA(1)<=16) ) {
                        input.consume();
                        state.errorRecovery=false;
                    }
                    else {
                        MismatchedSetException mse = new MismatchedSetException(null,input);
                        throw mse;
                    }

                    pushFollow(FOLLOW_conc_in_conctail279);
                    conc10=conc();

                    state._fsp--;

                    pushFollow(FOLLOW_conctail_in_conctail283);
                    tail3=conctail();

                    state._fsp--;

                    ArrayList<Term> aux=tail3; 
                                                                   aux.add(0,conc10); value =aux;
                                                                  

                    }
                    break;
                case 2 :
                    // FOScheme.g:58:47: 
                    {
                    value =new ArrayList<Term>();

                    }
                    break;

            }
        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return value;
    }
    // $ANTLR end "conctail"


    // $ANTLR start "conc"
    // FOScheme.g:60:1: conc returns [Term value] : neq disytail ;
    public final Term conc() throws RecognitionException {
        Term value = null;

        Term neq11 = null;

        ArrayList<ParserPair> disytail12 = null;


        try {
            // FOScheme.g:60:26: ( neq disytail )
            // FOScheme.g:60:28: neq disytail
            {
            pushFollow(FOLLOW_neq_in_conc344);
            neq11=neq();

            state._fsp--;

            pushFollow(FOLLOW_disytail_in_conc346);
            disytail12=disytail();

            state._fsp--;

             Term aux=neq11; 
                                                                 for(Iterator<ParserPair> i = disytail12.iterator(); i.hasNext();)
                                                                 {
                                                                    ParserPair pair = i.next();
                                                                    if (pair.symbol.equals("\\vee "))
                                                                       aux=new App(new App(new Const(pair.symbol),pair.term),aux); 
                                                                    else if (pair.symbol.equals("\\wedge "))
                                                                       aux=new App(new App(new Const(pair.symbol),pair.term),aux); 
                                                                 }
                                                                 value =aux;
                                                               

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return value;
    }
    // $ANTLR end "conc"


    // $ANTLR start "disytail"
    // FOScheme.g:72:1: disytail returns [ArrayList<ParserPair> value] : ( ( '\\\\/' | '\\\\vee' ) neq tail4= disytail | ( '/\\\\' | '\\\\wedge' ) neq tail5= disytail | );
    public final ArrayList<ParserPair> disytail() throws RecognitionException {
        ArrayList<ParserPair> value = null;

        ArrayList<ParserPair> tail4 = null;

        ArrayList<ParserPair> tail5 = null;

        Term neq13 = null;

        Term neq14 = null;


        try {
            // FOScheme.g:72:47: ( ( '\\\\/' | '\\\\vee' ) neq tail4= disytail | ( '/\\\\' | '\\\\wedge' ) neq tail5= disytail | )
            int alt4=3;
            switch ( input.LA(1) ) {
            case 17:
            case 18:
                {
                alt4=1;
                }
                break;
            case 19:
            case 20:
                {
                alt4=2;
                }
                break;
            case EOF:
            case 11:
            case 12:
            case 13:
            case 14:
            case 15:
            case 16:
            case 30:
            case 31:
            case 36:
                {
                alt4=3;
                }
                break;
            default:
                NoViableAltException nvae =
                    new NoViableAltException("", 4, 0, input);

                throw nvae;
            }

            switch (alt4) {
                case 1 :
                    // FOScheme.g:74:6: ( '\\\\/' | '\\\\vee' ) neq tail4= disytail
                    {
                    if ( (input.LA(1)>=17 && input.LA(1)<=18) ) {
                        input.consume();
                        state.errorRecovery=false;
                    }
                    else {
                        MismatchedSetException mse = new MismatchedSetException(null,input);
                        throw mse;
                    }

                    pushFollow(FOLLOW_neq_in_disytail384);
                    neq13=neq();

                    state._fsp--;

                    pushFollow(FOLLOW_disytail_in_disytail388);
                    tail4=disytail();

                    state._fsp--;

                    ArrayList<ParserPair> aux=tail4;
                                                                   aux.add(0,new ParserPair("\\vee ",neq13)); value =aux;
                                                                  

                    }
                    break;
                case 2 :
                    // FOScheme.g:78:6: ( '/\\\\' | '\\\\wedge' ) neq tail5= disytail
                    {
                    if ( (input.LA(1)>=19 && input.LA(1)<=20) ) {
                        input.consume();
                        state.errorRecovery=false;
                    }
                    else {
                        MismatchedSetException mse = new MismatchedSetException(null,input);
                        throw mse;
                    }

                    pushFollow(FOLLOW_neq_in_disytail410);
                    neq14=neq();

                    state._fsp--;

                    pushFollow(FOLLOW_disytail_in_disytail414);
                    tail5=disytail();

                    state._fsp--;

                    ArrayList<ParserPair> aux=tail5; 
                                                                   aux.add(0,new ParserPair("\\wedge ",neq14)); value =aux;
                                                                  

                    }
                    break;
                case 3 :
                    // FOScheme.g:82:47: 
                    {
                    value =new ArrayList<ParserPair>();

                    }
                    break;

            }
        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return value;
    }
    // $ANTLR end "disytail"


    // $ANTLR start "neq"
    // FOScheme.g:84:1: neq returns [Term value] : neg neqtail ;
    public final Term neq() throws RecognitionException {
        Term value = null;

        Term neg15 = null;

        ArrayList<Term> neqtail16 = null;


        try {
            // FOScheme.g:84:25: ( neg neqtail )
            // FOScheme.g:84:27: neg neqtail
            {
            pushFollow(FOLLOW_neg_in_neq479);
            neg15=neg();

            state._fsp--;

            pushFollow(FOLLOW_neqtail_in_neq481);
            neqtail16=neqtail();

            state._fsp--;

             Term aux=neg15;
                                                            for(Iterator<Term> i = neqtail16.iterator(); i.hasNext();) 
                                                               aux=new App(new App(new Const("\\nequiv "),i.next()),aux);
                                                            value =aux;
                                                          

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return value;
    }
    // $ANTLR end "neq"


    // $ANTLR start "neqtail"
    // FOScheme.g:90:1: neqtail returns [ArrayList<Term> value] : ( ( '!==' | '\\\\nequiv' ) neg tail6= neqtail | );
    public final ArrayList<Term> neqtail() throws RecognitionException {
        ArrayList<Term> value = null;

        ArrayList<Term> tail6 = null;

        Term neg17 = null;


        try {
            // FOScheme.g:90:40: ( ( '!==' | '\\\\nequiv' ) neg tail6= neqtail | )
            int alt5=2;
            int LA5_0 = input.LA(1);

            if ( ((LA5_0>=21 && LA5_0<=22)) ) {
                alt5=1;
            }
            else if ( (LA5_0==EOF||(LA5_0>=11 && LA5_0<=20)||(LA5_0>=30 && LA5_0<=31)||LA5_0==36) ) {
                alt5=2;
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 5, 0, input);

                throw nvae;
            }
            switch (alt5) {
                case 1 :
                    // FOScheme.g:92:5: ( '!==' | '\\\\nequiv' ) neg tail6= neqtail
                    {
                    if ( (input.LA(1)>=21 && input.LA(1)<=22) ) {
                        input.consume();
                        state.errorRecovery=false;
                    }
                    else {
                        MismatchedSetException mse = new MismatchedSetException(null,input);
                        throw mse;
                    }

                    pushFollow(FOLLOW_neg_in_neqtail514);
                    neg17=neg();

                    state._fsp--;

                    pushFollow(FOLLOW_neqtail_in_neqtail518);
                    tail6=neqtail();

                    state._fsp--;

                    ArrayList<Term> aux=tail6; 
                                                                   aux.add(0,neg17); value =aux;
                                                                  

                    }
                    break;
                case 2 :
                    // FOScheme.g:96:47: 
                    {
                    value =new ArrayList<Term>();

                    }
                    break;

            }
        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return value;
    }
    // $ANTLR end "neqtail"


    // $ANTLR start "neg"
    // FOScheme.g:98:1: neg returns [Term value] : ( ( '!' | '\\\\neg' ) n= neg | CAPITALLETTER sust | 'true' sust | 'false' sust | '(' 'forall' LETTER '|' ':' b1= eq ')' sust | '(' 'forall' LETTER '|' ran1= eq ':' b1= eq ')' sust | '(' 'exists' LETTER '|' ':' b2= eq ')' sust | '(' 'exists' LETTER '|' ran2= eq ':' b2= eq ')' sust | WORD '(' arguments ')' sust | '(' eq ')' sust );
    public final Term neg() throws RecognitionException {
        Term value = null;

        Token CAPITALLETTER18=null;
        Token LETTER22=null;
        Token LETTER24=null;
        Token LETTER26=null;
        Token LETTER28=null;
        Token WORD30=null;
        Term n = null;

        Term b1 = null;

        Term ran1 = null;

        Term b2 = null;

        Term ran2 = null;

        ArrayList<Sust> sust19 = null;

        ArrayList<Sust> sust20 = null;

        ArrayList<Sust> sust21 = null;

        ArrayList<Sust> sust23 = null;

        ArrayList<Sust> sust25 = null;

        ArrayList<Sust> sust27 = null;

        ArrayList<Sust> sust29 = null;

        ArrayList<Var> arguments31 = null;

        ArrayList<Sust> sust32 = null;

        Term eq33 = null;

        ArrayList<Sust> sust34 = null;


        try {
            // FOScheme.g:98:25: ( ( '!' | '\\\\neg' ) n= neg | CAPITALLETTER sust | 'true' sust | 'false' sust | '(' 'forall' LETTER '|' ':' b1= eq ')' sust | '(' 'forall' LETTER '|' ran1= eq ':' b1= eq ')' sust | '(' 'exists' LETTER '|' ':' b2= eq ')' sust | '(' 'exists' LETTER '|' ran2= eq ':' b2= eq ')' sust | WORD '(' arguments ')' sust | '(' eq ')' sust )
            int alt6=10;
            alt6 = dfa6.predict(input);
            switch (alt6) {
                case 1 :
                    // FOScheme.g:100:7: ( '!' | '\\\\neg' ) n= neg
                    {
                    if ( (input.LA(1)>=23 && input.LA(1)<=24) ) {
                        input.consume();
                        state.errorRecovery=false;
                    }
                    else {
                        MismatchedSetException mse = new MismatchedSetException(null,input);
                        throw mse;
                    }

                    pushFollow(FOLLOW_neg_in_neg602);
                    n=neg();

                    state._fsp--;

                    value =new App(new Const("\\neg "),n);

                    }
                    break;
                case 2 :
                    // FOScheme.g:102:8: CAPITALLETTER sust
                    {
                    CAPITALLETTER18=(Token)match(input,CAPITALLETTER,FOLLOW_CAPITALLETTER_in_neg628); 
                    pushFollow(FOLLOW_sust_in_neg630);
                    sust19=sust();

                    state._fsp--;

                    Term aux = new Var((new Integer((int)(CAPITALLETTER18!=null?CAPITALLETTER18.getText():null).charAt(0))).intValue());
                                                               for(Iterator<Sust> i = sust19.iterator(); i.hasNext();)
                                                                  aux=new App(aux,i.next()); 
                                                               value =aux;
                                                              

                    }
                    break;
                case 3 :
                    // FOScheme.g:108:8: 'true' sust
                    {
                    match(input,25,FOLLOW_25_in_neg658); 
                    pushFollow(FOLLOW_sust_in_neg660);
                    sust20=sust();

                    state._fsp--;

                    Term aux = new Const("true ");
                                                               for(Iterator<Sust> i = sust20.iterator(); i.hasNext();)
                                                                  aux=new App(aux,i.next()); 
                                                               value =aux;
                                                              

                    }
                    break;
                case 4 :
                    // FOScheme.g:114:8: 'false' sust
                    {
                    match(input,26,FOLLOW_26_in_neg695); 
                    pushFollow(FOLLOW_sust_in_neg697);
                    sust21=sust();

                    state._fsp--;

                    Term aux = new Const("false ");
                                                               for(Iterator<Sust> i = sust21.iterator(); i.hasNext();)
                                                                  aux=new App(aux,i.next()); 
                                                               value =aux;
                                                              

                    }
                    break;
                case 5 :
                    // FOScheme.g:120:8: '(' 'forall' LETTER '|' ':' b1= eq ')' sust
                    {
                    match(input,27,FOLLOW_27_in_neg731); 
                    match(input,28,FOLLOW_28_in_neg733); 
                    LETTER22=(Token)match(input,LETTER,FOLLOW_LETTER_in_neg735); 
                    match(input,29,FOLLOW_29_in_neg737); 
                    match(input,30,FOLLOW_30_in_neg740); 
                    pushFollow(FOLLOW_eq_in_neg744);
                    b1=eq();

                    state._fsp--;

                    match(input,31,FOLLOW_31_in_neg746); 
                    pushFollow(FOLLOW_sust_in_neg748);
                    sust23=sust();

                    state._fsp--;

                    Var v = new Var((int)(LETTER22!=null?LETTER22.getText():null).charAt(0));
                                                                        Term aux =new Bracket(v,b1, "\\forall");
                                                                        for(Iterator<Sust> i = sust23.iterator(); i.hasNext();)
                                                                           aux=new App(aux,i.next()); 
                                                                        value =aux;
                                                                       

                    }
                    break;
                case 6 :
                    // FOScheme.g:127:8: '(' 'forall' LETTER '|' ran1= eq ':' b1= eq ')' sust
                    {
                    match(input,27,FOLLOW_27_in_neg760); 
                    match(input,28,FOLLOW_28_in_neg762); 
                    LETTER24=(Token)match(input,LETTER,FOLLOW_LETTER_in_neg764); 
                    match(input,29,FOLLOW_29_in_neg766); 
                    pushFollow(FOLLOW_eq_in_neg770);
                    ran1=eq();

                    state._fsp--;

                    match(input,30,FOLLOW_30_in_neg772); 
                    pushFollow(FOLLOW_eq_in_neg776);
                    b1=eq();

                    state._fsp--;

                    match(input,31,FOLLOW_31_in_neg778); 
                    pushFollow(FOLLOW_sust_in_neg780);
                    sust25=sust();

                    state._fsp--;

                    Var v = new Var((int)(LETTER24!=null?LETTER24.getText():null).charAt(0));
                                                                   Term aux = new Bracket(v,new App(new App(new I(),ran1),b1), "\\forall");
                                                                               for(Iterator<Sust> i = sust25.iterator(); i.hasNext();)
                                                                                   aux=new App(aux,i.next()); 
                                                                               value =aux;
                                                                              

                    }
                    break;
                case 7 :
                    // FOScheme.g:134:8: '(' 'exists' LETTER '|' ':' b2= eq ')' sust
                    {
                    match(input,27,FOLLOW_27_in_neg792); 
                    match(input,32,FOLLOW_32_in_neg794); 
                    LETTER26=(Token)match(input,LETTER,FOLLOW_LETTER_in_neg796); 
                    match(input,29,FOLLOW_29_in_neg798); 
                    match(input,30,FOLLOW_30_in_neg800); 
                    pushFollow(FOLLOW_eq_in_neg804);
                    b2=eq();

                    state._fsp--;

                    match(input,31,FOLLOW_31_in_neg806); 
                    pushFollow(FOLLOW_sust_in_neg808);
                    sust27=sust();

                    state._fsp--;

                    Var v = new Var((int)(LETTER26!=null?LETTER26.getText():null).charAt(0));
                                                                       Term aux = new Bracket(v,b2, "\\exists");
                                                                       for(Iterator<Sust> i = sust27.iterator(); i.hasNext();)
                                                                           aux=new App(aux,i.next()); 
                                                                       value =aux;
                                                                      

                    }
                    break;
                case 8 :
                    // FOScheme.g:141:8: '(' 'exists' LETTER '|' ran2= eq ':' b2= eq ')' sust
                    {
                    match(input,27,FOLLOW_27_in_neg820); 
                    match(input,32,FOLLOW_32_in_neg822); 
                    LETTER28=(Token)match(input,LETTER,FOLLOW_LETTER_in_neg824); 
                    match(input,29,FOLLOW_29_in_neg826); 
                    pushFollow(FOLLOW_eq_in_neg830);
                    ran2=eq();

                    state._fsp--;

                    match(input,30,FOLLOW_30_in_neg832); 
                    pushFollow(FOLLOW_eq_in_neg836);
                    b2=eq();

                    state._fsp--;

                    match(input,31,FOLLOW_31_in_neg838); 
                    pushFollow(FOLLOW_sust_in_neg840);
                    sust29=sust();

                    state._fsp--;

                    Var v = new Var((int)(LETTER28!=null?LETTER28.getText():null).charAt(0));
                                                                         Term aux = new Bracket(v,new App(new App(new I(),ran2),b2), "\\exists");
                                                                               for(Iterator<Sust> i = sust29.iterator(); i.hasNext();)
                                                                                  aux=new App(aux,i.next()); 
                                                                               value =aux;
                                                                              

                    }
                    break;
                case 9 :
                    // FOScheme.g:148:8: WORD '(' arguments ')' sust
                    {
                    WORD30=(Token)match(input,WORD,FOLLOW_WORD_in_neg852); 
                    match(input,27,FOLLOW_27_in_neg854); 
                    pushFollow(FOLLOW_arguments_in_neg856);
                    arguments31=arguments();

                    state._fsp--;

                    match(input,31,FOLLOW_31_in_neg858); 
                    pushFollow(FOLLOW_sust_in_neg860);
                    sust32=sust();

                    state._fsp--;

                    Term aux = new Const((WORD30!=null?WORD30.getText():null));
                                                                   for(Iterator<Var> i = arguments31.iterator(); i.hasNext();) 
                                                                      aux=new App(aux,i.next());
                                                                   for(Iterator<Sust> i = sust32.iterator(); i.hasNext();)
                                                                      aux=new App(aux,i.next()); 
                                                                   value =aux;
                                                                  

                    }
                    break;
                case 10 :
                    // FOScheme.g:156:8: '(' eq ')' sust
                    {
                    match(input,27,FOLLOW_27_in_neg883); 
                    pushFollow(FOLLOW_eq_in_neg885);
                    eq33=eq();

                    state._fsp--;

                    match(input,31,FOLLOW_31_in_neg887); 
                    pushFollow(FOLLOW_sust_in_neg889);
                    sust34=sust();

                    state._fsp--;

                    Term aux=eq33;
                                                                     for(Iterator<Sust> i = sust34.iterator(); i.hasNext();)
                                                                        aux=new App(aux,i.next()); 
                                                                   value =aux;
                                                                  

                    }
                    break;

            }
        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return value;
    }
    // $ANTLR end "neg"


    // $ANTLR start "sust"
    // FOScheme.g:162:1: sust returns [ArrayList<Sust> value] : ( '[' lei= LETTER ':=' led= LETTER ']' su= sust | );
    public final ArrayList<Sust> sust() throws RecognitionException {
        ArrayList<Sust> value = null;

        Token lei=null;
        Token led=null;
        ArrayList<Sust> su = null;


        try {
            // FOScheme.g:162:37: ( '[' lei= LETTER ':=' led= LETTER ']' su= sust | )
            int alt7=2;
            int LA7_0 = input.LA(1);

            if ( (LA7_0==33) ) {
                alt7=1;
            }
            else if ( (LA7_0==EOF||(LA7_0>=11 && LA7_0<=22)||(LA7_0>=30 && LA7_0<=31)||LA7_0==36) ) {
                alt7=2;
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 7, 0, input);

                throw nvae;
            }
            switch (alt7) {
                case 1 :
                    // FOScheme.g:164:4: '[' lei= LETTER ':=' led= LETTER ']' su= sust
                    {
                    match(input,33,FOLLOW_33_in_sust929); 
                    lei=(Token)match(input,LETTER,FOLLOW_LETTER_in_sust933); 
                    match(input,34,FOLLOW_34_in_sust935); 
                    led=(Token)match(input,LETTER,FOLLOW_LETTER_in_sust939); 
                    match(input,35,FOLLOW_35_in_sust941); 
                    pushFollow(FOLLOW_sust_in_sust945);
                    su=sust();

                    state._fsp--;

                    Var letter = new Var((int)(lei!=null?lei.getText():null).charAt(0));
                                                                Var le = new Var((int)(led!=null?led.getText():null).charAt(0));
                                                                ArrayList<Var> varlist = new ArrayList<Var>();
                                                                varlist.add(0,letter);
                                                                ArrayList<Term> termlist = new ArrayList<Term>();
                                                                termlist.add(0,le);
                                                                ArrayList<Sust> sus = su;
                                                                sus.add(0,new Sust(varlist,termlist));
                                                                value = sus;
                                                               

                    }
                    break;
                case 2 :
                    // FOScheme.g:175:44: 
                    {
                    value = new ArrayList<Sust>();

                    }
                    break;

            }
        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return value;
    }
    // $ANTLR end "sust"


    // $ANTLR start "instantiate"
    // FOScheme.g:177:1: instantiate returns [ArrayList<Object> value] : arguments ':=' explist ;
    public final ArrayList<Object> instantiate() throws RecognitionException {
        ArrayList<Object> value = null;

        ArrayList<Var> arguments35 = null;

        ArrayList<Term> explist36 = null;


        try {
            // FOScheme.g:177:46: ( arguments ':=' explist )
            // FOScheme.g:179:6: arguments ':=' explist
            {
            pushFollow(FOLLOW_arguments_in_instantiate1012);
            arguments35=arguments();

            state._fsp--;

            match(input,34,FOLLOW_34_in_instantiate1014); 
            pushFollow(FOLLOW_explist_in_instantiate1016);
            explist36=explist();

            state._fsp--;

            ArrayList<Object> arr=new ArrayList<Object>();
                                                           arr.add(arguments35);
                                                           arr.add(explist36);
                                                           value = arr;
                                                          

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return value;
    }
    // $ANTLR end "instantiate"


    // $ANTLR start "explist"
    // FOScheme.g:185:1: explist returns [ArrayList<Term> value] : eq explisttail ;
    public final ArrayList<Term> explist() throws RecognitionException {
        ArrayList<Term> value = null;

        ArrayList<Term> explisttail37 = null;

        Term eq38 = null;


        try {
            // FOScheme.g:185:40: ( eq explisttail )
            // FOScheme.g:187:6: eq explisttail
            {
            pushFollow(FOLLOW_eq_in_explist1054);
            eq38=eq();

            state._fsp--;

            pushFollow(FOLLOW_explisttail_in_explist1057);
            explisttail37=explisttail();

            state._fsp--;

            ArrayList<Term> aux = explisttail37;
                                                           aux.add(0,eq38);
                                                           value = aux;
                                                          

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return value;
    }
    // $ANTLR end "explist"


    // $ANTLR start "explisttail"
    // FOScheme.g:192:1: explisttail returns [ArrayList<Term> value] : ( ',' eq tail7= explisttail | );
    public final ArrayList<Term> explisttail() throws RecognitionException {
        ArrayList<Term> value = null;

        ArrayList<Term> tail7 = null;

        Term eq39 = null;


        try {
            // FOScheme.g:192:44: ( ',' eq tail7= explisttail | )
            int alt8=2;
            int LA8_0 = input.LA(1);

            if ( (LA8_0==36) ) {
                alt8=1;
            }
            else if ( (LA8_0==EOF) ) {
                alt8=2;
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 8, 0, input);

                throw nvae;
            }
            switch (alt8) {
                case 1 :
                    // FOScheme.g:194:6: ',' eq tail7= explisttail
                    {
                    match(input,36,FOLLOW_36_in_explisttail1102); 
                    pushFollow(FOLLOW_eq_in_explisttail1104);
                    eq39=eq();

                    state._fsp--;

                    pushFollow(FOLLOW_explisttail_in_explisttail1108);
                    tail7=explisttail();

                    state._fsp--;

                    ArrayList<Term> aux = tail7;
                                                                   aux.add(0,eq39);
                                                                   value =aux;
                                                                  

                    }
                    break;
                case 2 :
                    // FOScheme.g:199:47: 
                    {
                    value = new ArrayList<Term>();

                    }
                    break;

            }
        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return value;
    }
    // $ANTLR end "explisttail"


    // $ANTLR start "arguments"
    // FOScheme.g:201:1: arguments returns [ArrayList<Var> value] : ( CAPITALLETTER ',' arg= arguments | CAPITALLETTER );
    public final ArrayList<Var> arguments() throws RecognitionException {
        ArrayList<Var> value = null;

        Token CAPITALLETTER40=null;
        Token CAPITALLETTER41=null;
        ArrayList<Var> arg = null;


        try {
            // FOScheme.g:201:41: ( CAPITALLETTER ',' arg= arguments | CAPITALLETTER )
            int alt9=2;
            int LA9_0 = input.LA(1);

            if ( (LA9_0==CAPITALLETTER) ) {
                int LA9_1 = input.LA(2);

                if ( (LA9_1==36) ) {
                    alt9=1;
                }
                else if ( (LA9_1==31||LA9_1==34) ) {
                    alt9=2;
                }
                else {
                    NoViableAltException nvae =
                        new NoViableAltException("", 9, 1, input);

                    throw nvae;
                }
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 9, 0, input);

                throw nvae;
            }
            switch (alt9) {
                case 1 :
                    // FOScheme.g:201:43: CAPITALLETTER ',' arg= arguments
                    {
                    CAPITALLETTER40=(Token)match(input,CAPITALLETTER,FOLLOW_CAPITALLETTER_in_arguments1186); 
                    match(input,36,FOLLOW_36_in_arguments1188); 
                    pushFollow(FOLLOW_arguments_in_arguments1192);
                    arg=arguments();

                    state._fsp--;

                    ArrayList<Var> aux=arg; 
                                                                         Var v=new Var((new Integer((int)(CAPITALLETTER40!=null?CAPITALLETTER40.getText():null).charAt(0))).intValue());
                                                                                aux.add(0,v); 
                                                                                value =aux;
                                                                               

                    }
                    break;
                case 2 :
                    // FOScheme.g:207:44: CAPITALLETTER
                    {
                    CAPITALLETTER41=(Token)match(input,CAPITALLETTER,FOLLOW_CAPITALLETTER_in_arguments1240); 
                    ArrayList<Var> list=new ArrayList<Var>();
                                                                           Var v=new Var((new Integer((CAPITALLETTER41!=null?CAPITALLETTER41.getText():null).charAt(0))).intValue());
                                                                                 list.add(0,v);
                                                                                 value = list;
                                                                               

                    }
                    break;

            }
        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return value;
    }
    // $ANTLR end "arguments"


    // $ANTLR start "lambda"
    // FOScheme.g:213:1: lambda returns [Term value] : 'lambda' LETTER '.' eq ;
    public final Term lambda() throws RecognitionException {
        Term value = null;

        Token LETTER42=null;
        Term eq43 = null;


        try {
            // FOScheme.g:213:28: ( 'lambda' LETTER '.' eq )
            // FOScheme.g:213:30: 'lambda' LETTER '.' eq
            {
            match(input,37,FOLLOW_37_in_lambda1255); 
            LETTER42=(Token)match(input,LETTER,FOLLOW_LETTER_in_lambda1257); 
            match(input,38,FOLLOW_38_in_lambda1259); 
            pushFollow(FOLLOW_eq_in_lambda1261);
            eq43=eq();

            state._fsp--;

            Var v=new Var((new Integer((LETTER42!=null?LETTER42.getText():null).charAt(0))).intValue());
                                                                        value = new Bracket(v,eq43);
                                                                       

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return value;
    }
    // $ANTLR end "lambda"

    // Delegated rules


    protected DFA6 dfa6 = new DFA6(this);
    static final String DFA6_eotS =
        "\22\uffff";
    static final String DFA6_eofS =
        "\22\uffff";
    static final String DFA6_minS =
        "\1\4\4\uffff\1\4\1\uffff\2\5\1\uffff\2\35\2\4\4\uffff";
    static final String DFA6_maxS =
        "\1\33\4\uffff\1\40\1\uffff\2\5\1\uffff\2\35\2\36\4\uffff";
    static final String DFA6_acceptS =
        "\1\uffff\1\1\1\2\1\3\1\4\1\uffff\1\11\2\uffff\1\12\4\uffff\1\5\1"+
        "\6\1\7\1\10";
    static final String DFA6_specialS =
        "\22\uffff}>";
    static final String[] DFA6_transitionS = {
            "\1\2\1\uffff\1\6\20\uffff\2\1\1\3\1\4\1\5",
            "",
            "",
            "",
            "",
            "\1\11\1\uffff\1\11\20\uffff\5\11\1\7\3\uffff\1\10",
            "",
            "\1\12",
            "\1\13",
            "",
            "\1\14",
            "\1\15",
            "\1\17\1\uffff\1\17\20\uffff\5\17\2\uffff\1\16",
            "\1\21\1\uffff\1\21\20\uffff\5\21\2\uffff\1\20",
            "",
            "",
            "",
            ""
    };

    static final short[] DFA6_eot = DFA.unpackEncodedString(DFA6_eotS);
    static final short[] DFA6_eof = DFA.unpackEncodedString(DFA6_eofS);
    static final char[] DFA6_min = DFA.unpackEncodedStringToUnsignedChars(DFA6_minS);
    static final char[] DFA6_max = DFA.unpackEncodedStringToUnsignedChars(DFA6_maxS);
    static final short[] DFA6_accept = DFA.unpackEncodedString(DFA6_acceptS);
    static final short[] DFA6_special = DFA.unpackEncodedString(DFA6_specialS);
    static final short[][] DFA6_transition;

    static {
        int numStates = DFA6_transitionS.length;
        DFA6_transition = new short[numStates][];
        for (int i=0; i<numStates; i++) {
            DFA6_transition[i] = DFA.unpackEncodedString(DFA6_transitionS[i]);
        }
    }

    class DFA6 extends DFA {

        public DFA6(BaseRecognizer recognizer) {
            this.recognizer = recognizer;
            this.decisionNumber = 6;
            this.eot = DFA6_eot;
            this.eof = DFA6_eof;
            this.min = DFA6_min;
            this.max = DFA6_max;
            this.accept = DFA6_accept;
            this.special = DFA6_special;
            this.transition = DFA6_transition;
        }
        public String getDescription() {
            return "98:1: neg returns [Term value] : ( ( '!' | '\\\\neg' ) n= neg | CAPITALLETTER sust | 'true' sust | 'false' sust | '(' 'forall' LETTER '|' ':' b1= eq ')' sust | '(' 'forall' LETTER '|' ran1= eq ':' b1= eq ')' sust | '(' 'exists' LETTER '|' ':' b2= eq ')' sust | '(' 'exists' LETTER '|' ran2= eq ':' b2= eq ')' sust | WORD '(' arguments ')' sust | '(' eq ')' sust );";
        }
    }
 

    public static final BitSet FOLLOW_eq_in_start_rule21 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_term_in_eq44 = new BitSet(new long[]{0x0000000000001800L});
    public static final BitSet FOLLOW_eqtail_in_eq46 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_set_in_eqtail76 = new BitSet(new long[]{0x000000000F800050L});
    public static final BitSet FOLLOW_term_in_eqtail83 = new BitSet(new long[]{0x0000000000001800L});
    public static final BitSet FOLLOW_eqtail_in_eqtail87 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_disyconj_in_term155 = new BitSet(new long[]{0x0000000000006000L});
    public static final BitSet FOLLOW_disyconjtail_in_term157 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_set_in_disyconjtail179 = new BitSet(new long[]{0x000000000F800050L});
    public static final BitSet FOLLOW_disyconj_in_disyconjtail186 = new BitSet(new long[]{0x0000000000006000L});
    public static final BitSet FOLLOW_disyconjtail_in_disyconjtail190 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_conc_in_disyconj251 = new BitSet(new long[]{0x0000000000018000L});
    public static final BitSet FOLLOW_conctail_in_disyconj253 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_set_in_conctail272 = new BitSet(new long[]{0x000000000F800050L});
    public static final BitSet FOLLOW_conc_in_conctail279 = new BitSet(new long[]{0x0000000000018000L});
    public static final BitSet FOLLOW_conctail_in_conctail283 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_neq_in_conc344 = new BitSet(new long[]{0x00000000001E0000L});
    public static final BitSet FOLLOW_disytail_in_conc346 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_set_in_disytail377 = new BitSet(new long[]{0x000000000F800050L});
    public static final BitSet FOLLOW_neq_in_disytail384 = new BitSet(new long[]{0x00000000001E0000L});
    public static final BitSet FOLLOW_disytail_in_disytail388 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_set_in_disytail403 = new BitSet(new long[]{0x000000000F800050L});
    public static final BitSet FOLLOW_neq_in_disytail410 = new BitSet(new long[]{0x00000000001E0000L});
    public static final BitSet FOLLOW_disytail_in_disytail414 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_neg_in_neq479 = new BitSet(new long[]{0x0000000000600000L});
    public static final BitSet FOLLOW_neqtail_in_neq481 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_set_in_neqtail507 = new BitSet(new long[]{0x000000000F800050L});
    public static final BitSet FOLLOW_neg_in_neqtail514 = new BitSet(new long[]{0x0000000000600000L});
    public static final BitSet FOLLOW_neqtail_in_neqtail518 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_set_in_neg592 = new BitSet(new long[]{0x000000000F800050L});
    public static final BitSet FOLLOW_neg_in_neg602 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_CAPITALLETTER_in_neg628 = new BitSet(new long[]{0x0000000200000000L});
    public static final BitSet FOLLOW_sust_in_neg630 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_25_in_neg658 = new BitSet(new long[]{0x0000000200000000L});
    public static final BitSet FOLLOW_sust_in_neg660 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_26_in_neg695 = new BitSet(new long[]{0x0000000200000000L});
    public static final BitSet FOLLOW_sust_in_neg697 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_27_in_neg731 = new BitSet(new long[]{0x0000000010000000L});
    public static final BitSet FOLLOW_28_in_neg733 = new BitSet(new long[]{0x0000000000000020L});
    public static final BitSet FOLLOW_LETTER_in_neg735 = new BitSet(new long[]{0x0000000020000000L});
    public static final BitSet FOLLOW_29_in_neg737 = new BitSet(new long[]{0x0000000040000000L});
    public static final BitSet FOLLOW_30_in_neg740 = new BitSet(new long[]{0x000000000F800050L});
    public static final BitSet FOLLOW_eq_in_neg744 = new BitSet(new long[]{0x0000000080000000L});
    public static final BitSet FOLLOW_31_in_neg746 = new BitSet(new long[]{0x0000000200000000L});
    public static final BitSet FOLLOW_sust_in_neg748 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_27_in_neg760 = new BitSet(new long[]{0x0000000010000000L});
    public static final BitSet FOLLOW_28_in_neg762 = new BitSet(new long[]{0x0000000000000020L});
    public static final BitSet FOLLOW_LETTER_in_neg764 = new BitSet(new long[]{0x0000000020000000L});
    public static final BitSet FOLLOW_29_in_neg766 = new BitSet(new long[]{0x000000000F800050L});
    public static final BitSet FOLLOW_eq_in_neg770 = new BitSet(new long[]{0x0000000040000000L});
    public static final BitSet FOLLOW_30_in_neg772 = new BitSet(new long[]{0x000000000F800050L});
    public static final BitSet FOLLOW_eq_in_neg776 = new BitSet(new long[]{0x0000000080000000L});
    public static final BitSet FOLLOW_31_in_neg778 = new BitSet(new long[]{0x0000000200000000L});
    public static final BitSet FOLLOW_sust_in_neg780 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_27_in_neg792 = new BitSet(new long[]{0x0000000100000000L});
    public static final BitSet FOLLOW_32_in_neg794 = new BitSet(new long[]{0x0000000000000020L});
    public static final BitSet FOLLOW_LETTER_in_neg796 = new BitSet(new long[]{0x0000000020000000L});
    public static final BitSet FOLLOW_29_in_neg798 = new BitSet(new long[]{0x0000000040000000L});
    public static final BitSet FOLLOW_30_in_neg800 = new BitSet(new long[]{0x000000000F800050L});
    public static final BitSet FOLLOW_eq_in_neg804 = new BitSet(new long[]{0x0000000080000000L});
    public static final BitSet FOLLOW_31_in_neg806 = new BitSet(new long[]{0x0000000200000000L});
    public static final BitSet FOLLOW_sust_in_neg808 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_27_in_neg820 = new BitSet(new long[]{0x0000000100000000L});
    public static final BitSet FOLLOW_32_in_neg822 = new BitSet(new long[]{0x0000000000000020L});
    public static final BitSet FOLLOW_LETTER_in_neg824 = new BitSet(new long[]{0x0000000020000000L});
    public static final BitSet FOLLOW_29_in_neg826 = new BitSet(new long[]{0x000000000F800050L});
    public static final BitSet FOLLOW_eq_in_neg830 = new BitSet(new long[]{0x0000000040000000L});
    public static final BitSet FOLLOW_30_in_neg832 = new BitSet(new long[]{0x000000000F800050L});
    public static final BitSet FOLLOW_eq_in_neg836 = new BitSet(new long[]{0x0000000080000000L});
    public static final BitSet FOLLOW_31_in_neg838 = new BitSet(new long[]{0x0000000200000000L});
    public static final BitSet FOLLOW_sust_in_neg840 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_WORD_in_neg852 = new BitSet(new long[]{0x0000000008000000L});
    public static final BitSet FOLLOW_27_in_neg854 = new BitSet(new long[]{0x0000000000000010L});
    public static final BitSet FOLLOW_arguments_in_neg856 = new BitSet(new long[]{0x0000000080000000L});
    public static final BitSet FOLLOW_31_in_neg858 = new BitSet(new long[]{0x0000000200000000L});
    public static final BitSet FOLLOW_sust_in_neg860 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_27_in_neg883 = new BitSet(new long[]{0x000000000F800050L});
    public static final BitSet FOLLOW_eq_in_neg885 = new BitSet(new long[]{0x0000000080000000L});
    public static final BitSet FOLLOW_31_in_neg887 = new BitSet(new long[]{0x0000000200000000L});
    public static final BitSet FOLLOW_sust_in_neg889 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_33_in_sust929 = new BitSet(new long[]{0x0000000000000020L});
    public static final BitSet FOLLOW_LETTER_in_sust933 = new BitSet(new long[]{0x0000000400000000L});
    public static final BitSet FOLLOW_34_in_sust935 = new BitSet(new long[]{0x0000000000000020L});
    public static final BitSet FOLLOW_LETTER_in_sust939 = new BitSet(new long[]{0x0000000800000000L});
    public static final BitSet FOLLOW_35_in_sust941 = new BitSet(new long[]{0x0000000200000000L});
    public static final BitSet FOLLOW_sust_in_sust945 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_arguments_in_instantiate1012 = new BitSet(new long[]{0x0000000400000000L});
    public static final BitSet FOLLOW_34_in_instantiate1014 = new BitSet(new long[]{0x000000000F800050L});
    public static final BitSet FOLLOW_explist_in_instantiate1016 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_eq_in_explist1054 = new BitSet(new long[]{0x0000001000000000L});
    public static final BitSet FOLLOW_explisttail_in_explist1057 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_36_in_explisttail1102 = new BitSet(new long[]{0x000000000F800050L});
    public static final BitSet FOLLOW_eq_in_explisttail1104 = new BitSet(new long[]{0x0000001000000000L});
    public static final BitSet FOLLOW_explisttail_in_explisttail1108 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_CAPITALLETTER_in_arguments1186 = new BitSet(new long[]{0x0000001000000000L});
    public static final BitSet FOLLOW_36_in_arguments1188 = new BitSet(new long[]{0x0000000000000010L});
    public static final BitSet FOLLOW_arguments_in_arguments1192 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_CAPITALLETTER_in_arguments1240 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_37_in_lambda1255 = new BitSet(new long[]{0x0000000000000020L});
    public static final BitSet FOLLOW_LETTER_in_lambda1257 = new BitSet(new long[]{0x0000004000000000L});
    public static final BitSet FOLLOW_38_in_lambda1259 = new BitSet(new long[]{0x000000000F800050L});
    public static final BitSet FOLLOW_eq_in_lambda1261 = new BitSet(new long[]{0x0000000000000002L});

}