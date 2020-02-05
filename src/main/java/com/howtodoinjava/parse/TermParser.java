// $ANTLR 3.2 Sep 23, 2009 12:02:23 Term.g 2017-10-10 15:11:19
package com.howtodoinjava.parse; 

import com.howtodoinjava.entity.Termino;
import com.howtodoinjava.entity.TerminoId;
import com.howtodoinjava.lambdacalculo.*;
import com.howtodoinjava.service.TerminoManager;
import java.util.Iterator;

import org.antlr.runtime.*;
import java.util.Stack;
import java.util.List;
import java.util.ArrayList;

public class TermParser extends Parser {
    public static final String[] tokenNames = new String[] {
        "<invalid>", "<EOR>", "<DOWN>", "<UP>", "CAPITALLETTER", "LETTER", "WORD", "NUMBER", "X", "INITIALDIGIT", "DIGIT", "WHITESPACE", "'=='", "'\\\\equiv'", "'==>'", "'\\\\Rightarrow'", "'<=='", "'\\\\Leftarrow'", "'\\\\/'", "'\\\\vee'", "'/\\\\'", "'\\\\wedge'", "'!=='", "'\\\\not\\\\equiv'", "'!'", "'\\\\neg'", "'true'", "'false'", "'_{'", "'}^{'", "'}'", "'('", "')'", "':='", "','", "'lambda'", "'.'"
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
    public static final int NUMBER=7;
    public static final int CAPITALLETTER=4;
    public static final int INITIALDIGIT=9;
    public static final int WHITESPACE=11;
    public static final int EOF=-1;
    public static final int X=8;
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
    public static final int T__12=12;
    public static final int T__14=14;
    public static final int T__13=13;
    public static final int DIGIT=10;

    // delegates
    // delegators


        public TermParser(TokenStream input) {
            this(input, new RecognizerSharedState());
        }
        public TermParser(TokenStream input, RecognizerSharedState state) {
            super(input, state);
             
        }
        

    public String[] getTokenNames() { return TermParser.tokenNames; }
    public String getGrammarFileName() { return "Term.g"; }



    // $ANTLR start "start_rule"
    // Term.g:13:1: start_rule[TerminoId terminoid, TerminoManager terminoManager] returns [Term value] : eq ;
    public final Term start_rule(TerminoId terminoid, TerminoManager terminoManager) throws RecognitionException {
        Term value = null;

        Term eq1 = null;


        try {
            // Term.g:13:86: ( eq )
            // Term.g:13:88: eq
            {
            pushFollow(FOLLOW_eq_in_start_rule23);
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
    // Term.g:15:1: eq returns [Term value] : term eqtail ;
    public final Term eq() throws RecognitionException {
        Term value = null;

        Term term2 = null;

        ArrayList<Term> eqtail3 = null;


        try {
            // Term.g:15:24: ( term eqtail )
            // Term.g:15:26: term eqtail
            {
            pushFollow(FOLLOW_term_in_eq46);
            term2=term();

            state._fsp--;

            pushFollow(FOLLOW_eqtail_in_eq48);
            eqtail3=eqtail();

            state._fsp--;

             Term aux=term2;
                                                            for(Iterator<Term> i = eqtail3.iterator(); i.hasNext();) 
                                                               aux=new App(new App(new Const("\\equiv ",false,1,1),i.next()),aux);
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
    // Term.g:21:1: eqtail returns [ArrayList<Term> value] : ( ( '==' | '\\\\equiv' ) term tail1= eqtail | );
    public final ArrayList<Term> eqtail() throws RecognitionException {
        ArrayList<Term> value = null;

        ArrayList<Term> tail1 = null;

        Term term4 = null;


        try {
            // Term.g:21:39: ( ( '==' | '\\\\equiv' ) term tail1= eqtail | )
            int alt1=2;
            int LA1_0 = input.LA(1);

            if ( ((LA1_0>=12 && LA1_0<=13)) ) {
                alt1=1;
            }
            else if ( (LA1_0==EOF||LA1_0==29||LA1_0==32||LA1_0==34) ) {
                alt1=2;
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 1, 0, input);

                throw nvae;
            }
            switch (alt1) {
                case 1 :
                    // Term.g:22:5: ( '==' | '\\\\equiv' ) term tail1= eqtail
                    {
                    if ( (input.LA(1)>=12 && input.LA(1)<=13) ) {
                        input.consume();
                        state.errorRecovery=false;
                    }
                    else {
                        MismatchedSetException mse = new MismatchedSetException(null,input);
                        throw mse;
                    }

                    pushFollow(FOLLOW_term_in_eqtail85);
                    term4=term();

                    state._fsp--;

                    pushFollow(FOLLOW_eqtail_in_eqtail89);
                    tail1=eqtail();

                    state._fsp--;

                    ArrayList<Term> aux=tail1; aux.add(0,term4); value =aux;

                    }
                    break;
                case 2 :
                    // Term.g:24:47: 
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
    // Term.g:26:1: term returns [Term value] : disyconj disyconjtail ;
    public final Term term() throws RecognitionException {
        Term value = null;

        Term disyconjtail5 = null;

        Term disyconj6 = null;


        try {
            // Term.g:26:26: ( disyconj disyconjtail )
            // Term.g:26:28: disyconj disyconjtail
            {
            pushFollow(FOLLOW_disyconj_in_term157);
            disyconj6=disyconj();

            state._fsp--;

            pushFollow(FOLLOW_disyconjtail_in_term159);
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
    // Term.g:33:1: disyconjtail returns [Term value] : ( ( '==>' | '\\\\Rightarrow' ) disyconj tail2= disyconjtail | );
    public final Term disyconjtail() throws RecognitionException {
        Term value = null;

        Term tail2 = null;

        Term disyconj7 = null;


        try {
            // Term.g:33:34: ( ( '==>' | '\\\\Rightarrow' ) disyconj tail2= disyconjtail | )
            int alt2=2;
            int LA2_0 = input.LA(1);

            if ( ((LA2_0>=14 && LA2_0<=15)) ) {
                alt2=1;
            }
            else if ( (LA2_0==EOF||(LA2_0>=12 && LA2_0<=13)||LA2_0==29||LA2_0==32||LA2_0==34) ) {
                alt2=2;
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 2, 0, input);

                throw nvae;
            }
            switch (alt2) {
                case 1 :
                    // Term.g:35:6: ( '==>' | '\\\\Rightarrow' ) disyconj tail2= disyconjtail
                    {
                    if ( (input.LA(1)>=14 && input.LA(1)<=15) ) {
                        input.consume();
                        state.errorRecovery=false;
                    }
                    else {
                        MismatchedSetException mse = new MismatchedSetException(null,input);
                        throw mse;
                    }

                    pushFollow(FOLLOW_disyconj_in_disyconjtail188);
                    disyconj7=disyconj();

                    state._fsp--;

                    pushFollow(FOLLOW_disyconjtail_in_disyconjtail192);
                    tail2=disyconjtail();

                    state._fsp--;


                                                                   if (tail2 == null)
                                                                      value = new App(new Const("\\Rightarrow ",false,2,2),disyconj7);
                                                                   else
                                                                   value =new App(new Const("\\Rightarrow ",false,2,2),new App(tail2,disyconj7));
                                                                  

                    }
                    break;
                case 2 :
                    // Term.g:42:47: 
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
    // Term.g:44:1: disyconj returns [Term value] : conc conctail ;
    public final Term disyconj() throws RecognitionException {
        Term value = null;

        Term conc8 = null;

        ArrayList<Term> conctail9 = null;


        try {
            // Term.g:44:30: ( conc conctail )
            // Term.g:44:32: conc conctail
            {
            pushFollow(FOLLOW_conc_in_disyconj253);
            conc8=conc();

            state._fsp--;

            pushFollow(FOLLOW_conctail_in_disyconj255);
            conctail9=conctail();

            state._fsp--;

             Term aux=conc8;
                                                            for(Iterator<Term> i = conctail9.iterator(); i.hasNext();) 
                                                               aux=new App(new App(new Const("\\Leftarrow ",false,2,1),i.next()),aux);
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
    // Term.g:50:1: conctail returns [ArrayList<Term> value] : ( ( '<==' | '\\\\Leftarrow' ) conc tail3= conctail | );
    public final ArrayList<Term> conctail() throws RecognitionException {
        ArrayList<Term> value = null;

        ArrayList<Term> tail3 = null;

        Term conc10 = null;


        try {
            // Term.g:50:41: ( ( '<==' | '\\\\Leftarrow' ) conc tail3= conctail | )
            int alt3=2;
            int LA3_0 = input.LA(1);

            if ( ((LA3_0>=16 && LA3_0<=17)) ) {
                alt3=1;
            }
            else if ( (LA3_0==EOF||(LA3_0>=12 && LA3_0<=15)||LA3_0==29||LA3_0==32||LA3_0==34) ) {
                alt3=2;
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 3, 0, input);

                throw nvae;
            }
            switch (alt3) {
                case 1 :
                    // Term.g:52:5: ( '<==' | '\\\\Leftarrow' ) conc tail3= conctail
                    {
                    if ( (input.LA(1)>=16 && input.LA(1)<=17) ) {
                        input.consume();
                        state.errorRecovery=false;
                    }
                    else {
                        MismatchedSetException mse = new MismatchedSetException(null,input);
                        throw mse;
                    }

                    pushFollow(FOLLOW_conc_in_conctail281);
                    conc10=conc();

                    state._fsp--;

                    pushFollow(FOLLOW_conctail_in_conctail285);
                    tail3=conctail();

                    state._fsp--;

                    ArrayList<Term> aux=tail3; 
                                                                   aux.add(0,conc10); value =aux;
                                                                  

                    }
                    break;
                case 2 :
                    // Term.g:56:47: 
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
    // Term.g:58:1: conc returns [Term value] : neq disytail ;
    public final Term conc() throws RecognitionException {
        Term value = null;

        Term neq11 = null;

        ArrayList<ParserPair> disytail12 = null;


        try {
            // Term.g:58:26: ( neq disytail )
            // Term.g:58:28: neq disytail
            {
            pushFollow(FOLLOW_neq_in_conc346);
            neq11=neq();

            state._fsp--;

            pushFollow(FOLLOW_disytail_in_conc348);
            disytail12=disytail();

            state._fsp--;

             Term aux=neq11; 
                                                                 for(Iterator<ParserPair> i = disytail12.iterator(); i.hasNext();)
                                                                 {
                                                                    ParserPair pair = i.next();
                                                                    if (pair.symbol.equals("\\vee "))
                                                                       aux=new App(new App(new Const(pair.symbol,false,3,1),pair.term),aux); 
                                                                    else if (pair.symbol.equals("\\wedge "))
                                                                       aux=new App(new App(new Const(pair.symbol,false,3,1),pair.term),aux); 
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
    // Term.g:70:1: disytail returns [ArrayList<ParserPair> value] : ( ( '\\\\/' | '\\\\vee' ) neq tail4= disytail | ( '/\\\\' | '\\\\wedge' ) neq tail5= disytail | );
    public final ArrayList<ParserPair> disytail() throws RecognitionException {
        ArrayList<ParserPair> value = null;

        ArrayList<ParserPair> tail4 = null;

        ArrayList<ParserPair> tail5 = null;

        Term neq13 = null;

        Term neq14 = null;


        try {
            // Term.g:70:47: ( ( '\\\\/' | '\\\\vee' ) neq tail4= disytail | ( '/\\\\' | '\\\\wedge' ) neq tail5= disytail | )
            int alt4=3;
            switch ( input.LA(1) ) {
            case 18:
            case 19:
                {
                alt4=1;
                }
                break;
            case 20:
            case 21:
                {
                alt4=2;
                }
                break;
            case EOF:
            case 12:
            case 13:
            case 14:
            case 15:
            case 16:
            case 17:
            case 29:
            case 32:
            case 34:
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
                    // Term.g:72:6: ( '\\\\/' | '\\\\vee' ) neq tail4= disytail
                    {
                    if ( (input.LA(1)>=18 && input.LA(1)<=19) ) {
                        input.consume();
                        state.errorRecovery=false;
                    }
                    else {
                        MismatchedSetException mse = new MismatchedSetException(null,input);
                        throw mse;
                    }

                    pushFollow(FOLLOW_neq_in_disytail386);
                    neq13=neq();

                    state._fsp--;

                    pushFollow(FOLLOW_disytail_in_disytail390);
                    tail4=disytail();

                    state._fsp--;

                    ArrayList<ParserPair> aux=tail4;
                                                                   aux.add(0,new ParserPair("\\vee ",neq13)); value =aux;
                                                                  

                    }
                    break;
                case 2 :
                    // Term.g:76:6: ( '/\\\\' | '\\\\wedge' ) neq tail5= disytail
                    {
                    if ( (input.LA(1)>=20 && input.LA(1)<=21) ) {
                        input.consume();
                        state.errorRecovery=false;
                    }
                    else {
                        MismatchedSetException mse = new MismatchedSetException(null,input);
                        throw mse;
                    }

                    pushFollow(FOLLOW_neq_in_disytail412);
                    neq14=neq();

                    state._fsp--;

                    pushFollow(FOLLOW_disytail_in_disytail416);
                    tail5=disytail();

                    state._fsp--;

                    ArrayList<ParserPair> aux=tail5; 
                                                                   aux.add(0,new ParserPair("\\wedge ",neq14)); value =aux;
                                                                  

                    }
                    break;
                case 3 :
                    // Term.g:80:47: 
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
    // Term.g:82:1: neq returns [Term value] : neg neqtail ;
    public final Term neq() throws RecognitionException {
        Term value = null;

        Term neg15 = null;

        ArrayList<Term> neqtail16 = null;


        try {
            // Term.g:82:25: ( neg neqtail )
            // Term.g:82:27: neg neqtail
            {
            pushFollow(FOLLOW_neg_in_neq481);
            neg15=neg();

            state._fsp--;

            pushFollow(FOLLOW_neqtail_in_neq483);
            neqtail16=neqtail();

            state._fsp--;

             Term aux=neg15;
                                                            for(Iterator<Term> i = neqtail16.iterator(); i.hasNext();) 
                                                               aux=new App(new App(new Const("\\not\\equiv ",false,4,1),i.next()),aux);
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
    // Term.g:88:1: neqtail returns [ArrayList<Term> value] : ( ( '!==' | '\\\\not\\\\equiv' ) neg tail6= neqtail | );
    public final ArrayList<Term> neqtail() throws RecognitionException {
        ArrayList<Term> value = null;

        ArrayList<Term> tail6 = null;

        Term neg17 = null;


        try {
            // Term.g:88:40: ( ( '!==' | '\\\\not\\\\equiv' ) neg tail6= neqtail | )
            int alt5=2;
            int LA5_0 = input.LA(1);

            if ( ((LA5_0>=22 && LA5_0<=23)) ) {
                alt5=1;
            }
            else if ( (LA5_0==EOF||(LA5_0>=12 && LA5_0<=21)||LA5_0==29||LA5_0==32||LA5_0==34) ) {
                alt5=2;
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 5, 0, input);

                throw nvae;
            }
            switch (alt5) {
                case 1 :
                    // Term.g:90:5: ( '!==' | '\\\\not\\\\equiv' ) neg tail6= neqtail
                    {
                    if ( (input.LA(1)>=22 && input.LA(1)<=23) ) {
                        input.consume();
                        state.errorRecovery=false;
                    }
                    else {
                        MismatchedSetException mse = new MismatchedSetException(null,input);
                        throw mse;
                    }

                    pushFollow(FOLLOW_neg_in_neqtail516);
                    neg17=neg();

                    state._fsp--;

                    pushFollow(FOLLOW_neqtail_in_neqtail520);
                    tail6=neqtail();

                    state._fsp--;

                    ArrayList<Term> aux=tail6; 
                                                                   aux.add(0,neg17); value =aux;
                                                                  

                    }
                    break;
                case 2 :
                    // Term.g:94:47: 
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
    // Term.g:96:1: neg returns [Term value] : ( ( '!' | '\\\\neg' ) n= neg | CAPITALLETTER | LETTER | 'true' | 'false' | CAPITALLETTER '_{' eq '}^{' LETTER '}' | WORD '(' arguments ')' | '(' eq ')' );
    public final Term neg() throws RecognitionException {
        Term value = null;

        Token CAPITALLETTER18=null;
        Token LETTER19=null;
        Token LETTER20=null;
        Token CAPITALLETTER21=null;
        Token WORD23=null;
        Term n = null;

        Term eq22 = null;

        ArrayList<Var> arguments24 = null;

        Term eq25 = null;


        try {
            // Term.g:96:25: ( ( '!' | '\\\\neg' ) n= neg | CAPITALLETTER | LETTER | 'true' | 'false' | CAPITALLETTER '_{' eq '}^{' LETTER '}' | WORD '(' arguments ')' | '(' eq ')' )
            int alt6=8;
            alt6 = dfa6.predict(input);
            switch (alt6) {
                case 1 :
                    // Term.g:98:7: ( '!' | '\\\\neg' ) n= neg
                    {
                    if ( (input.LA(1)>=24 && input.LA(1)<=25) ) {
                        input.consume();
                        state.errorRecovery=false;
                    }
                    else {
                        MismatchedSetException mse = new MismatchedSetException(null,input);
                        throw mse;
                    }

                    pushFollow(FOLLOW_neg_in_neg600);
                    n=neg();

                    state._fsp--;

                    value =new App(new Const("\\neg ",false,5,2),n);

                    }
                    break;
                case 2 :
                    // Term.g:100:8: CAPITALLETTER
                    {
                    CAPITALLETTER18=(Token)match(input,CAPITALLETTER,FOLLOW_CAPITALLETTER_in_neg630); 
                    value = new Var((new Integer((int)(CAPITALLETTER18!=null?CAPITALLETTER18.getText():null).charAt(0))).intValue());

                    }
                    break;
                case 3 :
                    // Term.g:102:8: LETTER
                    {
                    LETTER19=(Token)match(input,LETTER,FOLLOW_LETTER_in_neg667); 
                    value = new Var((new Integer((int)(LETTER19!=null?LETTER19.getText():null).charAt(0))).intValue());

                    }
                    break;
                case 4 :
                    // Term.g:104:8: 'true'
                    {
                    match(input,26,FOLLOW_26_in_neg711); 
                    value = new Const("true ");

                    }
                    break;
                case 5 :
                    // Term.g:106:8: 'false'
                    {
                    match(input,27,FOLLOW_27_in_neg755); 
                    value = new Const("false ");

                    }
                    break;
                case 6 :
                    // Term.g:108:8: CAPITALLETTER '_{' eq '}^{' LETTER '}'
                    {
                    CAPITALLETTER21=(Token)match(input,CAPITALLETTER,FOLLOW_CAPITALLETTER_in_neg798); 
                    match(input,28,FOLLOW_28_in_neg800); 
                    pushFollow(FOLLOW_eq_in_neg802);
                    eq22=eq();

                    state._fsp--;

                    match(input,29,FOLLOW_29_in_neg804); 
                    LETTER20=(Token)match(input,LETTER,FOLLOW_LETTER_in_neg806); 
                    match(input,30,FOLLOW_30_in_neg808); 
                    Var letter = new Var((new Integer((int)(LETTER20!=null?LETTER20.getText():null).charAt(0))).intValue());
                                                                   Var capl = new Var((new Integer((int)(CAPITALLETTER21!=null?CAPITALLETTER21.getText():null).charAt(0))).intValue());
                                                                   List<Var> vars = new ArrayList<Var>();
                                                                   List<Term> terms = new ArrayList<Term>();
                                                                   vars.add(0,letter);
                                                                   terms.add(0,eq22 );    
                                                                   value = new App(capl,new Sust(vars, terms));
                                                                  

                    }
                    break;
                case 7 :
                    // Term.g:117:8: WORD '(' arguments ')'
                    {
                    WORD23=(Token)match(input,WORD,FOLLOW_WORD_in_neg821); 
                    match(input,31,FOLLOW_31_in_neg823); 
                    pushFollow(FOLLOW_arguments_in_neg825);
                    arguments24=arguments();

                    state._fsp--;

                    match(input,32,FOLLOW_32_in_neg827); 
                    Term aux = new Const((WORD23!=null?WORD23.getText():null),true,-1,-1);
                                                                   for(Iterator<Var> i = arguments24.iterator(); i.hasNext();) 
                                                                      aux=new App(aux,i.next());
                                                                   value =aux;
                                                                  

                    }
                    break;
                case 8 :
                    // Term.g:123:8: '(' eq ')'
                    {
                    match(input,31,FOLLOW_31_in_neg855); 
                    pushFollow(FOLLOW_eq_in_neg857);
                    eq25=eq();

                    state._fsp--;

                    match(input,32,FOLLOW_32_in_neg859); 
                    value =eq25;

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


    // $ANTLR start "instantiate"
    // Term.g:125:1: instantiate[TerminoId terminoid, TerminoManager terminoManager] returns [ArrayList<Object> value] : arguments ':=' explist ;
    public final ArrayList<Object> instantiate(TerminoId terminoid, TerminoManager terminoManager) throws RecognitionException {
        ArrayList<Object> value = null;

        ArrayList<Var> arguments26 = null;

        ArrayList<Term> explist27 = null;


        try {
            // Term.g:125:98: ( arguments ':=' explist )
            // Term.g:127:6: arguments ':=' explist
            {
            pushFollow(FOLLOW_arguments_in_instantiate908);
            arguments26=arguments();

            state._fsp--;

            match(input,33,FOLLOW_33_in_instantiate910); 
            pushFollow(FOLLOW_explist_in_instantiate912);
            explist27=explist();

            state._fsp--;

            ArrayList<Object> arr=new ArrayList<Object>();
                                                           arr.add(arguments26);
                                                           arr.add(explist27);
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
    // Term.g:133:1: explist returns [ArrayList<Term> value] : eq explisttail ;
    public final ArrayList<Term> explist() throws RecognitionException {
        ArrayList<Term> value = null;

        ArrayList<Term> explisttail28 = null;

        Term eq29 = null;


        try {
            // Term.g:133:40: ( eq explisttail )
            // Term.g:135:6: eq explisttail
            {
            pushFollow(FOLLOW_eq_in_explist950);
            eq29=eq();

            state._fsp--;

            pushFollow(FOLLOW_explisttail_in_explist953);
            explisttail28=explisttail();

            state._fsp--;

            ArrayList<Term> aux = explisttail28;
                                                           aux.add(0,eq29);
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
    // Term.g:140:1: explisttail returns [ArrayList<Term> value] : ( ',' eq tail7= explisttail | );
    public final ArrayList<Term> explisttail() throws RecognitionException {
        ArrayList<Term> value = null;

        ArrayList<Term> tail7 = null;

        Term eq30 = null;


        try {
            // Term.g:140:44: ( ',' eq tail7= explisttail | )
            int alt7=2;
            int LA7_0 = input.LA(1);

            if ( (LA7_0==34) ) {
                alt7=1;
            }
            else if ( (LA7_0==EOF) ) {
                alt7=2;
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 7, 0, input);

                throw nvae;
            }
            switch (alt7) {
                case 1 :
                    // Term.g:142:6: ',' eq tail7= explisttail
                    {
                    match(input,34,FOLLOW_34_in_explisttail998); 
                    pushFollow(FOLLOW_eq_in_explisttail1000);
                    eq30=eq();

                    state._fsp--;

                    pushFollow(FOLLOW_explisttail_in_explisttail1004);
                    tail7=explisttail();

                    state._fsp--;

                    ArrayList<Term> aux = tail7;
                                                                   aux.add(0,eq30);
                                                                   value =aux;
                                                                  

                    }
                    break;
                case 2 :
                    // Term.g:147:47: 
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
    // Term.g:154:1: arguments returns [ArrayList<Var> value] : ( LETTER ',' arg= arguments | CAPITALLETTER ',' arg= arguments | LETTER | CAPITALLETTER );
    public final ArrayList<Var> arguments() throws RecognitionException {
        ArrayList<Var> value = null;

        Token LETTER31=null;
        Token CAPITALLETTER32=null;
        Token LETTER33=null;
        Token CAPITALLETTER34=null;
        ArrayList<Var> arg = null;


        try {
            // Term.g:154:41: ( LETTER ',' arg= arguments | CAPITALLETTER ',' arg= arguments | LETTER | CAPITALLETTER )
            int alt8=4;
            int LA8_0 = input.LA(1);

            if ( (LA8_0==LETTER) ) {
                int LA8_1 = input.LA(2);

                if ( (LA8_1==34) ) {
                    alt8=1;
                }
                else if ( ((LA8_1>=32 && LA8_1<=33)) ) {
                    alt8=3;
                }
                else {
                    NoViableAltException nvae =
                        new NoViableAltException("", 8, 1, input);

                    throw nvae;
                }
            }
            else if ( (LA8_0==CAPITALLETTER) ) {
                int LA8_2 = input.LA(2);

                if ( (LA8_2==34) ) {
                    alt8=2;
                }
                else if ( ((LA8_2>=32 && LA8_2<=33)) ) {
                    alt8=4;
                }
                else {
                    NoViableAltException nvae =
                        new NoViableAltException("", 8, 2, input);

                    throw nvae;
                }
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 8, 0, input);

                throw nvae;
            }
            switch (alt8) {
                case 1 :
                    // Term.g:154:43: LETTER ',' arg= arguments
                    {
                    LETTER31=(Token)match(input,LETTER,FOLLOW_LETTER_in_arguments1103); 
                    match(input,34,FOLLOW_34_in_arguments1105); 
                    pushFollow(FOLLOW_arguments_in_arguments1109);
                    arg=arguments();

                    state._fsp--;

                    ArrayList<Var> aux=arg; 
                                                                                Var v=new Var((new Integer((int)(LETTER31!=null?LETTER31.getText():null).charAt(0))).intValue());
                                                                                aux.add(0,v); 
                                                                                value =aux;
                                                                               

                    }
                    break;
                case 2 :
                    // Term.g:160:44: CAPITALLETTER ',' arg= arguments
                    {
                    CAPITALLETTER32=(Token)match(input,CAPITALLETTER,FOLLOW_CAPITALLETTER_in_arguments1157); 
                    match(input,34,FOLLOW_34_in_arguments1159); 
                    pushFollow(FOLLOW_arguments_in_arguments1163);
                    arg=arguments();

                    state._fsp--;

                    ArrayList<Var> aux=arg; 
                                                                         Var v=new Var((new Integer((int)(CAPITALLETTER32!=null?CAPITALLETTER32.getText():null).charAt(0))).intValue());
                                                                                aux.add(0,v); 
                                                                                value =aux;
                                                                               

                    }
                    break;
                case 3 :
                    // Term.g:166:44: LETTER
                    {
                    LETTER33=(Token)match(input,LETTER,FOLLOW_LETTER_in_arguments1211); 
                    ArrayList<Var> list=new ArrayList<Var>();
                                                                                Var v=new Var((new Integer((LETTER33!=null?LETTER33.getText():null).charAt(0))).intValue());
                                                                                list.add(0,v);
                                                                                value = list;
                                                                               

                    }
                    break;
                case 4 :
                    // Term.g:172:44: CAPITALLETTER
                    {
                    CAPITALLETTER34=(Token)match(input,CAPITALLETTER,FOLLOW_CAPITALLETTER_in_arguments1268); 
                    ArrayList<Var> list=new ArrayList<Var>();
                                                                           Var v=new Var((new Integer((CAPITALLETTER34!=null?CAPITALLETTER34.getText():null).charAt(0))).intValue());
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
    // Term.g:178:1: lambda[TerminoId terminoid, TerminoManager terminoManager] returns [Term value] : 'lambda' LETTER '.' eq ;
    public final Term lambda(TerminoId terminoid, TerminoManager terminoManager) throws RecognitionException {
        Term value = null;

        Token LETTER35=null;
        Term eq36 = null;


        try {
            // Term.g:178:80: ( 'lambda' LETTER '.' eq )
            // Term.g:179:30: 'lambda' LETTER '.' eq
            {
            match(input,35,FOLLOW_35_in_lambda1314); 
            LETTER35=(Token)match(input,LETTER,FOLLOW_LETTER_in_lambda1316); 
            match(input,36,FOLLOW_36_in_lambda1318); 
            pushFollow(FOLLOW_eq_in_lambda1320);
            eq36=eq();

            state._fsp--;

            Var v=new Var((new Integer((LETTER35!=null?LETTER35.getText():null).charAt(0))).intValue());
                                                                        value = new Bracket(v,eq36);
                                                                       

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
        "\12\uffff";
    static final String DFA6_eofS =
        "\2\uffff\1\11\7\uffff";
    static final String DFA6_minS =
        "\1\4\1\uffff\1\14\7\uffff";
    static final String DFA6_maxS =
        "\1\37\1\uffff\1\42\7\uffff";
    static final String DFA6_acceptS =
        "\1\uffff\1\1\1\uffff\1\3\1\4\1\5\1\7\1\10\1\6\1\2";
    static final String DFA6_specialS =
        "\12\uffff}>";
    static final String[] DFA6_transitionS = {
            "\1\2\1\3\1\6\21\uffff\2\1\1\4\1\5\3\uffff\1\7",
            "",
            "\14\11\4\uffff\1\10\1\11\2\uffff\1\11\1\uffff\1\11",
            "",
            "",
            "",
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
            return "96:1: neg returns [Term value] : ( ( '!' | '\\\\neg' ) n= neg | CAPITALLETTER | LETTER | 'true' | 'false' | CAPITALLETTER '_{' eq '}^{' LETTER '}' | WORD '(' arguments ')' | '(' eq ')' );";
        }
    }
 

    public static final BitSet FOLLOW_eq_in_start_rule23 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_term_in_eq46 = new BitSet(new long[]{0x0000000000003000L});
    public static final BitSet FOLLOW_eqtail_in_eq48 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_set_in_eqtail78 = new BitSet(new long[]{0x000000008F000070L});
    public static final BitSet FOLLOW_term_in_eqtail85 = new BitSet(new long[]{0x0000000000003000L});
    public static final BitSet FOLLOW_eqtail_in_eqtail89 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_disyconj_in_term157 = new BitSet(new long[]{0x000000000000C000L});
    public static final BitSet FOLLOW_disyconjtail_in_term159 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_set_in_disyconjtail181 = new BitSet(new long[]{0x000000008F000070L});
    public static final BitSet FOLLOW_disyconj_in_disyconjtail188 = new BitSet(new long[]{0x000000000000C000L});
    public static final BitSet FOLLOW_disyconjtail_in_disyconjtail192 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_conc_in_disyconj253 = new BitSet(new long[]{0x0000000000030000L});
    public static final BitSet FOLLOW_conctail_in_disyconj255 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_set_in_conctail274 = new BitSet(new long[]{0x000000008F000070L});
    public static final BitSet FOLLOW_conc_in_conctail281 = new BitSet(new long[]{0x0000000000030000L});
    public static final BitSet FOLLOW_conctail_in_conctail285 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_neq_in_conc346 = new BitSet(new long[]{0x00000000003C0000L});
    public static final BitSet FOLLOW_disytail_in_conc348 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_set_in_disytail379 = new BitSet(new long[]{0x000000008F000070L});
    public static final BitSet FOLLOW_neq_in_disytail386 = new BitSet(new long[]{0x00000000003C0000L});
    public static final BitSet FOLLOW_disytail_in_disytail390 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_set_in_disytail405 = new BitSet(new long[]{0x000000008F000070L});
    public static final BitSet FOLLOW_neq_in_disytail412 = new BitSet(new long[]{0x00000000003C0000L});
    public static final BitSet FOLLOW_disytail_in_disytail416 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_neg_in_neq481 = new BitSet(new long[]{0x0000000000C00000L});
    public static final BitSet FOLLOW_neqtail_in_neq483 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_set_in_neqtail509 = new BitSet(new long[]{0x000000008F000070L});
    public static final BitSet FOLLOW_neg_in_neqtail516 = new BitSet(new long[]{0x0000000000C00000L});
    public static final BitSet FOLLOW_neqtail_in_neqtail520 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_set_in_neg590 = new BitSet(new long[]{0x000000008F000070L});
    public static final BitSet FOLLOW_neg_in_neg600 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_CAPITALLETTER_in_neg630 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_LETTER_in_neg667 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_26_in_neg711 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_27_in_neg755 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_CAPITALLETTER_in_neg798 = new BitSet(new long[]{0x0000000010000000L});
    public static final BitSet FOLLOW_28_in_neg800 = new BitSet(new long[]{0x000000008F000070L});
    public static final BitSet FOLLOW_eq_in_neg802 = new BitSet(new long[]{0x0000000020000000L});
    public static final BitSet FOLLOW_29_in_neg804 = new BitSet(new long[]{0x0000000000000020L});
    public static final BitSet FOLLOW_LETTER_in_neg806 = new BitSet(new long[]{0x0000000040000000L});
    public static final BitSet FOLLOW_30_in_neg808 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_WORD_in_neg821 = new BitSet(new long[]{0x0000000080000000L});
    public static final BitSet FOLLOW_31_in_neg823 = new BitSet(new long[]{0x0000000000000030L});
    public static final BitSet FOLLOW_arguments_in_neg825 = new BitSet(new long[]{0x0000000100000000L});
    public static final BitSet FOLLOW_32_in_neg827 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_31_in_neg855 = new BitSet(new long[]{0x000000008F000070L});
    public static final BitSet FOLLOW_eq_in_neg857 = new BitSet(new long[]{0x0000000100000000L});
    public static final BitSet FOLLOW_32_in_neg859 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_arguments_in_instantiate908 = new BitSet(new long[]{0x0000000200000000L});
    public static final BitSet FOLLOW_33_in_instantiate910 = new BitSet(new long[]{0x000000008F000070L});
    public static final BitSet FOLLOW_explist_in_instantiate912 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_eq_in_explist950 = new BitSet(new long[]{0x0000000400000000L});
    public static final BitSet FOLLOW_explisttail_in_explist953 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_34_in_explisttail998 = new BitSet(new long[]{0x000000008F000070L});
    public static final BitSet FOLLOW_eq_in_explisttail1000 = new BitSet(new long[]{0x0000000400000000L});
    public static final BitSet FOLLOW_explisttail_in_explisttail1004 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_LETTER_in_arguments1103 = new BitSet(new long[]{0x0000000400000000L});
    public static final BitSet FOLLOW_34_in_arguments1105 = new BitSet(new long[]{0x0000000000000030L});
    public static final BitSet FOLLOW_arguments_in_arguments1109 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_CAPITALLETTER_in_arguments1157 = new BitSet(new long[]{0x0000000400000000L});
    public static final BitSet FOLLOW_34_in_arguments1159 = new BitSet(new long[]{0x0000000000000030L});
    public static final BitSet FOLLOW_arguments_in_arguments1163 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_LETTER_in_arguments1211 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_CAPITALLETTER_in_arguments1268 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_35_in_lambda1314 = new BitSet(new long[]{0x0000000000000020L});
    public static final BitSet FOLLOW_LETTER_in_lambda1316 = new BitSet(new long[]{0x0000001000000000L});
    public static final BitSet FOLLOW_36_in_lambda1318 = new BitSet(new long[]{0x000000008F000070L});
    public static final BitSet FOLLOW_eq_in_lambda1320 = new BitSet(new long[]{0x0000000000000002L});

}