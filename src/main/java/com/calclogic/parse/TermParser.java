// Generated from .\Term.g by ANTLR 4.8
package com.calclogic.parse; 

import com.calclogic.entity.Predicado;
import com.calclogic.entity.Simbolo;
import com.calclogic.entity.PredicadoId;
import com.calclogic.entity.Simbolo;
import com.calclogic.lambdacalculo.*;
import com.calclogic.service.PredicadoManager;
import com.calclogic.service.SimboloManager;
import org.antlr.v4.runtime.misc.Pair;
import java.util.Collections;
import java.util.ArrayList;
import java.util.HashSet;
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
		T__0=1, T__1=2, T__2=3, T__3=4, T__4=5, T__5=6, T__6=7, CAPITALLETTER=8, 
		LETTER=9, NUMBER=10, WORD=11, WHITESPACE=12;
	public static final int
		RULE_start_rule = 0, RULE_eq = 1, RULE_explist = 2, RULE_explisttail = 3, 
		RULE_lambda = 4, RULE_instantiate = 5, RULE_arguments = 6;
	private static String[] makeRuleNames() {
		return new String[] {
			"start_rule", "eq", "explist", "explisttail", "lambda", "instantiate", 
			"arguments"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, "'C'", "'('", "')'", "','", "'lambda'", "'.'", "':='"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, null, null, null, null, null, null, null, "CAPITALLETTER", "LETTER", 
			"NUMBER", "WORD", "WHITESPACE"
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
		public String[] st;
		public Term value;
		public EqContext eq;
		public EqContext eq() {
			return getRuleContext(EqContext.class,0);
		}
		public Start_ruleContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public Start_ruleContext(ParserRuleContext parent, int invokingState, PredicadoId id, PredicadoManager pm, SimboloManager sm, String[] st) {
			super(parent, invokingState);
			this.id = id;
			this.pm = pm;
			this.sm = sm;
			this.st = st;
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

	public final Start_ruleContext start_rule(PredicadoId id,PredicadoManager pm,SimboloManager sm,String[] st) throws RecognitionException {
		Start_ruleContext _localctx = new Start_ruleContext(_ctx, getState(), id, pm, sm, st);
		enterRule(_localctx, 0, RULE_start_rule);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(14);
			((Start_ruleContext)_localctx).eq = eq(id, pm, sm, st);
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
		public String[] st;
		public Term value;
		public Token NUMBER;
		public ExplistContext explist;
		public Token WORD;
		public Token CAPITALLETTER;
		public Token LETTER;
		public TerminalNode NUMBER() { return getToken(TermParser.NUMBER, 0); }
		public ExplistContext explist() {
			return getRuleContext(ExplistContext.class,0);
		}
		public TerminalNode WORD() { return getToken(TermParser.WORD, 0); }
		public TerminalNode CAPITALLETTER() { return getToken(TermParser.CAPITALLETTER, 0); }
		public TerminalNode LETTER() { return getToken(TermParser.LETTER, 0); }
		public EqContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public EqContext(ParserRuleContext parent, int invokingState, PredicadoId id, PredicadoManager pm, SimboloManager sm, String[] st) {
			super(parent, invokingState);
			this.id = id;
			this.pm = pm;
			this.sm = sm;
			this.st = st;
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

	public final EqContext eq(PredicadoId id,PredicadoManager pm,SimboloManager sm,String[] st) throws RecognitionException {
		EqContext _localctx = new EqContext(_ctx, getState(), id, pm, sm, st);
		enterRule(_localctx, 2, RULE_eq);
		try {
			setState(36);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,0,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(17);
				match(T__0);
				setState(18);
				((EqContext)_localctx).NUMBER = match(NUMBER);
				setState(19);
				match(T__1);
				setState(20);
				((EqContext)_localctx).explist = explist(id,pm,sm,st);
				setState(21);
				match(T__2);
				Term aux;
				                                               if (Integer.parseInt((((EqContext)_localctx).NUMBER!=null?((EqContext)_localctx).NUMBER.getText():null)) == sm.getPropFunApp() 
				                                                   || Integer.parseInt((((EqContext)_localctx).NUMBER!=null?((EqContext)_localctx).NUMBER.getText():null)) == sm.getTermFunApp()
				                                                  ) {
				                                                Iterator<Term> i = ((EqContext)_localctx).explist.value.iterator();
				                                                aux = i.next();
				                                                for(i = i; i.hasNext();)
				                                                   aux=new App(aux,i.next());
				                                               }
				                                               else {
				                                                Simbolo s = sm.getSimbolo(Integer.parseInt((((EqContext)_localctx).NUMBER!=null?((EqContext)_localctx).NUMBER.getText():null))); 
				                                                if (s == null)throw new IsNotInDBException(this,"");
				                                                int nArg = s.getArgumentos();
				                                                if (s.isQuantifier()) {
				                                                    ArrayList<Term> boundVars = new ArrayList<Term>();
				                                                    ArrayList<Term> unboundVars = new ArrayList<Term>();
				                                                    int j = 1;
				                                                    for(Iterator<Term> i = ((EqContext)_localctx).explist.value.iterator(); i.hasNext();) {
				                                                        if (j > nArg) {
				                                                            boundVars.add(i.next());
				                                                        }
				                                                        else {
				                                                            unboundVars.add(i.next());
				                                                        }
				                                                        j++;
				                                                    }
				                                                    Collections.reverse(boundVars);
				                                                    ArrayList<Term> abstractedTerms = new ArrayList<Term>();
				                                                    for (Term base_term: unboundVars) {
				                                                        Term t = base_term;
				                                                        for (Term var: boundVars) {
				                                                            if (st[0].equals(""))
				                                                                st[0] = "" + ((char) ((Var) var).indice);
				                                                            else
				                                                                st[0] = ((char) ((Var) var).indice) + "," + st[0];
				                                                            t = new Bracket((Var) var, t);
				                                                        }
				                                                        abstractedTerms.add(t);
				                                                    }
				                                                    aux = new Const(Integer.parseInt((((EqContext)_localctx).NUMBER!=null?((EqContext)_localctx).NUMBER.getText():null)),"c_{"+(((EqContext)_localctx).NUMBER!=null?((EqContext)_localctx).NUMBER.getText():null)+"}",
				                                                                     !s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad());
				                                                    for (Term t: abstractedTerms) {
				                                                        aux = new App(aux, t);
				                                                    }
				                                                }
				                                                else {
				                                                    if (((EqContext)_localctx).explist.value.size() != nArg)
				                                                      throw new NoViableAltException(this);
				                                                    aux = new Const(Integer.parseInt((((EqContext)_localctx).NUMBER!=null?((EqContext)_localctx).NUMBER.getText():null)),"c_{"+(((EqContext)_localctx).NUMBER!=null?((EqContext)_localctx).NUMBER.getText():null)+"}",
				                                                                         !s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad());
				                                                    for(Iterator<Term> i = ((EqContext)_localctx).explist.value.iterator(); i.hasNext();)
				                                                       aux=new App(aux,i.next());
				                                                }
				                                               }
				                                               
				                                               ((EqContext)_localctx).value =  aux;
				                                              
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(24);
				((EqContext)_localctx).WORD = match(WORD);
				setState(25);
				match(T__1);
				setState(26);
				((EqContext)_localctx).explist = explist(id,pm,sm,st);
				setState(27);
				match(T__2);
				id.setAlias((((EqContext)_localctx).WORD!=null?((EqContext)_localctx).WORD.getText():null)); 
				                                               Predicado preInBD=pm.getPredicado(id);
				                                               if(preInBD==null) {
				                                                 throw new IsNotInDBException(this,"");
				                                               } 
				                                               Term aux = preInBD.getTerm();
				                                               int nArg = preInBD.getArgumentos().split(",").length;
				                                               if (((EqContext)_localctx).explist.value.size() != nArg)
				                                                 throw new NoViableAltException(this);
				                                               for(Iterator<Term> i = ((EqContext)_localctx).explist.value.iterator(); i.hasNext();) 
				                                                  aux=new App(aux,i.next());
				                                               aux = aux.evaluar();
				                                               aux.setAlias(id.getAlias());
				                                               ((EqContext)_localctx).value = aux;
				                                              
				}
				break;
			case 3:
				enterOuterAlt(_localctx, 3);
				{
				setState(30);
				match(T__0);
				((EqContext)_localctx).value =  new Var((new Integer((int)'C')).intValue());
				}
				break;
			case 4:
				enterOuterAlt(_localctx, 4);
				{
				setState(32);
				((EqContext)_localctx).CAPITALLETTER = match(CAPITALLETTER);
				((EqContext)_localctx).value =  new Var((new Integer((int)(((EqContext)_localctx).CAPITALLETTER!=null?((EqContext)_localctx).CAPITALLETTER.getText():null).charAt(0))).intValue());
				}
				break;
			case 5:
				enterOuterAlt(_localctx, 5);
				{
				setState(34);
				((EqContext)_localctx).LETTER = match(LETTER);
				((EqContext)_localctx).value =  new Var((new Integer((int)(((EqContext)_localctx).LETTER!=null?((EqContext)_localctx).LETTER.getText():null).charAt(0))).intValue());
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

	public static class ExplistContext extends ParserRuleContext {
		public PredicadoId id;
		public PredicadoManager pm;
		public SimboloManager sm;
		public String[] st;
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
		public ExplistContext(ParserRuleContext parent, int invokingState, PredicadoId id, PredicadoManager pm, SimboloManager sm, String[] st) {
			super(parent, invokingState);
			this.id = id;
			this.pm = pm;
			this.sm = sm;
			this.st = st;
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

	public final ExplistContext explist(PredicadoId id,PredicadoManager pm,SimboloManager sm,String[] st) throws RecognitionException {
		ExplistContext _localctx = new ExplistContext(_ctx, getState(), id, pm, sm, st);
		enterRule(_localctx, 4, RULE_explist);
		try {
			setState(43);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__0:
			case CAPITALLETTER:
			case LETTER:
			case WORD:
				enterOuterAlt(_localctx, 1);
				{
				setState(38);
				((ExplistContext)_localctx).eq = eq(id,pm,sm,st);
				setState(39);
				((ExplistContext)_localctx).explisttail = explisttail(id,pm,sm,st);
				ArrayList<Term> aux = ((ExplistContext)_localctx).explisttail.value;
				                                               aux.add(0,((ExplistContext)_localctx).eq.value);
				                                               ((ExplistContext)_localctx).value =  aux;
				                                              
				}
				break;
			case EOF:
			case T__2:
				enterOuterAlt(_localctx, 2);
				{
				((ExplistContext)_localctx).value =  new ArrayList<Term>();
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

	public static class ExplisttailContext extends ParserRuleContext {
		public PredicadoId id;
		public PredicadoManager pm;
		public SimboloManager sm;
		public String[] st;
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
		public ExplisttailContext(ParserRuleContext parent, int invokingState, PredicadoId id, PredicadoManager pm, SimboloManager sm, String[] st) {
			super(parent, invokingState);
			this.id = id;
			this.pm = pm;
			this.sm = sm;
			this.st = st;
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

	public final ExplisttailContext explisttail(PredicadoId id,PredicadoManager pm,SimboloManager sm,String[] st) throws RecognitionException {
		ExplisttailContext _localctx = new ExplisttailContext(_ctx, getState(), id, pm, sm, st);
		enterRule(_localctx, 6, RULE_explisttail);
		try {
			setState(51);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__3:
				enterOuterAlt(_localctx, 1);
				{
				setState(45);
				match(T__3);
				setState(46);
				((ExplisttailContext)_localctx).eq = eq(id,pm,sm,st);
				setState(47);
				((ExplisttailContext)_localctx).tail7 = explisttail(id,pm,sm,st);
				ArrayList<Term> aux = ((ExplisttailContext)_localctx).tail7.value;
				                                               aux.add(0,((ExplisttailContext)_localctx).eq.value);
				                                               ((ExplisttailContext)_localctx).value = aux;
				                                              
				}
				break;
			case EOF:
			case T__2:
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

	public static class LambdaContext extends ParserRuleContext {
		public PredicadoId id;
		public PredicadoManager pm;
		public SimboloManager sm;
		public String[] st;
		public Term value;
		public Token LETTER;
		public EqContext eq;
		public TerminalNode LETTER() { return getToken(TermParser.LETTER, 0); }
		public EqContext eq() {
			return getRuleContext(EqContext.class,0);
		}
		public LambdaContext(ParserRuleContext parent, int invokingState) { super(parent, invokingState); }
		public LambdaContext(ParserRuleContext parent, int invokingState, PredicadoId id, PredicadoManager pm, SimboloManager sm, String[] st) {
			super(parent, invokingState);
			this.id = id;
			this.pm = pm;
			this.sm = sm;
			this.st = st;
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

	public final LambdaContext lambda(PredicadoId id,PredicadoManager pm,SimboloManager sm,String[] st) throws RecognitionException {
		LambdaContext _localctx = new LambdaContext(_ctx, getState(), id, pm, sm, st);
		enterRule(_localctx, 8, RULE_lambda);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(53);
			match(T__4);
			setState(54);
			((LambdaContext)_localctx).LETTER = match(LETTER);
			setState(55);
			match(T__5);
			setState(56);
			((LambdaContext)_localctx).eq = eq(id,pm,sm,st);
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

	public static class InstantiateContext extends ParserRuleContext {
		public PredicadoId id;
		public PredicadoManager pm;
		public SimboloManager sm;
		public String[] st;
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
		public InstantiateContext(ParserRuleContext parent, int invokingState, PredicadoId id, PredicadoManager pm, SimboloManager sm, String[] st) {
			super(parent, invokingState);
			this.id = id;
			this.pm = pm;
			this.sm = sm;
			this.st = st;
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

	public final InstantiateContext instantiate(PredicadoId id,PredicadoManager pm,SimboloManager sm,String[] st) throws RecognitionException {
		InstantiateContext _localctx = new InstantiateContext(_ctx, getState(), id, pm, sm, st);
		enterRule(_localctx, 10, RULE_instantiate);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(59);
			((InstantiateContext)_localctx).arguments = arguments();
			setState(60);
			match(T__6);
			setState(61);
			((InstantiateContext)_localctx).explist = explist(id,pm,sm,st);
			ArrayList<Object> arr=new ArrayList<Object>();
			                                                  ArrayList<Var> args=new ArrayList<Var>();
			                                                  ArrayList<Term> arguments = ((InstantiateContext)_localctx).arguments.value;
			                                                  ArrayList<Term> explist = ((InstantiateContext)_localctx).explist.value;
			                                               if (arguments.size() != explist.size())
			                                                 throw new NoViableAltException(this);
			                                               for (int i=0; i<arguments.size(); i++){
			                                                 if (arguments.get(i) instanceof Var)
			                                                    args.add((Var)arguments.get(i));
			                                                 else{
			                                                    args.add((Var)((App)arguments.get(i)).p);
			                                                    Term t = new Bracket((Var)((App)arguments.get(i)).q,explist.get(i));
			                                                    explist.set(i,t);
			                                                 }
			                                               }
			                                               arr.add(args);
			                                               arr.add(explist);
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

	public static class ArgumentsContext extends ParserRuleContext {
		public ArrayList<Term> value;
		public Token L;
		public ArgumentsContext arg;
		public Token M;
		public Token L2;
		public List<TerminalNode> LETTER() { return getTokens(TermParser.LETTER); }
		public TerminalNode LETTER(int i) {
			return getToken(TermParser.LETTER, i);
		}
		public List<TerminalNode> CAPITALLETTER() { return getTokens(TermParser.CAPITALLETTER); }
		public TerminalNode CAPITALLETTER(int i) {
			return getToken(TermParser.CAPITALLETTER, i);
		}
		public ArgumentsContext arguments() {
			return getRuleContext(ArgumentsContext.class,0);
		}
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
		enterRule(_localctx, 12, RULE_arguments);
		int _la;
		try {
			setState(85);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,3,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(65);
				((ArgumentsContext)_localctx).L = _input.LT(1);
				_la = _input.LA(1);
				if ( !(_la==CAPITALLETTER || _la==LETTER) ) {
					((ArgumentsContext)_localctx).L = (Token)_errHandler.recoverInline(this);
				}
				else {
					if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
					_errHandler.reportMatch(this);
					consume();
				}
				ArrayList<Term> list=new ArrayList<Term>();
				                                                            Var v=new Var((new Integer((((ArgumentsContext)_localctx).L!=null?((ArgumentsContext)_localctx).L.getText():null).charAt(0))).intValue());
				                                                            list.add(0,v);
				                                                            ((ArgumentsContext)_localctx).value =  list;
				                                                           
				}
				break;
			case 3:
				enterOuterAlt(_localctx, 3);
				{
				setState(67);
				((ArgumentsContext)_localctx).L = _input.LT(1);
				_la = _input.LA(1);
				if ( !(_la==CAPITALLETTER || _la==LETTER) ) {
					((ArgumentsContext)_localctx).L = (Token)_errHandler.recoverInline(this);
				}
				else {
					if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
					_errHandler.reportMatch(this);
					consume();
				}
				setState(68);
				match(T__3);
				setState(69);
				((ArgumentsContext)_localctx).arg = arguments();
				ArrayList<Term> aux=((ArgumentsContext)_localctx).arg.value; 
				                                                            Var v=new Var((new Integer((int)(((ArgumentsContext)_localctx).L!=null?((ArgumentsContext)_localctx).L.getText():null).charAt(0))).intValue());
				                                                            aux.add(0,v); 
				                                                            ((ArgumentsContext)_localctx).value = aux;
				                                                           
				}
				break;
			case 4:
				enterOuterAlt(_localctx, 4);
				{
				setState(72);
				((ArgumentsContext)_localctx).L = _input.LT(1);
				_la = _input.LA(1);
				if ( !(_la==CAPITALLETTER || _la==LETTER) ) {
					((ArgumentsContext)_localctx).L = (Token)_errHandler.recoverInline(this);
				}
				else {
					if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
					_errHandler.reportMatch(this);
					consume();
				}
				setState(73);
				match(T__1);
				setState(74);
				((ArgumentsContext)_localctx).M = _input.LT(1);
				_la = _input.LA(1);
				if ( !(_la==CAPITALLETTER || _la==LETTER) ) {
					((ArgumentsContext)_localctx).M = (Token)_errHandler.recoverInline(this);
				}
				else {
					if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
					_errHandler.reportMatch(this);
					consume();
				}
				setState(75);
				match(T__2);
				setState(76);
				match(T__3);
				setState(77);
				((ArgumentsContext)_localctx).arg = arguments();
				ArrayList<Term> aux=((ArgumentsContext)_localctx).arg.value; 
				                                                            Var v=new Var((new Integer((int)(((ArgumentsContext)_localctx).L!=null?((ArgumentsContext)_localctx).L.getText():null).charAt(0))).intValue());
				                                                            Var v2=new Var((new Integer((int)(((ArgumentsContext)_localctx).M!=null?((ArgumentsContext)_localctx).M.getText():null).charAt(0))).intValue());
				                                                            aux.add(0,new App(v,v2)); 
				                                                            ((ArgumentsContext)_localctx).value = aux;
				                                                           
				}
				break;
			case 5:
				enterOuterAlt(_localctx, 5);
				{
				setState(80);
				((ArgumentsContext)_localctx).L = _input.LT(1);
				_la = _input.LA(1);
				if ( !(_la==CAPITALLETTER || _la==LETTER) ) {
					((ArgumentsContext)_localctx).L = (Token)_errHandler.recoverInline(this);
				}
				else {
					if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
					_errHandler.reportMatch(this);
					consume();
				}
				setState(81);
				match(T__1);
				setState(82);
				((ArgumentsContext)_localctx).L2 = _input.LT(1);
				_la = _input.LA(1);
				if ( !(_la==CAPITALLETTER || _la==LETTER) ) {
					((ArgumentsContext)_localctx).L2 = (Token)_errHandler.recoverInline(this);
				}
				else {
					if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
					_errHandler.reportMatch(this);
					consume();
				}
				setState(83);
				match(T__2);
				ArrayList<Term> list=new ArrayList<Term>();
				                                                            Var v=new Var((new Integer((((ArgumentsContext)_localctx).L!=null?((ArgumentsContext)_localctx).L.getText():null).charAt(0))).intValue());
				                                                            Var v2=new Var((new Integer((((ArgumentsContext)_localctx).L2!=null?((ArgumentsContext)_localctx).L2.getText():null).charAt(0))).intValue());
				                                                            list.add(0,new App(v,v2));
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

	public static final String _serializedATN =
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\3\16Z\4\2\t\2\4\3\t"+
		"\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\3\2\3\2\3\2\3\3\3\3\3\3\3\3"+
		"\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\5\3\'\n\3"+
		"\3\4\3\4\3\4\3\4\3\4\5\4.\n\4\3\5\3\5\3\5\3\5\3\5\3\5\5\5\66\n\5\3\6\3"+
		"\6\3\6\3\6\3\6\3\6\3\7\3\7\3\7\3\7\3\7\3\b\3\b\3\b\3\b\3\b\3\b\3\b\3\b"+
		"\3\b\3\b\3\b\3\b\3\b\3\b\3\b\3\b\3\b\3\b\3\b\3\b\3\b\5\bX\n\b\3\b\2\2"+
		"\t\2\4\6\b\n\f\16\2\3\3\2\n\13\2\\\2\20\3\2\2\2\4&\3\2\2\2\6-\3\2\2\2"+
		"\b\65\3\2\2\2\n\67\3\2\2\2\f=\3\2\2\2\16W\3\2\2\2\20\21\5\4\3\2\21\22"+
		"\b\2\1\2\22\3\3\2\2\2\23\24\7\3\2\2\24\25\7\f\2\2\25\26\7\4\2\2\26\27"+
		"\5\6\4\2\27\30\7\5\2\2\30\31\b\3\1\2\31\'\3\2\2\2\32\33\7\r\2\2\33\34"+
		"\7\4\2\2\34\35\5\6\4\2\35\36\7\5\2\2\36\37\b\3\1\2\37\'\3\2\2\2 !\7\3"+
		"\2\2!\'\b\3\1\2\"#\7\n\2\2#\'\b\3\1\2$%\7\13\2\2%\'\b\3\1\2&\23\3\2\2"+
		"\2&\32\3\2\2\2& \3\2\2\2&\"\3\2\2\2&$\3\2\2\2\'\5\3\2\2\2()\5\4\3\2)*"+
		"\5\b\5\2*+\b\4\1\2+.\3\2\2\2,.\b\4\1\2-(\3\2\2\2-,\3\2\2\2.\7\3\2\2\2"+
		"/\60\7\6\2\2\60\61\5\4\3\2\61\62\5\b\5\2\62\63\b\5\1\2\63\66\3\2\2\2\64"+
		"\66\b\5\1\2\65/\3\2\2\2\65\64\3\2\2\2\66\t\3\2\2\2\678\7\7\2\289\7\13"+
		"\2\29:\7\b\2\2:;\5\4\3\2;<\b\6\1\2<\13\3\2\2\2=>\5\16\b\2>?\7\t\2\2?@"+
		"\5\6\4\2@A\b\7\1\2A\r\3\2\2\2BX\3\2\2\2CD\t\2\2\2DX\b\b\1\2EF\t\2\2\2"+
		"FG\7\6\2\2GH\5\16\b\2HI\b\b\1\2IX\3\2\2\2JK\t\2\2\2KL\7\4\2\2LM\t\2\2"+
		"\2MN\7\5\2\2NO\7\6\2\2OP\5\16\b\2PQ\b\b\1\2QX\3\2\2\2RS\t\2\2\2ST\7\4"+
		"\2\2TU\t\2\2\2UV\7\5\2\2VX\b\b\1\2WB\3\2\2\2WC\3\2\2\2WE\3\2\2\2WJ\3\2"+
		"\2\2WR\3\2\2\2X\17\3\2\2\2\6&-\65W";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}