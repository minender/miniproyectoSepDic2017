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
		DM=1, SS=2, TR=3, WE=4, ST=5, ND=6, CO=7, CR=8, AI=9, MI=10, CA=11, WI=12, 
		O_PAR=13, C_PAR=14, WHITESPACE=15;
	public static String[] channelNames = {
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	};

	public static String[] modeNames = {
		"DEFAULT_MODE"
	};

	private static String[] makeRuleNames() {
		return new String[] {
			"DM", "SS", "TR", "WE", "ST", "ND", "CO", "CR", "AI", "MI", "CA", "WI", 
			"O_PAR", "C_PAR", "WHITESPACE"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, "'DM'", "'SS'", "'TR'", "'WE'", "'ST'", "'ND'", "'CO'", "'CR'", 
			"'AI'", "'MI'", "'CA'", "'WI'", "'('", "')'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, "DM", "SS", "TR", "WE", "ST", "ND", "CO", "CR", "AI", "MI", "CA", 
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
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\2\21P\b\1\4\2\t\2\4"+
		"\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4\13\t"+
		"\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\3\2\3\2\3\2\3\3\3\3"+
		"\3\3\3\4\3\4\3\4\3\5\3\5\3\5\3\6\3\6\3\6\3\7\3\7\3\7\3\b\3\b\3\b\3\t\3"+
		"\t\3\t\3\n\3\n\3\n\3\13\3\13\3\13\3\f\3\f\3\f\3\r\3\r\3\r\3\16\3\16\3"+
		"\17\3\17\3\20\6\20K\n\20\r\20\16\20L\3\20\3\20\2\2\21\3\3\5\4\7\5\t\6"+
		"\13\7\r\b\17\t\21\n\23\13\25\f\27\r\31\16\33\17\35\20\37\21\3\2\2\2P\2"+
		"\3\3\2\2\2\2\5\3\2\2\2\2\7\3\2\2\2\2\t\3\2\2\2\2\13\3\2\2\2\2\r\3\2\2"+
		"\2\2\17\3\2\2\2\2\21\3\2\2\2\2\23\3\2\2\2\2\25\3\2\2\2\2\27\3\2\2\2\2"+
		"\31\3\2\2\2\2\33\3\2\2\2\2\35\3\2\2\2\2\37\3\2\2\2\3!\3\2\2\2\5$\3\2\2"+
		"\2\7\'\3\2\2\2\t*\3\2\2\2\13-\3\2\2\2\r\60\3\2\2\2\17\63\3\2\2\2\21\66"+
		"\3\2\2\2\239\3\2\2\2\25<\3\2\2\2\27?\3\2\2\2\31B\3\2\2\2\33E\3\2\2\2\35"+
		"G\3\2\2\2\37J\3\2\2\2!\"\7F\2\2\"#\7O\2\2#\4\3\2\2\2$%\7U\2\2%&\7U\2\2"+
		"&\6\3\2\2\2\'(\7V\2\2()\7T\2\2)\b\3\2\2\2*+\7Y\2\2+,\7G\2\2,\n\3\2\2\2"+
		"-.\7U\2\2./\7V\2\2/\f\3\2\2\2\60\61\7P\2\2\61\62\7F\2\2\62\16\3\2\2\2"+
		"\63\64\7E\2\2\64\65\7Q\2\2\65\20\3\2\2\2\66\67\7E\2\2\678\7T\2\28\22\3"+
		"\2\2\29:\7C\2\2:;\7K\2\2;\24\3\2\2\2<=\7O\2\2=>\7K\2\2>\26\3\2\2\2?@\7"+
		"E\2\2@A\7C\2\2A\30\3\2\2\2BC\7Y\2\2CD\7K\2\2D\32\3\2\2\2EF\7*\2\2F\34"+
		"\3\2\2\2GH\7+\2\2H\36\3\2\2\2IK\7\"\2\2JI\3\2\2\2KL\3\2\2\2LJ\3\2\2\2"+
		"LM\3\2\2\2MN\3\2\2\2NO\b\20\2\2O \3\2\2\2\4\2L\3\2\3\2";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}