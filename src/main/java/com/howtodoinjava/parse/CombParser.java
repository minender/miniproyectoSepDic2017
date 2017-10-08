// $ANTLR 3.2 Sep 23, 2009 12:02:23 Comb.g 2014-05-18 11:11:23
package com.howtodoinjava.parse;

import org.antlr.runtime.*;
import java.util.Stack;
import java.util.List;
import java.util.ArrayList;
import com.howtodoinjava.lambdacalculo.*;

public class CombParser extends Parser {
    public static final String[] tokenNames = new String[] {
        "<invalid>", "<EOR>", "<DOWN>", "<UP>", "X", "K", "P", "CONSTINDICE", "NUMBER", "INITIALDIGIT", "DIGIT", "WHITESPACE", "'{'", "'}'", "'('", "')'", "','"
    };
    public static final int CONSTINDICE=7;
    public static final int T__16=16;
    public static final int T__15=15;
    public static final int T__12=12;
    public static final int T__14=14;
    public static final int T__13=13;
    public static final int NUMBER=8;
    public static final int K=5;
    public static final int INITIALDIGIT=9;
    public static final int WHITESPACE=11;
    public static final int P=6;
    public static final int DIGIT=10;
    public static final int EOF=-1;
    public static final int X=4;

    // delegates
    // delegators


        public CombParser(TokenStream input) {
            this(input, new RecognizerSharedState());
        }
        public CombParser(TokenStream input, RecognizerSharedState state) {
            super(input, state);
             
        }
        

    public String[] getTokenNames() { return CombParser.tokenNames; }
    public String getGrammarFileName() { return "Comb.g"; }



    // $ANTLR start "c"
    // Comb.g:4:1: c returns [Term value] : ( X | K | P '{' indice '}' | '(' ci= c cd= c ')' );
    public final Term c() throws RecognitionException {
        Term value = null;

        Token X1=null;
        Term ci = null;

        Term cd = null;

        ListaInd indice2 = null;


        try {
            // Comb.g:4:23: ( X | K | P '{' indice '}' | '(' ci= c cd= c ')' )
            int alt1=4;
            switch ( input.LA(1) ) {
            case X:
                {
                alt1=1;
                }
                break;
            case K:
                {
                alt1=2;
                }
                break;
            case P:
                {
                alt1=3;
                }
                break;
            case 14:
                {
                alt1=4;
                }
                break;
            default:
                NoViableAltException nvae =
                    new NoViableAltException("", 1, 0, input);

                throw nvae;
            }

            switch (alt1) {
                case 1 :
                    // Comb.g:4:25: X
                    {
                    X1=(Token)match(input,X,FOLLOW_X_in_c14); 
                     value =new Var((new Integer((X1!=null?X1.getText():null).substring(1))).intValue());

                    }
                    break;
                case 2 :
                    // Comb.g:5:10: K
                    {
                    match(input,K,FOLLOW_K_in_c27); 
                    value = new Const("K");

                    }
                    break;
                case 3 :
                    // Comb.g:6:10: P '{' indice '}'
                    {
                    match(input,P,FOLLOW_P_in_c40); 
                    match(input,12,FOLLOW_12_in_c42); 
                    pushFollow(FOLLOW_indice_in_c44);
                    indice2=indice();

                    state._fsp--;

                    match(input,13,FOLLOW_13_in_c46); 
                    value =new Phi(); ((Phi)value).ind=indice2; 

                    }
                    break;
                case 4 :
                    // Comb.g:7:10: '(' ci= c cd= c ')'
                    {
                    match(input,14,FOLLOW_14_in_c59); 
                    pushFollow(FOLLOW_c_in_c63);
                    ci=c();

                    state._fsp--;

                    pushFollow(FOLLOW_c_in_c67);
                    cd=c();

                    state._fsp--;

                    match(input,15,FOLLOW_15_in_c69); 
                    value =new App(ci,cd);

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
    // $ANTLR end "c"


    // $ANTLR start "indice"
    // Comb.g:9:1: indice returns [ListaInd ind] : (con= CONSTINDICE i= indice | '(' izq= indice ',' der= indice ')' | );
    public final ListaInd indice() throws RecognitionException {
        ListaInd ind = null;

        Token con=null;
        ListaInd i = null;

        ListaInd izq = null;

        ListaInd der = null;


        try {
            // Comb.g:9:30: (con= CONSTINDICE i= indice | '(' izq= indice ',' der= indice ')' | )
            int alt2=3;
            switch ( input.LA(1) ) {
            case CONSTINDICE:
                {
                alt2=1;
                }
                break;
            case 14:
                {
                alt2=2;
                }
                break;
            case 13:
            case 15:
            case 16:
                {
                alt2=3;
                }
                break;
            default:
                NoViableAltException nvae =
                    new NoViableAltException("", 2, 0, input);

                throw nvae;
            }

            switch (alt2) {
                case 1 :
                    // Comb.g:9:32: con= CONSTINDICE i= indice
                    {
                    con=(Token)match(input,CONSTINDICE,FOLLOW_CONSTINDICE_in_indice84); 
                    pushFollow(FOLLOW_indice_in_indice88);
                    i=indice();

                    state._fsp--;

                    i.list.add(i.list.size(),new ConstInd((con!=null?con.getText():null))); ind = i;

                    }
                    break;
                case 2 :
                    // Comb.g:10:9: '(' izq= indice ',' der= indice ')'
                    {
                    match(input,14,FOLLOW_14_in_indice100); 
                    pushFollow(FOLLOW_indice_in_indice104);
                    izq=indice();

                    state._fsp--;

                    match(input,16,FOLLOW_16_in_indice106); 
                    pushFollow(FOLLOW_indice_in_indice110);
                    der=indice();

                    state._fsp--;

                    match(input,15,FOLLOW_15_in_indice112); 
                    ind =new ListaInd(new ParInd(izq,der));

                    }
                    break;
                case 3 :
                    // Comb.g:11:8: 
                    {
                    ind = new ListaInd();

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
        return ind;
    }
    // $ANTLR end "indice"

    // Delegated rules


 

    public static final BitSet FOLLOW_X_in_c14 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_K_in_c27 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_P_in_c40 = new BitSet(new long[]{0x0000000000001000L});
    public static final BitSet FOLLOW_12_in_c42 = new BitSet(new long[]{0x0000000000006080L});
    public static final BitSet FOLLOW_indice_in_c44 = new BitSet(new long[]{0x0000000000002000L});
    public static final BitSet FOLLOW_13_in_c46 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_14_in_c59 = new BitSet(new long[]{0x0000000000004070L});
    public static final BitSet FOLLOW_c_in_c63 = new BitSet(new long[]{0x0000000000004070L});
    public static final BitSet FOLLOW_c_in_c67 = new BitSet(new long[]{0x0000000000008000L});
    public static final BitSet FOLLOW_15_in_c69 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_CONSTINDICE_in_indice84 = new BitSet(new long[]{0x0000000000004080L});
    public static final BitSet FOLLOW_indice_in_indice88 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_14_in_indice100 = new BitSet(new long[]{0x0000000000014080L});
    public static final BitSet FOLLOW_indice_in_indice104 = new BitSet(new long[]{0x0000000000010000L});
    public static final BitSet FOLLOW_16_in_indice106 = new BitSet(new long[]{0x000000000000C080L});
    public static final BitSet FOLLOW_indice_in_indice110 = new BitSet(new long[]{0x0000000000008000L});
    public static final BitSet FOLLOW_15_in_indice112 = new BitSet(new long[]{0x0000000000000002L});

}
