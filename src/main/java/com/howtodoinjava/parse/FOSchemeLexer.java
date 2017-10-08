// $ANTLR 3.2 Sep 23, 2009 12:02:23 FOScheme.g 2017-03-31 17:37:48
package com.howtodoinjava.parse; 

import org.antlr.runtime.*;
import java.util.Stack;
import java.util.List;
import java.util.ArrayList;

public class FOSchemeLexer extends Lexer {
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
    public static final int T__19=19;
    public static final int T__30=30;
    public static final int T__31=31;
    public static final int T__32=32;
    public static final int T__16=16;
    public static final int T__33=33;
    public static final int T__15=15;
    public static final int T__34=34;
    public static final int T__18=18;
    public static final int T__35=35;
    public static final int T__17=17;
    public static final int T__36=36;
    public static final int T__12=12;
    public static final int T__37=37;
    public static final int T__11=11;
    public static final int T__38=38;
    public static final int T__14=14;
    public static final int T__13=13;
    public static final int DIGIT=8;

    // delegates
    // delegators

    public FOSchemeLexer() {;} 
    public FOSchemeLexer(CharStream input) {
        this(input, new RecognizerSharedState());
    }
    public FOSchemeLexer(CharStream input, RecognizerSharedState state) {
        super(input,state);

    }
    public String getGrammarFileName() { return "FOScheme.g"; }

    // $ANTLR start "T__11"
    public final void mT__11() throws RecognitionException {
        try {
            int _type = T__11;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // FOScheme.g:3:7: ( '==' )
            // FOScheme.g:3:9: '=='
            {
            match("=="); 


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
            // FOScheme.g:4:7: ( '\\\\equiv' )
            // FOScheme.g:4:9: '\\\\equiv'
            {
            match("\\equiv"); 


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
            // FOScheme.g:5:7: ( '==>' )
            // FOScheme.g:5:9: '==>'
            {
            match("==>"); 


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
            // FOScheme.g:6:7: ( '\\\\Rightarrow' )
            // FOScheme.g:6:9: '\\\\Rightarrow'
            {
            match("\\Rightarrow"); 


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
            // FOScheme.g:7:7: ( '<==' )
            // FOScheme.g:7:9: '<=='
            {
            match("<=="); 


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
            // FOScheme.g:8:7: ( '\\\\Leftarrow' )
            // FOScheme.g:8:9: '\\\\Leftarrow'
            {
            match("\\Leftarrow"); 


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
            // FOScheme.g:9:7: ( '\\\\/' )
            // FOScheme.g:9:9: '\\\\/'
            {
            match("\\/"); 


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
            // FOScheme.g:10:7: ( '\\\\vee' )
            // FOScheme.g:10:9: '\\\\vee'
            {
            match("\\vee"); 


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
            // FOScheme.g:11:7: ( '/\\\\' )
            // FOScheme.g:11:9: '/\\\\'
            {
            match("/\\"); 


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
            // FOScheme.g:12:7: ( '\\\\wedge' )
            // FOScheme.g:12:9: '\\\\wedge'
            {
            match("\\wedge"); 


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
            // FOScheme.g:13:7: ( '!==' )
            // FOScheme.g:13:9: '!=='
            {
            match("!=="); 


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
            // FOScheme.g:14:7: ( '\\\\nequiv' )
            // FOScheme.g:14:9: '\\\\nequiv'
            {
            match("\\nequiv"); 


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
            // FOScheme.g:15:7: ( '!' )
            // FOScheme.g:15:9: '!'
            {
            match('!'); 

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
            // FOScheme.g:16:7: ( '\\\\neg' )
            // FOScheme.g:16:9: '\\\\neg'
            {
            match("\\neg"); 


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
            // FOScheme.g:17:7: ( 'true' )
            // FOScheme.g:17:9: 'true'
            {
            match("true"); 


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
            // FOScheme.g:18:7: ( 'false' )
            // FOScheme.g:18:9: 'false'
            {
            match("false"); 


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
            // FOScheme.g:19:7: ( '(' )
            // FOScheme.g:19:9: '('
            {
            match('('); 

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
            // FOScheme.g:20:7: ( 'forall' )
            // FOScheme.g:20:9: 'forall'
            {
            match("forall"); 


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
            // FOScheme.g:21:7: ( '|' )
            // FOScheme.g:21:9: '|'
            {
            match('|'); 

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
            // FOScheme.g:22:7: ( ':' )
            // FOScheme.g:22:9: ':'
            {
            match(':'); 

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
            // FOScheme.g:23:7: ( ')' )
            // FOScheme.g:23:9: ')'
            {
            match(')'); 

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
            // FOScheme.g:24:7: ( 'exists' )
            // FOScheme.g:24:9: 'exists'
            {
            match("exists"); 


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
            // FOScheme.g:25:7: ( '[' )
            // FOScheme.g:25:9: '['
            {
            match('['); 

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__33"

    // $ANTLR start "T__34"
    public final void mT__34() throws RecognitionException {
        try {
            int _type = T__34;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // FOScheme.g:26:7: ( ':=' )
            // FOScheme.g:26:9: ':='
            {
            match(":="); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__34"

    // $ANTLR start "T__35"
    public final void mT__35() throws RecognitionException {
        try {
            int _type = T__35;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // FOScheme.g:27:7: ( ']' )
            // FOScheme.g:27:9: ']'
            {
            match(']'); 

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__35"

    // $ANTLR start "T__36"
    public final void mT__36() throws RecognitionException {
        try {
            int _type = T__36;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // FOScheme.g:28:7: ( ',' )
            // FOScheme.g:28:9: ','
            {
            match(','); 

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__36"

    // $ANTLR start "T__37"
    public final void mT__37() throws RecognitionException {
        try {
            int _type = T__37;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // FOScheme.g:29:7: ( 'lambda' )
            // FOScheme.g:29:9: 'lambda'
            {
            match("lambda"); 


            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__37"

    // $ANTLR start "T__38"
    public final void mT__38() throws RecognitionException {
        try {
            int _type = T__38;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // FOScheme.g:30:7: ( '.' )
            // FOScheme.g:30:9: '.'
            {
            match('.'); 

            }

            state.type = _type;
            state.channel = _channel;
        }
        finally {
        }
    }
    // $ANTLR end "T__38"

    // $ANTLR start "INITIALDIGIT"
    public final void mINITIALDIGIT() throws RecognitionException {
        try {
            int _type = INITIALDIGIT;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // FOScheme.g:217:13: ( '1' .. '9' )
            // FOScheme.g:217:15: '1' .. '9'
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
            // FOScheme.g:219:6: ( '0' | INITIALDIGIT )
            // FOScheme.g:
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
            // FOScheme.g:221:7: ( '0' | INITIALDIGIT ( DIGIT )* )
            int alt2=2;
            int LA2_0 = input.LA(1);

            if ( (LA2_0=='0') ) {
                alt2=1;
            }
            else if ( ((LA2_0>='1' && LA2_0<='9')) ) {
                alt2=2;
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 2, 0, input);

                throw nvae;
            }
            switch (alt2) {
                case 1 :
                    // FOScheme.g:221:9: '0'
                    {
                    match('0'); 

                    }
                    break;
                case 2 :
                    // FOScheme.g:221:15: INITIALDIGIT ( DIGIT )*
                    {
                    mINITIALDIGIT(); 
                    // FOScheme.g:221:28: ( DIGIT )*
                    loop1:
                    do {
                        int alt1=2;
                        int LA1_0 = input.LA(1);

                        if ( ((LA1_0>='0' && LA1_0<='9')) ) {
                            alt1=1;
                        }


                        switch (alt1) {
                    	case 1 :
                    	    // FOScheme.g:221:29: DIGIT
                    	    {
                    	    mDIGIT(); 

                    	    }
                    	    break;

                    	default :
                    	    break loop1;
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

    // $ANTLR start "CAPITALLETTER"
    public final void mCAPITALLETTER() throws RecognitionException {
        try {
            int _type = CAPITALLETTER;
            int _channel = DEFAULT_TOKEN_CHANNEL;
            // FOScheme.g:223:14: ( 'A' .. 'Z' )
            // FOScheme.g:223:16: 'A' .. 'Z'
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
            // FOScheme.g:225:7: ( 'a' .. 'z' )
            // FOScheme.g:225:9: 'a' .. 'z'
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
            // FOScheme.g:227:5: ( CAPITALLETTER ( LETTER )+ | CAPITALLETTER )
            int alt4=2;
            int LA4_0 = input.LA(1);

            if ( ((LA4_0>='A' && LA4_0<='Z')) ) {
                int LA4_1 = input.LA(2);

                if ( ((LA4_1>='a' && LA4_1<='z')) ) {
                    alt4=1;
                }
                else {
                    alt4=2;}
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 4, 0, input);

                throw nvae;
            }
            switch (alt4) {
                case 1 :
                    // FOScheme.g:227:9: CAPITALLETTER ( LETTER )+
                    {
                    mCAPITALLETTER(); 
                    // FOScheme.g:227:23: ( LETTER )+
                    int cnt3=0;
                    loop3:
                    do {
                        int alt3=2;
                        int LA3_0 = input.LA(1);

                        if ( ((LA3_0>='a' && LA3_0<='z')) ) {
                            alt3=1;
                        }


                        switch (alt3) {
                    	case 1 :
                    	    // FOScheme.g:227:24: LETTER
                    	    {
                    	    mLETTER(); 

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


                    }
                    break;
                case 2 :
                    // FOScheme.g:229:9: CAPITALLETTER
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
            // FOScheme.g:231:11: ( ( ' ' | '\\r' )+ )
            // FOScheme.g:231:13: ( ' ' | '\\r' )+
            {
            // FOScheme.g:231:13: ( ' ' | '\\r' )+
            int cnt5=0;
            loop5:
            do {
                int alt5=2;
                int LA5_0 = input.LA(1);

                if ( (LA5_0=='\r'||LA5_0==' ') ) {
                    alt5=1;
                }


                switch (alt5) {
            	case 1 :
            	    // FOScheme.g:
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
            	    if ( cnt5 >= 1 ) break loop5;
                        EarlyExitException eee =
                            new EarlyExitException(5, input);
                        throw eee;
                }
                cnt5++;
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
        // FOScheme.g:1:8: ( T__11 | T__12 | T__13 | T__14 | T__15 | T__16 | T__17 | T__18 | T__19 | T__20 | T__21 | T__22 | T__23 | T__24 | T__25 | T__26 | T__27 | T__28 | T__29 | T__30 | T__31 | T__32 | T__33 | T__34 | T__35 | T__36 | T__37 | T__38 | INITIALDIGIT | DIGIT | NUMBER | CAPITALLETTER | LETTER | WORD | WHITESPACE )
        int alt6=35;
        alt6 = dfa6.predict(input);
        switch (alt6) {
            case 1 :
                // FOScheme.g:1:10: T__11
                {
                mT__11(); 

                }
                break;
            case 2 :
                // FOScheme.g:1:16: T__12
                {
                mT__12(); 

                }
                break;
            case 3 :
                // FOScheme.g:1:22: T__13
                {
                mT__13(); 

                }
                break;
            case 4 :
                // FOScheme.g:1:28: T__14
                {
                mT__14(); 

                }
                break;
            case 5 :
                // FOScheme.g:1:34: T__15
                {
                mT__15(); 

                }
                break;
            case 6 :
                // FOScheme.g:1:40: T__16
                {
                mT__16(); 

                }
                break;
            case 7 :
                // FOScheme.g:1:46: T__17
                {
                mT__17(); 

                }
                break;
            case 8 :
                // FOScheme.g:1:52: T__18
                {
                mT__18(); 

                }
                break;
            case 9 :
                // FOScheme.g:1:58: T__19
                {
                mT__19(); 

                }
                break;
            case 10 :
                // FOScheme.g:1:64: T__20
                {
                mT__20(); 

                }
                break;
            case 11 :
                // FOScheme.g:1:70: T__21
                {
                mT__21(); 

                }
                break;
            case 12 :
                // FOScheme.g:1:76: T__22
                {
                mT__22(); 

                }
                break;
            case 13 :
                // FOScheme.g:1:82: T__23
                {
                mT__23(); 

                }
                break;
            case 14 :
                // FOScheme.g:1:88: T__24
                {
                mT__24(); 

                }
                break;
            case 15 :
                // FOScheme.g:1:94: T__25
                {
                mT__25(); 

                }
                break;
            case 16 :
                // FOScheme.g:1:100: T__26
                {
                mT__26(); 

                }
                break;
            case 17 :
                // FOScheme.g:1:106: T__27
                {
                mT__27(); 

                }
                break;
            case 18 :
                // FOScheme.g:1:112: T__28
                {
                mT__28(); 

                }
                break;
            case 19 :
                // FOScheme.g:1:118: T__29
                {
                mT__29(); 

                }
                break;
            case 20 :
                // FOScheme.g:1:124: T__30
                {
                mT__30(); 

                }
                break;
            case 21 :
                // FOScheme.g:1:130: T__31
                {
                mT__31(); 

                }
                break;
            case 22 :
                // FOScheme.g:1:136: T__32
                {
                mT__32(); 

                }
                break;
            case 23 :
                // FOScheme.g:1:142: T__33
                {
                mT__33(); 

                }
                break;
            case 24 :
                // FOScheme.g:1:148: T__34
                {
                mT__34(); 

                }
                break;
            case 25 :
                // FOScheme.g:1:154: T__35
                {
                mT__35(); 

                }
                break;
            case 26 :
                // FOScheme.g:1:160: T__36
                {
                mT__36(); 

                }
                break;
            case 27 :
                // FOScheme.g:1:166: T__37
                {
                mT__37(); 

                }
                break;
            case 28 :
                // FOScheme.g:1:172: T__38
                {
                mT__38(); 

                }
                break;
            case 29 :
                // FOScheme.g:1:178: INITIALDIGIT
                {
                mINITIALDIGIT(); 

                }
                break;
            case 30 :
                // FOScheme.g:1:191: DIGIT
                {
                mDIGIT(); 

                }
                break;
            case 31 :
                // FOScheme.g:1:197: NUMBER
                {
                mNUMBER(); 

                }
                break;
            case 32 :
                // FOScheme.g:1:204: CAPITALLETTER
                {
                mCAPITALLETTER(); 

                }
                break;
            case 33 :
                // FOScheme.g:1:218: LETTER
                {
                mLETTER(); 

                }
                break;
            case 34 :
                // FOScheme.g:1:225: WORD
                {
                mWORD(); 

                }
                break;
            case 35 :
                // FOScheme.g:1:230: WHITESPACE
                {
                mWHITESPACE(); 

                }
                break;

        }

    }


    protected DFA6 dfa6 = new DFA6(this);
    static final String DFA6_eotS =
        "\5\uffff\1\40\2\25\2\uffff\1\45\1\uffff\1\25\3\uffff\1\25\1\uffff"+
        "\1\50\1\uffff\1\53\2\uffff\1\56\32\uffff";
    static final String DFA6_eofS =
        "\62\uffff";
    static final String DFA6_minS =
        "\1\15\1\75\1\57\2\uffff\1\75\1\162\1\141\2\uffff\1\75\1\uffff\1"+
        "\170\3\uffff\1\141\1\uffff\1\60\1\uffff\1\141\2\uffff\1\76\6\uffff"+
        "\1\145\20\uffff\1\147\2\uffff";
    static final String DFA6_maxS =
        "\1\174\1\75\1\167\2\uffff\1\75\1\162\1\157\2\uffff\1\75\1\uffff"+
        "\1\170\3\uffff\1\141\1\uffff\1\71\1\uffff\1\172\2\uffff\1\76\6\uffff"+
        "\1\145\20\uffff\1\161\2\uffff";
    static final String DFA6_acceptS =
        "\3\uffff\1\5\1\11\3\uffff\1\21\1\23\1\uffff\1\25\1\uffff\1\27\1"+
        "\31\1\32\1\uffff\1\34\1\uffff\1\36\1\uffff\1\41\1\43\1\uffff\1\2"+
        "\1\4\1\6\1\7\1\10\1\12\1\uffff\1\13\1\15\1\17\1\20\1\22\1\30\1\24"+
        "\1\26\1\33\1\35\1\37\1\36\1\40\1\42\1\3\1\1\1\uffff\1\14\1\16";
    static final String DFA6_specialS =
        "\62\uffff}>";
    static final String[] DFA6_transitionS = {
            "\1\26\22\uffff\1\26\1\5\6\uffff\1\10\1\13\2\uffff\1\17\1\uffff"+
            "\1\21\1\4\1\23\11\22\1\12\1\uffff\1\3\1\1\3\uffff\32\24\1\15"+
            "\1\2\1\16\3\uffff\4\25\1\14\1\7\5\25\1\20\7\25\1\6\6\25\1\uffff"+
            "\1\11",
            "\1\27",
            "\1\33\34\uffff\1\32\5\uffff\1\31\22\uffff\1\30\10\uffff\1\36"+
            "\7\uffff\1\34\1\35",
            "",
            "",
            "\1\37",
            "\1\41",
            "\1\42\15\uffff\1\43",
            "",
            "",
            "\1\44",
            "",
            "\1\46",
            "",
            "",
            "",
            "\1\47",
            "",
            "\12\51",
            "",
            "\32\54",
            "",
            "",
            "\1\55",
            "",
            "",
            "",
            "",
            "",
            "",
            "\1\57",
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
            "",
            "",
            "",
            "",
            "\1\61\11\uffff\1\60",
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
            return "1:1: Tokens : ( T__11 | T__12 | T__13 | T__14 | T__15 | T__16 | T__17 | T__18 | T__19 | T__20 | T__21 | T__22 | T__23 | T__24 | T__25 | T__26 | T__27 | T__28 | T__29 | T__30 | T__31 | T__32 | T__33 | T__34 | T__35 | T__36 | T__37 | T__38 | INITIALDIGIT | DIGIT | NUMBER | CAPITALLETTER | LETTER | WORD | WHITESPACE );";
        }
    }
 

}