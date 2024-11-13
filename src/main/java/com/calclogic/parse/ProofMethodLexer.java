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
		DS=1, DT=2, EO=3, OE=4, SL=5, SR=6, TL=7, TR=8, WL=9, WR=10, DE=11, CO=12, 
		CR=13, AI=14, MI=15, CA=16, GE=17, WI=18, O_PAR=19, C_PAR=20, WHITESPACE=21;
	public static String[] channelNames = {
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	};

	public static String[] modeNames = {
		"DEFAULT_MODE"
	};

	private static String[] makeRuleNames() {
		return new String[] {
			"DS", "DT", "EO", "OE", "SL", "SR", "TL", "TR", "WL", "WR", "DE", "CO", 
			"CR", "AI", "MI", "CA", "GE", "WI", "O_PAR", "C_PAR", "WHITESPACE"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, "'DS'", "'DT'", "'EO'", "'OE'", "'SL'", "'SR'", "'TL'", "'TR'", 
			"'WL'", "'WR'", "'DE'", "'CO'", "'CR'", "'AI'", "'MI'", "'CA'", "'GE'", 
			"'WI'", "'('", "')'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, "DS", "DT", "EO", "OE", "SL", "SR", "TL", "TR", "WL", "WR", "DE", 
			"CO", "CR", "AI", "MI", "CA", "GE", "WI", "O_PAR", "C_PAR", "WHITESPACE"
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
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\2\27n\b\1\4\2\t\2\4"+
		"\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4\13\t"+
		"\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22\t\22"+
		"\4\23\t\23\4\24\t\24\4\25\t\25\4\26\t\26\3\2\3\2\3\2\3\3\3\3\3\3\3\4\3"+
		"\4\3\4\3\5\3\5\3\5\3\6\3\6\3\6\3\7\3\7\3\7\3\b\3\b\3\b\3\t\3\t\3\t\3\n"+
		"\3\n\3\n\3\13\3\13\3\13\3\f\3\f\3\f\3\r\3\r\3\r\3\16\3\16\3\16\3\17\3"+
		"\17\3\17\3\20\3\20\3\20\3\21\3\21\3\21\3\22\3\22\3\22\3\23\3\23\3\23\3"+
		"\24\3\24\3\25\3\25\3\26\6\26i\n\26\r\26\16\26j\3\26\3\26\2\2\27\3\3\5"+
		"\4\7\5\t\6\13\7\r\b\17\t\21\n\23\13\25\f\27\r\31\16\33\17\35\20\37\21"+
		"!\22#\23%\24\'\25)\26+\27\3\2\3\5\2\13\f\17\17\"\"\2n\2\3\3\2\2\2\2\5"+
		"\3\2\2\2\2\7\3\2\2\2\2\t\3\2\2\2\2\13\3\2\2\2\2\r\3\2\2\2\2\17\3\2\2\2"+
		"\2\21\3\2\2\2\2\23\3\2\2\2\2\25\3\2\2\2\2\27\3\2\2\2\2\31\3\2\2\2\2\33"+
		"\3\2\2\2\2\35\3\2\2\2\2\37\3\2\2\2\2!\3\2\2\2\2#\3\2\2\2\2%\3\2\2\2\2"+
		"\'\3\2\2\2\2)\3\2\2\2\2+\3\2\2\2\3-\3\2\2\2\5\60\3\2\2\2\7\63\3\2\2\2"+
		"\t\66\3\2\2\2\139\3\2\2\2\r<\3\2\2\2\17?\3\2\2\2\21B\3\2\2\2\23E\3\2\2"+
		"\2\25H\3\2\2\2\27K\3\2\2\2\31N\3\2\2\2\33Q\3\2\2\2\35T\3\2\2\2\37W\3\2"+
		"\2\2!Z\3\2\2\2#]\3\2\2\2%`\3\2\2\2\'c\3\2\2\2)e\3\2\2\2+h\3\2\2\2-.\7"+
		"F\2\2./\7U\2\2/\4\3\2\2\2\60\61\7F\2\2\61\62\7V\2\2\62\6\3\2\2\2\63\64"+
		"\7G\2\2\64\65\7Q\2\2\65\b\3\2\2\2\66\67\7Q\2\2\678\7G\2\28\n\3\2\2\29"+
		":\7U\2\2:;\7N\2\2;\f\3\2\2\2<=\7U\2\2=>\7T\2\2>\16\3\2\2\2?@\7V\2\2@A"+
		"\7N\2\2A\20\3\2\2\2BC\7V\2\2CD\7T\2\2D\22\3\2\2\2EF\7Y\2\2FG\7N\2\2G\24"+
		"\3\2\2\2HI\7Y\2\2IJ\7T\2\2J\26\3\2\2\2KL\7F\2\2LM\7G\2\2M\30\3\2\2\2N"+
		"O\7E\2\2OP\7Q\2\2P\32\3\2\2\2QR\7E\2\2RS\7T\2\2S\34\3\2\2\2TU\7C\2\2U"+
		"V\7K\2\2V\36\3\2\2\2WX\7O\2\2XY\7K\2\2Y \3\2\2\2Z[\7E\2\2[\\\7C\2\2\\"+
		"\"\3\2\2\2]^\7I\2\2^_\7G\2\2_$\3\2\2\2`a\7Y\2\2ab\7K\2\2b&\3\2\2\2cd\7"+
		"*\2\2d(\3\2\2\2ef\7+\2\2f*\3\2\2\2gi\t\2\2\2hg\3\2\2\2ij\3\2\2\2jh\3\2"+
		"\2\2jk\3\2\2\2kl\3\2\2\2lm\b\26\2\2m,\3\2\2\2\4\2j\3\2\3\2";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}