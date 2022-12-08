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
		RULE_prove_base = 15, RULE_factorize = 16;
	private static String[] makeRuleNames() {
		return new String[] {
			"start_rule", "expr", "term", "term_base", "term_tail", "variable_list", 
			"variable_list_tail", "term_list", "term_list_tail", "variable", "constant", 
			"constant_phi", "phi_tail", "comb_index", "cb_pair", "prove_base", "factorize"
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
			setState(34);
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
			setState(47);
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
				setState(37);
				((ExprContext)_localctx).term = term(u);
				 ((ExprContext)_localctx).value =  ((ExprContext)_localctx).term.value; 
				}
				break;
			case O_BRACKET2:
				enterOuterAlt(_localctx, 2);
				{
				setState(40);
				match(O_BRACKET2);
				setState(41);
				((ExprContext)_localctx).vl = variable_list();
				setState(42);
				match(ASSIGN);
				setState(43);
				((ExprContext)_localctx).el = term_list(u);
				setState(44);
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
			setState(49);
			((TermContext)_localctx).term_base = term_base(u);
			setState(50);
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
			setState(70);
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
				setState(53);
				((Term_baseContext)_localctx).constant = constant(u);
				 ((Term_baseContext)_localctx).value =  ((Term_baseContext)_localctx).constant.value; 
				}
				break;
			case X:
				enterOuterAlt(_localctx, 2);
				{
				setState(56);
				((Term_baseContext)_localctx).variable = variable();
				 ((Term_baseContext)_localctx).value =  ((Term_baseContext)_localctx).variable.value; 
				}
				break;
			case LAMBDA:
				enterOuterAlt(_localctx, 3);
				{
				setState(59);
				match(LAMBDA);
				setState(60);
				((Term_baseContext)_localctx).v = variable();
				setState(61);
				match(PERIOD);
				setState(62);
				((Term_baseContext)_localctx).e1 = term(u);
				 ((Term_baseContext)_localctx).value =  new Bracket(((Term_baseContext)_localctx).v.value, ((Term_baseContext)_localctx).e1.value); 
				}
				break;
			case O_PAR:
				enterOuterAlt(_localctx, 4);
				{
				setState(65);
				match(O_PAR);
				setState(66);
				((Term_baseContext)_localctx).term = term(u);
				setState(67);
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
			setState(77);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,2,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(72);
				((Term_tailContext)_localctx).term_base = term_base(u);
				setState(73);
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
			setState(79);
			((Variable_listContext)_localctx).variable = variable();
			setState(80);
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
			setState(88);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case COMMA:
				enterOuterAlt(_localctx, 1);
				{
				setState(83);
				match(COMMA);
				setState(84);
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
			setState(90);
			((Term_listContext)_localctx).term = term(u);
			setState(91);
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
			setState(99);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case COMMA:
				enterOuterAlt(_localctx, 1);
				{
				setState(94);
				match(COMMA);
				setState(95);
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
			setState(101);
			match(X);
			setState(102);
			((VariableContext)_localctx).DIGITS = match(DIGITS);
			setState(103);
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
			setState(120);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case C:
				enterOuterAlt(_localctx, 1);
				{
				setState(106);
				match(C);
				setState(107);
				((ConstantContext)_localctx).DIGITS = match(DIGITS);
				setState(108);
				match(C_BRACKET);
				 int index = Integer.parseInt((((ConstantContext)_localctx).DIGITS!=null?((ConstantContext)_localctx).DIGITS.getText():null));
				                          ((ConstantContext)_localctx).value =  new Const(index ,"c_{"+index+"}");
				                        
				}
				break;
			case EQUAL:
				enterOuterAlt(_localctx, 2);
				{
				setState(110);
				((ConstantContext)_localctx).EQUAL = match(EQUAL);
				 String cons = (((ConstantContext)_localctx).EQUAL!=null?((ConstantContext)_localctx).EQUAL.getText():null) ; // Take string format of the constant
				                          ((ConstantContext)_localctx).value =  new Const(0 ,cons);
				                        
				}
				break;
			case TRUE:
				enterOuterAlt(_localctx, 3);
				{
				setState(112);
				((ConstantContext)_localctx).TRUE = match(TRUE);
				 String cons = (((ConstantContext)_localctx).TRUE!=null?((ConstantContext)_localctx).TRUE.getText():null) ; // Take string format of the constant
				                          ((ConstantContext)_localctx).value =  new Const(-1 ,cons);
				                        
				}
				break;
			case PHI:
				enterOuterAlt(_localctx, 4);
				{
				setState(114);
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
				setState(117);
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
			setState(122);
			match(PHI);
			setState(123);
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
			setState(133);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case K:
				enterOuterAlt(_localctx, 1);
				{
				setState(126);
				match(K);
				setState(127);
				match(C_BRACKET);
				 ((Phi_tailContext)_localctx).value =  new Const("\\Phi_{K}"); 
				}
				break;
			case CB:
			case O_PAR:
			case C_BRACKET:
				enterOuterAlt(_localctx, 2);
				{
				setState(129);
				((Phi_tailContext)_localctx).comb_index = comb_index();
				setState(130);
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
			setState(143);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case O_PAR:
				enterOuterAlt(_localctx, 1);
				{
				setState(135);
				((Comb_indexContext)_localctx).cb_pair = cb_pair();
				((Comb_indexContext)_localctx).value =  new ListaInd(((Comb_indexContext)_localctx).cb_pair.value);
				}
				break;
			case CB:
				enterOuterAlt(_localctx, 2);
				{
				setState(138);
				((Comb_indexContext)_localctx).CB = match(CB);
				setState(139);
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
			setState(145);
			match(O_PAR);
			setState(146);
			((Cb_pairContext)_localctx).c1 = comb_index();
			setState(147);
			match(COMMA);
			setState(148);
			((Cb_pairContext)_localctx).c2 = comb_index();
			setState(149);
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
		public Token d;
		public FactorizeContext factorize;
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
		public FactorizeContext factorize() {
			return getRuleContext(FactorizeContext.class,0);
		}
		public TerminalNode DIGITS() { return getToken(CombParser.DIGITS, 0); }
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
			setState(180);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case I:
				enterOuterAlt(_localctx, 1);
				{
				setState(152);
				match(I);
				setState(153);
				((Prove_baseContext)_localctx).expr = expr(u);
				setState(154);
				match(C_BRACKET);
				 ((Prove_baseContext)_localctx).value =  new TypedI((Sust) ((Prove_baseContext)_localctx).expr.value); 
				}
				break;
			case L:
				enterOuterAlt(_localctx, 2);
				{
				setState(157);
				match(L);
				setState(158);
				((Prove_baseContext)_localctx).expr = expr(u);
				setState(159);
				match(C_BRACKET);
				 ((Prove_baseContext)_localctx).value =  new TypedL((Bracket) ((Prove_baseContext)_localctx).expr.value); 
				}
				break;
			case S:
				enterOuterAlt(_localctx, 3);
				{
				setState(162);
				match(S);
				setState(163);
				((Prove_baseContext)_localctx).expr = expr(u);
				setState(164);
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
				setState(167);
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
				setState(169);
				match(A);
				setState(170);
				((Prove_baseContext)_localctx).expr = expr(u);
				setState(171);
				match(C_BRACKET);
				 ((Prove_baseContext)_localctx).value =  (u!=null ? new TypedA(((Prove_baseContext)_localctx).expr.value,u) : new TypedA(((Prove_baseContext)_localctx).expr.value)); 
				}
				break;
			case M:
				enterOuterAlt(_localctx, 6);
				{
				setState(174);
				match(M);
				setState(175);
				((Prove_baseContext)_localctx).d = match(DIGITS);
				setState(176);
				match(EXP);
				setState(177);
				((Prove_baseContext)_localctx).factorize = factorize();
				 
				                            int id;
				                            id = Integer.parseInt((((Prove_baseContext)_localctx).d!=null?((Prove_baseContext)_localctx).d.getText():null));
				                            if (((Prove_baseContext)_localctx).factorize.value == null)
				                               ((Prove_baseContext)_localctx).value =  new M(id, "0");
				                            else
				                               ((Prove_baseContext)_localctx).value =  new M(id, ((Prove_baseContext)_localctx).factorize.value);
				                        
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

	public static class FactorizeContext extends ParserRuleContext {
		public String value;
		public Token d;
		public TerminalNode C_BRACKET() { return getToken(CombParser.C_BRACKET, 0); }
		public TerminalNode DIGITS() { return getToken(CombParser.DIGITS, 0); }
		public FactorizeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_factorize; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CombListener ) ((CombListener)listener).enterFactorize(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CombListener ) ((CombListener)listener).exitFactorize(this);
		}
	}

	public final FactorizeContext factorize() throws RecognitionException {
		FactorizeContext _localctx = new FactorizeContext(_ctx, getState());
		enterRule(_localctx, 32, RULE_factorize);
		try {
			setState(187);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case DIGITS:
				enterOuterAlt(_localctx, 1);
				{
				setState(182);
				((FactorizeContext)_localctx).d = match(DIGITS);
				setState(183);
				match(C_BRACKET);
				((FactorizeContext)_localctx).value =  (((FactorizeContext)_localctx).d!=null?((FactorizeContext)_localctx).d.getText():null); 
				}
				break;
			case C_BRACKET:
				enterOuterAlt(_localctx, 2);
				{
				setState(185);
				match(C_BRACKET);
				((FactorizeContext)_localctx).value =  null; 
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
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\3\33\u00c0\4\2\t\2"+
		"\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4\13"+
		"\t\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22\t\22"+
		"\3\2\3\2\3\2\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\5\3\62\n\3\3\4\3"+
		"\4\3\4\3\4\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5"+
		"\3\5\3\5\5\5I\n\5\3\6\3\6\3\6\3\6\3\6\5\6P\n\6\3\7\3\7\3\7\3\7\3\b\3\b"+
		"\3\b\3\b\3\b\5\b[\n\b\3\t\3\t\3\t\3\t\3\n\3\n\3\n\3\n\3\n\5\nf\n\n\3\13"+
		"\3\13\3\13\3\13\3\13\3\f\3\f\3\f\3\f\3\f\3\f\3\f\3\f\3\f\3\f\3\f\3\f\3"+
		"\f\3\f\5\f{\n\f\3\r\3\r\3\r\3\r\3\16\3\16\3\16\3\16\3\16\3\16\3\16\5\16"+
		"\u0088\n\16\3\17\3\17\3\17\3\17\3\17\3\17\3\17\3\17\5\17\u0092\n\17\3"+
		"\20\3\20\3\20\3\20\3\20\3\20\3\20\3\21\3\21\3\21\3\21\3\21\3\21\3\21\3"+
		"\21\3\21\3\21\3\21\3\21\3\21\3\21\3\21\3\21\3\21\3\21\3\21\3\21\3\21\3"+
		"\21\3\21\3\21\3\21\3\21\3\21\3\21\5\21\u00b7\n\21\3\22\3\22\3\22\3\22"+
		"\3\22\5\22\u00be\n\22\3\22\2\2\23\2\4\6\b\n\f\16\20\22\24\26\30\32\34"+
		"\36 \"\2\2\2\u00c2\2$\3\2\2\2\4\61\3\2\2\2\6\63\3\2\2\2\bH\3\2\2\2\nO"+
		"\3\2\2\2\fQ\3\2\2\2\16Z\3\2\2\2\20\\\3\2\2\2\22e\3\2\2\2\24g\3\2\2\2\26"+
		"z\3\2\2\2\30|\3\2\2\2\32\u0087\3\2\2\2\34\u0091\3\2\2\2\36\u0093\3\2\2"+
		"\2 \u00b6\3\2\2\2\"\u00bd\3\2\2\2$%\5\4\3\2%&\b\2\1\2&\3\3\2\2\2\'(\5"+
		"\6\4\2()\b\3\1\2)\62\3\2\2\2*+\7\21\2\2+,\5\f\7\2,-\7\24\2\2-.\5\20\t"+
		"\2./\7\22\2\2/\60\b\3\1\2\60\62\3\2\2\2\61\'\3\2\2\2\61*\3\2\2\2\62\5"+
		"\3\2\2\2\63\64\5\b\5\2\64\65\5\n\6\2\65\66\b\4\1\2\66\7\3\2\2\2\678\5"+
		"\26\f\289\b\5\1\29I\3\2\2\2:;\5\24\13\2;<\b\5\1\2<I\3\2\2\2=>\7\t\2\2"+
		">?\5\24\13\2?@\7\n\2\2@A\5\6\4\2AB\b\5\1\2BI\3\2\2\2CD\7\r\2\2DE\5\6\4"+
		"\2EF\7\16\2\2FG\b\5\1\2GI\3\2\2\2H\67\3\2\2\2H:\3\2\2\2H=\3\2\2\2HC\3"+
		"\2\2\2I\t\3\2\2\2JK\5\b\5\2KL\5\n\6\2LM\b\6\1\2MP\3\2\2\2NP\b\6\1\2OJ"+
		"\3\2\2\2ON\3\2\2\2P\13\3\2\2\2QR\5\24\13\2RS\5\16\b\2ST\b\7\1\2T\r\3\2"+
		"\2\2UV\7\17\2\2VW\5\f\7\2WX\b\b\1\2X[\3\2\2\2Y[\b\b\1\2ZU\3\2\2\2ZY\3"+
		"\2\2\2[\17\3\2\2\2\\]\5\6\4\2]^\5\22\n\2^_\b\t\1\2_\21\3\2\2\2`a\7\17"+
		"\2\2ab\5\20\t\2bc\b\n\1\2cf\3\2\2\2df\b\n\1\2e`\3\2\2\2ed\3\2\2\2f\23"+
		"\3\2\2\2gh\7\5\2\2hi\7\3\2\2ij\7\20\2\2jk\b\13\1\2k\25\3\2\2\2lm\7\4\2"+
		"\2mn\7\3\2\2no\7\20\2\2o{\b\f\1\2pq\7\6\2\2q{\b\f\1\2rs\7\7\2\2s{\b\f"+
		"\1\2tu\5\30\r\2uv\b\f\1\2v{\3\2\2\2wx\5 \21\2xy\b\f\1\2y{\3\2\2\2zl\3"+
		"\2\2\2zp\3\2\2\2zr\3\2\2\2zt\3\2\2\2zw\3\2\2\2{\27\3\2\2\2|}\7\b\2\2}"+
		"~\5\32\16\2~\177\b\r\1\2\177\31\3\2\2\2\u0080\u0081\7\13\2\2\u0081\u0082"+
		"\7\20\2\2\u0082\u0088\b\16\1\2\u0083\u0084\5\34\17\2\u0084\u0085\7\20"+
		"\2\2\u0085\u0086\b\16\1\2\u0086\u0088\3\2\2\2\u0087\u0080\3\2\2\2\u0087"+
		"\u0083\3\2\2\2\u0088\33\3\2\2\2\u0089\u008a\5\36\20\2\u008a\u008b\b\17"+
		"\1\2\u008b\u0092\3\2\2\2\u008c\u008d\7\f\2\2\u008d\u008e\5\34\17\2\u008e"+
		"\u008f\b\17\1\2\u008f\u0092\3\2\2\2\u0090\u0092\b\17\1\2\u0091\u0089\3"+
		"\2\2\2\u0091\u008c\3\2\2\2\u0091\u0090\3\2\2\2\u0092\35\3\2\2\2\u0093"+
		"\u0094\7\r\2\2\u0094\u0095\5\34\17\2\u0095\u0096\7\17\2\2\u0096\u0097"+
		"\5\34\17\2\u0097\u0098\7\16\2\2\u0098\u0099\b\20\1\2\u0099\37\3\2\2\2"+
		"\u009a\u009b\7\27\2\2\u009b\u009c\5\4\3\2\u009c\u009d\7\20\2\2\u009d\u009e"+
		"\b\21\1\2\u009e\u00b7\3\2\2\2\u009f\u00a0\7\30\2\2\u00a0\u00a1\5\4\3\2"+
		"\u00a1\u00a2\7\20\2\2\u00a2\u00a3\b\21\1\2\u00a3\u00b7\3\2\2\2\u00a4\u00a5"+
		"\7\31\2\2\u00a5\u00a6\5\4\3\2\u00a6\u00a7\7\20\2\2\u00a7\u00a8\b\21\1"+
		"\2\u00a8\u00b7\3\2\2\2\u00a9\u00aa\7\32\2\2\u00aa\u00b7\b\21\1\2\u00ab"+
		"\u00ac\7\25\2\2\u00ac\u00ad\5\4\3\2\u00ad\u00ae\7\20\2\2\u00ae\u00af\b"+
		"\21\1\2\u00af\u00b7\3\2\2\2\u00b0\u00b1\7\26\2\2\u00b1\u00b2\7\3\2\2\u00b2"+
		"\u00b3\7\23\2\2\u00b3\u00b4\5\"\22\2\u00b4\u00b5\b\21\1\2\u00b5\u00b7"+
		"\3\2\2\2\u00b6\u009a\3\2\2\2\u00b6\u009f\3\2\2\2\u00b6\u00a4\3\2\2\2\u00b6"+
		"\u00a9\3\2\2\2\u00b6\u00ab\3\2\2\2\u00b6\u00b0\3\2\2\2\u00b7!\3\2\2\2"+
		"\u00b8\u00b9\7\3\2\2\u00b9\u00ba\7\20\2\2\u00ba\u00be\b\22\1\2\u00bb\u00bc"+
		"\7\20\2\2\u00bc\u00be\b\22\1\2\u00bd\u00b8\3\2\2\2\u00bd\u00bb\3\2\2\2"+
		"\u00be#\3\2\2\2\f\61HOZez\u0087\u0091\u00b6\u00bd";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}