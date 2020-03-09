// Generated from Term.g by ANTLR 4.8
package com.howtodoinjava.parse; 

import com.howtodoinjava.entity.Termino;
import com.howtodoinjava.entity.Simbolo;
import com.howtodoinjava.entity.TerminoId;
import com.howtodoinjava.lambdacalculo.*;
import com.howtodoinjava.service.TerminoManager;
import com.howtodoinjava.service.SimboloManager;

import java.util.Iterator;
import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.misc.*;
import org.antlr.v4.runtime.tree.*;
import java.util.List;
import java.util.Iterator;
import java.util.ArrayList;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast"})
public class TermParser extends Parser {
	static { RuntimeMetaData.checkVersion("4.8", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		T__0=1, T__1=2, T__2=3, T__3=4, T__4=5, T__5=6, T__6=7, T__7=8, T__8=9, 
		T__9=10, T__10=11, T__11=12, T__12=13, T__13=14, T__14=15, T__15=16, T__16=17, 
		T__17=18, T__18=19, T__19=20, T__20=21, T__21=22, T__22=23, T__23=24, 
		T__24=25, CAPITALLETTER=26, LETTER=27, WORD=28, WHITESPACE=29;
	public static final int
		RULE_start_rule = 0, RULE_eq = 1, RULE_eqtail = 2, RULE_term = 3, RULE_disyconjtail = 4, 
		RULE_disyconj = 5, RULE_conctail = 6, RULE_conc = 7, RULE_disytail = 8, 
		RULE_neq = 9, RULE_neqtail = 10, RULE_neg = 11, RULE_instantiate = 12, 
		RULE_explist = 13, RULE_explisttail = 14, RULE_arguments = 15, RULE_lambda = 16;
	private static String[] makeRuleNames() {
		return new String[] {
			"start_rule", "eq", "eqtail", "term", "disyconjtail", "disyconj", "conctail", 
			"conc", "disytail", "neq", "neqtail", "neg", "instantiate", "explist", 
			"explisttail", "arguments", "lambda"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, "'=='", "'\\equiv'", "'==>'", "'\\Rightarrow'", "'<=='", "'\\Leftarrow'", 
			"'\\/'", "'\\vee'", "'/\\'", "'\\wedge'", "'!=='", "'\\not\\equiv'", 
			"'!'", "'\\neg'", "'true'", "'false'", "'_{'", "'}^{'", "'}'", "'('", 
			"')'", "':='", "','", "'lambda'", "'.'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, null, null, null, null, null, null, null, null, null, null, null, 
			null, null, null, null, null, null, null, null, null, null, null, null, 
			null, null, "CAPITALLETTER", "LETTER", "WORD", "WHITESPACE"
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
	public String getGrammarFileName() { return "Term.g"; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public String getSerializedATN() { return _serializedATN; }

	@Override
	public ATN getATN() { return _ATN; }

	public TermParser(TokenStream input) {
		super(input);
		_interp = new ParserATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}

	public static class Start_ruleContext extends ParserRuleContext {
		public TerminoId terminoid;
		public TerminoManager terminoManager;
		public SimboloManager simboloManager;
		public Term value;
		public EqContext eq;
		public EqContext eq() {
			return getRuleContext(EqContext.class,0);
		}
		public Start_ruleContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public Start_ruleContext(ParserRuleContext parent, int invokingState, TerminoId terminoid, TerminoManager terminoManager, SimboloManager simboloManager) {
			super(parent, invokingState);
			this.terminoid = terminoid;
			this.terminoManager = terminoManager;
			this.simboloManager = simboloManager;
		}
		@Override public int getRuleIndex() { return RULE_start_rule; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).enterStart_rule(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).exitStart_rule(this);
		}
	}

	public final Start_ruleContext start_rule(TerminoId terminoid,TerminoManager terminoManager,SimboloManager simboloManager) throws RecognitionException {
		Start_ruleContext _localctx = new Start_ruleContext(_ctx, getState(), terminoid, terminoManager, simboloManager);
		enterRule(_localctx, 0, RULE_start_rule);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(34);
			((Start_ruleContext)_localctx).eq = eq(simboloManager);
			 ((Start_ruleContext)_localctx).value = ((Start_ruleContext)_localctx).eq.value;
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

	public static class EqContext extends ParserRuleContext {
		public SimboloManager simboloManager;
		public Term value;
		public TermContext term;
		public EqtailContext eqtail;
		public TermContext term() {
			return getRuleContext(TermContext.class,0);
		}
		public EqtailContext eqtail() {
			return getRuleContext(EqtailContext.class,0);
		}
		public EqContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public EqContext(ParserRuleContext parent, int invokingState, SimboloManager simboloManager) {
			super(parent, invokingState);
			this.simboloManager = simboloManager;
		}
		@Override public int getRuleIndex() { return RULE_eq; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).enterEq(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).exitEq(this);
		}
	}

	public final EqContext eq(SimboloManager simboloManager) throws RecognitionException {
		EqContext _localctx = new EqContext(_ctx, getState(), simboloManager);
		enterRule(_localctx, 2, RULE_eq);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(37);
			((EqContext)_localctx).term = term(simboloManager);
			setState(38);
			((EqContext)_localctx).eqtail = eqtail(simboloManager);
			 Term aux=((EqContext)_localctx).term.value;
			                                                for(Iterator<Term> i = ((EqContext)_localctx).eqtail.value.iterator(); i.hasNext();) {
			                                                   Simbolo s = simboloManager.getSimbolo(54);
			                                                   aux=new App(new App(new Const(s.getNotacion_latex(),!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),i.next()),aux);
			                                                }
			                                                ((EqContext)_localctx).value = aux;
			                                              
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

	public static class EqtailContext extends ParserRuleContext {
		public SimboloManager simboloManager;
		public ArrayList<Term> value;
		public TermContext term;
		public EqtailContext tail1;
		public TermContext term() {
			return getRuleContext(TermContext.class,0);
		}
		public EqtailContext eqtail() {
			return getRuleContext(EqtailContext.class,0);
		}
		public EqtailContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public EqtailContext(ParserRuleContext parent, int invokingState, SimboloManager simboloManager) {
			super(parent, invokingState);
			this.simboloManager = simboloManager;
		}
		@Override public int getRuleIndex() { return RULE_eqtail; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).enterEqtail(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).exitEqtail(this);
		}
	}

	public final EqtailContext eqtail(SimboloManager simboloManager) throws RecognitionException {
		EqtailContext _localctx = new EqtailContext(_ctx, getState(), simboloManager);
		enterRule(_localctx, 4, RULE_eqtail);
		int _la;
		try {
			setState(47);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__0:
			case T__1:
				enterOuterAlt(_localctx, 1);
				{
				setState(41);
				_la = _input.LA(1);
				if ( !(_la==T__0 || _la==T__1) ) {
				_errHandler.recoverInline(this);
				}
				else {
					if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
					_errHandler.reportMatch(this);
					consume();
				}
				setState(42);
				((EqtailContext)_localctx).term = term(simboloManager);
				setState(43);
				((EqtailContext)_localctx).tail1 = eqtail(simboloManager);
				ArrayList<Term> aux=((EqtailContext)_localctx).tail1.value; aux.add(0,((EqtailContext)_localctx).term.value); ((EqtailContext)_localctx).value = aux;
				}
				break;
			case EOF:
			case T__17:
			case T__20:
			case T__22:
				enterOuterAlt(_localctx, 2);
				{
				((EqtailContext)_localctx).value = new ArrayList<Term>();
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

	public static class TermContext extends ParserRuleContext {
		public SimboloManager simboloManager;
		public Term value;
		public DisyconjContext disyconj;
		public DisyconjtailContext disyconjtail;
		public DisyconjContext disyconj() {
			return getRuleContext(DisyconjContext.class,0);
		}
		public DisyconjtailContext disyconjtail() {
			return getRuleContext(DisyconjtailContext.class,0);
		}
		public TermContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public TermContext(ParserRuleContext parent, int invokingState, SimboloManager simboloManager) {
			super(parent, invokingState);
			this.simboloManager = simboloManager;
		}
		@Override public int getRuleIndex() { return RULE_term; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).enterTerm(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).exitTerm(this);
		}
	}

	public final TermContext term(SimboloManager simboloManager) throws RecognitionException {
		TermContext _localctx = new TermContext(_ctx, getState(), simboloManager);
		enterRule(_localctx, 6, RULE_term);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(49);
			((TermContext)_localctx).disyconj = disyconj(simboloManager);
			setState(50);
			((TermContext)_localctx).disyconjtail = disyconjtail(simboloManager);
			 
			                                                    if (((TermContext)_localctx).disyconjtail.value == null)
			                                                       ((TermContext)_localctx).value =  ((TermContext)_localctx).disyconj.value;
			                                                    else
			                                                       ((TermContext)_localctx).value =  new App(((TermContext)_localctx).disyconjtail.value,((TermContext)_localctx).disyconj.value);
			                                                  
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

	public static class DisyconjtailContext extends ParserRuleContext {
		public SimboloManager simboloManager;
		public Term value;
		public DisyconjContext disyconj;
		public DisyconjtailContext tail2;
		public DisyconjContext disyconj() {
			return getRuleContext(DisyconjContext.class,0);
		}
		public DisyconjtailContext disyconjtail() {
			return getRuleContext(DisyconjtailContext.class,0);
		}
		public DisyconjtailContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public DisyconjtailContext(ParserRuleContext parent, int invokingState, SimboloManager simboloManager) {
			super(parent, invokingState);
			this.simboloManager = simboloManager;
		}
		@Override public int getRuleIndex() { return RULE_disyconjtail; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).enterDisyconjtail(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).exitDisyconjtail(this);
		}
	}

	public final DisyconjtailContext disyconjtail(SimboloManager simboloManager) throws RecognitionException {
		DisyconjtailContext _localctx = new DisyconjtailContext(_ctx, getState(), simboloManager);
		enterRule(_localctx, 8, RULE_disyconjtail);
		int _la;
		try {
			setState(59);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__2:
			case T__3:
				enterOuterAlt(_localctx, 1);
				{
				setState(53);
				_la = _input.LA(1);
				if ( !(_la==T__2 || _la==T__3) ) {
				_errHandler.recoverInline(this);
				}
				else {
					if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
					_errHandler.reportMatch(this);
					consume();
				}
				setState(54);
				((DisyconjtailContext)_localctx).disyconj = disyconj(simboloManager);
				setState(55);
				((DisyconjtailContext)_localctx).tail2 = disyconjtail(simboloManager);

				                                               if (((DisyconjtailContext)_localctx).tail2.value == null)
				                                                  ((DisyconjtailContext)_localctx).value =  new App(new Const("\\Rightarrow ",false,2,2),((DisyconjtailContext)_localctx).disyconj.value);
				                                               else
				                                               ((DisyconjtailContext)_localctx).value = new App(new Const("\\Rightarrow ",false,2,2),new App(((DisyconjtailContext)_localctx).tail2.value,((DisyconjtailContext)_localctx).disyconj.value));
				                                              
				}
				break;
			case EOF:
			case T__0:
			case T__1:
			case T__17:
			case T__20:
			case T__22:
				enterOuterAlt(_localctx, 2);
				{
				((DisyconjtailContext)_localctx).value = null;
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

	public static class DisyconjContext extends ParserRuleContext {
		public SimboloManager simboloManager;
		public Term value;
		public ConcContext conc;
		public ConctailContext conctail;
		public ConcContext conc() {
			return getRuleContext(ConcContext.class,0);
		}
		public ConctailContext conctail() {
			return getRuleContext(ConctailContext.class,0);
		}
		public DisyconjContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public DisyconjContext(ParserRuleContext parent, int invokingState, SimboloManager simboloManager) {
			super(parent, invokingState);
			this.simboloManager = simboloManager;
		}
		@Override public int getRuleIndex() { return RULE_disyconj; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).enterDisyconj(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).exitDisyconj(this);
		}
	}

	public final DisyconjContext disyconj(SimboloManager simboloManager) throws RecognitionException {
		DisyconjContext _localctx = new DisyconjContext(_ctx, getState(), simboloManager);
		enterRule(_localctx, 10, RULE_disyconj);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(61);
			((DisyconjContext)_localctx).conc = conc(simboloManager);
			setState(62);
			((DisyconjContext)_localctx).conctail = conctail(simboloManager);
			 Term aux=((DisyconjContext)_localctx).conc.value;
			                                                for(Iterator<Term> i = ((DisyconjContext)_localctx).conctail.value.iterator(); i.hasNext();) 
			                                                   aux=new App(new App(new Const("\\Leftarrow ",false,2,1),i.next()),aux);
			                                                ((DisyconjContext)_localctx).value = aux;
			                                              
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

	public static class ConctailContext extends ParserRuleContext {
		public SimboloManager simboloManager;
		public ArrayList<Term> value;
		public ConcContext conc;
		public ConctailContext tail3;
		public ConcContext conc() {
			return getRuleContext(ConcContext.class,0);
		}
		public ConctailContext conctail() {
			return getRuleContext(ConctailContext.class,0);
		}
		public ConctailContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public ConctailContext(ParserRuleContext parent, int invokingState, SimboloManager simboloManager) {
			super(parent, invokingState);
			this.simboloManager = simboloManager;
		}
		@Override public int getRuleIndex() { return RULE_conctail; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).enterConctail(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).exitConctail(this);
		}
	}

	public final ConctailContext conctail(SimboloManager simboloManager) throws RecognitionException {
		ConctailContext _localctx = new ConctailContext(_ctx, getState(), simboloManager);
		enterRule(_localctx, 12, RULE_conctail);
		int _la;
		try {
			setState(71);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__4:
			case T__5:
				enterOuterAlt(_localctx, 1);
				{
				setState(65);
				_la = _input.LA(1);
				if ( !(_la==T__4 || _la==T__5) ) {
				_errHandler.recoverInline(this);
				}
				else {
					if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
					_errHandler.reportMatch(this);
					consume();
				}
				setState(66);
				((ConctailContext)_localctx).conc = conc(simboloManager);
				setState(67);
				((ConctailContext)_localctx).tail3 = conctail(simboloManager);
				ArrayList<Term> aux=((ConctailContext)_localctx).tail3.value; 
				                                               aux.add(0,((ConctailContext)_localctx).conc.value); ((ConctailContext)_localctx).value = aux;
				                                              
				}
				break;
			case EOF:
			case T__0:
			case T__1:
			case T__2:
			case T__3:
			case T__17:
			case T__20:
			case T__22:
				enterOuterAlt(_localctx, 2);
				{
				((ConctailContext)_localctx).value = new ArrayList<Term>();
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

	public static class ConcContext extends ParserRuleContext {
		public SimboloManager simboloManager;
		public Term value;
		public NeqContext neq;
		public DisytailContext disytail;
		public NeqContext neq() {
			return getRuleContext(NeqContext.class,0);
		}
		public DisytailContext disytail() {
			return getRuleContext(DisytailContext.class,0);
		}
		public ConcContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public ConcContext(ParserRuleContext parent, int invokingState, SimboloManager simboloManager) {
			super(parent, invokingState);
			this.simboloManager = simboloManager;
		}
		@Override public int getRuleIndex() { return RULE_conc; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).enterConc(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).exitConc(this);
		}
	}

	public final ConcContext conc(SimboloManager simboloManager) throws RecognitionException {
		ConcContext _localctx = new ConcContext(_ctx, getState(), simboloManager);
		enterRule(_localctx, 14, RULE_conc);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(73);
			((ConcContext)_localctx).neq = neq(simboloManager);
			setState(74);
			((ConcContext)_localctx).disytail = disytail(simboloManager);
			 Term aux=((ConcContext)_localctx).neq.value; 
			                                                     for(Iterator<ParserPair> i = ((ConcContext)_localctx).disytail.value.iterator(); i.hasNext();)
			                                                     {
			                                                        ParserPair pair = i.next();
			                                                        if (pair.symbol.equals("\\vee "))
			                                                           aux=new App(new App(new Const(pair.symbol,false,3,1),pair.term),aux); 
			                                                        else if (pair.symbol.equals("\\wedge "))
			                                                           aux=new App(new App(new Const(pair.symbol,false,3,1),pair.term),aux); 
			                                                     }
			                                                     ((ConcContext)_localctx).value = aux;
			                                                   
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

	public static class DisytailContext extends ParserRuleContext {
		public SimboloManager simboloManager;
		public ArrayList<ParserPair> value;
		public NeqContext neq;
		public DisytailContext tail4;
		public DisytailContext tail5;
		public NeqContext neq() {
			return getRuleContext(NeqContext.class,0);
		}
		public DisytailContext disytail() {
			return getRuleContext(DisytailContext.class,0);
		}
		public DisytailContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public DisytailContext(ParserRuleContext parent, int invokingState, SimboloManager simboloManager) {
			super(parent, invokingState);
			this.simboloManager = simboloManager;
		}
		@Override public int getRuleIndex() { return RULE_disytail; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).enterDisytail(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).exitDisytail(this);
		}
	}

	public final DisytailContext disytail(SimboloManager simboloManager) throws RecognitionException {
		DisytailContext _localctx = new DisytailContext(_ctx, getState(), simboloManager);
		enterRule(_localctx, 16, RULE_disytail);
		int _la;
		try {
			setState(88);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__6:
			case T__7:
				enterOuterAlt(_localctx, 1);
				{
				setState(77);
				_la = _input.LA(1);
				if ( !(_la==T__6 || _la==T__7) ) {
				_errHandler.recoverInline(this);
				}
				else {
					if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
					_errHandler.reportMatch(this);
					consume();
				}
				setState(78);
				((DisytailContext)_localctx).neq = neq(simboloManager);
				setState(79);
				((DisytailContext)_localctx).tail4 = disytail(simboloManager);
				ArrayList<ParserPair> aux=((DisytailContext)_localctx).tail4.value;
				                                               aux.add(0,new ParserPair("\\vee ",((DisytailContext)_localctx).neq.value)); ((DisytailContext)_localctx).value = aux;
				                                              
				}
				break;
			case T__8:
			case T__9:
				enterOuterAlt(_localctx, 2);
				{
				setState(82);
				_la = _input.LA(1);
				if ( !(_la==T__8 || _la==T__9) ) {
				_errHandler.recoverInline(this);
				}
				else {
					if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
					_errHandler.reportMatch(this);
					consume();
				}
				setState(83);
				((DisytailContext)_localctx).neq = neq(simboloManager);
				setState(84);
				((DisytailContext)_localctx).tail5 = disytail(simboloManager);
				ArrayList<ParserPair> aux=((DisytailContext)_localctx).tail5.value; 
				                                               aux.add(0,new ParserPair("\\wedge ",((DisytailContext)_localctx).neq.value)); ((DisytailContext)_localctx).value = aux;
				                                              
				}
				break;
			case EOF:
			case T__0:
			case T__1:
			case T__2:
			case T__3:
			case T__4:
			case T__5:
			case T__17:
			case T__20:
			case T__22:
				enterOuterAlt(_localctx, 3);
				{
				((DisytailContext)_localctx).value = new ArrayList<ParserPair>();
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

	public static class NeqContext extends ParserRuleContext {
		public SimboloManager simboloManager;
		public Term value;
		public NegContext neg;
		public NeqtailContext neqtail;
		public NegContext neg() {
			return getRuleContext(NegContext.class,0);
		}
		public NeqtailContext neqtail() {
			return getRuleContext(NeqtailContext.class,0);
		}
		public NeqContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public NeqContext(ParserRuleContext parent, int invokingState, SimboloManager simboloManager) {
			super(parent, invokingState);
			this.simboloManager = simboloManager;
		}
		@Override public int getRuleIndex() { return RULE_neq; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).enterNeq(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).exitNeq(this);
		}
	}

	public final NeqContext neq(SimboloManager simboloManager) throws RecognitionException {
		NeqContext _localctx = new NeqContext(_ctx, getState(), simboloManager);
		enterRule(_localctx, 18, RULE_neq);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(90);
			((NeqContext)_localctx).neg = neg(simboloManager);
			setState(91);
			((NeqContext)_localctx).neqtail = neqtail(simboloManager);
			 Term aux=((NeqContext)_localctx).neg.value;
			                                                for(Iterator<Term> i = ((NeqContext)_localctx).neqtail.value.iterator(); i.hasNext();) 
			                                                   aux=new App(new App(new Const("\\not\\equiv ",false,4,1),i.next()),aux);
			                                                ((NeqContext)_localctx).value = aux;
			                                              
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

	public static class NeqtailContext extends ParserRuleContext {
		public SimboloManager simboloManager;
		public ArrayList<Term> value;
		public NegContext neg;
		public NeqtailContext tail6;
		public NegContext neg() {
			return getRuleContext(NegContext.class,0);
		}
		public NeqtailContext neqtail() {
			return getRuleContext(NeqtailContext.class,0);
		}
		public NeqtailContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public NeqtailContext(ParserRuleContext parent, int invokingState, SimboloManager simboloManager) {
			super(parent, invokingState);
			this.simboloManager = simboloManager;
		}
		@Override public int getRuleIndex() { return RULE_neqtail; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).enterNeqtail(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).exitNeqtail(this);
		}
	}

	public final NeqtailContext neqtail(SimboloManager simboloManager) throws RecognitionException {
		NeqtailContext _localctx = new NeqtailContext(_ctx, getState(), simboloManager);
		enterRule(_localctx, 20, RULE_neqtail);
		int _la;
		try {
			setState(100);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__10:
			case T__11:
				enterOuterAlt(_localctx, 1);
				{
				setState(94);
				_la = _input.LA(1);
				if ( !(_la==T__10 || _la==T__11) ) {
				_errHandler.recoverInline(this);
				}
				else {
					if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
					_errHandler.reportMatch(this);
					consume();
				}
				setState(95);
				((NeqtailContext)_localctx).neg = neg(simboloManager);
				setState(96);
				((NeqtailContext)_localctx).tail6 = neqtail(simboloManager);
				ArrayList<Term> aux=((NeqtailContext)_localctx).tail6.value; 
				                                               aux.add(0,((NeqtailContext)_localctx).neg.value); ((NeqtailContext)_localctx).value = aux;
				                                              
				}
				break;
			case EOF:
			case T__0:
			case T__1:
			case T__2:
			case T__3:
			case T__4:
			case T__5:
			case T__6:
			case T__7:
			case T__8:
			case T__9:
			case T__17:
			case T__20:
			case T__22:
				enterOuterAlt(_localctx, 2);
				{
				((NeqtailContext)_localctx).value = new ArrayList<Term>();
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

	public static class NegContext extends ParserRuleContext {
		public SimboloManager simboloManager;
		public Term value;
		public NegContext n;
		public Token CAPITALLETTER;
		public Token LETTER;
		public EqContext eq;
		public Token WORD;
		public ArgumentsContext arguments;
		public NegContext neg() {
			return getRuleContext(NegContext.class,0);
		}
		public TerminalNode CAPITALLETTER() { return getToken(TermParser.CAPITALLETTER, 0); }
		public TerminalNode LETTER() { return getToken(TermParser.LETTER, 0); }
		public EqContext eq() {
			return getRuleContext(EqContext.class,0);
		}
		public TerminalNode WORD() { return getToken(TermParser.WORD, 0); }
		public ArgumentsContext arguments() {
			return getRuleContext(ArgumentsContext.class,0);
		}
		public NegContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public NegContext(ParserRuleContext parent, int invokingState, SimboloManager simboloManager) {
			super(parent, invokingState);
			this.simboloManager = simboloManager;
		}
		@Override public int getRuleIndex() { return RULE_neg; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).enterNeg(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).exitNeg(this);
		}
	}

	public final NegContext neg(SimboloManager simboloManager) throws RecognitionException {
		NegContext _localctx = new NegContext(_ctx, getState(), simboloManager);
		enterRule(_localctx, 22, RULE_neg);
		int _la;
		try {
			setState(133);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,5,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(102);
				_la = _input.LA(1);
				if ( !(_la==T__12 || _la==T__13) ) {
				_errHandler.recoverInline(this);
				}
				else {
					if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
					_errHandler.reportMatch(this);
					consume();
				}
				setState(103);
				((NegContext)_localctx).n = neg(simboloManager);
				((NegContext)_localctx).value = new App(new Const("\\neg ",false,5,2),((NegContext)_localctx).n.value);
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(106);
				((NegContext)_localctx).CAPITALLETTER = match(CAPITALLETTER);
				((NegContext)_localctx).value =  new Var((new Integer((int)(((NegContext)_localctx).CAPITALLETTER!=null?((NegContext)_localctx).CAPITALLETTER.getText():null).charAt(0))).intValue());
				}
				break;
			case 3:
				enterOuterAlt(_localctx, 3);
				{
				setState(108);
				((NegContext)_localctx).LETTER = match(LETTER);
				((NegContext)_localctx).value =  new Var((new Integer((int)(((NegContext)_localctx).LETTER!=null?((NegContext)_localctx).LETTER.getText():null).charAt(0))).intValue());
				}
				break;
			case 4:
				enterOuterAlt(_localctx, 4);
				{
				setState(110);
				match(T__14);
				((NegContext)_localctx).value =  new Const("true ");
				}
				break;
			case 5:
				enterOuterAlt(_localctx, 5);
				{
				setState(112);
				match(T__15);
				((NegContext)_localctx).value =  new Const("false ");
				}
				break;
			case 6:
				enterOuterAlt(_localctx, 6);
				{
				setState(114);
				((NegContext)_localctx).CAPITALLETTER = match(CAPITALLETTER);
				setState(115);
				match(T__16);
				setState(116);
				((NegContext)_localctx).eq = eq(simboloManager);
				setState(117);
				match(T__17);
				setState(118);
				((NegContext)_localctx).LETTER = match(LETTER);
				setState(119);
				match(T__18);
				Var letter = new Var((new Integer((int)(((NegContext)_localctx).LETTER!=null?((NegContext)_localctx).LETTER.getText():null).charAt(0))).intValue());
				                                               Var capl = new Var((new Integer((int)(((NegContext)_localctx).CAPITALLETTER!=null?((NegContext)_localctx).CAPITALLETTER.getText():null).charAt(0))).intValue());
				                                               List<Var> vars = new ArrayList<Var>();
				                                               List<Term> terms = new ArrayList<Term>();
				                                               vars.add(0,letter);
				                                               terms.add(0,((NegContext)_localctx).eq.value );    
				                                               ((NegContext)_localctx).value =  new App(capl,new Sust(vars, terms));
				                                              
				}
				break;
			case 7:
				enterOuterAlt(_localctx, 7);
				{
				setState(122);
				((NegContext)_localctx).WORD = match(WORD);
				setState(123);
				match(T__19);
				setState(124);
				((NegContext)_localctx).arguments = arguments(simboloManager);
				setState(125);
				match(T__20);
				Term aux = new Const((((NegContext)_localctx).WORD!=null?((NegContext)_localctx).WORD.getText():null),true,-1,-1);
				                                               for(Iterator<Var> i = ((NegContext)_localctx).arguments.value.iterator(); i.hasNext();) 
				                                                  aux=new App(aux,i.next());
				                                               ((NegContext)_localctx).value = aux;
				                                              
				}
				break;
			case 8:
				enterOuterAlt(_localctx, 8);
				{
				setState(128);
				match(T__19);
				setState(129);
				((NegContext)_localctx).eq = eq(simboloManager);
				setState(130);
				match(T__20);
				((NegContext)_localctx).value = ((NegContext)_localctx).eq.value;
				}
				break;
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

	public static class InstantiateContext extends ParserRuleContext {
		public TerminoId terminoid;
		public TerminoManager terminoManager;
		public SimboloManager simboloManager;
		public ArrayList<Object> value;
		public ArgumentsContext arguments;
		public ExplistContext explist;
		public ArgumentsContext arguments() {
			return getRuleContext(ArgumentsContext.class,0);
		}
		public ExplistContext explist() {
			return getRuleContext(ExplistContext.class,0);
		}
		public InstantiateContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public InstantiateContext(ParserRuleContext parent, int invokingState, TerminoId terminoid, TerminoManager terminoManager, SimboloManager simboloManager) {
			super(parent, invokingState);
			this.terminoid = terminoid;
			this.terminoManager = terminoManager;
			this.simboloManager = simboloManager;
		}
		@Override public int getRuleIndex() { return RULE_instantiate; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).enterInstantiate(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).exitInstantiate(this);
		}
	}

	public final InstantiateContext instantiate(TerminoId terminoid,TerminoManager terminoManager,SimboloManager simboloManager) throws RecognitionException {
		InstantiateContext _localctx = new InstantiateContext(_ctx, getState(), terminoid, terminoManager, simboloManager);
		enterRule(_localctx, 24, RULE_instantiate);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(135);
			((InstantiateContext)_localctx).arguments = arguments(simboloManager);
			setState(136);
			match(T__21);
			setState(137);
			((InstantiateContext)_localctx).explist = explist(simboloManager);
			ArrayList<Object> arr=new ArrayList<Object>();
			                                               arr.add(((InstantiateContext)_localctx).arguments.value);
			                                               arr.add(((InstantiateContext)_localctx).explist.value);
			                                               ((InstantiateContext)_localctx).value =  arr;
			                                              
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

	public static class ExplistContext extends ParserRuleContext {
		public SimboloManager simboloManager;
		public ArrayList<Term> value;
		public EqContext eq;
		public ExplisttailContext explisttail;
		public EqContext eq() {
			return getRuleContext(EqContext.class,0);
		}
		public ExplisttailContext explisttail() {
			return getRuleContext(ExplisttailContext.class,0);
		}
		public ExplistContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public ExplistContext(ParserRuleContext parent, int invokingState, SimboloManager simboloManager) {
			super(parent, invokingState);
			this.simboloManager = simboloManager;
		}
		@Override public int getRuleIndex() { return RULE_explist; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).enterExplist(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).exitExplist(this);
		}
	}

	public final ExplistContext explist(SimboloManager simboloManager) throws RecognitionException {
		ExplistContext _localctx = new ExplistContext(_ctx, getState(), simboloManager);
		enterRule(_localctx, 26, RULE_explist);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(140);
			((ExplistContext)_localctx).eq = eq(simboloManager);
			setState(141);
			((ExplistContext)_localctx).explisttail = explisttail(simboloManager);
			ArrayList<Term> aux = ((ExplistContext)_localctx).explisttail.value;
			                                               aux.add(0,((ExplistContext)_localctx).eq.value);
			                                               ((ExplistContext)_localctx).value =  aux;
			                                              
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

	public static class ExplisttailContext extends ParserRuleContext {
		public SimboloManager simboloManager;
		public ArrayList<Term> value;
		public EqContext eq;
		public ExplisttailContext tail7;
		public EqContext eq() {
			return getRuleContext(EqContext.class,0);
		}
		public ExplisttailContext explisttail() {
			return getRuleContext(ExplisttailContext.class,0);
		}
		public ExplisttailContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public ExplisttailContext(ParserRuleContext parent, int invokingState, SimboloManager simboloManager) {
			super(parent, invokingState);
			this.simboloManager = simboloManager;
		}
		@Override public int getRuleIndex() { return RULE_explisttail; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).enterExplisttail(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).exitExplisttail(this);
		}
	}

	public final ExplisttailContext explisttail(SimboloManager simboloManager) throws RecognitionException {
		ExplisttailContext _localctx = new ExplisttailContext(_ctx, getState(), simboloManager);
		enterRule(_localctx, 28, RULE_explisttail);
		try {
			setState(150);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__22:
				enterOuterAlt(_localctx, 1);
				{
				setState(144);
				match(T__22);
				setState(145);
				((ExplisttailContext)_localctx).eq = eq(simboloManager);
				setState(146);
				((ExplisttailContext)_localctx).tail7 = explisttail(simboloManager);
				ArrayList<Term> aux = ((ExplisttailContext)_localctx).tail7.value;
				                                               aux.add(0,((ExplisttailContext)_localctx).eq.value);
				                                               ((ExplisttailContext)_localctx).value = aux;
				                                              
				}
				break;
			case EOF:
				enterOuterAlt(_localctx, 2);
				{
				((ExplisttailContext)_localctx).value =  new ArrayList<Term>();
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

	public static class ArgumentsContext extends ParserRuleContext {
		public SimboloManager simboloManager;
		public ArrayList<Var> value;
		public Token LETTER;
		public ArgumentsContext arg;
		public Token CAPITALLETTER;
		public TerminalNode LETTER() { return getToken(TermParser.LETTER, 0); }
		public ArgumentsContext arguments() {
			return getRuleContext(ArgumentsContext.class,0);
		}
		public TerminalNode CAPITALLETTER() { return getToken(TermParser.CAPITALLETTER, 0); }
		public ArgumentsContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public ArgumentsContext(ParserRuleContext parent, int invokingState, SimboloManager simboloManager) {
			super(parent, invokingState);
			this.simboloManager = simboloManager;
		}
		@Override public int getRuleIndex() { return RULE_arguments; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).enterArguments(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).exitArguments(this);
		}
	}

	public final ArgumentsContext arguments(SimboloManager simboloManager) throws RecognitionException {
		ArgumentsContext _localctx = new ArgumentsContext(_ctx, getState(), simboloManager);
		enterRule(_localctx, 30, RULE_arguments);
		try {
			setState(166);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,7,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(152);
				((ArgumentsContext)_localctx).LETTER = match(LETTER);
				setState(153);
				match(T__22);
				setState(154);
				((ArgumentsContext)_localctx).arg = arguments(simboloManager);
				ArrayList<Var> aux=((ArgumentsContext)_localctx).arg.value; 
				                                                            Var v=new Var((new Integer((int)(((ArgumentsContext)_localctx).LETTER!=null?((ArgumentsContext)_localctx).LETTER.getText():null).charAt(0))).intValue());
				                                                            aux.add(0,v); 
				                                                            ((ArgumentsContext)_localctx).value = aux;
				                                                           
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(157);
				((ArgumentsContext)_localctx).CAPITALLETTER = match(CAPITALLETTER);
				setState(158);
				match(T__22);
				setState(159);
				((ArgumentsContext)_localctx).arg = arguments(simboloManager);
				ArrayList<Var> aux=((ArgumentsContext)_localctx).arg.value; 
				                                                     Var v=new Var((new Integer((int)(((ArgumentsContext)_localctx).CAPITALLETTER!=null?((ArgumentsContext)_localctx).CAPITALLETTER.getText():null).charAt(0))).intValue());
				                                                            aux.add(0,v); 
				                                                            ((ArgumentsContext)_localctx).value = aux;
				                                                           
				}
				break;
			case 3:
				enterOuterAlt(_localctx, 3);
				{
				setState(162);
				((ArgumentsContext)_localctx).LETTER = match(LETTER);
				ArrayList<Var> list=new ArrayList<Var>();
				                                                            Var v=new Var((new Integer((((ArgumentsContext)_localctx).LETTER!=null?((ArgumentsContext)_localctx).LETTER.getText():null).charAt(0))).intValue());
				                                                            list.add(0,v);
				                                                            ((ArgumentsContext)_localctx).value =  list;
				                                                           
				}
				break;
			case 4:
				enterOuterAlt(_localctx, 4);
				{
				setState(164);
				((ArgumentsContext)_localctx).CAPITALLETTER = match(CAPITALLETTER);
				ArrayList<Var> list=new ArrayList<Var>();
				                                                       Var v=new Var((new Integer((((ArgumentsContext)_localctx).CAPITALLETTER!=null?((ArgumentsContext)_localctx).CAPITALLETTER.getText():null).charAt(0))).intValue());
				                                                             list.add(0,v);
				                                                             ((ArgumentsContext)_localctx).value =  list;
				                                                           
				}
				break;
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

	public static class LambdaContext extends ParserRuleContext {
		public TerminoId terminoid;
		public TerminoManager terminoManager;
		public SimboloManager simboloManager;
		public Term value;
		public Token LETTER;
		public EqContext eq;
		public TerminalNode LETTER() { return getToken(TermParser.LETTER, 0); }
		public EqContext eq() {
			return getRuleContext(EqContext.class,0);
		}
		public LambdaContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public LambdaContext(ParserRuleContext parent, int invokingState, TerminoId terminoid, TerminoManager terminoManager, SimboloManager simboloManager) {
			super(parent, invokingState);
			this.terminoid = terminoid;
			this.terminoManager = terminoManager;
			this.simboloManager = simboloManager;
		}
		@Override public int getRuleIndex() { return RULE_lambda; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).enterLambda(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).exitLambda(this);
		}
	}

	public final LambdaContext lambda(TerminoId terminoid,TerminoManager terminoManager,SimboloManager simboloManager) throws RecognitionException {
		LambdaContext _localctx = new LambdaContext(_ctx, getState(), terminoid, terminoManager, simboloManager);
		enterRule(_localctx, 32, RULE_lambda);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(168);
			match(T__23);
			setState(169);
			((LambdaContext)_localctx).LETTER = match(LETTER);
			setState(170);
			match(T__24);
			setState(171);
			((LambdaContext)_localctx).eq = eq(simboloManager);
			Var v=new Var((new Integer((((LambdaContext)_localctx).LETTER!=null?((LambdaContext)_localctx).LETTER.getText():null).charAt(0))).intValue());
			                                                            ((LambdaContext)_localctx).value =  new Bracket(v,((LambdaContext)_localctx).eq.value);
			                                                           
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
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\3\37\u00b1\4\2\t\2"+
		"\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4\13"+
		"\t\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22\t\22"+
		"\3\2\3\2\3\2\3\3\3\3\3\3\3\3\3\4\3\4\3\4\3\4\3\4\3\4\5\4\62\n\4\3\5\3"+
		"\5\3\5\3\5\3\6\3\6\3\6\3\6\3\6\3\6\5\6>\n\6\3\7\3\7\3\7\3\7\3\b\3\b\3"+
		"\b\3\b\3\b\3\b\5\bJ\n\b\3\t\3\t\3\t\3\t\3\n\3\n\3\n\3\n\3\n\3\n\3\n\3"+
		"\n\3\n\3\n\3\n\5\n[\n\n\3\13\3\13\3\13\3\13\3\f\3\f\3\f\3\f\3\f\3\f\5"+
		"\fg\n\f\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3"+
		"\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\5\r\u0088"+
		"\n\r\3\16\3\16\3\16\3\16\3\16\3\17\3\17\3\17\3\17\3\20\3\20\3\20\3\20"+
		"\3\20\3\20\5\20\u0099\n\20\3\21\3\21\3\21\3\21\3\21\3\21\3\21\3\21\3\21"+
		"\3\21\3\21\3\21\3\21\3\21\5\21\u00a9\n\21\3\22\3\22\3\22\3\22\3\22\3\22"+
		"\3\22\2\2\23\2\4\6\b\n\f\16\20\22\24\26\30\32\34\36 \"\2\t\3\2\3\4\3\2"+
		"\5\6\3\2\7\b\3\2\t\n\3\2\13\f\3\2\r\16\3\2\17\20\2\u00b0\2$\3\2\2\2\4"+
		"\'\3\2\2\2\6\61\3\2\2\2\b\63\3\2\2\2\n=\3\2\2\2\f?\3\2\2\2\16I\3\2\2\2"+
		"\20K\3\2\2\2\22Z\3\2\2\2\24\\\3\2\2\2\26f\3\2\2\2\30\u0087\3\2\2\2\32"+
		"\u0089\3\2\2\2\34\u008e\3\2\2\2\36\u0098\3\2\2\2 \u00a8\3\2\2\2\"\u00aa"+
		"\3\2\2\2$%\5\4\3\2%&\b\2\1\2&\3\3\2\2\2\'(\5\b\5\2()\5\6\4\2)*\b\3\1\2"+
		"*\5\3\2\2\2+,\t\2\2\2,-\5\b\5\2-.\5\6\4\2./\b\4\1\2/\62\3\2\2\2\60\62"+
		"\b\4\1\2\61+\3\2\2\2\61\60\3\2\2\2\62\7\3\2\2\2\63\64\5\f\7\2\64\65\5"+
		"\n\6\2\65\66\b\5\1\2\66\t\3\2\2\2\678\t\3\2\289\5\f\7\29:\5\n\6\2:;\b"+
		"\6\1\2;>\3\2\2\2<>\b\6\1\2=\67\3\2\2\2=<\3\2\2\2>\13\3\2\2\2?@\5\20\t"+
		"\2@A\5\16\b\2AB\b\7\1\2B\r\3\2\2\2CD\t\4\2\2DE\5\20\t\2EF\5\16\b\2FG\b"+
		"\b\1\2GJ\3\2\2\2HJ\b\b\1\2IC\3\2\2\2IH\3\2\2\2J\17\3\2\2\2KL\5\24\13\2"+
		"LM\5\22\n\2MN\b\t\1\2N\21\3\2\2\2OP\t\5\2\2PQ\5\24\13\2QR\5\22\n\2RS\b"+
		"\n\1\2S[\3\2\2\2TU\t\6\2\2UV\5\24\13\2VW\5\22\n\2WX\b\n\1\2X[\3\2\2\2"+
		"Y[\b\n\1\2ZO\3\2\2\2ZT\3\2\2\2ZY\3\2\2\2[\23\3\2\2\2\\]\5\30\r\2]^\5\26"+
		"\f\2^_\b\13\1\2_\25\3\2\2\2`a\t\7\2\2ab\5\30\r\2bc\5\26\f\2cd\b\f\1\2"+
		"dg\3\2\2\2eg\b\f\1\2f`\3\2\2\2fe\3\2\2\2g\27\3\2\2\2hi\t\b\2\2ij\5\30"+
		"\r\2jk\b\r\1\2k\u0088\3\2\2\2lm\7\34\2\2m\u0088\b\r\1\2no\7\35\2\2o\u0088"+
		"\b\r\1\2pq\7\21\2\2q\u0088\b\r\1\2rs\7\22\2\2s\u0088\b\r\1\2tu\7\34\2"+
		"\2uv\7\23\2\2vw\5\4\3\2wx\7\24\2\2xy\7\35\2\2yz\7\25\2\2z{\b\r\1\2{\u0088"+
		"\3\2\2\2|}\7\36\2\2}~\7\26\2\2~\177\5 \21\2\177\u0080\7\27\2\2\u0080\u0081"+
		"\b\r\1\2\u0081\u0088\3\2\2\2\u0082\u0083\7\26\2\2\u0083\u0084\5\4\3\2"+
		"\u0084\u0085\7\27\2\2\u0085\u0086\b\r\1\2\u0086\u0088\3\2\2\2\u0087h\3"+
		"\2\2\2\u0087l\3\2\2\2\u0087n\3\2\2\2\u0087p\3\2\2\2\u0087r\3\2\2\2\u0087"+
		"t\3\2\2\2\u0087|\3\2\2\2\u0087\u0082\3\2\2\2\u0088\31\3\2\2\2\u0089\u008a"+
		"\5 \21\2\u008a\u008b\7\30\2\2\u008b\u008c\5\34\17\2\u008c\u008d\b\16\1"+
		"\2\u008d\33\3\2\2\2\u008e\u008f\5\4\3\2\u008f\u0090\5\36\20\2\u0090\u0091"+
		"\b\17\1\2\u0091\35\3\2\2\2\u0092\u0093\7\31\2\2\u0093\u0094\5\4\3\2\u0094"+
		"\u0095\5\36\20\2\u0095\u0096\b\20\1\2\u0096\u0099\3\2\2\2\u0097\u0099"+
		"\b\20\1\2\u0098\u0092\3\2\2\2\u0098\u0097\3\2\2\2\u0099\37\3\2\2\2\u009a"+
		"\u009b\7\35\2\2\u009b\u009c\7\31\2\2\u009c\u009d\5 \21\2\u009d\u009e\b"+
		"\21\1\2\u009e\u00a9\3\2\2\2\u009f\u00a0\7\34\2\2\u00a0\u00a1\7\31\2\2"+
		"\u00a1\u00a2\5 \21\2\u00a2\u00a3\b\21\1\2\u00a3\u00a9\3\2\2\2\u00a4\u00a5"+
		"\7\35\2\2\u00a5\u00a9\b\21\1\2\u00a6\u00a7\7\34\2\2\u00a7\u00a9\b\21\1"+
		"\2\u00a8\u009a\3\2\2\2\u00a8\u009f\3\2\2\2\u00a8\u00a4\3\2\2\2\u00a8\u00a6"+
		"\3\2\2\2\u00a9!\3\2\2\2\u00aa\u00ab\7\32\2\2\u00ab\u00ac\7\35\2\2\u00ac"+
		"\u00ad\7\33\2\2\u00ad\u00ae\5\4\3\2\u00ae\u00af\b\22\1\2\u00af#\3\2\2"+
		"\2\n\61=IZf\u0087\u0098\u00a8";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}