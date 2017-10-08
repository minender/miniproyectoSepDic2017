// $ANTLR 3.2 Sep 23, 2009 12:02:23 Comb.g 2014-05-18 11:11:23
package com.howtodoinjava.parse;

import org.antlr.runtime.*;
import java.util.Stack;
import java.util.List;
import java.util.ArrayList;
import com.howtodoinjava.lambdacalculo.*;

public class CombLexer extends Lexer {
    public static final int CONSTINDICE=7;
    public static final int T__16=16;
    public static final int T__15=15;
    public static final int T__12=12;
    public static final int T__14=14;
    public static final int T__13=13;
    public static final int K=5;
    public static final int NUMBER=8;
    public static final int INITIALDIGIT=9;
    public static final int WHITESPACE=11;
    public static final int P=6;
    public static final int DIGIT=10;
    public static final int EOF=-1;
    public static final int X=4;

    // delegates
    // delegators

    public CombLexer() {;} 
    public CombLexer(CharStream input) {
        this(input, new RecognizerSharedState());
    }
    public CombLexer(CharStream input, RecognizerSharedState state) {
        super(input,state);

    }
    public String getGrammarFileName() { return "Comb.g"; }

    // $ANTLR start "T__12"
    public final void mT__12() throws RecognitionException {
        try {
            int _type = T__12;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // Comb.g:3:7: ( '{' )
            // Comb.g:3:9: '{'
            {
            match('{'); 

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__12"

    // $ANTLR start "T__13"
    public final void mT__13() throws RecognitionException {
        try {
            int _type = T__13;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // Comb.g:4:7: ( '}' )
            // Comb.g:4:9: '}'
            {
            match('}'); 

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__13"

    // $ANTLR start "T__14"
    public final void mT__14() throws RecognitionException {
        try {
            int _type = T__14;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // Comb.g:5:7: ( '(' )
            // Comb.g:5:9: '('
            {
            match('('); 

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__14"

    // $ANTLR start "T__15"
    public final void mT__15() throws RecognitionException {
        try {
            int _type = T__15;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // Comb.g:6:7: ( ')' )
            // Comb.g:6:9: ')'
            {
            match(')'); 

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__15"

    // $ANTLR start "T__16"
    public final void mT__16() throws RecognitionException {
        try {
            int _type = T__16;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // Comb.g:7:7: ( ',' )
            // Comb.g:7:9: ','
            {
            match(','); 

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__16"

    // $ANTLR start "CONSTINDICE"
    public final void mCONSTINDICE() throws RecognitionException {
        try {
            int _type = CONSTINDICE;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // Comb.g:15:12: ( 'c' | 'b' )
            // Comb.g:
            {
            if ( (input.LA(1)>='b' && input.LA(1)<='c') ) {
                input.consume();

            }
            else {
                MismatchedSetException mse = new MismatchedSetException(null,input);
                recover(mse);
                throw mse;}


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "CONSTINDICE"

    // $ANTLR start "P"
    public final void mP() throws RecognitionException {
        try {
            int _type = P;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // Comb.g:17:2: ( '\\\\Phi_' )
            // Comb.g:17:4: '\\\\Phi_'
            {
            match("\\Phi_"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "P"

    // $ANTLR start "K"
    public final void mK() throws RecognitionException {
        try {
            int _type = K;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // Comb.g:19:2: ( 'K' )
            // Comb.g:19:4: 'K'
            {
            match('K'); 

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "K"

    // $ANTLR start "X"
    public final void mX() throws RecognitionException {
        try {
            int _type = X;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // Comb.g:21:2: ( 'x' NUMBER )
            // Comb.g:21:4: 'x' NUMBER
            {
            match('x'); 
            mNUMBER(); 

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "X"

    // $ANTLR start "INITIALDIGIT"
    public final void mINITIALDIGIT() throws RecognitionException {
        try {
            int _type = INITIALDIGIT;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // Comb.g:23:13: ( '1' .. '9' )
            // Comb.g:23:15: '1' .. '9'
            {
            matchRange('1','9'); 

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "INITIALDIGIT"

    // $ANTLR start "DIGIT"
    public final void mDIGIT() throws RecognitionException {
        try {
            int _type = DIGIT;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // Comb.g:25:6: ( '0' | INITIALDIGIT )
            // Comb.g:
            {
            if ( (input.LA(1)>='0' && input.LA(1)<='9') ) {
                input.consume();

            }
            else {
                MismatchedSetException mse = new MismatchedSetException(null,input);
                recover(mse);
                throw mse;}


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "DIGIT"

    // $ANTLR start "NUMBER"
    public final void mNUMBER() throws RecognitionException {
        try {
            int _type = NUMBER;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // Comb.g:27:7: ( '0' | ( INITIALDIGIT )+ ( DIGIT )* )
            int alt3=2;
            int LA3_0 = input.LA(1);

            if ( (LA3_0=='0') ) {
                alt3=1;
            }
            else if ( ((LA3_0>='1' && LA3_0<='9')) ) {
                alt3=2;
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 3, 0, input);

                throw nvae;
            }
            switch (alt3) {
                case 1 :
                    // Comb.g:27:9: '0'
                    {
                    match('0'); 

                    }
                    break;
                case 2 :
                    // Comb.g:27:15: ( INITIALDIGIT )+ ( DIGIT )*
                    {
                    // Comb.g:27:15: ( INITIALDIGIT )+
                    int cnt1=0;
                    loop1:
                    do {
                        int alt1=2;
                        int LA1_0 = input.LA(1);

                        if ( ((LA1_0>='1' && LA1_0<='9')) ) {
                            alt1=1;
                        }


                        switch (alt1) {
                    	case 1 :
                    	    // Comb.g:27:15: INITIALDIGIT
                    	    {
                    	    mINITIALDIGIT(); 

                    	    }
                    	    break;

                    	default :
                    	    if ( cnt1 >= 1 ) break loop1;
                                EarlyExitException eee =
                                    new EarlyExitException(1, input);
                                throw eee;
                        }
                        cnt1++;
                    } while (true);

                    // Comb.g:27:28: ( DIGIT )*
                    loop2:
                    do {
                        int alt2=2;
                        int LA2_0 = input.LA(1);

                        if ( ((LA2_0>='0' && LA2_0<='9')) ) {
                            alt2=1;
                        }


                        switch (alt2) {
                    	case 1 :
                    	    // Comb.g:27:29: DIGIT
                    	    {
                    	    mDIGIT(); 

                    	    }
                    	    break;

                    	default :
                    	    break loop2;
                        }
                    } while (true);


                    }
                    break;

            }
            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "NUMBER"

    // $ANTLR start "WHITESPACE"
    public final void mWHITESPACE() throws RecognitionException {
        try {
            int _type = WHITESPACE;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // Comb.g:29:11: ( ( ' ' | '\\r' )+ )
            // Comb.g:29:13: ( ' ' | '\\r' )+
            {
            // Comb.g:29:13: ( ' ' | '\\r' )+
            int cnt4=0;
            loop4:
            do {
                int alt4=2;
                int LA4_0 = input.LA(1);

                if ( (LA4_0=='\r'||LA4_0==' ') ) {
                    alt4=1;
                }


                switch (alt4) {
            	case 1 :
            	    // Comb.g:
            	    {
            	    if ( input.LA(1)=='\r'||input.LA(1)==' ' ) {
            	        input.consume();

            	    }
            	    else {
            	        MismatchedSetException mse = new MismatchedSetException(null,input);
            	        recover(mse);
            	        throw mse;}


            	    }
            	    break;

            	default :
            	    if ( cnt4 >= 1 ) break loop4;
                        EarlyExitException eee =
                            new EarlyExitException(4, input);
                        throw eee;
                }
                cnt4++;
            } while (true);

            _channel = HIDDEN;

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "WHITESPACE"

    public void mTokens() throws RecognitionException {
        // Comb.g:1:8: ( T__12 | T__13 | T__14 | T__15 | T__16 | CONSTINDICE | P | K | X | INITIALDIGIT | DIGIT | NUMBER | WHITESPACE )
        int alt5=13;
        alt5 = dfa5.predict(input);
        switch (alt5) {
            case 1 :
                // Comb.g:1:10: T__12
                {
                mT__12(); 

                }
                break;
            case 2 :
                // Comb.g:1:16: T__13
                {
                mT__13(); 

                }
                break;
            case 3 :
                // Comb.g:1:22: T__14
                {
                mT__14(); 

                }
                break;
            case 4 :
                // Comb.g:1:28: T__15
                {
                mT__15(); 

                }
                break;
            case 5 :
                // Comb.g:1:34: T__16
                {
                mT__16(); 

                }
                break;
            case 6 :
                // Comb.g:1:40: CONSTINDICE
                {
                mCONSTINDICE(); 

                }
                break;
            case 7 :
                // Comb.g:1:52: P
                {
                mP(); 

                }
                break;
            case 8 :
                // Comb.g:1:54: K
                {
                mK(); 

                }
                break;
            case 9 :
                // Comb.g:1:56: X
                {
                mX(); 

                }
                break;
            case 10 :
                // Comb.g:1:58: INITIALDIGIT
                {
                mINITIALDIGIT(); 

                }
                break;
            case 11 :
                // Comb.g:1:71: DIGIT
                {
                mDIGIT(); 

                }
                break;
            case 12 :
                // Comb.g:1:77: NUMBER
                {
                mNUMBER(); 

                }
                break;
            case 13 :
                // Comb.g:1:84: WHITESPACE
                {
                mWHITESPACE(); 

                }
                break;

        }

    }


    protected DFA5 dfa5 = new DFA5(this);
    static final String DFA5_eotS =
        "\12\uffff\1\15\5\uffff";
    static final String DFA5_eofS =
        "\20\uffff";
    static final String DFA5_minS =
        "\1\15\11\uffff\1\60\5\uffff";
    static final String DFA5_maxS =
        "\1\175\11\uffff\1\71\5\uffff";
    static final String DFA5_acceptS =
        "\1\uffff\1\1\1\2\1\3\1\4\1\5\1\6\1\7\1\10\1\11\1\uffff\1\13\1\15"+
        "\1\12\1\14\1\13";
    static final String DFA5_specialS =
        "\20\uffff}>";
    static final String[] DFA5_transitionS = {
            "\1\14\22\uffff\1\14\7\uffff\1\3\1\4\2\uffff\1\5\3\uffff\1\13"+
            "\11\12\21\uffff\1\10\20\uffff\1\7\5\uffff\2\6\24\uffff\1\11"+
            "\2\uffff\1\1\1\uffff\1\2",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "\12\16",
            "",
            "",
            "",
            "",
            ""
    };

    static final short[] DFA5_eot = DFA.unpackEncodedString(DFA5_eotS);
    static final short[] DFA5_eof = DFA.unpackEncodedString(DFA5_eofS);
    static final char[] DFA5_min = DFA.unpackEncodedStringToUnsignedChars(DFA5_minS);
    static final char[] DFA5_max = DFA.unpackEncodedStringToUnsignedChars(DFA5_maxS);
    static final short[] DFA5_accept = DFA.unpackEncodedString(DFA5_acceptS);
    static final short[] DFA5_special = DFA.unpackEncodedString(DFA5_specialS);
    static final short[][] DFA5_transition;

    static {
        int numStates = DFA5_transitionS.length;
        DFA5_transition = new short[numStates][];
        for (int i=0; i<numStates; i++) {
            DFA5_transition[i] = DFA.unpackEncodedString(DFA5_transitionS[i]);
        }
    }

    class DFA5 extends DFA {

        public DFA5(BaseRecognizer recognizer) {
            this.recognizer = recognizer;
            this.decisionNumber = 5;
            this.eot = DFA5_eot;
            this.eof = DFA5_eof;
            this.min = DFA5_min;
            this.max = DFA5_max;
            this.accept = DFA5_accept;
            this.special = DFA5_special;
            this.transition = DFA5_transition;
        }
        public String getDescription() {
            return "1:1: Tokens : ( T__12 | T__13 | T__14 | T__15 | T__16 | CONSTINDICE | P | K | X | INITIALDIGIT | DIGIT | NUMBER | WHITESPACE );";
        }
    }
 

}
