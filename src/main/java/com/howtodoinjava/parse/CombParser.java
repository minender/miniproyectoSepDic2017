// Generated from Comb.g4 by ANTLR 4.8

	
package com.howtodoinjava.parse; 

import com.howtodoinjava.lambdacalculo.*;	
	
	

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
		CONSTANT_C=1, PHI=2, K=3, CB=4, O_PAR=5, C_PAR=6, COMMA=7, C_BRACKET=8, 
		VARIABLE=9, WHITESPACE=10;
	public static final int
		RULE_expr = 0, RULE_aux_expr = 1, RULE_variable = 2, RULE_par_expr = 3, 
		RULE_constant = 4, RULE_constant_phi = 5, RULE_comb_index = 6, RULE_cb_pair = 7;
	private static String[] makeRuleNames() {
		return new String[] {
			"expr", "aux_expr", "variable", "par_expr", "constant", "constant_phi", 
			"comb_index", "cb_pair"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, null, "'\\Phi_{'", "'K'", null, "'('", "')'", "','", "'}'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, "CONSTANT_C", "PHI", "K", "CB", "O_PAR", "C_PAR", "COMMA", "C_BRACKET", 
			"VARIABLE", "WHITESPACE"
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

	public static class ExprContext extends ParserRuleContext {
		public Term value;
		public ExprContext e1;
		public Aux_exprContext aux_expr;
		public Aux_exprContext e2;
		public Aux_exprContext aux_expr() {
			return getRuleContext(Aux_exprContext.class,0);
		}
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public ExprContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
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

	public final ExprContext expr() throws RecognitionException {
		return expr(0);
	}

	private ExprContext expr(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		ExprContext _localctx = new ExprContext(_ctx, _parentState);
		ExprContext _prevctx = _localctx;
		int _startState = 0;
		enterRecursionRule(_localctx, 0, RULE_expr, _p);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			{
			setState(17);
			((ExprContext)_localctx).aux_expr = aux_expr();
			 ((ExprContext)_localctx).value =  ((ExprContext)_localctx).aux_expr.value; 
			}
			_ctx.stop = _input.LT(-1);
			setState(26);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,0,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					{
					_localctx = new ExprContext(_parentctx, _parentState);
					_localctx.e1 = _prevctx;
					_localctx.e1 = _prevctx;
					pushNewRecursionContext(_localctx, _startState, RULE_expr);
					setState(20);
					if (!(precpred(_ctx, 1))) throw new FailedPredicateException(this, "precpred(_ctx, 1)");
					setState(21);
					((ExprContext)_localctx).e2 = ((ExprContext)_localctx).aux_expr = aux_expr();
					 ((ExprContext)_localctx).value =  new App(((ExprContext)_localctx).e1.value, ((ExprContext)_localctx).e2.value); 
					}
					} 
				}
				setState(28);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,0,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	public static class Aux_exprContext extends ParserRuleContext {
		public Term value;
		public ConstantContext constant;
		public VariableContext variable;
		public Par_exprContext par_expr;
		public ConstantContext constant() {
			return getRuleContext(ConstantContext.class,0);
		}
		public VariableContext variable() {
			return getRuleContext(VariableContext.class,0);
		}
		public Par_exprContext par_expr() {
			return getRuleContext(Par_exprContext.class,0);
		}
		public Aux_exprContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_aux_expr; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CombListener ) ((CombListener)listener).enterAux_expr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CombListener ) ((CombListener)listener).exitAux_expr(this);
		}
	}

	public final Aux_exprContext aux_expr() throws RecognitionException {
		Aux_exprContext _localctx = new Aux_exprContext(_ctx, getState());
		enterRule(_localctx, 2, RULE_aux_expr);
		try {
			setState(38);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case CONSTANT_C:
			case PHI:
				enterOuterAlt(_localctx, 1);
				{
				setState(29);
				((Aux_exprContext)_localctx).constant = constant();
				 ((Aux_exprContext)_localctx).value =  ((Aux_exprContext)_localctx).constant.value; 
				}
				break;
			case VARIABLE:
				enterOuterAlt(_localctx, 2);
				{
				setState(32);
				((Aux_exprContext)_localctx).variable = variable();
				 ((Aux_exprContext)_localctx).value =  ((Aux_exprContext)_localctx).variable.value; 
				}
				break;
			case O_PAR:
				enterOuterAlt(_localctx, 3);
				{
				setState(35);
				((Aux_exprContext)_localctx).par_expr = par_expr();
				 ((Aux_exprContext)_localctx).value =  ((Aux_exprContext)_localctx).par_expr.value; 
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
		public Term value;
		public Token VARIABLE;
		public TerminalNode VARIABLE() { return getToken(CombParser.VARIABLE, 0); }
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
		enterRule(_localctx, 4, RULE_variable);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(40);
			((VariableContext)_localctx).VARIABLE = match(VARIABLE);
			String var = (((VariableContext)_localctx).VARIABLE!=null?((VariableContext)_localctx).VARIABLE.getText():null) ; // Take string format of the variable
										int index = Integer.parseInt(var.substring(3,var.length()-1));// Take only the the index of the variable
										((VariableContext)_localctx).value =  new Var(index);// Return a new Variable obeject with that index
										
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

	public static class Par_exprContext extends ParserRuleContext {
		public Term value;
		public ExprContext expr;
		public TerminalNode O_PAR() { return getToken(CombParser.O_PAR, 0); }
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public TerminalNode C_PAR() { return getToken(CombParser.C_PAR, 0); }
		public Par_exprContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_par_expr; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CombListener ) ((CombListener)listener).enterPar_expr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CombListener ) ((CombListener)listener).exitPar_expr(this);
		}
	}

	public final Par_exprContext par_expr() throws RecognitionException {
		Par_exprContext _localctx = new Par_exprContext(_ctx, getState());
		enterRule(_localctx, 6, RULE_par_expr);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(43);
			match(O_PAR);
			setState(44);
			((Par_exprContext)_localctx).expr = expr(0);
			setState(45);
			match(C_PAR);
			 ((Par_exprContext)_localctx).value =  ((Par_exprContext)_localctx).expr.value; 
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
		public Term value;
		public Token CONSTANT_C;
		public Constant_phiContext constant_phi;
		public TerminalNode CONSTANT_C() { return getToken(CombParser.CONSTANT_C, 0); }
		public Constant_phiContext constant_phi() {
			return getRuleContext(Constant_phiContext.class,0);
		}
		public ConstantContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
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

	public final ConstantContext constant() throws RecognitionException {
		ConstantContext _localctx = new ConstantContext(_ctx, getState());
		enterRule(_localctx, 8, RULE_constant);
		try {
			setState(53);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case CONSTANT_C:
				enterOuterAlt(_localctx, 1);
				{
				setState(48);
				((ConstantContext)_localctx).CONSTANT_C = match(CONSTANT_C);
				 ((ConstantContext)_localctx).value =  new Const((((ConstantContext)_localctx).CONSTANT_C!=null?((ConstantContext)_localctx).CONSTANT_C.getText():null));
				}
				break;
			case PHI:
				enterOuterAlt(_localctx, 2);
				{
				setState(50);
				((ConstantContext)_localctx).constant_phi = constant_phi();
				 ((ConstantContext)_localctx).value =  ((ConstantContext)_localctx).constant_phi.value;
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
		public Comb_indexContext comb_index;
		public TerminalNode PHI() { return getToken(CombParser.PHI, 0); }
		public TerminalNode K() { return getToken(CombParser.K, 0); }
		public TerminalNode C_BRACKET() { return getToken(CombParser.C_BRACKET, 0); }
		public Comb_indexContext comb_index() {
			return getRuleContext(Comb_indexContext.class,0);
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
		enterRule(_localctx, 10, RULE_constant_phi);
		try {
			setState(64);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,3,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(55);
				match(PHI);
				setState(56);
				match(K);
				setState(57);
				match(C_BRACKET);
				 ((Constant_phiContext)_localctx).value =  new Const("\\Phi_{K}"); 
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(59);
				match(PHI);
				setState(60);
				((Constant_phiContext)_localctx).comb_index = comb_index();
				setState(61);
				match(C_BRACKET);
				 ((Constant_phiContext)_localctx).value =  new Phi(); ((Phi)_localctx.value).ind=((Constant_phiContext)_localctx).comb_index.value;
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

	public static class Comb_indexContext extends ParserRuleContext {
		public ListaInd value;
		public Token CB;
		public Cb_pairContext cb_pair;
		public Comb_indexContext c1;
		public TerminalNode CB() { return getToken(CombParser.CB, 0); }
		public Cb_pairContext cb_pair() {
			return getRuleContext(Cb_pairContext.class,0);
		}
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
		enterRule(_localctx, 12, RULE_comb_index);
		try {
			setState(76);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,4,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(66);
				((Comb_indexContext)_localctx).CB = match(CB);
				((Comb_indexContext)_localctx).value =  new ListaInd(new ConstInd((((Comb_indexContext)_localctx).CB!=null?((Comb_indexContext)_localctx).CB.getText():null)));
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(68);
				((Comb_indexContext)_localctx).cb_pair = cb_pair();
				((Comb_indexContext)_localctx).value =  new ListaInd(((Comb_indexContext)_localctx).cb_pair.value);
				}
				break;
			case 3:
				enterOuterAlt(_localctx, 3);
				{
				setState(71);
				((Comb_indexContext)_localctx).CB = match(CB);
				setState(72);
				((Comb_indexContext)_localctx).c1 = comb_index();
				((Comb_indexContext)_localctx).value =  ((Comb_indexContext)_localctx).c1.value;// Take the ListaInd from c1 
													ConstInd cb = new ConstInd((((Comb_indexContext)_localctx).CB!=null?((Comb_indexContext)_localctx).CB.getText():null));// Crete a new c/b const
													_localctx.value.list.add(cb);// Add it to the new value
													_localctx.value.orden +=cb.orden;// update orden
													
				}
				break;
			case 4:
				enterOuterAlt(_localctx, 4);
				{
				((Comb_indexContext)_localctx).value =  new ListaInd();
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
		enterRule(_localctx, 14, RULE_cb_pair);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(78);
			match(O_PAR);
			setState(79);
			((Cb_pairContext)_localctx).c1 = comb_index();
			setState(80);
			match(COMMA);
			setState(81);
			((Cb_pairContext)_localctx).c2 = comb_index();
			setState(82);
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

	public boolean sempred(RuleContext _localctx, int ruleIndex, int predIndex) {
		switch (ruleIndex) {
		case 0:
			return expr_sempred((ExprContext)_localctx, predIndex);
		}
		return true;
	}
	private boolean expr_sempred(ExprContext _localctx, int predIndex) {
		switch (predIndex) {
		case 0:
			return precpred(_ctx, 1);
		}
		return true;
	}

	public static final String _serializedATN =
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\3\fX\4\2\t\2\4\3\t"+
		"\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\3\2\3\2\3\2\3\2\3\2"+
		"\3\2\3\2\3\2\7\2\33\n\2\f\2\16\2\36\13\2\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3"+
		"\3\3\3\5\3)\n\3\3\4\3\4\3\4\3\5\3\5\3\5\3\5\3\5\3\6\3\6\3\6\3\6\3\6\5"+
		"\68\n\6\3\7\3\7\3\7\3\7\3\7\3\7\3\7\3\7\3\7\5\7C\n\7\3\b\3\b\3\b\3\b\3"+
		"\b\3\b\3\b\3\b\3\b\3\b\5\bO\n\b\3\t\3\t\3\t\3\t\3\t\3\t\3\t\3\t\2\3\2"+
		"\n\2\4\6\b\n\f\16\20\2\2\2W\2\22\3\2\2\2\4(\3\2\2\2\6*\3\2\2\2\b-\3\2"+
		"\2\2\n\67\3\2\2\2\fB\3\2\2\2\16N\3\2\2\2\20P\3\2\2\2\22\23\b\2\1\2\23"+
		"\24\5\4\3\2\24\25\b\2\1\2\25\34\3\2\2\2\26\27\f\3\2\2\27\30\5\4\3\2\30"+
		"\31\b\2\1\2\31\33\3\2\2\2\32\26\3\2\2\2\33\36\3\2\2\2\34\32\3\2\2\2\34"+
		"\35\3\2\2\2\35\3\3\2\2\2\36\34\3\2\2\2\37 \5\n\6\2 !\b\3\1\2!)\3\2\2\2"+
		"\"#\5\6\4\2#$\b\3\1\2$)\3\2\2\2%&\5\b\5\2&\'\b\3\1\2\')\3\2\2\2(\37\3"+
		"\2\2\2(\"\3\2\2\2(%\3\2\2\2)\5\3\2\2\2*+\7\13\2\2+,\b\4\1\2,\7\3\2\2\2"+
		"-.\7\7\2\2./\5\2\2\2/\60\7\b\2\2\60\61\b\5\1\2\61\t\3\2\2\2\62\63\7\3"+
		"\2\2\638\b\6\1\2\64\65\5\f\7\2\65\66\b\6\1\2\668\3\2\2\2\67\62\3\2\2\2"+
		"\67\64\3\2\2\28\13\3\2\2\29:\7\4\2\2:;\7\5\2\2;<\7\n\2\2<C\b\7\1\2=>\7"+
		"\4\2\2>?\5\16\b\2?@\7\n\2\2@A\b\7\1\2AC\3\2\2\2B9\3\2\2\2B=\3\2\2\2C\r"+
		"\3\2\2\2DE\7\6\2\2EO\b\b\1\2FG\5\20\t\2GH\b\b\1\2HO\3\2\2\2IJ\7\6\2\2"+
		"JK\5\16\b\2KL\b\b\1\2LO\3\2\2\2MO\b\b\1\2ND\3\2\2\2NF\3\2\2\2NI\3\2\2"+
		"\2NM\3\2\2\2O\17\3\2\2\2PQ\7\7\2\2QR\5\16\b\2RS\7\t\2\2ST\5\16\b\2TU\7"+
		"\b\2\2UV\b\t\1\2V\21\3\2\2\2\7\34(\67BN";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}