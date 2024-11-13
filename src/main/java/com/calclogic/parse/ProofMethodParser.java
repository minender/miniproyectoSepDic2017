// Generated from .\ProofMethod.g4 by ANTLR 4.8


package com.calclogic.parse;

import com.calclogic.lambdacalculo.Const;
import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Term;
import java.util.LinkedList;


import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.misc.*;
import org.antlr.v4.runtime.tree.*;
import java.util.List;
import java.util.Iterator;
import java.util.ArrayList;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast"})
public class ProofMethodParser extends Parser {
	static { RuntimeMetaData.checkVersion("4.8", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		DS=1, DT=2, EO=3, OE=4, SL=5, SR=6, TL=7, TR=8, WL=9, WR=10, DE=11, CO=12, 
		CR=13, AI=14, MI=15, CA=16, GE=17, WI=18, O_PAR=19, C_PAR=20, WHITESPACE=21;
	public static final int
		RULE_start_rule = 0, RULE_method = 1, RULE_method_tail = 2, RULE_method_base = 3;
	private static String[] makeRuleNames() {
		return new String[] {
			"start_rule", "method", "method_tail", "method_base"
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

	@Override
	public String getGrammarFileName() { return "ProofMethod.g4"; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public String getSerializedATN() { return _serializedATN; }

	@Override
	public ATN getATN() { return _ATN; }

	public ProofMethodParser(TokenStream input) {
		super(input);
		_interp = new ParserATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}

	public static class Start_ruleContext extends ParserRuleContext {
		public Term value;
		public MethodContext method;
		public MethodContext method() {
			return getRuleContext(MethodContext.class,0);
		}
		public Start_ruleContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_start_rule; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof ProofMethodListener ) ((ProofMethodListener)listener).enterStart_rule(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof ProofMethodListener ) ((ProofMethodListener)listener).exitStart_rule(this);
		}
	}

	public final Start_ruleContext start_rule() throws RecognitionException {
		Start_ruleContext _localctx = new Start_ruleContext(_ctx, getState());
		enterRule(_localctx, 0, RULE_start_rule);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(8);
			((Start_ruleContext)_localctx).method = method();
			 ((Start_ruleContext)_localctx).value = ((Start_ruleContext)_localctx).method.value; 
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

	public static class MethodContext extends ParserRuleContext {
		public Term value;
		public Method_baseContext method_base;
		public Method_tailContext method_tail;
		public Method_baseContext method_base() {
			return getRuleContext(Method_baseContext.class,0);
		}
		public Method_tailContext method_tail() {
			return getRuleContext(Method_tailContext.class,0);
		}
		public MethodContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_method; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof ProofMethodListener ) ((ProofMethodListener)listener).enterMethod(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof ProofMethodListener ) ((ProofMethodListener)listener).exitMethod(this);
		}
	}

	public final MethodContext method() throws RecognitionException {
		MethodContext _localctx = new MethodContext(_ctx, getState());
		enterRule(_localctx, 2, RULE_method);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(11);
			((MethodContext)_localctx).method_base = method_base();
			setState(12);
			((MethodContext)_localctx).method_tail = method_tail();

			                                Term aux = ((MethodContext)_localctx).method_base.value; 
				                        for (Term it: ((MethodContext)_localctx).method_tail.value) 
			                                    aux = new App(aux,it);
							((MethodContext)_localctx).value =  aux;  
			                               
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

	public static class Method_tailContext extends ParserRuleContext {
		public LinkedList<Term> value;
		public Method_baseContext method_base;
		public Method_tailContext t;
		public Method_baseContext method_base() {
			return getRuleContext(Method_baseContext.class,0);
		}
		public Method_tailContext method_tail() {
			return getRuleContext(Method_tailContext.class,0);
		}
		public Method_tailContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_method_tail; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof ProofMethodListener ) ((ProofMethodListener)listener).enterMethod_tail(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof ProofMethodListener ) ((ProofMethodListener)listener).exitMethod_tail(this);
		}
	}

	public final Method_tailContext method_tail() throws RecognitionException {
		Method_tailContext _localctx = new Method_tailContext(_ctx, getState());
		enterRule(_localctx, 4, RULE_method_tail);
		try {
			setState(20);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case DS:
			case DT:
			case EO:
			case OE:
			case SL:
			case SR:
			case TL:
			case TR:
			case WL:
			case WR:
			case DE:
			case CO:
			case CR:
			case AI:
			case MI:
			case CA:
			case GE:
			case WI:
			case O_PAR:
				enterOuterAlt(_localctx, 1);
				{
				setState(15);
				((Method_tailContext)_localctx).method_base = method_base();
				setState(16);
				((Method_tailContext)_localctx).t = method_tail();
				 ((Method_tailContext)_localctx).t.value.add(0,((Method_tailContext)_localctx).method_base.value); ((Method_tailContext)_localctx).value =  ((Method_tailContext)_localctx).t.value; 
				}
				break;
			case EOF:
			case C_PAR:
				enterOuterAlt(_localctx, 2);
				{
				 ((Method_tailContext)_localctx).value =  new LinkedList<Term>(); 
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

	public static class Method_baseContext extends ParserRuleContext {
		public Term value;
		public MethodContext method;
		public TerminalNode DS() { return getToken(ProofMethodParser.DS, 0); }
		public TerminalNode DT() { return getToken(ProofMethodParser.DT, 0); }
		public TerminalNode EO() { return getToken(ProofMethodParser.EO, 0); }
		public TerminalNode OE() { return getToken(ProofMethodParser.OE, 0); }
		public TerminalNode SL() { return getToken(ProofMethodParser.SL, 0); }
		public TerminalNode SR() { return getToken(ProofMethodParser.SR, 0); }
		public TerminalNode TL() { return getToken(ProofMethodParser.TL, 0); }
		public TerminalNode TR() { return getToken(ProofMethodParser.TR, 0); }
		public TerminalNode WL() { return getToken(ProofMethodParser.WL, 0); }
		public TerminalNode WR() { return getToken(ProofMethodParser.WR, 0); }
		public TerminalNode DE() { return getToken(ProofMethodParser.DE, 0); }
		public TerminalNode CO() { return getToken(ProofMethodParser.CO, 0); }
		public TerminalNode CR() { return getToken(ProofMethodParser.CR, 0); }
		public TerminalNode AI() { return getToken(ProofMethodParser.AI, 0); }
		public TerminalNode MI() { return getToken(ProofMethodParser.MI, 0); }
		public TerminalNode CA() { return getToken(ProofMethodParser.CA, 0); }
		public TerminalNode GE() { return getToken(ProofMethodParser.GE, 0); }
		public TerminalNode WI() { return getToken(ProofMethodParser.WI, 0); }
		public TerminalNode O_PAR() { return getToken(ProofMethodParser.O_PAR, 0); }
		public MethodContext method() {
			return getRuleContext(MethodContext.class,0);
		}
		public TerminalNode C_PAR() { return getToken(ProofMethodParser.C_PAR, 0); }
		public Method_baseContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_method_base; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof ProofMethodListener ) ((ProofMethodListener)listener).enterMethod_base(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof ProofMethodListener ) ((ProofMethodListener)listener).exitMethod_base(this);
		}
	}

	public final Method_baseContext method_base() throws RecognitionException {
		Method_baseContext _localctx = new Method_baseContext(_ctx, getState());
		enterRule(_localctx, 6, RULE_method_base);
		try {
			setState(63);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case DS:
				enterOuterAlt(_localctx, 1);
				{
				setState(22);
				match(DS);
				((Method_baseContext)_localctx).value =  new Const("DS");
				}
				break;
			case DT:
				enterOuterAlt(_localctx, 2);
				{
				setState(24);
				match(DT);
				((Method_baseContext)_localctx).value =  new Const("DT");
				}
				break;
			case EO:
				enterOuterAlt(_localctx, 3);
				{
				setState(26);
				match(EO);
				((Method_baseContext)_localctx).value =  new Const("EO");
				}
				break;
			case OE:
				enterOuterAlt(_localctx, 4);
				{
				setState(28);
				match(OE);
				((Method_baseContext)_localctx).value =  new Const("OE");
				}
				break;
			case SL:
				enterOuterAlt(_localctx, 5);
				{
				setState(30);
				match(SL);
				((Method_baseContext)_localctx).value =  new Const("SL");
				}
				break;
			case SR:
				enterOuterAlt(_localctx, 6);
				{
				setState(32);
				match(SR);
				((Method_baseContext)_localctx).value =  new Const("SR");
				}
				break;
			case TL:
				enterOuterAlt(_localctx, 7);
				{
				setState(34);
				match(TL);
				((Method_baseContext)_localctx).value =  new Const("TL");
				}
				break;
			case TR:
				enterOuterAlt(_localctx, 8);
				{
				setState(36);
				match(TR);
				((Method_baseContext)_localctx).value =  new Const("TR");
				}
				break;
			case WL:
				enterOuterAlt(_localctx, 9);
				{
				setState(38);
				match(WL);
				((Method_baseContext)_localctx).value =  new Const("WL");
				}
				break;
			case WR:
				enterOuterAlt(_localctx, 10);
				{
				setState(40);
				match(WR);
				((Method_baseContext)_localctx).value =  new Const("WR");
				}
				break;
			case DE:
				enterOuterAlt(_localctx, 11);
				{
				setState(42);
				match(DE);
				((Method_baseContext)_localctx).value =  new Const("DE");
				}
				break;
			case CO:
				enterOuterAlt(_localctx, 12);
				{
				setState(44);
				match(CO);
				((Method_baseContext)_localctx).value =  new Const("CO");
				}
				break;
			case CR:
				enterOuterAlt(_localctx, 13);
				{
				setState(46);
				match(CR);
				((Method_baseContext)_localctx).value =  new Const("CR");
				}
				break;
			case AI:
				enterOuterAlt(_localctx, 14);
				{
				setState(48);
				match(AI);
				((Method_baseContext)_localctx).value =  new Const("AI");
				}
				break;
			case MI:
				enterOuterAlt(_localctx, 15);
				{
				setState(50);
				match(MI);
				((Method_baseContext)_localctx).value =  new Const("MI");
				}
				break;
			case CA:
				enterOuterAlt(_localctx, 16);
				{
				setState(52);
				match(CA);
				((Method_baseContext)_localctx).value =  new Const("CA");
				}
				break;
			case GE:
				enterOuterAlt(_localctx, 17);
				{
				setState(54);
				match(GE);
				((Method_baseContext)_localctx).value =  new Const("GE");
				}
				break;
			case WI:
				enterOuterAlt(_localctx, 18);
				{
				setState(56);
				match(WI);
				((Method_baseContext)_localctx).value =  new Const("WI");
				}
				break;
			case O_PAR:
				enterOuterAlt(_localctx, 19);
				{
				setState(58);
				match(O_PAR);
				setState(59);
				((Method_baseContext)_localctx).method = method();
				setState(60);
				match(C_PAR);
				 ((Method_baseContext)_localctx).value =  ((Method_baseContext)_localctx).method.value; 
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
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\3\27D\4\2\t\2\4\3\t"+
		"\3\4\4\t\4\4\5\t\5\3\2\3\2\3\2\3\3\3\3\3\3\3\3\3\4\3\4\3\4\3\4\3\4\5\4"+
		"\27\n\4\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3"+
		"\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5"+
		"\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\5\5B\n\5\3\5\2\2\6\2\4\6\b\2\2\2R\2\n"+
		"\3\2\2\2\4\r\3\2\2\2\6\26\3\2\2\2\bA\3\2\2\2\n\13\5\4\3\2\13\f\b\2\1\2"+
		"\f\3\3\2\2\2\r\16\5\b\5\2\16\17\5\6\4\2\17\20\b\3\1\2\20\5\3\2\2\2\21"+
		"\22\5\b\5\2\22\23\5\6\4\2\23\24\b\4\1\2\24\27\3\2\2\2\25\27\b\4\1\2\26"+
		"\21\3\2\2\2\26\25\3\2\2\2\27\7\3\2\2\2\30\31\7\3\2\2\31B\b\5\1\2\32\33"+
		"\7\4\2\2\33B\b\5\1\2\34\35\7\5\2\2\35B\b\5\1\2\36\37\7\6\2\2\37B\b\5\1"+
		"\2 !\7\7\2\2!B\b\5\1\2\"#\7\b\2\2#B\b\5\1\2$%\7\t\2\2%B\b\5\1\2&\'\7\n"+
		"\2\2\'B\b\5\1\2()\7\13\2\2)B\b\5\1\2*+\7\f\2\2+B\b\5\1\2,-\7\r\2\2-B\b"+
		"\5\1\2./\7\16\2\2/B\b\5\1\2\60\61\7\17\2\2\61B\b\5\1\2\62\63\7\20\2\2"+
		"\63B\b\5\1\2\64\65\7\21\2\2\65B\b\5\1\2\66\67\7\22\2\2\67B\b\5\1\289\7"+
		"\23\2\29B\b\5\1\2:;\7\24\2\2;B\b\5\1\2<=\7\25\2\2=>\5\4\3\2>?\7\26\2\2"+
		"?@\b\5\1\2@B\3\2\2\2A\30\3\2\2\2A\32\3\2\2\2A\34\3\2\2\2A\36\3\2\2\2A"+
		" \3\2\2\2A\"\3\2\2\2A$\3\2\2\2A&\3\2\2\2A(\3\2\2\2A*\3\2\2\2A,\3\2\2\2"+
		"A.\3\2\2\2A\60\3\2\2\2A\62\3\2\2\2A\64\3\2\2\2A\66\3\2\2\2A8\3\2\2\2A"+
		":\3\2\2\2A<\3\2\2\2B\t\3\2\2\2\4\26A";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}