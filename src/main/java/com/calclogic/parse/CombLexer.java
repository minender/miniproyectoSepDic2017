// Generated from Comb.g4 by ANTLR 4.8

	
package com.calclogic.parse; 

import com.calclogic.lambdacalculo.*;	
import java.util.LinkedList;
import com.calclogic.entity.Resuelve;	
	

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
		CONSTANT_C=1, EQUAL=2, TRUE=3, PHI=4, LAMBDA=5, PERIOD=6, K=7, CB=8, O_PAR=9, 
		C_PAR=10, COMMA=11, C_BRACKET=12, O_BRACKET2=13, C_BRACKET2=14, ASSIGN=15, 
		VARIABLE=16, A=17, I=18, L=19, S=20, Si=21, WHITESPACE=22;
	public static String[] channelNames = {
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	};

	public static String[] modeNames = {
		"DEFAULT_MODE"
	};

	private static String[] makeRuleNames() {
		return new String[] {
			"DIGITS", "C", "X", "CONSTANT_C", "EQUAL", "TRUE", "PHI", "LAMBDA", "PERIOD", 
			"K", "CB", "O_PAR", "C_PAR", "COMMA", "C_BRACKET", "O_BRACKET2", "C_BRACKET2", 
			"ASSIGN", "VARIABLE", "A", "I", "L", "S", "Si", "WHITESPACE"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, null, "'='", "'T'", "'\\Phi_{'", "'\\lambda'", "'.'", "'K'", null, 
			"'('", "')'", "','", "'}'", "'['", "']'", "':='", null, "'A^{'", "'I^{'", 
			"'L^{'", "'S^{'", "'S'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, "CONSTANT_C", "EQUAL", "TRUE", "PHI", "LAMBDA", "PERIOD", "K", 
			"CB", "O_PAR", "C_PAR", "COMMA", "C_BRACKET", "O_BRACKET2", "C_BRACKET2", 
			"ASSIGN", "VARIABLE", "A", "I", "L", "S", "Si", "WHITESPACE"
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
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\2\30\u0092\b\1\4\2"+
		"\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4"+
		"\13\t\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22"+
		"\t\22\4\23\t\23\4\24\t\24\4\25\t\25\4\26\t\26\4\27\t\27\4\30\t\30\4\31"+
		"\t\31\4\32\t\32\3\2\3\2\7\28\n\2\f\2\16\2;\13\2\3\2\5\2>\n\2\3\3\3\3\3"+
		"\4\3\4\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\6\3\6\3\7\3\7\3\b\3\b\3\b\3\b\3\b"+
		"\3\b\3\b\3\t\3\t\3\t\3\t\3\t\3\t\3\t\3\t\3\n\3\n\3\13\3\13\3\f\3\f\3\r"+
		"\3\r\3\16\3\16\3\17\3\17\3\20\3\20\3\21\3\21\3\22\3\22\3\23\3\23\3\23"+
		"\3\24\3\24\3\24\3\24\3\24\3\24\3\24\3\25\3\25\3\25\3\25\3\26\3\26\3\26"+
		"\3\26\3\27\3\27\3\27\3\27\3\30\3\30\3\30\3\30\3\31\3\31\3\32\6\32\u008d"+
		"\n\32\r\32\16\32\u008e\3\32\3\32\2\2\33\3\2\5\2\7\2\t\3\13\4\r\5\17\6"+
		"\21\7\23\b\25\t\27\n\31\13\33\f\35\r\37\16!\17#\20%\21\'\22)\23+\24-\25"+
		"/\26\61\27\63\30\3\2\5\3\2\62;\4\2EEee\4\2ZZzz\2\u0091\2\t\3\2\2\2\2\13"+
		"\3\2\2\2\2\r\3\2\2\2\2\17\3\2\2\2\2\21\3\2\2\2\2\23\3\2\2\2\2\25\3\2\2"+
		"\2\2\27\3\2\2\2\2\31\3\2\2\2\2\33\3\2\2\2\2\35\3\2\2\2\2\37\3\2\2\2\2"+
		"!\3\2\2\2\2#\3\2\2\2\2%\3\2\2\2\2\'\3\2\2\2\2)\3\2\2\2\2+\3\2\2\2\2-\3"+
		"\2\2\2\2/\3\2\2\2\2\61\3\2\2\2\2\63\3\2\2\2\3=\3\2\2\2\5?\3\2\2\2\7A\3"+
		"\2\2\2\tC\3\2\2\2\13J\3\2\2\2\rL\3\2\2\2\17N\3\2\2\2\21U\3\2\2\2\23]\3"+
		"\2\2\2\25_\3\2\2\2\27a\3\2\2\2\31c\3\2\2\2\33e\3\2\2\2\35g\3\2\2\2\37"+
		"i\3\2\2\2!k\3\2\2\2#m\3\2\2\2%o\3\2\2\2\'r\3\2\2\2)y\3\2\2\2+}\3\2\2\2"+
		"-\u0081\3\2\2\2/\u0085\3\2\2\2\61\u0089\3\2\2\2\63\u008c\3\2\2\2\659\4"+
		"\63;\2\668\t\2\2\2\67\66\3\2\2\28;\3\2\2\29\67\3\2\2\29:\3\2\2\2:>\3\2"+
		"\2\2;9\3\2\2\2<>\7\62\2\2=\65\3\2\2\2=<\3\2\2\2>\4\3\2\2\2?@\t\3\2\2@"+
		"\6\3\2\2\2AB\t\4\2\2B\b\3\2\2\2CD\5\5\3\2DE\7a\2\2EF\7}\2\2FG\3\2\2\2"+
		"GH\5\3\2\2HI\7\177\2\2I\n\3\2\2\2JK\7?\2\2K\f\3\2\2\2LM\7V\2\2M\16\3\2"+
		"\2\2NO\7^\2\2OP\7R\2\2PQ\7j\2\2QR\7k\2\2RS\7a\2\2ST\7}\2\2T\20\3\2\2\2"+
		"UV\7^\2\2VW\7n\2\2WX\7c\2\2XY\7o\2\2YZ\7d\2\2Z[\7f\2\2[\\\7c\2\2\\\22"+
		"\3\2\2\2]^\7\60\2\2^\24\3\2\2\2_`\7M\2\2`\26\3\2\2\2ab\4de\2b\30\3\2\2"+
		"\2cd\7*\2\2d\32\3\2\2\2ef\7+\2\2f\34\3\2\2\2gh\7.\2\2h\36\3\2\2\2ij\7"+
		"\177\2\2j \3\2\2\2kl\7]\2\2l\"\3\2\2\2mn\7_\2\2n$\3\2\2\2op\7<\2\2pq\7"+
		"?\2\2q&\3\2\2\2rs\5\7\4\2st\7a\2\2tu\7}\2\2uv\3\2\2\2vw\5\3\2\2wx\7\177"+
		"\2\2x(\3\2\2\2yz\7C\2\2z{\7`\2\2{|\7}\2\2|*\3\2\2\2}~\7K\2\2~\177\7`\2"+
		"\2\177\u0080\7}\2\2\u0080,\3\2\2\2\u0081\u0082\7N\2\2\u0082\u0083\7`\2"+
		"\2\u0083\u0084\7}\2\2\u0084.\3\2\2\2\u0085\u0086\7U\2\2\u0086\u0087\7"+
		"`\2\2\u0087\u0088\7}\2\2\u0088\60\3\2\2\2\u0089\u008a\7U\2\2\u008a\62"+
		"\3\2\2\2\u008b\u008d\7\"\2\2\u008c\u008b\3\2\2\2\u008d\u008e\3\2\2\2\u008e"+
		"\u008c\3\2\2\2\u008e\u008f\3\2\2\2\u008f\u0090\3\2\2\2\u0090\u0091\b\32"+
		"\2\2\u0091\64\3\2\2\2\6\29=\u008e\3\2\3\2";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}