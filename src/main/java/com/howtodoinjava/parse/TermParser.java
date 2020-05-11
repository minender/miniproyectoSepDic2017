// Generated from Term.g by ANTLR 4.8
package com.howtodoinjava.parse; 

import com.howtodoinjava.entity.Predicado;
import com.howtodoinjava.entity.Simbolo;
import com.howtodoinjava.entity.PredicadoId;
import com.howtodoinjava.entity.Simbolo;
import com.howtodoinjava.lambdacalculo.*;
import com.howtodoinjava.service.PredicadoManager;
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
		T__24=25, T__25=26, T__26=27, T__27=28, T__28=29, T__29=30, T__30=31, 
		T__31=32, T__32=33, CAPITALLETTER=34, LETTER=35, NUMBER=36, WORD=37, WHITESPACE=38;
	public static final int
		RULE_start_rule = 0, RULE_eq = 1, RULE_eqtail = 2, RULE_form = 3, RULE_disyconjtail = 4, 
		RULE_disyconj = 5, RULE_conctail = 6, RULE_conc = 7, RULE_disytail = 8, 
		RULE_neq = 9, RULE_neqtail = 10, RULE_neg = 11, RULE_term = 12, RULE_sumsustail = 13, 
		RULE_sumsus = 14, RULE_multdivtail = 15, RULE_multdiv = 16, RULE_constail = 17, 
		RULE_cons = 18, RULE_instantiate = 19, RULE_explist = 20, RULE_explisttail = 21, 
		RULE_termtail = 22, RULE_arguments = 23, RULE_lambda = 24;
	private static String[] makeRuleNames() {
		return new String[] {
			"start_rule", "eq", "eqtail", "form", "disyconjtail", "disyconj", "conctail", 
			"conc", "disytail", "neq", "neqtail", "neg", "term", "sumsustail", "sumsus", 
			"multdivtail", "multdiv", "constail", "cons", "instantiate", "explist", 
			"explisttail", "termtail", "arguments", "lambda"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, "'=='", "'\\equiv'", "'==>'", "'\\Rightarrow'", "'<=='", "'\\Leftarrow'", 
			"'\\/'", "'\\vee'", "'/\\'", "'\\wedge'", "'!=='", "'\\not\\equiv'", 
			"'!'", "'\\neg'", "'true'", "'false'", "'_{'", "'}^{'", "'}'", "'='", 
			"'('", "')'", "'C'", "'+'", "'-'", "'.'", "'/'", "'^{'", "'0'", "'1'", 
			"':='", "','", "'lambda'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, null, null, null, null, null, null, null, null, null, null, null, 
			null, null, null, null, null, null, null, null, null, null, null, null, 
			null, null, null, null, null, null, null, null, null, null, "CAPITALLETTER", 
			"LETTER", "NUMBER", "WORD", "WHITESPACE"
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
		public PredicadoId id;
		public PredicadoManager pm;
		public SimboloManager sm;
		public Term value;
		public EqContext eq;
		public EqContext eq() {
			return getRuleContext(EqContext.class,0);
		}
		public Start_ruleContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public Start_ruleContext(ParserRuleContext parent, int invokingState, PredicadoId id, PredicadoManager pm, SimboloManager sm) {
			super(parent, invokingState);
			this.id = id;
			this.pm = pm;
			this.sm = sm;
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

	public final Start_ruleContext start_rule(PredicadoId id,PredicadoManager pm,SimboloManager sm) throws RecognitionException {
		Start_ruleContext _localctx = new Start_ruleContext(_ctx, getState(), id, pm, sm);
		enterRule(_localctx, 0, RULE_start_rule);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(50);
			((Start_ruleContext)_localctx).eq = eq(id, pm, sm);
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
		public PredicadoId id;
		public PredicadoManager pm;
		public SimboloManager sm;
		public Term value;
		public FormContext form;
		public EqtailContext eqtail;
		public FormContext form() {
			return getRuleContext(FormContext.class,0);
		}
		public EqtailContext eqtail() {
			return getRuleContext(EqtailContext.class,0);
		}
		public EqContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public EqContext(ParserRuleContext parent, int invokingState, PredicadoId id, PredicadoManager pm, SimboloManager sm) {
			super(parent, invokingState);
			this.id = id;
			this.pm = pm;
			this.sm = sm;
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

	public final EqContext eq(PredicadoId id,PredicadoManager pm,SimboloManager sm) throws RecognitionException {
		EqContext _localctx = new EqContext(_ctx, getState(), id, pm, sm);
		enterRule(_localctx, 2, RULE_eq);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(53);
			((EqContext)_localctx).form = form(id,pm,sm);
			setState(54);
			((EqContext)_localctx).eqtail = eqtail(id,pm,sm);
			 Term aux=((EqContext)_localctx).form.value;
			                                                for(Iterator<Term> i = ((EqContext)_localctx).eqtail.value.iterator(); i.hasNext();)
			                                                {
			                                                   Simbolo s = sm.getSimbolo(1); 
			                                                   if (s == null)
			                                                      throw new IsNotInDBException(this,"");
			                                                   aux=new App(new App(new Const(1,"c_{1}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),i.next()),aux);
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
		public PredicadoId id;
		public PredicadoManager pm;
		public SimboloManager sm;
		public ArrayList<Term> value;
		public FormContext form;
		public EqtailContext tail1;
		public FormContext form() {
			return getRuleContext(FormContext.class,0);
		}
		public EqtailContext eqtail() {
			return getRuleContext(EqtailContext.class,0);
		}
		public EqtailContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public EqtailContext(ParserRuleContext parent, int invokingState, PredicadoId id, PredicadoManager pm, SimboloManager sm) {
			super(parent, invokingState);
			this.id = id;
			this.pm = pm;
			this.sm = sm;
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

	public final EqtailContext eqtail(PredicadoId id,PredicadoManager pm,SimboloManager sm) throws RecognitionException {
		EqtailContext _localctx = new EqtailContext(_ctx, getState(), id, pm, sm);
		enterRule(_localctx, 4, RULE_eqtail);
		int _la;
		try {
			setState(63);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__0:
			case T__1:
				enterOuterAlt(_localctx, 1);
				{
				setState(57);
				_la = _input.LA(1);
				if ( !(_la==T__0 || _la==T__1) ) {
				_errHandler.recoverInline(this);
				}
				else {
					if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
					_errHandler.reportMatch(this);
					consume();
				}
				setState(58);
				((EqtailContext)_localctx).form = form(id,pm,sm);
				setState(59);
				((EqtailContext)_localctx).tail1 = eqtail(id,pm,sm);
				ArrayList<Term> aux=((EqtailContext)_localctx).tail1.value; aux.add(0,((EqtailContext)_localctx).form.value); ((EqtailContext)_localctx).value = aux;
				}
				break;
			case EOF:
			case T__17:
			case T__21:
			case T__31:
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

	public static class FormContext extends ParserRuleContext {
		public PredicadoId id;
		public PredicadoManager pm;
		public SimboloManager sm;
		public Term value;
		public DisyconjContext disyconj;
		public DisyconjtailContext disyconjtail;
		public DisyconjContext disyconj() {
			return getRuleContext(DisyconjContext.class,0);
		}
		public DisyconjtailContext disyconjtail() {
			return getRuleContext(DisyconjtailContext.class,0);
		}
		public FormContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public FormContext(ParserRuleContext parent, int invokingState, PredicadoId id, PredicadoManager pm, SimboloManager sm) {
			super(parent, invokingState);
			this.id = id;
			this.pm = pm;
			this.sm = sm;
		}
		@Override public int getRuleIndex() { return RULE_form; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).enterForm(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).exitForm(this);
		}
	}

	public final FormContext form(PredicadoId id,PredicadoManager pm,SimboloManager sm) throws RecognitionException {
		FormContext _localctx = new FormContext(_ctx, getState(), id, pm, sm);
		enterRule(_localctx, 6, RULE_form);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(65);
			((FormContext)_localctx).disyconj = disyconj(id,pm,sm);
			setState(66);
			((FormContext)_localctx).disyconjtail = disyconjtail(id,pm,sm);
			 
			                                                    if (((FormContext)_localctx).disyconjtail.value == null)
			                                                       ((FormContext)_localctx).value =  ((FormContext)_localctx).disyconj.value;
			                                                    else
			                                                       ((FormContext)_localctx).value =  new App(((FormContext)_localctx).disyconjtail.value,((FormContext)_localctx).disyconj.value);
			                                                  
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
		public PredicadoId id;
		public PredicadoManager pm;
		public SimboloManager sm;
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
		public DisyconjtailContext(ParserRuleContext parent, int invokingState, PredicadoId id, PredicadoManager pm, SimboloManager sm) {
			super(parent, invokingState);
			this.id = id;
			this.pm = pm;
			this.sm = sm;
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

	public final DisyconjtailContext disyconjtail(PredicadoId id,PredicadoManager pm,SimboloManager sm) throws RecognitionException {
		DisyconjtailContext _localctx = new DisyconjtailContext(_ctx, getState(), id, pm, sm);
		enterRule(_localctx, 8, RULE_disyconjtail);
		int _la;
		try {
			setState(75);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__2:
			case T__3:
				enterOuterAlt(_localctx, 1);
				{
				setState(69);
				_la = _input.LA(1);
				if ( !(_la==T__2 || _la==T__3) ) {
				_errHandler.recoverInline(this);
				}
				else {
					if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
					_errHandler.reportMatch(this);
					consume();
				}
				setState(70);
				((DisyconjtailContext)_localctx).disyconj = disyconj(id,pm,sm);
				setState(71);
				((DisyconjtailContext)_localctx).tail2 = disyconjtail(id,pm,sm);

				                                               if (((DisyconjtailContext)_localctx).tail2.value == null)
				                                               {
				                                                  Simbolo s = sm.getSimbolo(2); 
				                                                  if (s == null)
				                                                     throw new IsNotInDBException(this,"");
				                                                  ((DisyconjtailContext)_localctx).value =  new App(new Const(2,"c_{2}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),((DisyconjtailContext)_localctx).disyconj.value);
				                                               }
				                                               else
				                                               {
				                                                  Simbolo s = sm.getSimbolo(2); 
				                                                  if (s == null)
				                                                     throw new IsNotInDBException(this,"");
				                                                  ((DisyconjtailContext)_localctx).value = new App(new Const(2,"c_{2}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),new App(((DisyconjtailContext)_localctx).tail2.value,((DisyconjtailContext)_localctx).disyconj.value));
				                                               }
				                                              
				}
				break;
			case EOF:
			case T__0:
			case T__1:
			case T__17:
			case T__21:
			case T__31:
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
		public PredicadoId id;
		public PredicadoManager pm;
		public SimboloManager sm;
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
		public DisyconjContext(ParserRuleContext parent, int invokingState, PredicadoId id, PredicadoManager pm, SimboloManager sm) {
			super(parent, invokingState);
			this.id = id;
			this.pm = pm;
			this.sm = sm;
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

	public final DisyconjContext disyconj(PredicadoId id,PredicadoManager pm,SimboloManager sm) throws RecognitionException {
		DisyconjContext _localctx = new DisyconjContext(_ctx, getState(), id, pm, sm);
		enterRule(_localctx, 10, RULE_disyconj);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(77);
			((DisyconjContext)_localctx).conc = conc(id,pm,sm);
			setState(78);
			((DisyconjContext)_localctx).conctail = conctail(id,pm,sm);
			 Term aux=((DisyconjContext)_localctx).conc.value;
			                                                for(Iterator<Term> i = ((DisyconjContext)_localctx).conctail.value.iterator(); i.hasNext();) 
			                                                {
			                                                   Simbolo s = sm.getSimbolo(3); 
			                                                   if (s == null)
			                                                      throw new IsNotInDBException(this,"");
			                                                   aux=new App(new App(new Const(3,"c_{3}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),i.next()),aux);
			                                                }
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
		public PredicadoId id;
		public PredicadoManager pm;
		public SimboloManager sm;
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
		public ConctailContext(ParserRuleContext parent, int invokingState, PredicadoId id, PredicadoManager pm, SimboloManager sm) {
			super(parent, invokingState);
			this.id = id;
			this.pm = pm;
			this.sm = sm;
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

	public final ConctailContext conctail(PredicadoId id,PredicadoManager pm,SimboloManager sm) throws RecognitionException {
		ConctailContext _localctx = new ConctailContext(_ctx, getState(), id, pm, sm);
		enterRule(_localctx, 12, RULE_conctail);
		int _la;
		try {
			setState(87);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__4:
			case T__5:
				enterOuterAlt(_localctx, 1);
				{
				setState(81);
				_la = _input.LA(1);
				if ( !(_la==T__4 || _la==T__5) ) {
				_errHandler.recoverInline(this);
				}
				else {
					if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
					_errHandler.reportMatch(this);
					consume();
				}
				setState(82);
				((ConctailContext)_localctx).conc = conc(id,pm,sm);
				setState(83);
				((ConctailContext)_localctx).tail3 = conctail(id,pm,sm);
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
			case T__21:
			case T__31:
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
		public PredicadoId id;
		public PredicadoManager pm;
		public SimboloManager sm;
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
		public ConcContext(ParserRuleContext parent, int invokingState, PredicadoId id, PredicadoManager pm, SimboloManager sm) {
			super(parent, invokingState);
			this.id = id;
			this.pm = pm;
			this.sm = sm;
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

	public final ConcContext conc(PredicadoId id,PredicadoManager pm,SimboloManager sm) throws RecognitionException {
		ConcContext _localctx = new ConcContext(_ctx, getState(), id, pm, sm);
		enterRule(_localctx, 14, RULE_conc);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(89);
			((ConcContext)_localctx).neq = neq(id,pm,sm);
			setState(90);
			((ConcContext)_localctx).disytail = disytail(id,pm,sm);
			 Term aux=((ConcContext)_localctx).neq.value; 
			                                                     for(Iterator<ParserPair> i = ((ConcContext)_localctx).disytail.value.iterator(); i.hasNext();)
			                                                     {
			                                                        ParserPair pair = i.next();
			                                                        if (pair.symbolId==4)
			                                                        {
			                                                           Simbolo s = sm.getSimbolo(4); 
			                                                           if (s == null)
			                                                              throw new IsNotInDBException(this,"");
			                                                           aux=new App(new App(new Const(4,"c_{4}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),pair.term),aux); 
			                                                        }
			                                                        else if (pair.symbolId==5)
			                                                        {
			                                                           Simbolo s = sm.getSimbolo(5); 
			                                                           if (s == null)
			                                                              throw new IsNotInDBException(this,"");
			                                                           aux=new App(new App(new Const(5,"c_{5}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),pair.term),aux); 
			                                                        }
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
		public PredicadoId id;
		public PredicadoManager pm;
		public SimboloManager sm;
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
		public DisytailContext(ParserRuleContext parent, int invokingState, PredicadoId id, PredicadoManager pm, SimboloManager sm) {
			super(parent, invokingState);
			this.id = id;
			this.pm = pm;
			this.sm = sm;
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

	public final DisytailContext disytail(PredicadoId id,PredicadoManager pm,SimboloManager sm) throws RecognitionException {
		DisytailContext _localctx = new DisytailContext(_ctx, getState(), id, pm, sm);
		enterRule(_localctx, 16, RULE_disytail);
		int _la;
		try {
			setState(104);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__6:
			case T__7:
				enterOuterAlt(_localctx, 1);
				{
				setState(93);
				_la = _input.LA(1);
				if ( !(_la==T__6 || _la==T__7) ) {
				_errHandler.recoverInline(this);
				}
				else {
					if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
					_errHandler.reportMatch(this);
					consume();
				}
				setState(94);
				((DisytailContext)_localctx).neq = neq(id,pm,sm);
				setState(95);
				((DisytailContext)_localctx).tail4 = disytail(id,pm,sm);
				ArrayList<ParserPair> aux=((DisytailContext)_localctx).tail4.value;
				                                               Simbolo s = sm.getSimbolo(4); 
				                                               if (s == null)
				                                                  throw new IsNotInDBException(this,"");
				                                               aux.add(0,new ParserPair(s.getId(),((DisytailContext)_localctx).neq.value)); ((DisytailContext)_localctx).value = aux;
				                                              
				}
				break;
			case T__8:
			case T__9:
				enterOuterAlt(_localctx, 2);
				{
				setState(98);
				_la = _input.LA(1);
				if ( !(_la==T__8 || _la==T__9) ) {
				_errHandler.recoverInline(this);
				}
				else {
					if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
					_errHandler.reportMatch(this);
					consume();
				}
				setState(99);
				((DisytailContext)_localctx).neq = neq(id,pm,sm);
				setState(100);
				((DisytailContext)_localctx).tail5 = disytail(id,pm,sm);
				ArrayList<ParserPair> aux=((DisytailContext)_localctx).tail5.value; 
				                                                 Simbolo s = sm.getSimbolo(5); 
				                                                 if (s == null)
				                                                    throw new IsNotInDBException(this,"");
				                                                 aux.add(0,new ParserPair(s.getId(),((DisytailContext)_localctx).neq.value)); ((DisytailContext)_localctx).value = aux;
				                                                
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
			case T__21:
			case T__31:
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
		public PredicadoId id;
		public PredicadoManager pm;
		public SimboloManager sm;
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
		public NeqContext(ParserRuleContext parent, int invokingState, PredicadoId id, PredicadoManager pm, SimboloManager sm) {
			super(parent, invokingState);
			this.id = id;
			this.pm = pm;
			this.sm = sm;
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

	public final NeqContext neq(PredicadoId id,PredicadoManager pm,SimboloManager sm) throws RecognitionException {
		NeqContext _localctx = new NeqContext(_ctx, getState(), id, pm, sm);
		enterRule(_localctx, 18, RULE_neq);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(106);
			((NeqContext)_localctx).neg = neg(id,pm,sm);
			setState(107);
			((NeqContext)_localctx).neqtail = neqtail(id,pm,sm);
			 Term aux=((NeqContext)_localctx).neg.value;
			                                                for(Iterator<Term> i = ((NeqContext)_localctx).neqtail.value.iterator(); i.hasNext();) 
			                                                {
			                                                   Simbolo s = sm.getSimbolo(6); 
			                                                   if (s == null)
			                                                      throw new IsNotInDBException(this,"");
			                                                   aux=new App(new App(new Const(6,"c_{6}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),i.next()),aux);
			                                                }
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
		public PredicadoId id;
		public PredicadoManager pm;
		public SimboloManager sm;
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
		public NeqtailContext(ParserRuleContext parent, int invokingState, PredicadoId id, PredicadoManager pm, SimboloManager sm) {
			super(parent, invokingState);
			this.id = id;
			this.pm = pm;
			this.sm = sm;
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

	public final NeqtailContext neqtail(PredicadoId id,PredicadoManager pm,SimboloManager sm) throws RecognitionException {
		NeqtailContext _localctx = new NeqtailContext(_ctx, getState(), id, pm, sm);
		enterRule(_localctx, 20, RULE_neqtail);
		int _la;
		try {
			setState(116);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__10:
			case T__11:
				enterOuterAlt(_localctx, 1);
				{
				setState(110);
				_la = _input.LA(1);
				if ( !(_la==T__10 || _la==T__11) ) {
				_errHandler.recoverInline(this);
				}
				else {
					if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
					_errHandler.reportMatch(this);
					consume();
				}
				setState(111);
				((NeqtailContext)_localctx).neg = neg(id,pm,sm);
				setState(112);
				((NeqtailContext)_localctx).tail6 = neqtail(id,pm,sm);
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
			case T__21:
			case T__31:
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
		public PredicadoId id;
		public PredicadoManager pm;
		public SimboloManager sm;
		public Term value;
		public NegContext n;
		public Token CAPITALLETTER;
		public Token LETTER;
		public EqContext eq;
		public TermContext t1;
		public TermContext t2;
		public Token WORD;
		public ExplistContext explist;
		public Token NUMBER;
		public NegContext neg() {
			return getRuleContext(NegContext.class,0);
		}
		public TerminalNode CAPITALLETTER() { return getToken(TermParser.CAPITALLETTER, 0); }
		public TerminalNode LETTER() { return getToken(TermParser.LETTER, 0); }
		public EqContext eq() {
			return getRuleContext(EqContext.class,0);
		}
		public List<TermContext> term() {
			return getRuleContexts(TermContext.class);
		}
		public TermContext term(int i) {
			return getRuleContext(TermContext.class,i);
		}
		public TerminalNode WORD() { return getToken(TermParser.WORD, 0); }
		public ExplistContext explist() {
			return getRuleContext(ExplistContext.class,0);
		}
		public TerminalNode NUMBER() { return getToken(TermParser.NUMBER, 0); }
		public NegContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public NegContext(ParserRuleContext parent, int invokingState, PredicadoId id, PredicadoManager pm, SimboloManager sm) {
			super(parent, invokingState);
			this.id = id;
			this.pm = pm;
			this.sm = sm;
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

	public final NegContext neg(PredicadoId id,PredicadoManager pm,SimboloManager sm) throws RecognitionException {
		NegContext _localctx = new NegContext(_ctx, getState(), id, pm, sm);
		enterRule(_localctx, 22, RULE_neg);
		int _la;
		try {
			setState(161);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,5,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(118);
				_la = _input.LA(1);
				if ( !(_la==T__12 || _la==T__13) ) {
				_errHandler.recoverInline(this);
				}
				else {
					if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
					_errHandler.reportMatch(this);
					consume();
				}
				setState(119);
				((NegContext)_localctx).n = neg(id,pm,sm);
				Simbolo s = sm.getSimbolo(7); if (s == null)throw new IsNotInDBException(this,""); 
				                                               ((NegContext)_localctx).value = new App(new Const(7,"c_{7}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),((NegContext)_localctx).n.value);
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(122);
				((NegContext)_localctx).CAPITALLETTER = match(CAPITALLETTER);
				((NegContext)_localctx).value =  new Var((new Integer((int)(((NegContext)_localctx).CAPITALLETTER!=null?((NegContext)_localctx).CAPITALLETTER.getText():null).charAt(0))).intValue());
				}
				break;
			case 3:
				enterOuterAlt(_localctx, 3);
				{
				setState(124);
				((NegContext)_localctx).LETTER = match(LETTER);
				((NegContext)_localctx).value =  new Var((new Integer((int)(((NegContext)_localctx).LETTER!=null?((NegContext)_localctx).LETTER.getText():null).charAt(0))).intValue());
				}
				break;
			case 4:
				enterOuterAlt(_localctx, 4);
				{
				setState(126);
				match(T__14);
				Simbolo s = sm.getSimbolo(8); if (s == null)throw new IsNotInDBException(this,"");
				                                               ((NegContext)_localctx).value =  new Const(8,"c_{8}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad());
				                                              
				}
				break;
			case 5:
				enterOuterAlt(_localctx, 5);
				{
				setState(128);
				match(T__15);
				Simbolo s = sm.getSimbolo(9); if (s == null)throw new IsNotInDBException(this,"");
				                                               ((NegContext)_localctx).value =  new Const(9,"c_{9}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad());
				}
				break;
			case 6:
				enterOuterAlt(_localctx, 6);
				{
				setState(130);
				((NegContext)_localctx).CAPITALLETTER = match(CAPITALLETTER);
				setState(131);
				match(T__16);
				setState(132);
				((NegContext)_localctx).eq = eq(id,pm,sm);
				setState(133);
				match(T__17);
				setState(134);
				((NegContext)_localctx).LETTER = match(LETTER);
				setState(135);
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
				setState(138);
				((NegContext)_localctx).t1 = term(id,pm,sm);
				setState(139);
				match(T__19);
				setState(140);
				((NegContext)_localctx).t2 = term(id,pm,sm);
				Simbolo s = sm.getSimbolo(10); if (s == null)throw new IsNotInDBException(this,"");
				                                               Term c = new Const(10,"c_{10}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad());
				                                               ((NegContext)_localctx).value =  new App(new App(c,((NegContext)_localctx).t2.value), ((NegContext)_localctx).t1.value);
				                                              
				}
				break;
			case 8:
				enterOuterAlt(_localctx, 8);
				{
				setState(143);
				((NegContext)_localctx).WORD = match(WORD);
				setState(144);
				match(T__20);
				setState(145);
				((NegContext)_localctx).explist = explist(id,pm,sm);
				setState(146);
				match(T__21);
				id.setAlias((((NegContext)_localctx).WORD!=null?((NegContext)_localctx).WORD.getText():null)); 
				                                               Predicado preInBD=pm.getPredicado(id);
				                                               if(preInBD==null) {
				                                                 throw new IsNotInDBException(this,"");
				                                               } 
				                                               Term aux = preInBD.getTerm();
				                                               int nArg = preInBD.getArgumentos().split(",").length;
				                                               if (((NegContext)_localctx).explist.value.size() != nArg)
				                                                 throw new NoViableAltException(this);
				                                               for(Iterator<Term> i = ((NegContext)_localctx).explist.value.iterator(); i.hasNext();) 
				                                                  aux=new App(aux,i.next());
				                                               aux = aux.evaluar();
				                                               aux.setAlias(id.getAlias());
				                                               ((NegContext)_localctx).value = aux;
				                                              
				}
				break;
			case 9:
				enterOuterAlt(_localctx, 9);
				{
				setState(149);
				match(T__22);
				setState(150);
				((NegContext)_localctx).NUMBER = match(NUMBER);
				setState(151);
				match(T__20);
				setState(152);
				((NegContext)_localctx).explist = explist(id,pm,sm);
				setState(153);
				match(T__21);
				Simbolo s = sm.getSimbolo(Integer.parseInt((((NegContext)_localctx).NUMBER!=null?((NegContext)_localctx).NUMBER.getText():null))); 
				                                               if (s == null)throw new IsNotInDBException(this,"");
				                                               int nArg = s.getArgumentos();
				                                               if (((NegContext)_localctx).explist.value.size() != nArg)
				                                                 throw new NoViableAltException(this);
				                                               Term aux = new Const(Integer.parseInt((((NegContext)_localctx).NUMBER!=null?((NegContext)_localctx).NUMBER.getText():null)),"c_{"+(((NegContext)_localctx).NUMBER!=null?((NegContext)_localctx).NUMBER.getText():null)+"}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad());
				                                               for(Iterator<Term> i = ((NegContext)_localctx).explist.value.iterator(); i.hasNext();)
				                                                  aux=new App(aux,i.next());
				                                               ((NegContext)_localctx).value =  aux;
				                                              
				}
				break;
			case 10:
				enterOuterAlt(_localctx, 10);
				{
				setState(156);
				match(T__20);
				setState(157);
				((NegContext)_localctx).eq = eq(id,pm,sm);
				setState(158);
				match(T__21);
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

	public static class TermContext extends ParserRuleContext {
		public PredicadoId id;
		public PredicadoManager pm;
		public SimboloManager sm;
		public Term value;
		public SumsusContext sumsus;
		public SumsustailContext sumsustail;
		public SumsusContext sumsus() {
			return getRuleContext(SumsusContext.class,0);
		}
		public SumsustailContext sumsustail() {
			return getRuleContext(SumsustailContext.class,0);
		}
		public TermContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public TermContext(ParserRuleContext parent, int invokingState, PredicadoId id, PredicadoManager pm, SimboloManager sm) {
			super(parent, invokingState);
			this.id = id;
			this.pm = pm;
			this.sm = sm;
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

	public final TermContext term(PredicadoId id,PredicadoManager pm,SimboloManager sm) throws RecognitionException {
		TermContext _localctx = new TermContext(_ctx, getState(), id, pm, sm);
		enterRule(_localctx, 24, RULE_term);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(163);
			((TermContext)_localctx).sumsus = sumsus(id,pm,sm);
			setState(164);
			((TermContext)_localctx).sumsustail = sumsustail(id,pm,sm);
			 
			                                                    if (((TermContext)_localctx).sumsustail.value == null)
			                                                       ((TermContext)_localctx).value =  ((TermContext)_localctx).sumsus.value;
			                                                    else
			                                                       ((TermContext)_localctx).value =  new App(((TermContext)_localctx).sumsustail.value,((TermContext)_localctx).sumsus.value);
			                                                  
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

	public static class SumsustailContext extends ParserRuleContext {
		public PredicadoId id;
		public PredicadoManager pm;
		public SimboloManager sm;
		public Term value;
		public SumsusContext sumsus;
		public SumsustailContext tail2;
		public SumsusContext sumsus() {
			return getRuleContext(SumsusContext.class,0);
		}
		public SumsustailContext sumsustail() {
			return getRuleContext(SumsustailContext.class,0);
		}
		public SumsustailContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public SumsustailContext(ParserRuleContext parent, int invokingState, PredicadoId id, PredicadoManager pm, SimboloManager sm) {
			super(parent, invokingState);
			this.id = id;
			this.pm = pm;
			this.sm = sm;
		}
		@Override public int getRuleIndex() { return RULE_sumsustail; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).enterSumsustail(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).exitSumsustail(this);
		}
	}

	public final SumsustailContext sumsustail(PredicadoId id,PredicadoManager pm,SimboloManager sm) throws RecognitionException {
		SumsustailContext _localctx = new SumsustailContext(_ctx, getState(), id, pm, sm);
		enterRule(_localctx, 26, RULE_sumsustail);
		try {
			setState(178);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__23:
				enterOuterAlt(_localctx, 1);
				{
				setState(167);
				match(T__23);
				setState(168);
				((SumsustailContext)_localctx).sumsus = sumsus(id,pm,sm);
				setState(169);
				((SumsustailContext)_localctx).tail2 = sumsustail(id,pm,sm);

				                                               if (((SumsustailContext)_localctx).tail2.value == null)
				                                               {
				                                                  Simbolo s = sm.getSimbolo(11); 
				                                                  if (s == null)
				                                                     throw new IsNotInDBException(this,"");
				                                                  ((SumsustailContext)_localctx).value =  new App(new Const(11,"c_{11}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),((SumsustailContext)_localctx).sumsus.value);
				                                               }
				                                               else
				                                               {
				                                                  Simbolo s = sm.getSimbolo(11); 
				                                                  if (s == null)
				                                                     throw new IsNotInDBException(this,"");
				                                                  ((SumsustailContext)_localctx).value = new App(new Const(11,"c_{11}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),new App(((SumsustailContext)_localctx).tail2.value,((SumsustailContext)_localctx).sumsus.value));
				                                               }
				                                              
				}
				break;
			case T__24:
				enterOuterAlt(_localctx, 2);
				{
				setState(172);
				match(T__24);
				setState(173);
				((SumsustailContext)_localctx).sumsus = sumsus(id,pm,sm);
				setState(174);
				((SumsustailContext)_localctx).tail2 = sumsustail(id,pm,sm);

				                                               if (((SumsustailContext)_localctx).tail2.value == null)
				                                               {
				                                                  Simbolo s = sm.getSimbolo(12); 
				                                                  if (s == null)
				                                                     throw new IsNotInDBException(this,"");
				                                                  ((SumsustailContext)_localctx).value =  new App(new Const(12,"c_{12}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),((SumsustailContext)_localctx).sumsus.value);
				                                               }
				                                               else
				                                               {
				                                                  Simbolo s = sm.getSimbolo(12); 
				                                                  if (s == null)
				                                                     throw new IsNotInDBException(this,"");
				                                                  ((SumsustailContext)_localctx).value = new App(new Const(12,"c_{12}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),new App(((SumsustailContext)_localctx).tail2.value,((SumsustailContext)_localctx).sumsus.value));
				                                               }
				                                              
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
			case T__10:
			case T__11:
			case T__17:
			case T__19:
			case T__21:
			case T__31:
				enterOuterAlt(_localctx, 3);
				{
				((SumsustailContext)_localctx).value = null;
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

	public static class SumsusContext extends ParserRuleContext {
		public PredicadoId id;
		public PredicadoManager pm;
		public SimboloManager sm;
		public Term value;
		public MultdivContext multdiv;
		public MultdivtailContext multdivtail;
		public MultdivContext multdiv() {
			return getRuleContext(MultdivContext.class,0);
		}
		public MultdivtailContext multdivtail() {
			return getRuleContext(MultdivtailContext.class,0);
		}
		public SumsusContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public SumsusContext(ParserRuleContext parent, int invokingState, PredicadoId id, PredicadoManager pm, SimboloManager sm) {
			super(parent, invokingState);
			this.id = id;
			this.pm = pm;
			this.sm = sm;
		}
		@Override public int getRuleIndex() { return RULE_sumsus; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).enterSumsus(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).exitSumsus(this);
		}
	}

	public final SumsusContext sumsus(PredicadoId id,PredicadoManager pm,SimboloManager sm) throws RecognitionException {
		SumsusContext _localctx = new SumsusContext(_ctx, getState(), id, pm, sm);
		enterRule(_localctx, 28, RULE_sumsus);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(180);
			((SumsusContext)_localctx).multdiv = multdiv(id,pm,sm);
			setState(181);
			((SumsusContext)_localctx).multdivtail = multdivtail(id,pm,sm);
			 
			                                                    if (((SumsusContext)_localctx).multdivtail.value == null)
			                                                       ((SumsusContext)_localctx).value =  ((SumsusContext)_localctx).multdiv.value;
			                                                    else
			                                                       ((SumsusContext)_localctx).value =  new App(((SumsusContext)_localctx).multdivtail.value,((SumsusContext)_localctx).multdiv.value);
			                                                  
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

	public static class MultdivtailContext extends ParserRuleContext {
		public PredicadoId id;
		public PredicadoManager pm;
		public SimboloManager sm;
		public Term value;
		public MultdivContext multdiv;
		public MultdivtailContext tail2;
		public MultdivContext multdiv() {
			return getRuleContext(MultdivContext.class,0);
		}
		public MultdivtailContext multdivtail() {
			return getRuleContext(MultdivtailContext.class,0);
		}
		public MultdivtailContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public MultdivtailContext(ParserRuleContext parent, int invokingState, PredicadoId id, PredicadoManager pm, SimboloManager sm) {
			super(parent, invokingState);
			this.id = id;
			this.pm = pm;
			this.sm = sm;
		}
		@Override public int getRuleIndex() { return RULE_multdivtail; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).enterMultdivtail(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).exitMultdivtail(this);
		}
	}

	public final MultdivtailContext multdivtail(PredicadoId id,PredicadoManager pm,SimboloManager sm) throws RecognitionException {
		MultdivtailContext _localctx = new MultdivtailContext(_ctx, getState(), id, pm, sm);
		enterRule(_localctx, 30, RULE_multdivtail);
		try {
			setState(195);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__25:
				enterOuterAlt(_localctx, 1);
				{
				setState(184);
				match(T__25);
				setState(185);
				((MultdivtailContext)_localctx).multdiv = multdiv(id,pm,sm);
				setState(186);
				((MultdivtailContext)_localctx).tail2 = multdivtail(id,pm,sm);

				                                               if (((MultdivtailContext)_localctx).tail2.value == null)
				                                               {
				                                                  Simbolo s = sm.getSimbolo(13); 
				                                                  if (s == null)
				                                                     throw new IsNotInDBException(this,"");
				                                                  ((MultdivtailContext)_localctx).value =  new App(new Const(13,"c_{13}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),((MultdivtailContext)_localctx).multdiv.value);
				                                               }
				                                               else
				                                               {
				                                                  Simbolo s = sm.getSimbolo(13); 
				                                                  if (s == null)
				                                                     throw new IsNotInDBException(this,"");
				                                                  ((MultdivtailContext)_localctx).value = new App(new Const(13,"c_{13}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),new App(((MultdivtailContext)_localctx).tail2.value,((MultdivtailContext)_localctx).multdiv.value));
				                                               }
				                                              
				}
				break;
			case T__26:
				enterOuterAlt(_localctx, 2);
				{
				setState(189);
				match(T__26);
				setState(190);
				((MultdivtailContext)_localctx).multdiv = multdiv(id,pm,sm);
				setState(191);
				((MultdivtailContext)_localctx).tail2 = multdivtail(id,pm,sm);

				                                               if (((MultdivtailContext)_localctx).tail2.value == null)
				                                               {
				                                                  Simbolo s = sm.getSimbolo(14); 
				                                                  if (s == null)
				                                                     throw new IsNotInDBException(this,"");
				                                                  ((MultdivtailContext)_localctx).value =  new App(new Const(14,"c_{14}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),((MultdivtailContext)_localctx).multdiv.value);
				                                               }
				                                               else
				                                               {
				                                                  Simbolo s = sm.getSimbolo(14); 
				                                                  if (s == null)
				                                                     throw new IsNotInDBException(this,"");
				                                                  ((MultdivtailContext)_localctx).value = new App(new Const(14,"c_{14}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),new App(((MultdivtailContext)_localctx).tail2.value,((MultdivtailContext)_localctx).multdiv.value));
				                                               }
				                                              
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
			case T__10:
			case T__11:
			case T__17:
			case T__19:
			case T__21:
			case T__23:
			case T__24:
			case T__31:
				enterOuterAlt(_localctx, 3);
				{
				((MultdivtailContext)_localctx).value = null;
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

	public static class MultdivContext extends ParserRuleContext {
		public PredicadoId id;
		public PredicadoManager pm;
		public SimboloManager sm;
		public Term value;
		public ConsContext cons;
		public ConstailContext constail;
		public ConsContext cons() {
			return getRuleContext(ConsContext.class,0);
		}
		public ConstailContext constail() {
			return getRuleContext(ConstailContext.class,0);
		}
		public MultdivContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public MultdivContext(ParserRuleContext parent, int invokingState, PredicadoId id, PredicadoManager pm, SimboloManager sm) {
			super(parent, invokingState);
			this.id = id;
			this.pm = pm;
			this.sm = sm;
		}
		@Override public int getRuleIndex() { return RULE_multdiv; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).enterMultdiv(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).exitMultdiv(this);
		}
	}

	public final MultdivContext multdiv(PredicadoId id,PredicadoManager pm,SimboloManager sm) throws RecognitionException {
		MultdivContext _localctx = new MultdivContext(_ctx, getState(), id, pm, sm);
		enterRule(_localctx, 32, RULE_multdiv);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(197);
			((MultdivContext)_localctx).cons = cons(id,pm,sm);
			setState(198);
			((MultdivContext)_localctx).constail = constail(id,pm,sm);
			 
			                                                    if (((MultdivContext)_localctx).constail.value == null)
			                                                       ((MultdivContext)_localctx).value =  ((MultdivContext)_localctx).cons.value;
			                                                    else
			                                                       ((MultdivContext)_localctx).value =  new App(((MultdivContext)_localctx).constail.value,((MultdivContext)_localctx).cons.value);
			                                                  
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

	public static class ConstailContext extends ParserRuleContext {
		public PredicadoId id;
		public PredicadoManager pm;
		public SimboloManager sm;
		public Term value;
		public ConsContext cons;
		public ConstailContext tail2;
		public ConsContext cons() {
			return getRuleContext(ConsContext.class,0);
		}
		public ConstailContext constail() {
			return getRuleContext(ConstailContext.class,0);
		}
		public ConstailContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public ConstailContext(ParserRuleContext parent, int invokingState, PredicadoId id, PredicadoManager pm, SimboloManager sm) {
			super(parent, invokingState);
			this.id = id;
			this.pm = pm;
			this.sm = sm;
		}
		@Override public int getRuleIndex() { return RULE_constail; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).enterConstail(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).exitConstail(this);
		}
	}

	public final ConstailContext constail(PredicadoId id,PredicadoManager pm,SimboloManager sm) throws RecognitionException {
		ConstailContext _localctx = new ConstailContext(_ctx, getState(), id, pm, sm);
		enterRule(_localctx, 34, RULE_constail);
		try {
			setState(208);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__27:
				enterOuterAlt(_localctx, 1);
				{
				setState(201);
				match(T__27);
				setState(202);
				((ConstailContext)_localctx).cons = cons(id,pm,sm);
				setState(203);
				match(T__18);
				setState(204);
				((ConstailContext)_localctx).tail2 = constail(id,pm,sm);

				                                               if (((ConstailContext)_localctx).tail2.value == null)
				                                               {
				                                                  Simbolo s = sm.getSimbolo(16); 
				                                                  if (s == null)
				                                                     throw new IsNotInDBException(this,"");
				                                                  ((ConstailContext)_localctx).value =  new App(new Const(16,"c_{16}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),((ConstailContext)_localctx).cons.value);
				                                               }
				                                               else
				                                               {
				                                                  Simbolo s = sm.getSimbolo(16); 
				                                                  if (s == null)
				                                                     throw new IsNotInDBException(this,"");
				                                                  ((ConstailContext)_localctx).value = new App(new Const(16,"c_{16}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),new App(((ConstailContext)_localctx).tail2.value,((ConstailContext)_localctx).cons.value));
				                                               }
				                                              
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
			case T__10:
			case T__11:
			case T__17:
			case T__19:
			case T__21:
			case T__23:
			case T__24:
			case T__25:
			case T__26:
			case T__31:
				enterOuterAlt(_localctx, 2);
				{
				((ConstailContext)_localctx).value = null;
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

	public static class ConsContext extends ParserRuleContext {
		public PredicadoId id;
		public PredicadoManager pm;
		public SimboloManager sm;
		public Term value;
		public ConsContext n;
		public Token LETTER;
		public Token NUMBER;
		public ExplistContext explist;
		public TermContext term;
		public ConsContext cons() {
			return getRuleContext(ConsContext.class,0);
		}
		public TerminalNode LETTER() { return getToken(TermParser.LETTER, 0); }
		public TerminalNode NUMBER() { return getToken(TermParser.NUMBER, 0); }
		public ExplistContext explist() {
			return getRuleContext(ExplistContext.class,0);
		}
		public TermContext term() {
			return getRuleContext(TermContext.class,0);
		}
		public ConsContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public ConsContext(ParserRuleContext parent, int invokingState, PredicadoId id, PredicadoManager pm, SimboloManager sm) {
			super(parent, invokingState);
			this.id = id;
			this.pm = pm;
			this.sm = sm;
		}
		@Override public int getRuleIndex() { return RULE_cons; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).enterCons(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).exitCons(this);
		}
	}

	public final ConsContext cons(PredicadoId id,PredicadoManager pm,SimboloManager sm) throws RecognitionException {
		ConsContext _localctx = new ConsContext(_ctx, getState(), id, pm, sm);
		enterRule(_localctx, 36, RULE_cons);
		try {
			setState(232);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__24:
				enterOuterAlt(_localctx, 1);
				{
				setState(210);
				match(T__24);
				setState(211);
				((ConsContext)_localctx).n = cons(id,pm,sm);
				Simbolo s = sm.getSimbolo(15); if (s == null)throw new IsNotInDBException(this,""); 
				                                               ((ConsContext)_localctx).value = new App(new Const(15,"c_{15}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),((ConsContext)_localctx).n.value);
				}
				break;
			case T__28:
				enterOuterAlt(_localctx, 2);
				{
				setState(214);
				match(T__28);
				Simbolo s = sm.getSimbolo(17); if (s == null)throw new IsNotInDBException(this,"");
				                                               ((ConsContext)_localctx).value =  new Const(17,"c_{17}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad());
				                                              
				}
				break;
			case T__29:
				enterOuterAlt(_localctx, 3);
				{
				setState(216);
				match(T__29);
				Simbolo s = sm.getSimbolo(18); if (s == null)throw new IsNotInDBException(this,"");
				                                               ((ConsContext)_localctx).value =  new Const(18,"c_{18}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad());
				                                              
				}
				break;
			case LETTER:
				enterOuterAlt(_localctx, 4);
				{
				setState(218);
				((ConsContext)_localctx).LETTER = match(LETTER);
				((ConsContext)_localctx).value =  new Var((int)(((ConsContext)_localctx).LETTER!=null?((ConsContext)_localctx).LETTER.getText():null).charAt(0));
				}
				break;
			case T__22:
				enterOuterAlt(_localctx, 5);
				{
				setState(220);
				match(T__22);
				setState(221);
				((ConsContext)_localctx).NUMBER = match(NUMBER);
				setState(222);
				match(T__20);
				setState(223);
				((ConsContext)_localctx).explist = explist(id,pm,sm);
				setState(224);
				match(T__21);
				Simbolo s = sm.getSimbolo(Integer.parseInt((((ConsContext)_localctx).NUMBER!=null?((ConsContext)_localctx).NUMBER.getText():null))); 
				                                               if (s == null)throw new IsNotInDBException(this,"");
				                                               int nArg = s.getArgumentos();
				                                               if (((ConsContext)_localctx).explist.value.size() != nArg)
				                                                 throw new NoViableAltException(this);
				                                               Term aux = new Const(Integer.parseInt((((ConsContext)_localctx).NUMBER!=null?((ConsContext)_localctx).NUMBER.getText():null)),"c_{"+(((ConsContext)_localctx).NUMBER!=null?((ConsContext)_localctx).NUMBER.getText():null)+"}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad());
				                                               for(Iterator<Term> i = ((ConsContext)_localctx).explist.value.iterator(); i.hasNext();)
				                                                  aux=new App(aux,i.next());
				                                               ((ConsContext)_localctx).value =  aux;
				                                              
				}
				break;
			case T__20:
				enterOuterAlt(_localctx, 6);
				{
				setState(227);
				match(T__20);
				setState(228);
				((ConsContext)_localctx).term = term(id,pm,sm);
				setState(229);
				match(T__21);
				((ConsContext)_localctx).value = ((ConsContext)_localctx).term.value;
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

	public static class InstantiateContext extends ParserRuleContext {
		public PredicadoId id;
		public PredicadoManager pm;
		public SimboloManager sm;
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
		public InstantiateContext(ParserRuleContext parent, int invokingState, PredicadoId id, PredicadoManager pm, SimboloManager sm) {
			super(parent, invokingState);
			this.id = id;
			this.pm = pm;
			this.sm = sm;
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

	public final InstantiateContext instantiate(PredicadoId id,PredicadoManager pm,SimboloManager sm) throws RecognitionException {
		InstantiateContext _localctx = new InstantiateContext(_ctx, getState(), id, pm, sm);
		enterRule(_localctx, 38, RULE_instantiate);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(234);
			((InstantiateContext)_localctx).arguments = arguments();
			setState(235);
			match(T__30);
			setState(236);
			((InstantiateContext)_localctx).explist = explist(id,pm,sm);
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
		public PredicadoId id;
		public PredicadoManager pm;
		public SimboloManager sm;
		public ArrayList<Term> value;
		public EqContext eq;
		public ExplisttailContext explisttail;
		public TermContext term;
		public TermtailContext termtail;
		public EqContext eq() {
			return getRuleContext(EqContext.class,0);
		}
		public ExplisttailContext explisttail() {
			return getRuleContext(ExplisttailContext.class,0);
		}
		public TermContext term() {
			return getRuleContext(TermContext.class,0);
		}
		public TermtailContext termtail() {
			return getRuleContext(TermtailContext.class,0);
		}
		public ExplistContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public ExplistContext(ParserRuleContext parent, int invokingState, PredicadoId id, PredicadoManager pm, SimboloManager sm) {
			super(parent, invokingState);
			this.id = id;
			this.pm = pm;
			this.sm = sm;
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

	public final ExplistContext explist(PredicadoId id,PredicadoManager pm,SimboloManager sm) throws RecognitionException {
		ExplistContext _localctx = new ExplistContext(_ctx, getState(), id, pm, sm);
		enterRule(_localctx, 40, RULE_explist);
		try {
			setState(247);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,10,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(239);
				((ExplistContext)_localctx).eq = eq(id,pm,sm);
				setState(240);
				((ExplistContext)_localctx).explisttail = explisttail(id,pm,sm);
				ArrayList<Term> aux = ((ExplistContext)_localctx).explisttail.value;
				                                               aux.add(0,((ExplistContext)_localctx).eq.value);
				                                               ((ExplistContext)_localctx).value =  aux;
				                                              
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(243);
				((ExplistContext)_localctx).term = term(id,pm,sm);
				setState(244);
				((ExplistContext)_localctx).termtail = termtail(id,pm,sm);
				ArrayList<Term> aux = ((ExplistContext)_localctx).termtail.value;
				                                               aux.add(0,((ExplistContext)_localctx).term.value);
				                                               ((ExplistContext)_localctx).value =  aux;
				                                              
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

	public static class ExplisttailContext extends ParserRuleContext {
		public PredicadoId id;
		public PredicadoManager pm;
		public SimboloManager sm;
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
		public ExplisttailContext(ParserRuleContext parent, int invokingState, PredicadoId id, PredicadoManager pm, SimboloManager sm) {
			super(parent, invokingState);
			this.id = id;
			this.pm = pm;
			this.sm = sm;
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

	public final ExplisttailContext explisttail(PredicadoId id,PredicadoManager pm,SimboloManager sm) throws RecognitionException {
		ExplisttailContext _localctx = new ExplisttailContext(_ctx, getState(), id, pm, sm);
		enterRule(_localctx, 42, RULE_explisttail);
		try {
			setState(255);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__31:
				enterOuterAlt(_localctx, 1);
				{
				setState(249);
				match(T__31);
				setState(250);
				((ExplisttailContext)_localctx).eq = eq(id,pm,sm);
				setState(251);
				((ExplisttailContext)_localctx).tail7 = explisttail(id,pm,sm);
				ArrayList<Term> aux = ((ExplisttailContext)_localctx).tail7.value;
				                                               aux.add(0,((ExplisttailContext)_localctx).eq.value);
				                                               ((ExplisttailContext)_localctx).value = aux;
				                                              
				}
				break;
			case EOF:
			case T__21:
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

	public static class TermtailContext extends ParserRuleContext {
		public PredicadoId id;
		public PredicadoManager pm;
		public SimboloManager sm;
		public ArrayList<Term> value;
		public TermContext term;
		public TermtailContext tail7;
		public TermContext term() {
			return getRuleContext(TermContext.class,0);
		}
		public TermtailContext termtail() {
			return getRuleContext(TermtailContext.class,0);
		}
		public TermtailContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public TermtailContext(ParserRuleContext parent, int invokingState, PredicadoId id, PredicadoManager pm, SimboloManager sm) {
			super(parent, invokingState);
			this.id = id;
			this.pm = pm;
			this.sm = sm;
		}
		@Override public int getRuleIndex() { return RULE_termtail; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).enterTermtail(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof TermListener ) ((TermListener)listener).exitTermtail(this);
		}
	}

	public final TermtailContext termtail(PredicadoId id,PredicadoManager pm,SimboloManager sm) throws RecognitionException {
		TermtailContext _localctx = new TermtailContext(_ctx, getState(), id, pm, sm);
		enterRule(_localctx, 44, RULE_termtail);
		try {
			setState(263);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__31:
				enterOuterAlt(_localctx, 1);
				{
				setState(257);
				match(T__31);
				setState(258);
				((TermtailContext)_localctx).term = term(id,pm,sm);
				setState(259);
				((TermtailContext)_localctx).tail7 = termtail(id,pm,sm);
				ArrayList<Term> aux = ((TermtailContext)_localctx).tail7.value;
				                                               aux.add(0,((TermtailContext)_localctx).term.value);
				                                               ((TermtailContext)_localctx).value = aux;
				                                              
				}
				break;
			case EOF:
			case T__21:
				enterOuterAlt(_localctx, 2);
				{
				((TermtailContext)_localctx).value =  new ArrayList<Term>();
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
		public ArrayList<Var> value;
		public Token LETTER;
		public ArgumentsContext arg;
		public Token CAPITALLETTER;
		public TerminalNode LETTER() { return getToken(TermParser.LETTER, 0); }
		public ArgumentsContext arguments() {
			return getRuleContext(ArgumentsContext.class,0);
		}
		public TerminalNode CAPITALLETTER() { return getToken(TermParser.CAPITALLETTER, 0); }
		public ArgumentsContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
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

	public final ArgumentsContext arguments() throws RecognitionException {
		ArgumentsContext _localctx = new ArgumentsContext(_ctx, getState());
		enterRule(_localctx, 46, RULE_arguments);
		try {
			setState(279);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,13,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(265);
				((ArgumentsContext)_localctx).LETTER = match(LETTER);
				setState(266);
				match(T__31);
				setState(267);
				((ArgumentsContext)_localctx).arg = arguments();
				ArrayList<Var> aux=((ArgumentsContext)_localctx).arg.value; 
				                                                            Var v=new Var((new Integer((int)(((ArgumentsContext)_localctx).LETTER!=null?((ArgumentsContext)_localctx).LETTER.getText():null).charAt(0))).intValue());
				                                                            aux.add(0,v); 
				                                                            ((ArgumentsContext)_localctx).value = aux;
				                                                           
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(270);
				((ArgumentsContext)_localctx).CAPITALLETTER = match(CAPITALLETTER);
				setState(271);
				match(T__31);
				setState(272);
				((ArgumentsContext)_localctx).arg = arguments();
				ArrayList<Var> aux=((ArgumentsContext)_localctx).arg.value; 
				                                                     Var v=new Var((new Integer((int)(((ArgumentsContext)_localctx).CAPITALLETTER!=null?((ArgumentsContext)_localctx).CAPITALLETTER.getText():null).charAt(0))).intValue());
				                                                     aux.add(0,v); 
				                                                     ((ArgumentsContext)_localctx).value = aux;
				                                                    
				}
				break;
			case 3:
				enterOuterAlt(_localctx, 3);
				{
				setState(275);
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
				setState(277);
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
		public PredicadoId id;
		public PredicadoManager pm;
		public SimboloManager sm;
		public Term value;
		public Token LETTER;
		public EqContext eq;
		public TerminalNode LETTER() { return getToken(TermParser.LETTER, 0); }
		public EqContext eq() {
			return getRuleContext(EqContext.class,0);
		}
		public LambdaContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public LambdaContext(ParserRuleContext parent, int invokingState, PredicadoId id, PredicadoManager pm, SimboloManager sm) {
			super(parent, invokingState);
			this.id = id;
			this.pm = pm;
			this.sm = sm;
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

	public final LambdaContext lambda(PredicadoId id,PredicadoManager pm,SimboloManager sm) throws RecognitionException {
		LambdaContext _localctx = new LambdaContext(_ctx, getState(), id, pm, sm);
		enterRule(_localctx, 48, RULE_lambda);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(281);
			match(T__32);
			setState(282);
			((LambdaContext)_localctx).LETTER = match(LETTER);
			setState(283);
			match(T__25);
			setState(284);
			((LambdaContext)_localctx).eq = eq(id,pm,sm);
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
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\3(\u0122\4\2\t\2\4"+
		"\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4\13\t"+
		"\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22\t\22"+
		"\4\23\t\23\4\24\t\24\4\25\t\25\4\26\t\26\4\27\t\27\4\30\t\30\4\31\t\31"+
		"\4\32\t\32\3\2\3\2\3\2\3\3\3\3\3\3\3\3\3\4\3\4\3\4\3\4\3\4\3\4\5\4B\n"+
		"\4\3\5\3\5\3\5\3\5\3\6\3\6\3\6\3\6\3\6\3\6\5\6N\n\6\3\7\3\7\3\7\3\7\3"+
		"\b\3\b\3\b\3\b\3\b\3\b\5\bZ\n\b\3\t\3\t\3\t\3\t\3\n\3\n\3\n\3\n\3\n\3"+
		"\n\3\n\3\n\3\n\3\n\3\n\5\nk\n\n\3\13\3\13\3\13\3\13\3\f\3\f\3\f\3\f\3"+
		"\f\3\f\5\fw\n\f\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3"+
		"\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r"+
		"\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\5\r\u00a4\n\r\3\16\3"+
		"\16\3\16\3\16\3\17\3\17\3\17\3\17\3\17\3\17\3\17\3\17\3\17\3\17\3\17\5"+
		"\17\u00b5\n\17\3\20\3\20\3\20\3\20\3\21\3\21\3\21\3\21\3\21\3\21\3\21"+
		"\3\21\3\21\3\21\3\21\5\21\u00c6\n\21\3\22\3\22\3\22\3\22\3\23\3\23\3\23"+
		"\3\23\3\23\3\23\3\23\5\23\u00d3\n\23\3\24\3\24\3\24\3\24\3\24\3\24\3\24"+
		"\3\24\3\24\3\24\3\24\3\24\3\24\3\24\3\24\3\24\3\24\3\24\3\24\3\24\3\24"+
		"\3\24\5\24\u00eb\n\24\3\25\3\25\3\25\3\25\3\25\3\26\3\26\3\26\3\26\3\26"+
		"\3\26\3\26\3\26\5\26\u00fa\n\26\3\27\3\27\3\27\3\27\3\27\3\27\5\27\u0102"+
		"\n\27\3\30\3\30\3\30\3\30\3\30\3\30\5\30\u010a\n\30\3\31\3\31\3\31\3\31"+
		"\3\31\3\31\3\31\3\31\3\31\3\31\3\31\3\31\3\31\3\31\5\31\u011a\n\31\3\32"+
		"\3\32\3\32\3\32\3\32\3\32\3\32\2\2\33\2\4\6\b\n\f\16\20\22\24\26\30\32"+
		"\34\36 \"$&(*,.\60\62\2\t\3\2\3\4\3\2\5\6\3\2\7\b\3\2\t\n\3\2\13\f\3\2"+
		"\r\16\3\2\17\20\2\u0127\2\64\3\2\2\2\4\67\3\2\2\2\6A\3\2\2\2\bC\3\2\2"+
		"\2\nM\3\2\2\2\fO\3\2\2\2\16Y\3\2\2\2\20[\3\2\2\2\22j\3\2\2\2\24l\3\2\2"+
		"\2\26v\3\2\2\2\30\u00a3\3\2\2\2\32\u00a5\3\2\2\2\34\u00b4\3\2\2\2\36\u00b6"+
		"\3\2\2\2 \u00c5\3\2\2\2\"\u00c7\3\2\2\2$\u00d2\3\2\2\2&\u00ea\3\2\2\2"+
		"(\u00ec\3\2\2\2*\u00f9\3\2\2\2,\u0101\3\2\2\2.\u0109\3\2\2\2\60\u0119"+
		"\3\2\2\2\62\u011b\3\2\2\2\64\65\5\4\3\2\65\66\b\2\1\2\66\3\3\2\2\2\67"+
		"8\5\b\5\289\5\6\4\29:\b\3\1\2:\5\3\2\2\2;<\t\2\2\2<=\5\b\5\2=>\5\6\4\2"+
		">?\b\4\1\2?B\3\2\2\2@B\b\4\1\2A;\3\2\2\2A@\3\2\2\2B\7\3\2\2\2CD\5\f\7"+
		"\2DE\5\n\6\2EF\b\5\1\2F\t\3\2\2\2GH\t\3\2\2HI\5\f\7\2IJ\5\n\6\2JK\b\6"+
		"\1\2KN\3\2\2\2LN\b\6\1\2MG\3\2\2\2ML\3\2\2\2N\13\3\2\2\2OP\5\20\t\2PQ"+
		"\5\16\b\2QR\b\7\1\2R\r\3\2\2\2ST\t\4\2\2TU\5\20\t\2UV\5\16\b\2VW\b\b\1"+
		"\2WZ\3\2\2\2XZ\b\b\1\2YS\3\2\2\2YX\3\2\2\2Z\17\3\2\2\2[\\\5\24\13\2\\"+
		"]\5\22\n\2]^\b\t\1\2^\21\3\2\2\2_`\t\5\2\2`a\5\24\13\2ab\5\22\n\2bc\b"+
		"\n\1\2ck\3\2\2\2de\t\6\2\2ef\5\24\13\2fg\5\22\n\2gh\b\n\1\2hk\3\2\2\2"+
		"ik\b\n\1\2j_\3\2\2\2jd\3\2\2\2ji\3\2\2\2k\23\3\2\2\2lm\5\30\r\2mn\5\26"+
		"\f\2no\b\13\1\2o\25\3\2\2\2pq\t\7\2\2qr\5\30\r\2rs\5\26\f\2st\b\f\1\2"+
		"tw\3\2\2\2uw\b\f\1\2vp\3\2\2\2vu\3\2\2\2w\27\3\2\2\2xy\t\b\2\2yz\5\30"+
		"\r\2z{\b\r\1\2{\u00a4\3\2\2\2|}\7$\2\2}\u00a4\b\r\1\2~\177\7%\2\2\177"+
		"\u00a4\b\r\1\2\u0080\u0081\7\21\2\2\u0081\u00a4\b\r\1\2\u0082\u0083\7"+
		"\22\2\2\u0083\u00a4\b\r\1\2\u0084\u0085\7$\2\2\u0085\u0086\7\23\2\2\u0086"+
		"\u0087\5\4\3\2\u0087\u0088\7\24\2\2\u0088\u0089\7%\2\2\u0089\u008a\7\25"+
		"\2\2\u008a\u008b\b\r\1\2\u008b\u00a4\3\2\2\2\u008c\u008d\5\32\16\2\u008d"+
		"\u008e\7\26\2\2\u008e\u008f\5\32\16\2\u008f\u0090\b\r\1\2\u0090\u00a4"+
		"\3\2\2\2\u0091\u0092\7\'\2\2\u0092\u0093\7\27\2\2\u0093\u0094\5*\26\2"+
		"\u0094\u0095\7\30\2\2\u0095\u0096\b\r\1\2\u0096\u00a4\3\2\2\2\u0097\u0098"+
		"\7\31\2\2\u0098\u0099\7&\2\2\u0099\u009a\7\27\2\2\u009a\u009b\5*\26\2"+
		"\u009b\u009c\7\30\2\2\u009c\u009d\b\r\1\2\u009d\u00a4\3\2\2\2\u009e\u009f"+
		"\7\27\2\2\u009f\u00a0\5\4\3\2\u00a0\u00a1\7\30\2\2\u00a1\u00a2\b\r\1\2"+
		"\u00a2\u00a4\3\2\2\2\u00a3x\3\2\2\2\u00a3|\3\2\2\2\u00a3~\3\2\2\2\u00a3"+
		"\u0080\3\2\2\2\u00a3\u0082\3\2\2\2\u00a3\u0084\3\2\2\2\u00a3\u008c\3\2"+
		"\2\2\u00a3\u0091\3\2\2\2\u00a3\u0097\3\2\2\2\u00a3\u009e\3\2\2\2\u00a4"+
		"\31\3\2\2\2\u00a5\u00a6\5\36\20\2\u00a6\u00a7\5\34\17\2\u00a7\u00a8\b"+
		"\16\1\2\u00a8\33\3\2\2\2\u00a9\u00aa\7\32\2\2\u00aa\u00ab\5\36\20\2\u00ab"+
		"\u00ac\5\34\17\2\u00ac\u00ad\b\17\1\2\u00ad\u00b5\3\2\2\2\u00ae\u00af"+
		"\7\33\2\2\u00af\u00b0\5\36\20\2\u00b0\u00b1\5\34\17\2\u00b1\u00b2\b\17"+
		"\1\2\u00b2\u00b5\3\2\2\2\u00b3\u00b5\b\17\1\2\u00b4\u00a9\3\2\2\2\u00b4"+
		"\u00ae\3\2\2\2\u00b4\u00b3\3\2\2\2\u00b5\35\3\2\2\2\u00b6\u00b7\5\"\22"+
		"\2\u00b7\u00b8\5 \21\2\u00b8\u00b9\b\20\1\2\u00b9\37\3\2\2\2\u00ba\u00bb"+
		"\7\34\2\2\u00bb\u00bc\5\"\22\2\u00bc\u00bd\5 \21\2\u00bd\u00be\b\21\1"+
		"\2\u00be\u00c6\3\2\2\2\u00bf\u00c0\7\35\2\2\u00c0\u00c1\5\"\22\2\u00c1"+
		"\u00c2\5 \21\2\u00c2\u00c3\b\21\1\2\u00c3\u00c6\3\2\2\2\u00c4\u00c6\b"+
		"\21\1\2\u00c5\u00ba\3\2\2\2\u00c5\u00bf\3\2\2\2\u00c5\u00c4\3\2\2\2\u00c6"+
		"!\3\2\2\2\u00c7\u00c8\5&\24\2\u00c8\u00c9\5$\23\2\u00c9\u00ca\b\22\1\2"+
		"\u00ca#\3\2\2\2\u00cb\u00cc\7\36\2\2\u00cc\u00cd\5&\24\2\u00cd\u00ce\7"+
		"\25\2\2\u00ce\u00cf\5$\23\2\u00cf\u00d0\b\23\1\2\u00d0\u00d3\3\2\2\2\u00d1"+
		"\u00d3\b\23\1\2\u00d2\u00cb\3\2\2\2\u00d2\u00d1\3\2\2\2\u00d3%\3\2\2\2"+
		"\u00d4\u00d5\7\33\2\2\u00d5\u00d6\5&\24\2\u00d6\u00d7\b\24\1\2\u00d7\u00eb"+
		"\3\2\2\2\u00d8\u00d9\7\37\2\2\u00d9\u00eb\b\24\1\2\u00da\u00db\7 \2\2"+
		"\u00db\u00eb\b\24\1\2\u00dc\u00dd\7%\2\2\u00dd\u00eb\b\24\1\2\u00de\u00df"+
		"\7\31\2\2\u00df\u00e0\7&\2\2\u00e0\u00e1\7\27\2\2\u00e1\u00e2\5*\26\2"+
		"\u00e2\u00e3\7\30\2\2\u00e3\u00e4\b\24\1\2\u00e4\u00eb\3\2\2\2\u00e5\u00e6"+
		"\7\27\2\2\u00e6\u00e7\5\32\16\2\u00e7\u00e8\7\30\2\2\u00e8\u00e9\b\24"+
		"\1\2\u00e9\u00eb\3\2\2\2\u00ea\u00d4\3\2\2\2\u00ea\u00d8\3\2\2\2\u00ea"+
		"\u00da\3\2\2\2\u00ea\u00dc\3\2\2\2\u00ea\u00de\3\2\2\2\u00ea\u00e5\3\2"+
		"\2\2\u00eb\'\3\2\2\2\u00ec\u00ed\5\60\31\2\u00ed\u00ee\7!\2\2\u00ee\u00ef"+
		"\5*\26\2\u00ef\u00f0\b\25\1\2\u00f0)\3\2\2\2\u00f1\u00f2\5\4\3\2\u00f2"+
		"\u00f3\5,\27\2\u00f3\u00f4\b\26\1\2\u00f4\u00fa\3\2\2\2\u00f5\u00f6\5"+
		"\32\16\2\u00f6\u00f7\5.\30\2\u00f7\u00f8\b\26\1\2\u00f8\u00fa\3\2\2\2"+
		"\u00f9\u00f1\3\2\2\2\u00f9\u00f5\3\2\2\2\u00fa+\3\2\2\2\u00fb\u00fc\7"+
		"\"\2\2\u00fc\u00fd\5\4\3\2\u00fd\u00fe\5,\27\2\u00fe\u00ff\b\27\1\2\u00ff"+
		"\u0102\3\2\2\2\u0100\u0102\b\27\1\2\u0101\u00fb\3\2\2\2\u0101\u0100\3"+
		"\2\2\2\u0102-\3\2\2\2\u0103\u0104\7\"\2\2\u0104\u0105\5\32\16\2\u0105"+
		"\u0106\5.\30\2\u0106\u0107\b\30\1\2\u0107\u010a\3\2\2\2\u0108\u010a\b"+
		"\30\1\2\u0109\u0103\3\2\2\2\u0109\u0108\3\2\2\2\u010a/\3\2\2\2\u010b\u010c"+
		"\7%\2\2\u010c\u010d\7\"\2\2\u010d\u010e\5\60\31\2\u010e\u010f\b\31\1\2"+
		"\u010f\u011a\3\2\2\2\u0110\u0111\7$\2\2\u0111\u0112\7\"\2\2\u0112\u0113"+
		"\5\60\31\2\u0113\u0114\b\31\1\2\u0114\u011a\3\2\2\2\u0115\u0116\7%\2\2"+
		"\u0116\u011a\b\31\1\2\u0117\u0118\7$\2\2\u0118\u011a\b\31\1\2\u0119\u010b"+
		"\3\2\2\2\u0119\u0110\3\2\2\2\u0119\u0115\3\2\2\2\u0119\u0117\3\2\2\2\u011a"+
		"\61\3\2\2\2\u011b\u011c\7#\2\2\u011c\u011d\7%\2\2\u011d\u011e\7\34\2\2"+
		"\u011e\u011f\5\4\3\2\u011f\u0120\b\32\1\2\u0120\63\3\2\2\2\20AMYjv\u00a3"+
		"\u00b4\u00c5\u00d2\u00ea\u00f9\u0101\u0109\u0119";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}