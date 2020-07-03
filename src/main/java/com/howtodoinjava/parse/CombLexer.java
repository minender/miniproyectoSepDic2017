// Generated from Comb.g4 by ANTLR 4.8

	
package com.howtodoinjava.parse; 

import com.howtodoinjava.lambdacalculo.*;	
import java.util.LinkedList;	
	

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
		CONSTANT_C=1, PHI=2, LAMBDA=3, PERIOD=4, K=5, CB=6, O_PAR=7, C_PAR=8, 
		COMMA=9, C_BRACKET=10, O_BRACKET2=11, C_BRACKET2=12, ASSIGN=13, VARIABLE=14, 
		A=15, I=16, L=17, S=18, WHITESPACE=19;
	public static String[] channelNames = {
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	};

	public static String[] modeNames = {
		"DEFAULT_MODE"
	};

	private static String[] makeRuleNames() {
		return new String[] {
			"DIGITS", "C", "X", "CONSTANT_C", "PHI", "LAMBDA", "PERIOD", "K", "CB", 
			"O_PAR", "C_PAR", "COMMA", "C_BRACKET", "O_BRACKET2", "C_BRACKET2", "ASSIGN", 
			"VARIABLE", "A", "I", "L", "S", "WHITESPACE"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, null, "'\\Phi_{'", "'\\lambda'", "'.'", "'K'", null, "'('", "')'", 
			"','", "'}'", "'['", "']'", "':='", null, "'A^{'", "'I^{'", "'L^{'", 
			"'S^{'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, "CONSTANT_C", "PHI", "LAMBDA", "PERIOD", "K", "CB", "O_PAR", "C_PAR", 
			"COMMA", "C_BRACKET", "O_BRACKET2", "C_BRACKET2", "ASSIGN", "VARIABLE", 
			"A", "I", "L", "S", "WHITESPACE"
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
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\2\25\u0086\b\1\4\2"+
		"\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4"+
		"\13\t\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22"+
		"\t\22\4\23\t\23\4\24\t\24\4\25\t\25\4\26\t\26\4\27\t\27\3\2\3\2\7\2\62"+
		"\n\2\f\2\16\2\65\13\2\3\2\5\28\n\2\3\3\3\3\3\4\3\4\3\5\3\5\3\5\3\5\3\5"+
		"\3\5\3\5\3\6\3\6\3\6\3\6\3\6\3\6\3\6\3\7\3\7\3\7\3\7\3\7\3\7\3\7\3\7\3"+
		"\b\3\b\3\t\3\t\3\n\3\n\3\13\3\13\3\f\3\f\3\r\3\r\3\16\3\16\3\17\3\17\3"+
		"\20\3\20\3\21\3\21\3\21\3\22\3\22\3\22\3\22\3\22\3\22\3\22\3\23\3\23\3"+
		"\23\3\23\3\24\3\24\3\24\3\24\3\25\3\25\3\25\3\25\3\26\3\26\3\26\3\26\3"+
		"\27\6\27\u0081\n\27\r\27\16\27\u0082\3\27\3\27\2\2\30\3\2\5\2\7\2\t\3"+
		"\13\4\r\5\17\6\21\7\23\b\25\t\27\n\31\13\33\f\35\r\37\16!\17#\20%\21\'"+
		"\22)\23+\24-\25\3\2\5\3\2\62;\4\2EEee\4\2ZZzz\2\u0085\2\t\3\2\2\2\2\13"+
		"\3\2\2\2\2\r\3\2\2\2\2\17\3\2\2\2\2\21\3\2\2\2\2\23\3\2\2\2\2\25\3\2\2"+
		"\2\2\27\3\2\2\2\2\31\3\2\2\2\2\33\3\2\2\2\2\35\3\2\2\2\2\37\3\2\2\2\2"+
		"!\3\2\2\2\2#\3\2\2\2\2%\3\2\2\2\2\'\3\2\2\2\2)\3\2\2\2\2+\3\2\2\2\2-\3"+
		"\2\2\2\3\67\3\2\2\2\59\3\2\2\2\7;\3\2\2\2\t=\3\2\2\2\13D\3\2\2\2\rK\3"+
		"\2\2\2\17S\3\2\2\2\21U\3\2\2\2\23W\3\2\2\2\25Y\3\2\2\2\27[\3\2\2\2\31"+
		"]\3\2\2\2\33_\3\2\2\2\35a\3\2\2\2\37c\3\2\2\2!e\3\2\2\2#h\3\2\2\2%o\3"+
		"\2\2\2\'s\3\2\2\2)w\3\2\2\2+{\3\2\2\2-\u0080\3\2\2\2/\63\4\63;\2\60\62"+
		"\t\2\2\2\61\60\3\2\2\2\62\65\3\2\2\2\63\61\3\2\2\2\63\64\3\2\2\2\648\3"+
		"\2\2\2\65\63\3\2\2\2\668\7\62\2\2\67/\3\2\2\2\67\66\3\2\2\28\4\3\2\2\2"+
		"9:\t\3\2\2:\6\3\2\2\2;<\t\4\2\2<\b\3\2\2\2=>\5\5\3\2>?\7a\2\2?@\7}\2\2"+
		"@A\3\2\2\2AB\5\3\2\2BC\7\177\2\2C\n\3\2\2\2DE\7^\2\2EF\7R\2\2FG\7j\2\2"+
		"GH\7k\2\2HI\7a\2\2IJ\7}\2\2J\f\3\2\2\2KL\7^\2\2LM\7n\2\2MN\7c\2\2NO\7"+
		"o\2\2OP\7d\2\2PQ\7f\2\2QR\7c\2\2R\16\3\2\2\2ST\7\60\2\2T\20\3\2\2\2UV"+
		"\7M\2\2V\22\3\2\2\2WX\4de\2X\24\3\2\2\2YZ\7*\2\2Z\26\3\2\2\2[\\\7+\2\2"+
		"\\\30\3\2\2\2]^\7.\2\2^\32\3\2\2\2_`\7\177\2\2`\34\3\2\2\2ab\7]\2\2b\36"+
		"\3\2\2\2cd\7_\2\2d \3\2\2\2ef\7<\2\2fg\7?\2\2g\"\3\2\2\2hi\5\7\4\2ij\7"+
		"a\2\2jk\7}\2\2kl\3\2\2\2lm\5\3\2\2mn\7\177\2\2n$\3\2\2\2op\7C\2\2pq\7"+
		"`\2\2qr\7}\2\2r&\3\2\2\2st\7K\2\2tu\7`\2\2uv\7}\2\2v(\3\2\2\2wx\7N\2\2"+
		"xy\7`\2\2yz\7}\2\2z*\3\2\2\2{|\7U\2\2|}\7`\2\2}~\7}\2\2~,\3\2\2\2\177"+
		"\u0081\7\"\2\2\u0080\177\3\2\2\2\u0081\u0082\3\2\2\2\u0082\u0080\3\2\2"+
		"\2\u0082\u0083\3\2\2\2\u0083\u0084\3\2\2\2\u0084\u0085\b\27\2\2\u0085"+
		".\3\2\2\2\6\2\63\67\u0082\3\2\3\2";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}