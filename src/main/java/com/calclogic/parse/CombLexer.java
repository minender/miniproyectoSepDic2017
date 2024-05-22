// Generated from Comb.g4 by ANTLR 4.8

    
package com.calclogic.parse; 

import com.calclogic.lambdacalculo.*;   
import java.util.LinkedList;
import com.calclogic.entity.Resuelve; 
import com.calclogic.service.SimboloManager;  
    

import org.antlr.v4.runtime.Lexer;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.Token;
import org.antlr.v4.runtime.TokenStream;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.misc.*;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast"})
public class CombLexer extends Lexer {
	static { RuntimeMetaData.checkVersion("4.8", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		DIGITS=1, C=2, X=3, EQUAL=4, TRUE=5, PHI=6, LAMBDA=7, PERIOD=8, K=9, CB=10, 
		O_PAR=11, C_PAR=12, COMMA=13, C_BRACKET=14, O_BRACKET2=15, C_BRACKET2=16, 
		EXP=17, ASSIGN=18, A=19, M=20, I=21, L=22, S=23, Si=24, WHITESPACE=25;
	public static String[] channelNames = {
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	};

	public static String[] modeNames = {
		"DEFAULT_MODE"
	};

	private static String[] makeRuleNames() {
		return new String[] {
			"DIGITS", "C", "X", "EQUAL", "TRUE", "PHI", "LAMBDA", "PERIOD", "K", 
			"CB", "O_PAR", "C_PAR", "COMMA", "C_BRACKET", "O_BRACKET2", "C_BRACKET2", 
			"EXP", "ASSIGN", "A", "M", "I", "L", "S", "Si", "WHITESPACE"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, null, null, null, "'='", "'T'", "'\\Phi_{'", "'\\lambda'", "'.'", 
			"'K'", null, "'('", "')'", "','", "'}'", "'['", "']'", "'}^{'", "':='", 
			"'A^{'", "'M_{'", "'I^{'", "'L^{'", "'S^{'", "'S'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, "DIGITS", "C", "X", "EQUAL", "TRUE", "PHI", "LAMBDA", "PERIOD", 
			"K", "CB", "O_PAR", "C_PAR", "COMMA", "C_BRACKET", "O_BRACKET2", "C_BRACKET2", 
			"EXP", "ASSIGN", "A", "M", "I", "L", "S", "Si", "WHITESPACE"
		};
	}
	private static final String[] _SYMBOLIC_NAMES = makeSymbolicNames();
	public static final Vocabulary VOCABULARY = new VocabularyImpl(_LITERAL_NAMES, _SYMBOLIC_NAMES);

	/**
	 * @deprecated Use {@link #VOCABULARY} instead.
	 */
	@Deprecated
	public static final String[] tokenNames;
	static {
		tokenNames = new String[_SYMBOLIC_NAMES.length];
		for (int i = 0; i < tokenNames.length; i++) {
			tokenNames[i] = VOCABULARY.getLiteralName(i);
			if (tokenNames[i] == null) {
				tokenNames[i] = VOCABULARY.getSymbolicName(i);
			}

			if (tokenNames[i] == null) {
				tokenNames[i] = "<INVALID>";
			}
		}
	}

	@Override
	@Deprecated
	public String[] getTokenNames() {
		return tokenNames;
	}

	@Override

	public Vocabulary getVocabulary() {
		return VOCABULARY;
	}


	public CombLexer(CharStream input) {
		super(input);
		_interp = new LexerATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}

	@Override
	public String getGrammarFileName() { return "Comb.g4"; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public String getSerializedATN() { return _serializedATN; }

	@Override
	public String[] getChannelNames() { return channelNames; }

	@Override
	public String[] getModeNames() { return modeNames; }

	@Override
	public ATN getATN() { return _ATN; }

	public static final String _serializedATN =
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\2\33\u009c\b\1\4\2"+
		"\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4"+
		"\13\t\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22"+
		"\t\22\4\23\t\23\4\24\t\24\4\25\t\25\4\26\t\26\4\27\t\27\4\30\t\30\4\31"+
		"\t\31\4\32\t\32\3\2\3\2\5\28\n\2\3\2\3\2\7\2<\n\2\f\2\16\2?\13\2\3\2\5"+
		"\2B\n\2\3\3\3\3\3\3\3\3\3\3\3\3\5\3J\n\3\3\4\3\4\3\4\3\4\3\4\3\4\5\4R"+
		"\n\4\3\5\3\5\3\6\3\6\3\7\3\7\3\7\3\7\3\7\3\7\3\7\3\b\3\b\3\b\3\b\3\b\3"+
		"\b\3\b\3\b\3\t\3\t\3\n\3\n\3\13\3\13\3\f\3\f\3\r\3\r\3\16\3\16\3\17\3"+
		"\17\3\20\3\20\3\21\3\21\3\22\3\22\3\22\3\22\3\23\3\23\3\23\3\24\3\24\3"+
		"\24\3\24\3\25\3\25\3\25\3\25\3\26\3\26\3\26\3\26\3\27\3\27\3\27\3\27\3"+
		"\30\3\30\3\30\3\30\3\31\3\31\3\32\6\32\u0097\n\32\r\32\16\32\u0098\3\32"+
		"\3\32\2\2\33\3\3\5\4\7\5\t\6\13\7\r\b\17\t\21\n\23\13\25\f\27\r\31\16"+
		"\33\17\35\20\37\21!\22#\23%\24\'\25)\26+\27-\30/\31\61\32\63\33\3\2\4"+
		"\3\2\62;\5\2\13\f\17\17\"\"\2\u00a1\2\3\3\2\2\2\2\5\3\2\2\2\2\7\3\2\2"+
		"\2\2\t\3\2\2\2\2\13\3\2\2\2\2\r\3\2\2\2\2\17\3\2\2\2\2\21\3\2\2\2\2\23"+
		"\3\2\2\2\2\25\3\2\2\2\2\27\3\2\2\2\2\31\3\2\2\2\2\33\3\2\2\2\2\35\3\2"+
		"\2\2\2\37\3\2\2\2\2!\3\2\2\2\2#\3\2\2\2\2%\3\2\2\2\2\'\3\2\2\2\2)\3\2"+
		"\2\2\2+\3\2\2\2\2-\3\2\2\2\2/\3\2\2\2\2\61\3\2\2\2\2\63\3\2\2\2\3\67\3"+
		"\2\2\2\5I\3\2\2\2\7Q\3\2\2\2\tS\3\2\2\2\13U\3\2\2\2\rW\3\2\2\2\17^\3\2"+
		"\2\2\21f\3\2\2\2\23h\3\2\2\2\25j\3\2\2\2\27l\3\2\2\2\31n\3\2\2\2\33p\3"+
		"\2\2\2\35r\3\2\2\2\37t\3\2\2\2!v\3\2\2\2#x\3\2\2\2%|\3\2\2\2\'\177\3\2"+
		"\2\2)\u0083\3\2\2\2+\u0087\3\2\2\2-\u008b\3\2\2\2/\u008f\3\2\2\2\61\u0093"+
		"\3\2\2\2\63\u0096\3\2\2\2\658\7/\2\2\668\3\2\2\2\67\65\3\2\2\2\67\66\3"+
		"\2\2\28A\3\2\2\29=\4\63;\2:<\t\2\2\2;:\3\2\2\2<?\3\2\2\2=;\3\2\2\2=>\3"+
		"\2\2\2>B\3\2\2\2?=\3\2\2\2@B\7\62\2\2A9\3\2\2\2A@\3\2\2\2B\4\3\2\2\2C"+
		"D\7E\2\2DE\7a\2\2EJ\7}\2\2FG\7e\2\2GH\7a\2\2HJ\7}\2\2IC\3\2\2\2IF\3\2"+
		"\2\2J\6\3\2\2\2KL\7Z\2\2LM\7a\2\2MR\7}\2\2NO\7z\2\2OP\7a\2\2PR\7}\2\2"+
		"QK\3\2\2\2QN\3\2\2\2R\b\3\2\2\2ST\7?\2\2T\n\3\2\2\2UV\7V\2\2V\f\3\2\2"+
		"\2WX\7^\2\2XY\7R\2\2YZ\7j\2\2Z[\7k\2\2[\\\7a\2\2\\]\7}\2\2]\16\3\2\2\2"+
		"^_\7^\2\2_`\7n\2\2`a\7c\2\2ab\7o\2\2bc\7d\2\2cd\7f\2\2de\7c\2\2e\20\3"+
		"\2\2\2fg\7\60\2\2g\22\3\2\2\2hi\7M\2\2i\24\3\2\2\2jk\4de\2k\26\3\2\2\2"+
		"lm\7*\2\2m\30\3\2\2\2no\7+\2\2o\32\3\2\2\2pq\7.\2\2q\34\3\2\2\2rs\7\177"+
		"\2\2s\36\3\2\2\2tu\7]\2\2u \3\2\2\2vw\7_\2\2w\"\3\2\2\2xy\7\177\2\2yz"+
		"\7`\2\2z{\7}\2\2{$\3\2\2\2|}\7<\2\2}~\7?\2\2~&\3\2\2\2\177\u0080\7C\2"+
		"\2\u0080\u0081\7`\2\2\u0081\u0082\7}\2\2\u0082(\3\2\2\2\u0083\u0084\7"+
		"O\2\2\u0084\u0085\7a\2\2\u0085\u0086\7}\2\2\u0086*\3\2\2\2\u0087\u0088"+
		"\7K\2\2\u0088\u0089\7`\2\2\u0089\u008a\7}\2\2\u008a,\3\2\2\2\u008b\u008c"+
		"\7N\2\2\u008c\u008d\7`\2\2\u008d\u008e\7}\2\2\u008e.\3\2\2\2\u008f\u0090"+
		"\7U\2\2\u0090\u0091\7`\2\2\u0091\u0092\7}\2\2\u0092\60\3\2\2\2\u0093\u0094"+
		"\7U\2\2\u0094\62\3\2\2\2\u0095\u0097\t\3\2\2\u0096\u0095\3\2\2\2\u0097"+
		"\u0098\3\2\2\2\u0098\u0096\3\2\2\2\u0098\u0099\3\2\2\2\u0099\u009a\3\2"+
		"\2\2\u009a\u009b\b\32\2\2\u009b\64\3\2\2\2\t\2\67=AIQ\u0098\3\2\3\2";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}