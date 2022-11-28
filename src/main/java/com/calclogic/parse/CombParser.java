// Generated from .\Comb.g4 by ANTLR 4.8

    
package com.calclogic.parse; 

import com.calclogic.lambdacalculo.*;   
import java.util.LinkedList;
import com.calclogic.entity.Resuelve;   
    

import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.misc.*;
import org.antlr.v4.runtime.tree.*;
import java.util.List;
import java.util.Iterator;
import java.util.ArrayList;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast"})
public class CombParser extends Parser {
	static { RuntimeMetaData.checkVersion("4.8", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		DIGITS=1, C=2, X=3, EQUAL=4, TRUE=5, PHI=6, LAMBDA=7, PERIOD=8, K=9, CB=10, 
		O_PAR=11, C_PAR=12, COMMA=13, C_BRACKET=14, O_BRACKET2=15, C_BRACKET2=16, 
		EXP=17, ASSIGN=18, A=19, M=20, I=21, L=22, S=23, Si=24, WHITESPACE=25;
	public static final int
		RULE_start_rule = 0, RULE_expr = 1, RULE_term = 2, RULE_term_base = 3, 
		RULE_term_tail = 4, RULE_variable_list = 5, RULE_variable_list_tail = 6, 
		RULE_term_list = 7, RULE_term_list_tail = 8, RULE_variable = 9, RULE_constant = 10, 
		RULE_constant_phi = 11, RULE_phi_tail = 12, RULE_comb_index = 13, RULE_cb_pair = 14, 
		RULE_prove_base = 15;
	private static String[] makeRuleNames() {
		return new String[] {
			"start_rule", "expr", "term", "term_base", "term_tail", "variable_list", 
			"variable_list_tail", "term_list", "term_list_tail", "variable", "constant", 
			"constant_phi", "phi_tail", "comb_index", "cb_pair", "prove_base"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, null, null, null, "'='", "'T'", "'\\Phi_{'", "'\\lambda'", "'.'", 
			"'K'", null, "'('", "')'", "','", "'}'", "'['", "']'", "'}^{'", "':='", 
			"'A^{'", "'M_{'", "'I^{'", "'L^{'", "'S^{'", "'S'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, "DIGITS", "C", "X", "EQUAL", "TRUE", "PHI", "LAMBDA", "PERIOD", 
			"K", "CB", "O_PAR", "C_PAR", "COMMA", "C_BRACKET", "O_BRACKET2", "C_BRACKET2", 
			"EXP", "ASSIGN", "A", "M", "I", "L", "S", "Si", "WHITESPACE"
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
	public String getGrammarFileName() { return "Comb.g4"; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public String getSerializedATN() { return _serializedATN; }

	@Override
	public ATN getATN() { return _ATN; }

	public CombParser(TokenStream input) {
		super(input);
		_interp = new ParserATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}

	public static class Start_ruleContext extends ParserRuleContext {
		public String u;
		public Term value;
		public ExprContext expr;
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public Start_ruleContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public Start_ruleContext(ParserRuleContext parent, int invokingState, String u) {
			super(parent, invokingState);
			this.u = u;
		}
		@Override public int getRuleIndex() { return RULE_start_rule; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CombListener ) ((CombListener)listener).enterStart_rule(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CombListener ) ((CombListener)listener).exitStart_rule(this);
		}
	}

	public final Start_ruleContext start_rule(String u) throws RecognitionException {
		Start_ruleContext _localctx = new Start_ruleContext(_ctx, getState(), u);
		enterRule(_localctx, 0, RULE_start_rule);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(32);
			((Start_ruleContext)_localctx).expr = expr(u);
			 ((Start_ruleContext)_localctx).value = ((Start_ruleContext)_localctx).expr.value; 
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

	public static class ExprContext extends ParserRuleContext {
		public String u;
		public Term value;
		public TermContext term;
		public Variable_listContext vl;
		public Term_listContext el;
		public TermContext term() {
			return getRuleContext(TermContext.class,0);
		}
		public TerminalNode O_BRACKET2() { return getToken(CombParser.O_BRACKET2, 0); }
		public TerminalNode ASSIGN() { return getToken(CombParser.ASSIGN, 0); }
		public TerminalNode C_BRACKET2() { return getToken(CombParser.C_BRACKET2, 0); }
		public Variable_listContext variable_list() {
			return getRuleContext(Variable_listContext.class,0);
		}
		public Term_listContext term_list() {
			return getRuleContext(Term_listContext.class,0);
		}
		public ExprContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public ExprContext(ParserRuleContext parent, int invokingState, String u) {
			super(parent, invokingState);
			this.u = u;
		}
		@Override public int getRuleIndex() { return RULE_expr; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CombListener ) ((CombListener)listener).enterExpr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CombListener ) ((CombListener)listener).exitExpr(this);
		}
	}

	public final ExprContext expr(String u) throws RecognitionException {
		ExprContext _localctx = new ExprContext(_ctx, getState(), u);
		enterRule(_localctx, 2, RULE_expr);
		try {
			setState(45);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case C:
			case X:
			case EQUAL:
			case TRUE:
			case PHI:
			case LAMBDA:
			case O_PAR:
			case A:
			case M:
			case I:
			case L:
			case S:
			case Si:
				enterOuterAlt(_localctx, 1);
				{
				setState(35);
				((ExprContext)_localctx).term = term(u);
				 ((ExprContext)_localctx).value =  ((ExprContext)_localctx).term.value; 
				}
				break;
			case O_BRACKET2:
				enterOuterAlt(_localctx, 2);
				{
				setState(38);
				match(O_BRACKET2);
				setState(39);
				((ExprContext)_localctx).vl = variable_list();
				setState(40);
				match(ASSIGN);
				setState(41);
				((ExprContext)_localctx).el = term_list(u);
				setState(42);
				match(C_BRACKET2);
				 
				                                                    if (((ExprContext)_localctx).vl.value.size() != ((ExprContext)_localctx).el.value.size()) {
				                                                        try {
				                                                            throw new TypeVerificationException();
				                                                        }
				                                                        catch (TypeVerificationException e) {
				                                                            e.printStackTrace();
				                                                            return null;
				                                                        }
				                                                    }
				                                                    else{
				                                                        ((ExprContext)_localctx).value =  new Sust(((ExprContext)_localctx).vl.value, ((ExprContext)_localctx).el.value);
				                                                    }
				                                                
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
		public String u;
		public Term value;
		public Term_baseContext term_base;
		public Term_tailContext term_tail;
		public Term_baseContext term_base() {
			return getRuleContext(Term_baseContext.class,0);
		}
		public Term_tailContext term_tail() {
			return getRuleContext(Term_tailContext.class,0);
		}
		public TermContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public TermContext(ParserRuleContext parent, int invokingState, String u) {
			super(parent, invokingState);
			this.u = u;
		}
		@Override public int getRuleIndex() { return RULE_term; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CombListener ) ((CombListener)listener).enterTerm(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CombListener ) ((CombListener)listener).exitTerm(this);
		}
	}

	public final TermContext term(String u) throws RecognitionException {
		TermContext _localctx = new TermContext(_ctx, getState(), u);
		enterRule(_localctx, 4, RULE_term);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(47);
			((TermContext)_localctx).term_base = term_base(u);
			setState(48);
			((TermContext)_localctx).term_tail = term_tail(u);
			 
			                                    Term aux = ((TermContext)_localctx).term_base.value; 
			                                    try {
			                                        for (Term it: ((TermContext)_localctx).term_tail.value) {
			                                            if (aux instanceof TypedTerm && 
			                                                (it instanceof TypedTerm)) //|| it instanceof Const || it instanceof App))
			                                            {
			                                                aux = new TypedApp(aux,it);
			                                            }
			                                            else if (aux instanceof M && it instanceof TypedTerm) {
			                                                aux = new TypedM(((Const)aux).getId(), Integer.parseInt(((Const)aux).getCon()), it, ((TypedTerm)it).getCombDBType(), u);
			                                            } else if ( !(aux instanceof TypedTerm) && !(it instanceof TypedTerm)){
			                                                aux = new App(aux,it);
			                                            }
			                                            else{
			                                                throw new TypeVerificationException();
			                                            }
			                                        }
			                                    }
			                                    catch (TypeVerificationException e){
			                                        e.printStackTrace();
			                                        return null;
			                                    }
			                                    ((TermContext)_localctx).value =  aux;  
			                                
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

	public static class Term_baseContext extends ParserRuleContext {
		public String u;
		public Term value;
		public ConstantContext constant;
		public VariableContext variable;
		public VariableContext v;
		public TermContext e1;
		public TermContext term;
		public ConstantContext constant() {
			return getRuleContext(ConstantContext.class,0);
		}
		public VariableContext variable() {
			return getRuleContext(VariableContext.class,0);
		}
		public TerminalNode LAMBDA() { return getToken(CombParser.LAMBDA, 0); }
		public TerminalNode PERIOD() { return getToken(CombParser.PERIOD, 0); }
		public TermContext term() {
			return getRuleContext(TermContext.class,0);
		}
		public TerminalNode O_PAR() { return getToken(CombParser.O_PAR, 0); }
		public TerminalNode C_PAR() { return getToken(CombParser.C_PAR, 0); }
		public Term_baseContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public Term_baseContext(ParserRuleContext parent, int invokingState, String u) {
			super(parent, invokingState);
			this.u = u;
		}
		@Override public int getRuleIndex() { return RULE_term_base; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CombListener ) ((CombListener)listener).enterTerm_base(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CombListener ) ((CombListener)listener).exitTerm_base(this);
		}
	}

	public final Term_baseContext term_base(String u) throws RecognitionException {
		Term_baseContext _localctx = new Term_baseContext(_ctx, getState(), u);
		enterRule(_localctx, 6, RULE_term_base);
		try {
			setState(68);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case C:
			case EQUAL:
			case TRUE:
			case PHI:
			case A:
			case M:
			case I:
			case L:
			case S:
			case Si:
				enterOuterAlt(_localctx, 1);
				{
				setState(51);
				((Term_baseContext)_localctx).constant = constant(u);
				 ((Term_baseContext)_localctx).value =  ((Term_baseContext)_localctx).constant.value; 
				}
				break;
			case X:
				enterOuterAlt(_localctx, 2);
				{
				setState(54);
				((Term_baseContext)_localctx).variable = variable();
				 ((Term_baseContext)_localctx).value =  ((Term_baseContext)_localctx).variable.value; 
				}
				break;
			case LAMBDA:
				enterOuterAlt(_localctx, 3);
				{
				setState(57);
				match(LAMBDA);
				setState(58);
				((Term_baseContext)_localctx).v = variable();
				setState(59);
				match(PERIOD);
				setState(60);
				((Term_baseContext)_localctx).e1 = term(u);
				 ((Term_baseContext)_localctx).value =  new Bracket(((Term_baseContext)_localctx).v.value, ((Term_baseContext)_localctx).e1.value); 
				}
				break;
			case O_PAR:
				enterOuterAlt(_localctx, 4);
				{
				setState(63);
				match(O_PAR);
				setState(64);
				((Term_baseContext)_localctx).term = term(u);
				setState(65);
				match(C_PAR);
				 ((Term_baseContext)_localctx).value =  ((Term_baseContext)_localctx).term.value; 
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

	public static class Term_tailContext extends ParserRuleContext {
		public String u;
		public LinkedList<Term> value;
		public Term_baseContext term_base;
		public Term_tailContext t;
		public Term_baseContext term_base() {
			return getRuleContext(Term_baseContext.class,0);
		}
		public Term_tailContext term_tail() {
			return getRuleContext(Term_tailContext.class,0);
		}
		public Term_tailContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public Term_tailContext(ParserRuleContext parent, int invokingState, String u) {
			super(parent, invokingState);
			this.u = u;
		}
		@Override public int getRuleIndex() { return RULE_term_tail; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CombListener ) ((CombListener)listener).enterTerm_tail(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CombListener ) ((CombListener)listener).exitTerm_tail(this);
		}
	}

	public final Term_tailContext term_tail(String u) throws RecognitionException {
		Term_tailContext _localctx = new Term_tailContext(_ctx, getState(), u);
		enterRule(_localctx, 8, RULE_term_tail);
		try {
			setState(75);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,2,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(70);
				((Term_tailContext)_localctx).term_base = term_base(u);
				setState(71);
				((Term_tailContext)_localctx).t = term_tail(u);
				 ((Term_tailContext)_localctx).t.value.add(0,((Term_tailContext)_localctx).term_base.value); ((Term_tailContext)_localctx).value =  ((Term_tailContext)_localctx).t.value; 
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				 ((Term_tailContext)_localctx).value =  new LinkedList<Term>(); 
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

	public static class Variable_listContext extends ParserRuleContext {
		public LinkedList<Var> value;
		public VariableContext variable;
		public Variable_list_tailContext vl;
		public VariableContext variable() {
			return getRuleContext(VariableContext.class,0);
		}
		public Variable_list_tailContext variable_list_tail() {
			return getRuleContext(Variable_list_tailContext.class,0);
		}
		public Variable_listContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_variable_list; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CombListener ) ((CombListener)listener).enterVariable_list(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CombListener ) ((CombListener)listener).exitVariable_list(this);
		}
	}

	public final Variable_listContext variable_list() throws RecognitionException {
		Variable_listContext _localctx = new Variable_listContext(_ctx, getState());
		enterRule(_localctx, 10, RULE_variable_list);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(77);
			((Variable_listContext)_localctx).variable = variable();
			setState(78);
			((Variable_listContext)_localctx).vl = variable_list_tail();
			 ((Variable_listContext)_localctx).vl.value.add(0,((Variable_listContext)_localctx).variable.value); ((Variable_listContext)_localctx).value =  ((Variable_listContext)_localctx).vl.value; 
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

	public static class Variable_list_tailContext extends ParserRuleContext {
		public LinkedList<Var> value;
		public Variable_listContext variable_list;
		public TerminalNode COMMA() { return getToken(CombParser.COMMA, 0); }
		public Variable_listContext variable_list() {
			return getRuleContext(Variable_listContext.class,0);
		}
		public Variable_list_tailContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_variable_list_tail; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CombListener ) ((CombListener)listener).enterVariable_list_tail(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CombListener ) ((CombListener)listener).exitVariable_list_tail(this);
		}
	}

	public final Variable_list_tailContext variable_list_tail() throws RecognitionException {
		Variable_list_tailContext _localctx = new Variable_list_tailContext(_ctx, getState());
		enterRule(_localctx, 12, RULE_variable_list_tail);
		try {
			setState(86);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case COMMA:
				enterOuterAlt(_localctx, 1);
				{
				setState(81);
				match(COMMA);
				setState(82);
				((Variable_list_tailContext)_localctx).variable_list = variable_list();
				 ((Variable_list_tailContext)_localctx).value =  ((Variable_list_tailContext)_localctx).variable_list.value; 
				}
				break;
			case ASSIGN:
				enterOuterAlt(_localctx, 2);
				{
				 ((Variable_list_tailContext)_localctx).value =  new LinkedList<Var>(); 
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

	public static class Term_listContext extends ParserRuleContext {
		public String u;
		public LinkedList<Term> value;
		public TermContext term;
		public Term_list_tailContext el;
		public TermContext term() {
			return getRuleContext(TermContext.class,0);
		}
		public Term_list_tailContext term_list_tail() {
			return getRuleContext(Term_list_tailContext.class,0);
		}
		public Term_listContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public Term_listContext(ParserRuleContext parent, int invokingState, String u) {
			super(parent, invokingState);
			this.u = u;
		}
		@Override public int getRuleIndex() { return RULE_term_list; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CombListener ) ((CombListener)listener).enterTerm_list(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CombListener ) ((CombListener)listener).exitTerm_list(this);
		}
	}

	public final Term_listContext term_list(String u) throws RecognitionException {
		Term_listContext _localctx = new Term_listContext(_ctx, getState(), u);
		enterRule(_localctx, 14, RULE_term_list);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(88);
			((Term_listContext)_localctx).term = term(u);
			setState(89);
			((Term_listContext)_localctx).el = term_list_tail(u);
			 ((Term_listContext)_localctx).el.value.add(0,((Term_listContext)_localctx).term.value); ((Term_listContext)_localctx).value =  ((Term_listContext)_localctx).el.value; 
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

	public static class Term_list_tailContext extends ParserRuleContext {
		public String u;
		public LinkedList<Term> value;
		public Term_listContext term_list;
		public TerminalNode COMMA() { return getToken(CombParser.COMMA, 0); }
		public Term_listContext term_list() {
			return getRuleContext(Term_listContext.class,0);
		}
		public Term_list_tailContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public Term_list_tailContext(ParserRuleContext parent, int invokingState, String u) {
			super(parent, invokingState);
			this.u = u;
		}
		@Override public int getRuleIndex() { return RULE_term_list_tail; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CombListener ) ((CombListener)listener).enterTerm_list_tail(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CombListener ) ((CombListener)listener).exitTerm_list_tail(this);
		}
	}

	public final Term_list_tailContext term_list_tail(String u) throws RecognitionException {
		Term_list_tailContext _localctx = new Term_list_tailContext(_ctx, getState(), u);
		enterRule(_localctx, 16, RULE_term_list_tail);
		try {
			setState(97);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case COMMA:
				enterOuterAlt(_localctx, 1);
				{
				setState(92);
				match(COMMA);
				setState(93);
				((Term_list_tailContext)_localctx).term_list = term_list(u);
				 ((Term_list_tailContext)_localctx).value =  ((Term_list_tailContext)_localctx).term_list.value; 
				}
				break;
			case C_BRACKET2:
				enterOuterAlt(_localctx, 2);
				{
				 ((Term_list_tailContext)_localctx).value =  new LinkedList<Term>(); 
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

	public static class VariableContext extends ParserRuleContext {
		public Var value;
		public Token DIGITS;
		public TerminalNode X() { return getToken(CombParser.X, 0); }
		public TerminalNode DIGITS() { return getToken(CombParser.DIGITS, 0); }
		public TerminalNode C_BRACKET() { return getToken(CombParser.C_BRACKET, 0); }
		public VariableContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_variable; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CombListener ) ((CombListener)listener).enterVariable(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CombListener ) ((CombListener)listener).exitVariable(this);
		}
	}

	public final VariableContext variable() throws RecognitionException {
		VariableContext _localctx = new VariableContext(_ctx, getState());
		enterRule(_localctx, 18, RULE_variable);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(99);
			match(X);
			setState(100);
			((VariableContext)_localctx).DIGITS = match(DIGITS);
			setState(101);
			match(C_BRACKET);

			                          int index = Integer.parseInt((((VariableContext)_localctx).DIGITS!=null?((VariableContext)_localctx).DIGITS.getText():null));// Take the index of the variable
			                          ((VariableContext)_localctx).value =  new Var(index);// Return a new Variable object with that index
			                         
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

	public static class ConstantContext extends ParserRuleContext {
		public String u;
		public Term value;
		public Token DIGITS;
		public Token EQUAL;
		public Token TRUE;
		public Constant_phiContext constant_phi;
		public Prove_baseContext prove_base;
		public TerminalNode C() { return getToken(CombParser.C, 0); }
		public TerminalNode DIGITS() { return getToken(CombParser.DIGITS, 0); }
		public TerminalNode C_BRACKET() { return getToken(CombParser.C_BRACKET, 0); }
		public TerminalNode EQUAL() { return getToken(CombParser.EQUAL, 0); }
		public TerminalNode TRUE() { return getToken(CombParser.TRUE, 0); }
		public Constant_phiContext constant_phi() {
			return getRuleContext(Constant_phiContext.class,0);
		}
		public Prove_baseContext prove_base() {
			return getRuleContext(Prove_baseContext.class,0);
		}
		public ConstantContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public ConstantContext(ParserRuleContext parent, int invokingState, String u) {
			super(parent, invokingState);
			this.u = u;
		}
		@Override public int getRuleIndex() { return RULE_constant; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CombListener ) ((CombListener)listener).enterConstant(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CombListener ) ((CombListener)listener).exitConstant(this);
		}
	}

	public final ConstantContext constant(String u) throws RecognitionException {
		ConstantContext _localctx = new ConstantContext(_ctx, getState(), u);
		enterRule(_localctx, 20, RULE_constant);
		try {
			setState(118);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case C:
				enterOuterAlt(_localctx, 1);
				{
				setState(104);
				match(C);
				setState(105);
				((ConstantContext)_localctx).DIGITS = match(DIGITS);
				setState(106);
				match(C_BRACKET);
				 int index = Integer.parseInt((((ConstantContext)_localctx).DIGITS!=null?((ConstantContext)_localctx).DIGITS.getText():null));
				                          ((ConstantContext)_localctx).value =  new Const(index ,"c_{"+index+"}");
				                        
				}
				break;
			case EQUAL:
				enterOuterAlt(_localctx, 2);
				{
				setState(108);
				((ConstantContext)_localctx).EQUAL = match(EQUAL);
				 String cons = (((ConstantContext)_localctx).EQUAL!=null?((ConstantContext)_localctx).EQUAL.getText():null) ; // Take string format of the constant
				                          ((ConstantContext)_localctx).value =  new Const(0 ,cons);
				                        
				}
				break;
			case TRUE:
				enterOuterAlt(_localctx, 3);
				{
				setState(110);
				((ConstantContext)_localctx).TRUE = match(TRUE);
				 String cons = (((ConstantContext)_localctx).TRUE!=null?((ConstantContext)_localctx).TRUE.getText():null) ; // Take string format of the constant
				                          ((ConstantContext)_localctx).value =  new Const(-1 ,cons);
				                        
				}
				break;
			case PHI:
				enterOuterAlt(_localctx, 4);
				{
				setState(112);
				((ConstantContext)_localctx).constant_phi = constant_phi();
				 ((ConstantContext)_localctx).value =  ((ConstantContext)_localctx).constant_phi.value; 
				}
				break;
			case A:
			case M:
			case I:
			case L:
			case S:
			case Si:
				enterOuterAlt(_localctx, 5);
				{
				setState(115);
				((ConstantContext)_localctx).prove_base = prove_base(u);
				 ((ConstantContext)_localctx).value =  ((ConstantContext)_localctx).prove_base.value; 
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

	public static class Constant_phiContext extends ParserRuleContext {
		public Term value;
		public Phi_tailContext phi_tail;
		public TerminalNode PHI() { return getToken(CombParser.PHI, 0); }
		public Phi_tailContext phi_tail() {
			return getRuleContext(Phi_tailContext.class,0);
		}
		public Constant_phiContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_constant_phi; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CombListener ) ((CombListener)listener).enterConstant_phi(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CombListener ) ((CombListener)listener).exitConstant_phi(this);
		}
	}

	public final Constant_phiContext constant_phi() throws RecognitionException {
		Constant_phiContext _localctx = new Constant_phiContext(_ctx, getState());
		enterRule(_localctx, 22, RULE_constant_phi);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(120);
			match(PHI);
			setState(121);
			((Constant_phiContext)_localctx).phi_tail = phi_tail();
			 ((Constant_phiContext)_localctx).value =  ((Constant_phiContext)_localctx).phi_tail.value; 
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

	public static class Phi_tailContext extends ParserRuleContext {
		public Term value;
		public Comb_indexContext comb_index;
		public TerminalNode K() { return getToken(CombParser.K, 0); }
		public TerminalNode C_BRACKET() { return getToken(CombParser.C_BRACKET, 0); }
		public Comb_indexContext comb_index() {
			return getRuleContext(Comb_indexContext.class,0);
		}
		public Phi_tailContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_phi_tail; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CombListener ) ((CombListener)listener).enterPhi_tail(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CombListener ) ((CombListener)listener).exitPhi_tail(this);
		}
	}

	public final Phi_tailContext phi_tail() throws RecognitionException {
		Phi_tailContext _localctx = new Phi_tailContext(_ctx, getState());
		enterRule(_localctx, 24, RULE_phi_tail);
		try {
			setState(131);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case K:
				enterOuterAlt(_localctx, 1);
				{
				setState(124);
				match(K);
				setState(125);
				match(C_BRACKET);
				 ((Phi_tailContext)_localctx).value =  new Const("\\Phi_{K}"); 
				}
				break;
			case CB:
			case O_PAR:
			case C_BRACKET:
				enterOuterAlt(_localctx, 2);
				{
				setState(127);
				((Phi_tailContext)_localctx).comb_index = comb_index();
				setState(128);
				match(C_BRACKET);
				 ((Phi_tailContext)_localctx).value =  new Phi(); ((Phi)_localctx.value).ind=((Phi_tailContext)_localctx).comb_index.value;
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

	public static class Comb_indexContext extends ParserRuleContext {
		public ListaInd value;
		public Cb_pairContext cb_pair;
		public Token CB;
		public Comb_indexContext c1;
		public Cb_pairContext cb_pair() {
			return getRuleContext(Cb_pairContext.class,0);
		}
		public TerminalNode CB() { return getToken(CombParser.CB, 0); }
		public Comb_indexContext comb_index() {
			return getRuleContext(Comb_indexContext.class,0);
		}
		public Comb_indexContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_comb_index; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CombListener ) ((CombListener)listener).enterComb_index(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CombListener ) ((CombListener)listener).exitComb_index(this);
		}
	}

	public final Comb_indexContext comb_index() throws RecognitionException {
		Comb_indexContext _localctx = new Comb_indexContext(_ctx, getState());
		enterRule(_localctx, 26, RULE_comb_index);
		try {
			setState(141);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case O_PAR:
				enterOuterAlt(_localctx, 1);
				{
				setState(133);
				((Comb_indexContext)_localctx).cb_pair = cb_pair();
				((Comb_indexContext)_localctx).value =  new ListaInd(((Comb_indexContext)_localctx).cb_pair.value);
				}
				break;
			case CB:
				enterOuterAlt(_localctx, 2);
				{
				setState(136);
				((Comb_indexContext)_localctx).CB = match(CB);
				setState(137);
				((Comb_indexContext)_localctx).c1 = comb_index();
				((Comb_indexContext)_localctx).value =  ((Comb_indexContext)_localctx).c1.value;// Take the ListaInd from c1 
				             ConstInd cb = new ConstInd((((Comb_indexContext)_localctx).CB!=null?((Comb_indexContext)_localctx).CB.getText():null));// Crete a new c/b const
				             _localctx.value.list.add(cb);// Add it to the new value
				             _localctx.value.orden +=cb.orden;// update orden
				            
				}
				break;
			case C_PAR:
			case COMMA:
			case C_BRACKET:
				enterOuterAlt(_localctx, 3);
				{
				((Comb_indexContext)_localctx).value =  new ListaInd();
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

	public static class Cb_pairContext extends ParserRuleContext {
		public Indice value;
		public Comb_indexContext c1;
		public Comb_indexContext c2;
		public TerminalNode O_PAR() { return getToken(CombParser.O_PAR, 0); }
		public TerminalNode COMMA() { return getToken(CombParser.COMMA, 0); }
		public TerminalNode C_PAR() { return getToken(CombParser.C_PAR, 0); }
		public List<Comb_indexContext> comb_index() {
			return getRuleContexts(Comb_indexContext.class);
		}
		public Comb_indexContext comb_index(int i) {
			return getRuleContext(Comb_indexContext.class,i);
		}
		public Cb_pairContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_cb_pair; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CombListener ) ((CombListener)listener).enterCb_pair(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CombListener ) ((CombListener)listener).exitCb_pair(this);
		}
	}

	public final Cb_pairContext cb_pair() throws RecognitionException {
		Cb_pairContext _localctx = new Cb_pairContext(_ctx, getState());
		enterRule(_localctx, 28, RULE_cb_pair);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(143);
			match(O_PAR);
			setState(144);
			((Cb_pairContext)_localctx).c1 = comb_index();
			setState(145);
			match(COMMA);
			setState(146);
			((Cb_pairContext)_localctx).c2 = comb_index();
			setState(147);
			match(C_PAR);
			 ((Cb_pairContext)_localctx).value =  new ParInd(((Cb_pairContext)_localctx).c1.value,((Cb_pairContext)_localctx).c2.value);
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

	public static class Prove_baseContext extends ParserRuleContext {
		public String u;
		public Term value;
		public ExprContext expr;
		public Token d1;
		public Token d2;
		public TerminalNode I() { return getToken(CombParser.I, 0); }
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public TerminalNode C_BRACKET() { return getToken(CombParser.C_BRACKET, 0); }
		public TerminalNode L() { return getToken(CombParser.L, 0); }
		public TerminalNode S() { return getToken(CombParser.S, 0); }
		public TerminalNode Si() { return getToken(CombParser.Si, 0); }
		public TerminalNode A() { return getToken(CombParser.A, 0); }
		public TerminalNode M() { return getToken(CombParser.M, 0); }
		public TerminalNode EXP() { return getToken(CombParser.EXP, 0); }
		public List<TerminalNode> DIGITS() { return getTokens(CombParser.DIGITS); }
		public TerminalNode DIGITS(int i) {
			return getToken(CombParser.DIGITS, i);
		}
		public Prove_baseContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public Prove_baseContext(ParserRuleContext parent, int invokingState, String u) {
			super(parent, invokingState);
			this.u = u;
		}
		@Override public int getRuleIndex() { return RULE_prove_base; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CombListener ) ((CombListener)listener).enterProve_base(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CombListener ) ((CombListener)listener).exitProve_base(this);
		}
	}

	public final Prove_baseContext prove_base(String u) throws RecognitionException {
		Prove_baseContext _localctx = new Prove_baseContext(_ctx, getState(), u);
		enterRule(_localctx, 30, RULE_prove_base);
		try {
			setState(178);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case I:
				enterOuterAlt(_localctx, 1);
				{
				setState(150);
				match(I);
				setState(151);
				((Prove_baseContext)_localctx).expr = expr(u);
				setState(152);
				match(C_BRACKET);
				 ((Prove_baseContext)_localctx).value =  new TypedI((Sust) ((Prove_baseContext)_localctx).expr.value); 
				}
				break;
			case L:
				enterOuterAlt(_localctx, 2);
				{
				setState(155);
				match(L);
				setState(156);
				((Prove_baseContext)_localctx).expr = expr(u);
				setState(157);
				match(C_BRACKET);
				 ((Prove_baseContext)_localctx).value =  new TypedL((Bracket) ((Prove_baseContext)_localctx).expr.value); 
				}
				break;
			case S:
				enterOuterAlt(_localctx, 3);
				{
				setState(160);
				match(S);
				setState(161);
				((Prove_baseContext)_localctx).expr = expr(u);
				setState(162);
				match(C_BRACKET);
				 
				                            try {
				                                ((Prove_baseContext)_localctx).value =  new TypedS(((Prove_baseContext)_localctx).expr.value,0); 
				                            } catch (TypeVerificationException e) {
				                                e.printStackTrace();
				                                return null;
				                            }
				                        
				}
				break;
			case Si:
				enterOuterAlt(_localctx, 4);
				{
				setState(165);
				match(Si);

				            try {
				                ((Prove_baseContext)_localctx).value =  new TypedS(); 
				            } catch (TypeVerificationException e) {
				                e.printStackTrace();
				                return null;
				            } 
				        
				}
				break;
			case A:
				enterOuterAlt(_localctx, 5);
				{
				setState(167);
				match(A);
				setState(168);
				((Prove_baseContext)_localctx).expr = expr(u);
				setState(169);
				match(C_BRACKET);
				 ((Prove_baseContext)_localctx).value =  (u!=null ? new TypedA(((Prove_baseContext)_localctx).expr.value,u) : new TypedA(((Prove_baseContext)_localctx).expr.value)); 
				}
				break;
			case M:
				enterOuterAlt(_localctx, 6);
				{
				setState(172);
				match(M);
				setState(173);
				((Prove_baseContext)_localctx).d1 = match(DIGITS);
				setState(174);
				match(EXP);
				setState(175);
				((Prove_baseContext)_localctx).d2 = match(DIGITS);
				setState(176);
				match(C_BRACKET);
				 
				                            int id;
				                            id = Integer.parseInt((((Prove_baseContext)_localctx).d1!=null?((Prove_baseContext)_localctx).d1.getText():null));
				                            ((Prove_baseContext)_localctx).value =  new M(id, (((Prove_baseContext)_localctx).d2!=null?((Prove_baseContext)_localctx).d2.getText():null));
				                        
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
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\3\33\u00b7\4\2\t\2"+
		"\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4\13"+
		"\t\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\3\2\3\2"+
		"\3\2\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\5\3\60\n\3\3\4\3\4\3\4\3"+
		"\4\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5"+
		"\5\5G\n\5\3\6\3\6\3\6\3\6\3\6\5\6N\n\6\3\7\3\7\3\7\3\7\3\b\3\b\3\b\3\b"+
		"\3\b\5\bY\n\b\3\t\3\t\3\t\3\t\3\n\3\n\3\n\3\n\3\n\5\nd\n\n\3\13\3\13\3"+
		"\13\3\13\3\13\3\f\3\f\3\f\3\f\3\f\3\f\3\f\3\f\3\f\3\f\3\f\3\f\3\f\3\f"+
		"\5\fy\n\f\3\r\3\r\3\r\3\r\3\16\3\16\3\16\3\16\3\16\3\16\3\16\5\16\u0086"+
		"\n\16\3\17\3\17\3\17\3\17\3\17\3\17\3\17\3\17\5\17\u0090\n\17\3\20\3\20"+
		"\3\20\3\20\3\20\3\20\3\20\3\21\3\21\3\21\3\21\3\21\3\21\3\21\3\21\3\21"+
		"\3\21\3\21\3\21\3\21\3\21\3\21\3\21\3\21\3\21\3\21\3\21\3\21\3\21\3\21"+
		"\3\21\3\21\3\21\3\21\3\21\5\21\u00b5\n\21\3\21\2\2\22\2\4\6\b\n\f\16\20"+
		"\22\24\26\30\32\34\36 \2\2\2\u00b9\2\"\3\2\2\2\4/\3\2\2\2\6\61\3\2\2\2"+
		"\bF\3\2\2\2\nM\3\2\2\2\fO\3\2\2\2\16X\3\2\2\2\20Z\3\2\2\2\22c\3\2\2\2"+
		"\24e\3\2\2\2\26x\3\2\2\2\30z\3\2\2\2\32\u0085\3\2\2\2\34\u008f\3\2\2\2"+
		"\36\u0091\3\2\2\2 \u00b4\3\2\2\2\"#\5\4\3\2#$\b\2\1\2$\3\3\2\2\2%&\5\6"+
		"\4\2&\'\b\3\1\2\'\60\3\2\2\2()\7\21\2\2)*\5\f\7\2*+\7\24\2\2+,\5\20\t"+
		"\2,-\7\22\2\2-.\b\3\1\2.\60\3\2\2\2/%\3\2\2\2/(\3\2\2\2\60\5\3\2\2\2\61"+
		"\62\5\b\5\2\62\63\5\n\6\2\63\64\b\4\1\2\64\7\3\2\2\2\65\66\5\26\f\2\66"+
		"\67\b\5\1\2\67G\3\2\2\289\5\24\13\29:\b\5\1\2:G\3\2\2\2;<\7\t\2\2<=\5"+
		"\24\13\2=>\7\n\2\2>?\5\6\4\2?@\b\5\1\2@G\3\2\2\2AB\7\r\2\2BC\5\6\4\2C"+
		"D\7\16\2\2DE\b\5\1\2EG\3\2\2\2F\65\3\2\2\2F8\3\2\2\2F;\3\2\2\2FA\3\2\2"+
		"\2G\t\3\2\2\2HI\5\b\5\2IJ\5\n\6\2JK\b\6\1\2KN\3\2\2\2LN\b\6\1\2MH\3\2"+
		"\2\2ML\3\2\2\2N\13\3\2\2\2OP\5\24\13\2PQ\5\16\b\2QR\b\7\1\2R\r\3\2\2\2"+
		"ST\7\17\2\2TU\5\f\7\2UV\b\b\1\2VY\3\2\2\2WY\b\b\1\2XS\3\2\2\2XW\3\2\2"+
		"\2Y\17\3\2\2\2Z[\5\6\4\2[\\\5\22\n\2\\]\b\t\1\2]\21\3\2\2\2^_\7\17\2\2"+
		"_`\5\20\t\2`a\b\n\1\2ad\3\2\2\2bd\b\n\1\2c^\3\2\2\2cb\3\2\2\2d\23\3\2"+
		"\2\2ef\7\5\2\2fg\7\3\2\2gh\7\20\2\2hi\b\13\1\2i\25\3\2\2\2jk\7\4\2\2k"+
		"l\7\3\2\2lm\7\20\2\2my\b\f\1\2no\7\6\2\2oy\b\f\1\2pq\7\7\2\2qy\b\f\1\2"+
		"rs\5\30\r\2st\b\f\1\2ty\3\2\2\2uv\5 \21\2vw\b\f\1\2wy\3\2\2\2xj\3\2\2"+
		"\2xn\3\2\2\2xp\3\2\2\2xr\3\2\2\2xu\3\2\2\2y\27\3\2\2\2z{\7\b\2\2{|\5\32"+
		"\16\2|}\b\r\1\2}\31\3\2\2\2~\177\7\13\2\2\177\u0080\7\20\2\2\u0080\u0086"+
		"\b\16\1\2\u0081\u0082\5\34\17\2\u0082\u0083\7\20\2\2\u0083\u0084\b\16"+
		"\1\2\u0084\u0086\3\2\2\2\u0085~\3\2\2\2\u0085\u0081\3\2\2\2\u0086\33\3"+
		"\2\2\2\u0087\u0088\5\36\20\2\u0088\u0089\b\17\1\2\u0089\u0090\3\2\2\2"+
		"\u008a\u008b\7\f\2\2\u008b\u008c\5\34\17\2\u008c\u008d\b\17\1\2\u008d"+
		"\u0090\3\2\2\2\u008e\u0090\b\17\1\2\u008f\u0087\3\2\2\2\u008f\u008a\3"+
		"\2\2\2\u008f\u008e\3\2\2\2\u0090\35\3\2\2\2\u0091\u0092\7\r\2\2\u0092"+
		"\u0093\5\34\17\2\u0093\u0094\7\17\2\2\u0094\u0095\5\34\17\2\u0095\u0096"+
		"\7\16\2\2\u0096\u0097\b\20\1\2\u0097\37\3\2\2\2\u0098\u0099\7\27\2\2\u0099"+
		"\u009a\5\4\3\2\u009a\u009b\7\20\2\2\u009b\u009c\b\21\1\2\u009c\u00b5\3"+
		"\2\2\2\u009d\u009e\7\30\2\2\u009e\u009f\5\4\3\2\u009f\u00a0\7\20\2\2\u00a0"+
		"\u00a1\b\21\1\2\u00a1\u00b5\3\2\2\2\u00a2\u00a3\7\31\2\2\u00a3\u00a4\5"+
		"\4\3\2\u00a4\u00a5\7\20\2\2\u00a5\u00a6\b\21\1\2\u00a6\u00b5\3\2\2\2\u00a7"+
		"\u00a8\7\32\2\2\u00a8\u00b5\b\21\1\2\u00a9\u00aa\7\25\2\2\u00aa\u00ab"+
		"\5\4\3\2\u00ab\u00ac\7\20\2\2\u00ac\u00ad\b\21\1\2\u00ad\u00b5\3\2\2\2"+
		"\u00ae\u00af\7\26\2\2\u00af\u00b0\7\3\2\2\u00b0\u00b1\7\23\2\2\u00b1\u00b2"+
		"\7\3\2\2\u00b2\u00b3\7\20\2\2\u00b3\u00b5\b\21\1\2\u00b4\u0098\3\2\2\2"+
		"\u00b4\u009d\3\2\2\2\u00b4\u00a2\3\2\2\2\u00b4\u00a7\3\2\2\2\u00b4\u00a9"+
		"\3\2\2\2\u00b4\u00ae\3\2\2\2\u00b5!\3\2\2\2\13/FMXcx\u0085\u008f\u00b4";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}