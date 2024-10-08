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
		DM=1, EO=2, OE=3, SS=4, TL=5, TR=6, WL=7, WR=8, ND=9, CO=10, CR=11, AI=12, 
		MI=13, CA=14, GE=15, WI=16, O_PAR=17, C_PAR=18, WHITESPACE=19;
	public static String[] channelNames = {
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	};

	public static String[] modeNames = {
		"DEFAULT_MODE"
	};

	private static String[] makeRuleNames() {
		return new String[] {
			"DM", "EO", "OE", "SS", "TL", "TR", "WL", "WR", "ND", "CO", "CR", "AI", 
			"MI", "CA", "GE", "WI", "O_PAR", "C_PAR", "WHITESPACE"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, "'DM'", "'EO'", "'OE'", "'SS'", "'TL'", "'TR'", "'WL'", "'WR'", 
			"'ND'", "'CO'", "'CR'", "'AI'", "'MI'", "'CA'", "'GE'", "'WI'", "'('", 
			"')'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, "DM", "EO", "OE", "SS", "TL", "TR", "WL", "WR", "ND", "CO", "CR", 
			"AI", "MI", "CA", "GE", "WI", "O_PAR", "C_PAR", "WHITESPACE"
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
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\2\25d\b\1\4\2\t\2\4"+
		"\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4\13\t"+
		"\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22\t\22"+
		"\4\23\t\23\4\24\t\24\3\2\3\2\3\2\3\3\3\3\3\3\3\4\3\4\3\4\3\5\3\5\3\5\3"+
		"\6\3\6\3\6\3\7\3\7\3\7\3\b\3\b\3\b\3\t\3\t\3\t\3\n\3\n\3\n\3\13\3\13\3"+
		"\13\3\f\3\f\3\f\3\r\3\r\3\r\3\16\3\16\3\16\3\17\3\17\3\17\3\20\3\20\3"+
		"\20\3\21\3\21\3\21\3\22\3\22\3\23\3\23\3\24\6\24_\n\24\r\24\16\24`\3\24"+
		"\3\24\2\2\25\3\3\5\4\7\5\t\6\13\7\r\b\17\t\21\n\23\13\25\f\27\r\31\16"+
		"\33\17\35\20\37\21!\22#\23%\24\'\25\3\2\3\5\2\13\f\17\17\"\"\2d\2\3\3"+
		"\2\2\2\2\5\3\2\2\2\2\7\3\2\2\2\2\t\3\2\2\2\2\13\3\2\2\2\2\r\3\2\2\2\2"+
		"\17\3\2\2\2\2\21\3\2\2\2\2\23\3\2\2\2\2\25\3\2\2\2\2\27\3\2\2\2\2\31\3"+
		"\2\2\2\2\33\3\2\2\2\2\35\3\2\2\2\2\37\3\2\2\2\2!\3\2\2\2\2#\3\2\2\2\2"+
		"%\3\2\2\2\2\'\3\2\2\2\3)\3\2\2\2\5,\3\2\2\2\7/\3\2\2\2\t\62\3\2\2\2\13"+
		"\65\3\2\2\2\r8\3\2\2\2\17;\3\2\2\2\21>\3\2\2\2\23A\3\2\2\2\25D\3\2\2\2"+
		"\27G\3\2\2\2\31J\3\2\2\2\33M\3\2\2\2\35P\3\2\2\2\37S\3\2\2\2!V\3\2\2\2"+
		"#Y\3\2\2\2%[\3\2\2\2\'^\3\2\2\2)*\7F\2\2*+\7O\2\2+\4\3\2\2\2,-\7G\2\2"+
		"-.\7Q\2\2.\6\3\2\2\2/\60\7Q\2\2\60\61\7G\2\2\61\b\3\2\2\2\62\63\7U\2\2"+
		"\63\64\7U\2\2\64\n\3\2\2\2\65\66\7V\2\2\66\67\7N\2\2\67\f\3\2\2\289\7"+
		"V\2\29:\7T\2\2:\16\3\2\2\2;<\7Y\2\2<=\7N\2\2=\20\3\2\2\2>?\7Y\2\2?@\7"+
		"T\2\2@\22\3\2\2\2AB\7P\2\2BC\7F\2\2C\24\3\2\2\2DE\7E\2\2EF\7Q\2\2F\26"+
		"\3\2\2\2GH\7E\2\2HI\7T\2\2I\30\3\2\2\2JK\7C\2\2KL\7K\2\2L\32\3\2\2\2M"+
		"N\7O\2\2NO\7K\2\2O\34\3\2\2\2PQ\7E\2\2QR\7C\2\2R\36\3\2\2\2ST\7I\2\2T"+
		"U\7G\2\2U \3\2\2\2VW\7Y\2\2WX\7K\2\2X\"\3\2\2\2YZ\7*\2\2Z$\3\2\2\2[\\"+
		"\7+\2\2\\&\3\2\2\2]_\t\2\2\2^]\3\2\2\2_`\3\2\2\2`^\3\2\2\2`a\3\2\2\2a"+
		"b\3\2\2\2bc\b\24\2\2c(\3\2\2\2\4\2`\3\2\3\2";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}