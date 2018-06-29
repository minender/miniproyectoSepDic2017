// $ANTLR 3.2 Sep 23, 2009 12:02:23 Term.g 2018-01-07 14:24:50
package com.howtodoinjava.parse;

import org.antlr.runtime.*;
import java.util.Stack;
import java.util.List;
import java.util.ArrayList;

public class TermLexer extends Lexer {
    public static final int LETTER=5;
    public static final int CAPITALLETTER=4;
    public static final int T__19=19;
    public static final int T__15=15;
    public static final int T__16=16;
    public static final int T__17=17;
    public static final int WHITESPACE=8;
    public static final int T__18=18;
    public static final int T__11=11;
    public static final int T__33=33;
    public static final int T__12=12;
    public static final int T__13=13;
    public static final int T__14=14;
    public static final int EOF=-1;
    public static final int T__30=30;
    public static final int T__31=31;
    public static final int INITIALDIGIT=7;
    public static final int T__10=10;
    public static final int T__32=32;
    public static final int T__9=9;
    public static final int WORD=6;
    public static final int T__26=26;
    public static final int T__27=27;
    public static final int T__28=28;
    public static final int T__29=29;
    public static final int T__22=22;
    public static final int T__23=23;
    public static final int T__24=24;
    public static final int T__25=25;
    public static final int T__20=20;
    public static final int T__21=21;

    // delegates
    // delegators

    public TermLexer() {;} 
    public TermLexer(CharStream input) {
        this(input, new RecognizerSharedState());
    }
    public TermLexer(CharStream input, RecognizerSharedState state) {
        super(input,state);

    }
    public String getGrammarFileName() { return "Term.g"; }

    // $ANTLR start "T__9"
    public final void mT__9() throws RecognitionException {
        try {
            int _type = T__9;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // Term.g:3:6: ( '==' )
            // Term.g:3:8: '=='
            {
            match("=="); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__9"

    // $ANTLR start "T__10"
    public final void mT__10() throws RecognitionException {
        try {
            int _type = T__10;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // Term.g:4:7: ( '\\\\equiv' )
            // Term.g:4:9: '\\\\equiv'
            {
            match("\\equiv"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__10"

    // $ANTLR start "T__11"
    public final void mT__11() throws RecognitionException {
        try {
            int _type = T__11;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // Term.g:5:7: ( '==>' )
            // Term.g:5:9: '==>'
            {
            match("==>"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__11"

    // $ANTLR start "T__12"
    public final void mT__12() throws RecognitionException {
        try {
            int _type = T__12;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // Term.g:6:7: ( '\\\\Rightarrow' )
            // Term.g:6:9: '\\\\Rightarrow'
            {
            match("\\Rightarrow"); 


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
            // Term.g:7:7: ( '<==' )
            // Term.g:7:9: '<=='
            {
            match("<=="); 


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
            // Term.g:8:7: ( '\\\\Leftarrow' )
            // Term.g:8:9: '\\\\Leftarrow'
            {
            match("\\Leftarrow"); 


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
            // Term.g:9:7: ( '\\\\/' )
            // Term.g:9:9: '\\\\/'
            {
            match("\\/"); 


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
            // Term.g:10:7: ( '\\\\vee' )
            // Term.g:10:9: '\\\\vee'
            {
            match("\\vee"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__16"

    // $ANTLR start "T__17"
    public final void mT__17() throws RecognitionException {
        try {
            int _type = T__17;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // Term.g:11:7: ( '/\\\\' )
            // Term.g:11:9: '/\\\\'
            {
            match("/\\"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__17"

    // $ANTLR start "T__18"
    public final void mT__18() throws RecognitionException {
        try {
            int _type = T__18;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // Term.g:12:7: ( '\\\\wedge' )
            // Term.g:12:9: '\\\\wedge'
            {
            match("\\wedge"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__18"

    // $ANTLR start "T__19"
    public final void mT__19() throws RecognitionException {
        try {
            int _type = T__19;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // Term.g:13:7: ( '!==' )
            // Term.g:13:9: '!=='
            {
            match("!=="); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__19"

    // $ANTLR start "T__20"
    public final void mT__20() throws RecognitionException {
        try {
            int _type = T__20;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // Term.g:14:7: ( '\\\\not\\\\equiv' )
            // Term.g:14:9: '\\\\not\\\\equiv'
            {
            match("\\not\\equiv"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__20"

    // $ANTLR start "T__21"
    public final void mT__21() throws RecognitionException {
        try {
            int _type = T__21;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // Term.g:15:7: ( '!' )
            // Term.g:15:9: '!'
            {
            match('!'); 

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__21"

    // $ANTLR start "T__22"
    public final void mT__22() throws RecognitionException {
        try {
            int _type = T__22;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // Term.g:16:7: ( '\\\\neg' )
            // Term.g:16:9: '\\\\neg'
            {
            match("\\neg"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__22"

    // $ANTLR start "T__23"
    public final void mT__23() throws RecognitionException {
        try {
            int _type = T__23;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // Term.g:17:7: ( 'true' )
            // Term.g:17:9: 'true'
            {
            match("true"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__23"

    // $ANTLR start "T__24"
    public final void mT__24() throws RecognitionException {
        try {
            int _type = T__24;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // Term.g:18:7: ( 'false' )
            // Term.g:18:9: 'false'
            {
            match("false"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__24"

    // $ANTLR start "T__25"
    public final void mT__25() throws RecognitionException {
        try {
            int _type = T__25;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // Term.g:19:7: ( '_{' )
            // Term.g:19:9: '_{'
            {
            match("_{"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__25"

    // $ANTLR start "T__26"
    public final void mT__26() throws RecognitionException {
        try {
            int _type = T__26;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // Term.g:20:7: ( '}^{' )
            // Term.g:20:9: '}^{'
            {
            match("}^{"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__26"

    // $ANTLR start "T__27"
    public final void mT__27() throws RecognitionException {
        try {
            int _type = T__27;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // Term.g:21:7: ( '}' )
            // Term.g:21:9: '}'
            {
            match('}'); 

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__27"

    // $ANTLR start "T__28"
    public final void mT__28() throws RecognitionException {
        try {
            int _type = T__28;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // Term.g:22:7: ( '(' )
            // Term.g:22:9: '('
            {
            match('('); 

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__28"

    // $ANTLR start "T__29"
    public final void mT__29() throws RecognitionException {
        try {
            int _type = T__29;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // Term.g:23:7: ( ')' )
            // Term.g:23:9: ')'
            {
            match(')'); 

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__29"

    // $ANTLR start "T__30"
    public final void mT__30() throws RecognitionException {
        try {
            int _type = T__30;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // Term.g:24:7: ( ':=' )
            // Term.g:24:9: ':='
            {
            match(":="); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__30"

    // $ANTLR start "T__31"
    public final void mT__31() throws RecognitionException {
        try {
            int _type = T__31;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // Term.g:25:7: ( ',' )
            // Term.g:25:9: ','
            {
            match(','); 

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__31"

    // $ANTLR start "T__32"
    public final void mT__32() throws RecognitionException {
        try {
            int _type = T__32;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // Term.g:26:7: ( 'lambda' )
            // Term.g:26:9: 'lambda'
            {
            match("lambda"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__32"

    // $ANTLR start "T__33"
    public final void mT__33() throws RecognitionException {
        try {
            int _type = T__33;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // Term.g:27:7: ( '.' )
            // Term.g:27:9: '.'
            {
            match('.'); 

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__33"

    // $ANTLR start "INITIALDIGIT"
    public final void mINITIALDIGIT() throws RecognitionException {
        try {
            int _type = INITIALDIGIT;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // Term.g:183:13: ( '1' .. '9' )
            // Term.g:183:15: '1' .. '9'
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

    // $ANTLR start "CAPITALLETTER"
    public final void mCAPITALLETTER() throws RecognitionException {
        try {
            int _type = CAPITALLETTER;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // Term.g:189:14: ( 'A' .. 'Z' )
            // Term.g:189:16: 'A' .. 'Z'
            {
            matchRange('A','Z'); 

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "CAPITALLETTER"

    // $ANTLR start "LETTER"
    public final void mLETTER() throws RecognitionException {
        try {
            int _type = LETTER;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // Term.g:191:7: ( 'a' .. 'z' )
            // Term.g:191:9: 'a' .. 'z'
            {
            matchRange('a','z'); 

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "LETTER"

    // $ANTLR start "WORD"
    public final void mWORD() throws RecognitionException {
        try {
            int _type = WORD;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // Term.g:193:5: ( CAPITALLETTER ( LETTER )+ | CAPITALLETTER )
            int alt2=2;
            int LA2_0 = input.LA(1);

            if ( ((LA2_0>='A' && LA2_0<='Z')) ) {
                int LA2_1 = input.LA(2);

                if ( ((LA2_1>='a' && LA2_1<='z')) ) {
                    alt2=1;
                }
                else {
                    alt2=2;}
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 2, 0, input);

                throw nvae;
            }
            switch (alt2) {
                case 1 :
                    // Term.g:193:9: CAPITALLETTER ( LETTER )+
                    {
                    mCAPITALLETTER(); 
                    // Term.g:193:23: ( LETTER )+
                    int cnt1=0;
                    loop1:
                    do {
                        int alt1=2;
                        int LA1_0 = input.LA(1);

                        if ( ((LA1_0>='a' && LA1_0<='z')) ) {
                            alt1=1;
                        }


                        switch (alt1) {
                    	case 1 :
                    	    // Term.g:193:24: LETTER
                    	    {
                    	    mLETTER(); 

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


                    }
                    break;
                case 2 :
                    // Term.g:195:9: CAPITALLETTER
                    {
                    mCAPITALLETTER(); 

                    }
                    break;

            }
            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "WORD"

    // $ANTLR start "WHITESPACE"
    public final void mWHITESPACE() throws RecognitionException {
        try {
            int _type = WHITESPACE;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // Term.g:197:11: ( ( ' ' | '\\r' )+ )
            // Term.g:197:13: ( ' ' | '\\r' )+
            {
            // Term.g:197:13: ( ' ' | '\\r' )+
            int cnt3=0;
            loop3:
            do {
                int alt3=2;
                int LA3_0 = input.LA(1);

                if ( (LA3_0=='\r'||LA3_0==' ') ) {
                    alt3=1;
                }


                switch (alt3) {
            	case 1 :
            	    // Term.g:
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
            	    if ( cnt3 >= 1 ) break loop3;
                        EarlyExitException eee =
                            new EarlyExitException(3, input);
                        throw eee;
                }
                cnt3++;
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
        // Term.g:1:8: ( T__9 | T__10 | T__11 | T__12 | T__13 | T__14 | T__15 | T__16 | T__17 | T__18 | T__19 | T__20 | T__21 | T__22 | T__23 | T__24 | T__25 | T__26 | T__27 | T__28 | T__29 | T__30 | T__31 | T__32 | T__33 | INITIALDIGIT | CAPITALLETTER | LETTER | WORD | WHITESPACE )
        int alt4=30;
        alt4 = dfa4.predict(input);
        switch (alt4) {
            case 1 :
                // Term.g:1:10: T__9
                {
                mT__9(); 

                }
                break;
            case 2 :
                // Term.g:1:15: T__10
                {
                mT__10(); 

                }
                break;
            case 3 :
                // Term.g:1:21: T__11
                {
                mT__11(); 

                }
                break;
            case 4 :
                // Term.g:1:27: T__12
                {
                mT__12(); 

                }
                break;
            case 5 :
                // Term.g:1:33: T__13
                {
                mT__13(); 

                }
                break;
            case 6 :
                // Term.g:1:39: T__14
                {
                mT__14(); 

                }
                break;
            case 7 :
                // Term.g:1:45: T__15
                {
                mT__15(); 

                }
                break;
            case 8 :
                // Term.g:1:51: T__16
                {
                mT__16(); 

                }
                break;
            case 9 :
                // Term.g:1:57: T__17
                {
                mT__17(); 

                }
                break;
            case 10 :
                // Term.g:1:63: T__18
                {
                mT__18(); 

                }
                break;
            case 11 :
                // Term.g:1:69: T__19
                {
                mT__19(); 

                }
                break;
            case 12 :
                // Term.g:1:75: T__20
                {
                mT__20(); 

                }
                break;
            case 13 :
                // Term.g:1:81: T__21
                {
                mT__21(); 

                }
                break;
            case 14 :
                // Term.g:1:87: T__22
                {
                mT__22(); 

                }
                break;
            case 15 :
                // Term.g:1:93: T__23
                {
                mT__23(); 

                }
                break;
            case 16 :
                // Term.g:1:99: T__24
                {
                mT__24(); 

                }
                break;
            case 17 :
                // Term.g:1:105: T__25
                {
                mT__25(); 

                }
                break;
            case 18 :
                // Term.g:1:111: T__26
                {
                mT__26(); 

                }
                break;
            case 19 :
                // Term.g:1:117: T__27
                {
                mT__27(); 

                }
                break;
            case 20 :
                // Term.g:1:123: T__28
                {
                mT__28(); 

                }
                break;
            case 21 :
                // Term.g:1:129: T__29
                {
                mT__29(); 

                }
                break;
            case 22 :
                // Term.g:1:135: T__30
                {
                mT__30(); 

                }
                break;
            case 23 :
                // Term.g:1:141: T__31
                {
                mT__31(); 

                }
                break;
            case 24 :
                // Term.g:1:147: T__32
                {
                mT__32(); 

                }
                break;
            case 25 :
                // Term.g:1:153: T__33
                {
                mT__33(); 

                }
                break;
            case 26 :
                // Term.g:1:159: INITIALDIGIT
                {
                mINITIALDIGIT(); 

                }
                break;
            case 27 :
                // Term.g:1:172: CAPITALLETTER
                {
                mCAPITALLETTER(); 

                }
                break;
            case 28 :
                // Term.g:1:186: LETTER
                {
                mLETTER(); 

                }
                break;
            case 29 :
                // Term.g:1:193: WORD
                {
                mWORD(); 

                }
                break;
            case 30 :
                // Term.g:1:198: WHITESPACE
                {
                mWHITESPACE(); 

                }
                break;

        }

    }


    protected DFA4 dfa4 = new DFA4(this);
    static final String DFA4_eotS =
        "\5\uffff\1\35\2\22\1\uffff\1\41\4\uffff\1\22\2\uffff\1\43\2\uffff"+
        "\1\46\24\uffff";
    static final String DFA4_eofS =
        "\51\uffff";
    static final String DFA4_minS =
        "\1\15\1\75\1\57\2\uffff\1\75\1\162\1\141\1\uffff\1\136\4\uffff\1"+
        "\141\2\uffff\1\141\2\uffff\1\76\6\uffff\1\145\15\uffff";
    static final String DFA4_maxS =
        "\1\175\1\75\1\167\2\uffff\1\75\1\162\1\141\1\uffff\1\136\4\uffff"+
        "\1\141\2\uffff\1\172\2\uffff\1\76\6\uffff\1\157\15\uffff";
    static final String DFA4_acceptS =
        "\3\uffff\1\5\1\11\3\uffff\1\21\1\uffff\1\24\1\25\1\26\1\27\1\uffff"+
        "\1\31\1\32\1\uffff\1\34\1\36\1\uffff\1\2\1\4\1\6\1\7\1\10\1\12\1"+
        "\uffff\1\13\1\15\1\17\1\20\1\22\1\23\1\30\1\33\1\35\1\3\1\1\1\14"+
        "\1\16";
    static final String DFA4_specialS =
        "\51\uffff}>";
    static final String[] DFA4_transitionS = {
            "\1\23\22\uffff\1\23\1\5\6\uffff\1\12\1\13\2\uffff\1\15\1\uffff"+
            "\1\17\1\4\1\uffff\11\20\1\14\1\uffff\1\3\1\1\3\uffff\32\21\1"+
            "\uffff\1\2\2\uffff\1\10\1\uffff\5\22\1\7\5\22\1\16\7\22\1\6"+
            "\6\22\2\uffff\1\11",
            "\1\24",
            "\1\30\34\uffff\1\27\5\uffff\1\26\22\uffff\1\25\10\uffff\1\33"+
            "\7\uffff\1\31\1\32",
            "",
            "",
            "\1\34",
            "\1\36",
            "\1\37",
            "",
            "\1\40",
            "",
            "",
            "",
            "",
            "\1\42",
            "",
            "",
            "\32\44",
            "",
            "",
            "\1\45",
            "",
            "",
            "",
            "",
            "",
            "",
            "\1\50\11\uffff\1\47",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            ""
    };

    static final short[] DFA4_eot = DFA.unpackEncodedString(DFA4_eotS);
    static final short[] DFA4_eof = DFA.unpackEncodedString(DFA4_eofS);
    static final char[] DFA4_min = DFA.unpackEncodedStringToUnsignedChars(DFA4_minS);
    static final char[] DFA4_max = DFA.unpackEncodedStringToUnsignedChars(DFA4_maxS);
    static final short[] DFA4_accept = DFA.unpackEncodedString(DFA4_acceptS);
    static final short[] DFA4_special = DFA.unpackEncodedString(DFA4_specialS);
    static final short[][] DFA4_transition;

    static {
        int numStates = DFA4_transitionS.length;
        DFA4_transition = new short[numStates][];
        for (int i=0; i<numStates; i++) {
            DFA4_transition[i] = DFA.unpackEncodedString(DFA4_transitionS[i]);
        }
    }

    class DFA4 extends DFA {

        public DFA4(BaseRecognizer recognizer) {
            this.recognizer = recognizer;
            this.decisionNumber = 4;
            this.eot = DFA4_eot;
            this.eof = DFA4_eof;
            this.min = DFA4_min;
            this.max = DFA4_max;
            this.accept = DFA4_accept;
            this.special = DFA4_special;
            this.transition = DFA4_transition;
        }
        public String getDescription() {
            return "1:1: Tokens : ( T__9 | T__10 | T__11 | T__12 | T__13 | T__14 | T__15 | T__16 | T__17 | T__18 | T__19 | T__20 | T__21 | T__22 | T__23 | T__24 | T__25 | T__26 | T__27 | T__28 | T__29 | T__30 | T__31 | T__32 | T__33 | INITIALDIGIT | CAPITALLETTER | LETTER | WORD | WHITESPACE );";
        }
    }
 

}