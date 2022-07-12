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
		DM=1, SS=2, TR=3, WE=4, ST=5, ND=6, CO=7, CR=8, AI=9, CA=10, WI=11, O_PAR=12, 
		C_PAR=13, WHITESPACE=14;
	public static String[] channelNames = {
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	};

	public static String[] modeNames = {
		"DEFAULT_MODE"
	};

	private static String[] makeRuleNames() {
		return new String[] {
			"DM", "SS", "TR", "WE", "ST", "ND", "CO", "CR", "AI", "CA", "WI", "O_PAR", 
			"C_PAR", "WHITESPACE"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, "'DM'", "'SS'", "'TR'", "'WE'", "'ST'", "'ND'", "'CO'", "'CR'", 
			"'AI'", "'CA'", "'WI'", "'('", "')'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, "DM", "SS", "TR", "WE", "ST", "ND", "CO", "CR", "AI", "CA", "WI", 
			"O_PAR", "C_PAR", "WHITESPACE"
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
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\2\20K\b\1\4\2\t\2\4"+
		"\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4\13\t"+
		"\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\3\2\3\2\3\2\3\3\3\3\3\3\3\4\3"+
		"\4\3\4\3\5\3\5\3\5\3\6\3\6\3\6\3\7\3\7\3\7\3\b\3\b\3\b\3\t\3\t\3\t\3\n"+
		"\3\n\3\n\3\13\3\13\3\13\3\f\3\f\3\f\3\r\3\r\3\16\3\16\3\17\6\17F\n\17"+
		"\r\17\16\17G\3\17\3\17\2\2\20\3\3\5\4\7\5\t\6\13\7\r\b\17\t\21\n\23\13"+
		"\25\f\27\r\31\16\33\17\35\20\3\2\2\2K\2\3\3\2\2\2\2\5\3\2\2\2\2\7\3\2"+
		"\2\2\2\t\3\2\2\2\2\13\3\2\2\2\2\r\3\2\2\2\2\17\3\2\2\2\2\21\3\2\2\2\2"+
		"\23\3\2\2\2\2\25\3\2\2\2\2\27\3\2\2\2\2\31\3\2\2\2\2\33\3\2\2\2\2\35\3"+
		"\2\2\2\3\37\3\2\2\2\5\"\3\2\2\2\7%\3\2\2\2\t(\3\2\2\2\13+\3\2\2\2\r.\3"+
		"\2\2\2\17\61\3\2\2\2\21\64\3\2\2\2\23\67\3\2\2\2\25:\3\2\2\2\27=\3\2\2"+
		"\2\31@\3\2\2\2\33B\3\2\2\2\35E\3\2\2\2\37 \7F\2\2 !\7O\2\2!\4\3\2\2\2"+
		"\"#\7U\2\2#$\7U\2\2$\6\3\2\2\2%&\7V\2\2&\'\7T\2\2\'\b\3\2\2\2()\7Y\2\2"+
		")*\7G\2\2*\n\3\2\2\2+,\7U\2\2,-\7V\2\2-\f\3\2\2\2./\7P\2\2/\60\7F\2\2"+
		"\60\16\3\2\2\2\61\62\7E\2\2\62\63\7Q\2\2\63\20\3\2\2\2\64\65\7E\2\2\65"+
		"\66\7T\2\2\66\22\3\2\2\2\678\7C\2\289\7K\2\29\24\3\2\2\2:;\7E\2\2;<\7"+
		"C\2\2<\26\3\2\2\2=>\7Y\2\2>?\7K\2\2?\30\3\2\2\2@A\7*\2\2A\32\3\2\2\2B"+
		"C\7+\2\2C\34\3\2\2\2DF\7\"\2\2ED\3\2\2\2FG\3\2\2\2GE\3\2\2\2GH\3\2\2\2"+
		"HI\3\2\2\2IJ\b\17\2\2J\36\3\2\2\2\4\2G\3\2\3\2";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}