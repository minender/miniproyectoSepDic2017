// Generated from .\Type.g4 by ANTLR 4.8

    
package com.calclogic.parse; 

import com.calclogic.lambdacalculo.*;   
    

import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.misc.*;
import org.antlr.v4.runtime.tree.*;
import java.util.List;
import java.util.Iterator;
import java.util.ArrayList;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast"})
public class TypeParser extends Parser {
	static { RuntimeMetaData.checkVersion("4.8", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		X=1, DIGITS=2, P=3, TO=4, O_PAR=5, C_PAR=6, WHITESPACE=7;
	public static final int
		RULE_start_rule = 0, RULE_term = 1, RULE_tail = 2, RULE_head = 3;
	private static String[] makeRuleNames() {
		return new String[] {
			"start_rule", "term", "tail", "head"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, null, null, null, "'->'", "'('", "')'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, "X", "DIGITS", "P", "TO", "O_PAR", "C_PAR", "WHITESPACE"
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

	@Override
	public String getGrammarFileName() { return "Type.g4"; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public String getSerializedATN() { return _serializedATN; }

	@Override
	public ATN getATN() { return _ATN; }

	public TypeParser(TokenStream input) {
		super(input);
		_interp = new ParserATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}

	public static class Start_ruleContext extends ParserRuleContext {
		public Term value;
		public TermContext term;
		public TermContext term() {
			return getRuleContext(TermContext.class,0);
		}
		public Start_ruleContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_start_rule; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof TypeListener ) ((TypeListener)listener).enterStart_rule(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof TypeListener ) ((TypeListener)listener).exitStart_rule(this);
		}
	}

	public final Start_ruleContext start_rule() throws RecognitionException {
		Start_ruleContext _localctx = new Start_ruleContext(_ctx, getState());
		enterRule(_localctx, 0, RULE_start_rule);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(8);
			((Start_ruleContext)_localctx).term = term();
			((Start_ruleContext)_localctx).value =  ((Start_ruleContext)_localctx).term.value;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class TermContext extends ParserRuleContext {
		public Term value;
		public HeadContext head;
		public TailContext tail;
		public HeadContext head() {
			return getRuleContext(HeadContext.class,0);
		}
		public TailContext tail() {
			return getRuleContext(TailContext.class,0);
		}
		public TermContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_term; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof TypeListener ) ((TypeListener)listener).enterTerm(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof TypeListener ) ((TypeListener)listener).exitTerm(this);
		}
	}

	public final TermContext term() throws RecognitionException {
		TermContext _localctx = new TermContext(_ctx, getState());
		enterRule(_localctx, 2, RULE_term);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(11);
			((TermContext)_localctx).head = head();
			setState(12);
			((TermContext)_localctx).tail = tail();
			if(((TermContext)_localctx).tail.value==null){((TermContext)_localctx).value = ((TermContext)_localctx).head.value;}else{((TermContext)_localctx).value = new App(((TermContext)_localctx).tail.value,((TermContext)_localctx).head.value);}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class TailContext extends ParserRuleContext {
		public Term value;
		public TermContext term;
		public TerminalNode TO() { return getToken(TypeParser.TO, 0); }
		public TermContext term() {
			return getRuleContext(TermContext.class,0);
		}
		public TailContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_tail; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof TypeListener ) ((TypeListener)listener).enterTail(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof TypeListener ) ((TypeListener)listener).exitTail(this);
		}
	}

	public final TailContext tail() throws RecognitionException {
		TailContext _localctx = new TailContext(_ctx, getState());
		enterRule(_localctx, 4, RULE_tail);
		try {
			setState(20);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case TO:
				enterOuterAlt(_localctx, 1);
				{
				setState(15);
				match(TO);
				setState(16);
				((TailContext)_localctx).term = term();
				((TailContext)_localctx).value = new App(new Const(-3,"->"),((TailContext)_localctx).term.value);
				}
				break;
			case EOF:
			case C_PAR:
				enterOuterAlt(_localctx, 2);
				{
				((TailContext)_localctx).value = null;
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class HeadContext extends ParserRuleContext {
		public Term value;
		public Token P;
		public Token DIGITS;
		public TermContext term;
		public TerminalNode P() { return getToken(TypeParser.P, 0); }
		public TerminalNode X() { return getToken(TypeParser.X, 0); }
		public TerminalNode DIGITS() { return getToken(TypeParser.DIGITS, 0); }
		public TerminalNode O_PAR() { return getToken(TypeParser.O_PAR, 0); }
		public TermContext term() {
			return getRuleContext(TermContext.class,0);
		}
		public TerminalNode C_PAR() { return getToken(TypeParser.C_PAR, 0); }
		public HeadContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_head; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof TypeListener ) ((TypeListener)listener).enterHead(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof TypeListener ) ((TypeListener)listener).exitHead(this);
		}
	}

	public final HeadContext head() throws RecognitionException {
		HeadContext _localctx = new HeadContext(_ctx, getState());
		enterRule(_localctx, 6, RULE_head);
		try {
			setState(32);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case P:
				enterOuterAlt(_localctx, 1);
				{
				setState(22);
				((HeadContext)_localctx).P = match(P);
				 if((((HeadContext)_localctx).P!=null?((HeadContext)_localctx).P.getText():null).equals("p") || (((HeadContext)_localctx).P!=null?((HeadContext)_localctx).P.getText():null).equals("b")){((HeadContext)_localctx).value = new Const(-4,"p");}
				                         else if((((HeadContext)_localctx).P!=null?((HeadContext)_localctx).P.getText():null).equals("t")){((HeadContext)_localctx).value = new Const(-5,"t");}
				                       
				}
				break;
			case X:
				enterOuterAlt(_localctx, 2);
				{
				setState(24);
				match(X);
				setState(25);
				((HeadContext)_localctx).DIGITS = match(DIGITS);
				((HeadContext)_localctx).value = new Var(Integer.parseInt((((HeadContext)_localctx).DIGITS!=null?((HeadContext)_localctx).DIGITS.getText():null)));
				}
				break;
			case O_PAR:
				enterOuterAlt(_localctx, 3);
				{
				setState(27);
				match(O_PAR);
				setState(28);
				((HeadContext)_localctx).term = term();
				setState(29);
				match(C_PAR);
				((HeadContext)_localctx).value = ((HeadContext)_localctx).term.value;
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static final String _serializedATN =
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\3\t%\4\2\t\2\4\3\t"+
		"\3\4\4\t\4\4\5\t\5\3\2\3\2\3\2\3\3\3\3\3\3\3\3\3\4\3\4\3\4\3\4\3\4\5\4"+
		"\27\n\4\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\5\5#\n\5\3\5\2\2\6\2\4"+
		"\6\b\2\2\2#\2\n\3\2\2\2\4\r\3\2\2\2\6\26\3\2\2\2\b\"\3\2\2\2\n\13\5\4"+
		"\3\2\13\f\b\2\1\2\f\3\3\2\2\2\r\16\5\b\5\2\16\17\5\6\4\2\17\20\b\3\1\2"+
		"\20\5\3\2\2\2\21\22\7\6\2\2\22\23\5\4\3\2\23\24\b\4\1\2\24\27\3\2\2\2"+
		"\25\27\b\4\1\2\26\21\3\2\2\2\26\25\3\2\2\2\27\7\3\2\2\2\30\31\7\5\2\2"+
		"\31#\b\5\1\2\32\33\7\3\2\2\33\34\7\4\2\2\34#\b\5\1\2\35\36\7\7\2\2\36"+
		"\37\5\4\3\2\37 \7\b\2\2 !\b\5\1\2!#\3\2\2\2\"\30\3\2\2\2\"\32\3\2\2\2"+
		"\"\35\3\2\2\2#\t\3\2\2\2\4\26\"";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}