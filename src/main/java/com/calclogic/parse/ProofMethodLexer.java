// Generated from .\ProofMethod.g4 by ANTLR 4.8


package com.calclogic.parse;

import com.calclogic.lambdacalculo.Const;
import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Term;
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
public class ProofMethodLexer extends Lexer {
	static { RuntimeMetaData.checkVersion("4.8", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		DIGITS=1, DS=2, DT=3, EO=4, OE=5, EE=6, SL=7, SR=8, TL=9, TR=10, WL=11, 
		WR=12, DE=13, CO=14, CR=15, MP=16, EL=17, ER=18, AI=19, MI=20, CA=21, 
		GE=22, WI=23, O_PAR=24, C_PAR=25, WHITESPACE=26;
	public static String[] channelNames = {
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	};

	public static String[] modeNames = {
		"DEFAULT_MODE"
	};

	private static String[] makeRuleNames() {
		return new String[] {
			"DIGITS", "DS", "DT", "EO", "OE", "EE", "SL", "SR", "TL", "TR", "WL", 
			"WR", "DE", "CO", "CR", "MP", "EL", "ER", "AI", "MI", "CA", "GE", "WI", 
			"O_PAR", "C_PAR", "WHITESPACE"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, null, "'DS'", "'DT'", "'EO'", "'OE'", "'EE'", "'SL'", "'SR'", "'TL'", 
			"'TR'", "'WL'", "'WR'", "'DE'", "'CO'", "'CR'", "'MP'", "'EL'", "'ER'", 
			"'AI'", "'MI'", "'CA'", "'GE'", "'WI'", "'('", "')'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, "DIGITS", "DS", "DT", "EO", "OE", "EE", "SL", "SR", "TL", "TR", 
			"WL", "WR", "DE", "CO", "CR", "MP", "EL", "ER", "AI", "MI", "CA", "GE", 
			"WI", "O_PAR", "C_PAR", "WHITESPACE"
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


	public ProofMethodLexer(CharStream input) {
		super(input);
		_interp = new LexerATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}

	@Override
	public String getGrammarFileName() { return "ProofMethod.g4"; }

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
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\2\34\u0092\b\1\4\2"+
		"\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4"+
		"\13\t\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22"+
		"\t\22\4\23\t\23\4\24\t\24\4\25\t\25\4\26\t\26\4\27\t\27\4\30\t\30\4\31"+
		"\t\31\4\32\t\32\4\33\t\33\3\2\3\2\5\2:\n\2\3\2\3\2\7\2>\n\2\f\2\16\2A"+
		"\13\2\3\2\5\2D\n\2\3\3\3\3\3\3\3\4\3\4\3\4\3\5\3\5\3\5\3\6\3\6\3\6\3\7"+
		"\3\7\3\7\3\b\3\b\3\b\3\t\3\t\3\t\3\n\3\n\3\n\3\13\3\13\3\13\3\f\3\f\3"+
		"\f\3\r\3\r\3\r\3\16\3\16\3\16\3\17\3\17\3\17\3\20\3\20\3\20\3\21\3\21"+
		"\3\21\3\22\3\22\3\22\3\23\3\23\3\23\3\24\3\24\3\24\3\25\3\25\3\25\3\26"+
		"\3\26\3\26\3\27\3\27\3\27\3\30\3\30\3\30\3\31\3\31\3\32\3\32\3\33\6\33"+
		"\u008d\n\33\r\33\16\33\u008e\3\33\3\33\2\2\34\3\3\5\4\7\5\t\6\13\7\r\b"+
		"\17\t\21\n\23\13\25\f\27\r\31\16\33\17\35\20\37\21!\22#\23%\24\'\25)\26"+
		"+\27-\30/\31\61\32\63\33\65\34\3\2\4\3\2\62;\5\2\13\f\17\17\"\"\2\u0095"+
		"\2\3\3\2\2\2\2\5\3\2\2\2\2\7\3\2\2\2\2\t\3\2\2\2\2\13\3\2\2\2\2\r\3\2"+
		"\2\2\2\17\3\2\2\2\2\21\3\2\2\2\2\23\3\2\2\2\2\25\3\2\2\2\2\27\3\2\2\2"+
		"\2\31\3\2\2\2\2\33\3\2\2\2\2\35\3\2\2\2\2\37\3\2\2\2\2!\3\2\2\2\2#\3\2"+
		"\2\2\2%\3\2\2\2\2\'\3\2\2\2\2)\3\2\2\2\2+\3\2\2\2\2-\3\2\2\2\2/\3\2\2"+
		"\2\2\61\3\2\2\2\2\63\3\2\2\2\2\65\3\2\2\2\39\3\2\2\2\5E\3\2\2\2\7H\3\2"+
		"\2\2\tK\3\2\2\2\13N\3\2\2\2\rQ\3\2\2\2\17T\3\2\2\2\21W\3\2\2\2\23Z\3\2"+
		"\2\2\25]\3\2\2\2\27`\3\2\2\2\31c\3\2\2\2\33f\3\2\2\2\35i\3\2\2\2\37l\3"+
		"\2\2\2!o\3\2\2\2#r\3\2\2\2%u\3\2\2\2\'x\3\2\2\2){\3\2\2\2+~\3\2\2\2-\u0081"+
		"\3\2\2\2/\u0084\3\2\2\2\61\u0087\3\2\2\2\63\u0089\3\2\2\2\65\u008c\3\2"+
		"\2\2\67:\7/\2\28:\3\2\2\29\67\3\2\2\298\3\2\2\2:C\3\2\2\2;?\4\63;\2<>"+
		"\t\2\2\2=<\3\2\2\2>A\3\2\2\2?=\3\2\2\2?@\3\2\2\2@D\3\2\2\2A?\3\2\2\2B"+
		"D\7\62\2\2C;\3\2\2\2CB\3\2\2\2D\4\3\2\2\2EF\7F\2\2FG\7U\2\2G\6\3\2\2\2"+
		"HI\7F\2\2IJ\7V\2\2J\b\3\2\2\2KL\7G\2\2LM\7Q\2\2M\n\3\2\2\2NO\7Q\2\2OP"+
		"\7G\2\2P\f\3\2\2\2QR\7G\2\2RS\7G\2\2S\16\3\2\2\2TU\7U\2\2UV\7N\2\2V\20"+
		"\3\2\2\2WX\7U\2\2XY\7T\2\2Y\22\3\2\2\2Z[\7V\2\2[\\\7N\2\2\\\24\3\2\2\2"+
		"]^\7V\2\2^_\7T\2\2_\26\3\2\2\2`a\7Y\2\2ab\7N\2\2b\30\3\2\2\2cd\7Y\2\2"+
		"de\7T\2\2e\32\3\2\2\2fg\7F\2\2gh\7G\2\2h\34\3\2\2\2ij\7E\2\2jk\7Q\2\2"+
		"k\36\3\2\2\2lm\7E\2\2mn\7T\2\2n \3\2\2\2op\7O\2\2pq\7R\2\2q\"\3\2\2\2"+
		"rs\7G\2\2st\7N\2\2t$\3\2\2\2uv\7G\2\2vw\7T\2\2w&\3\2\2\2xy\7C\2\2yz\7"+
		"K\2\2z(\3\2\2\2{|\7O\2\2|}\7K\2\2}*\3\2\2\2~\177\7E\2\2\177\u0080\7C\2"+
		"\2\u0080,\3\2\2\2\u0081\u0082\7I\2\2\u0082\u0083\7G\2\2\u0083.\3\2\2\2"+
		"\u0084\u0085\7Y\2\2\u0085\u0086\7K\2\2\u0086\60\3\2\2\2\u0087\u0088\7"+
		"*\2\2\u0088\62\3\2\2\2\u0089\u008a\7+\2\2\u008a\64\3\2\2\2\u008b\u008d"+
		"\t\3\2\2\u008c\u008b\3\2\2\2\u008d\u008e\3\2\2\2\u008e\u008c\3\2\2\2\u008e"+
		"\u008f\3\2\2\2\u008f\u0090\3\2\2\2\u0090\u0091\b\33\2\2\u0091\66\3\2\2"+
		"\2\7\29?C\u008e\3\2\3\2";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}