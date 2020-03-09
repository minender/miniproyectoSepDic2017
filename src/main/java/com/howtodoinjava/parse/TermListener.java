// Generated from Term.g by ANTLR 4.8
package com.howtodoinjava.parse; 

import com.howtodoinjava.entity.Termino;
import com.howtodoinjava.entity.Simbolo;
import com.howtodoinjava.entity.TerminoId;
import com.howtodoinjava.lambdacalculo.*;
import com.howtodoinjava.service.TerminoManager;
import com.howtodoinjava.service.SimboloManager;

import java.util.Iterator;
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link TermParser}.
 */
public interface TermListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link TermParser#start_rule}.
	 * @param ctx the parse tree
	 */
	void enterStart_rule(TermParser.Start_ruleContext ctx);
	/**
	 * Exit a parse tree produced by {@link TermParser#start_rule}.
	 * @param ctx the parse tree
	 */
	void exitStart_rule(TermParser.Start_ruleContext ctx);
	/**
	 * Enter a parse tree produced by {@link TermParser#eq}.
	 * @param ctx the parse tree
	 */
	void enterEq(TermParser.EqContext ctx);
	/**
	 * Exit a parse tree produced by {@link TermParser#eq}.
	 * @param ctx the parse tree
	 */
	void exitEq(TermParser.EqContext ctx);
	/**
	 * Enter a parse tree produced by {@link TermParser#eqtail}.
	 * @param ctx the parse tree
	 */
	void enterEqtail(TermParser.EqtailContext ctx);
	/**
	 * Exit a parse tree produced by {@link TermParser#eqtail}.
	 * @param ctx the parse tree
	 */
	void exitEqtail(TermParser.EqtailContext ctx);
	/**
	 * Enter a parse tree produced by {@link TermParser#term}.
	 * @param ctx the parse tree
	 */
	void enterTerm(TermParser.TermContext ctx);
	/**
	 * Exit a parse tree produced by {@link TermParser#term}.
	 * @param ctx the parse tree
	 */
	void exitTerm(TermParser.TermContext ctx);
	/**
	 * Enter a parse tree produced by {@link TermParser#disyconjtail}.
	 * @param ctx the parse tree
	 */
	void enterDisyconjtail(TermParser.DisyconjtailContext ctx);
	/**
	 * Exit a parse tree produced by {@link TermParser#disyconjtail}.
	 * @param ctx the parse tree
	 */
	void exitDisyconjtail(TermParser.DisyconjtailContext ctx);
	/**
	 * Enter a parse tree produced by {@link TermParser#disyconj}.
	 * @param ctx the parse tree
	 */
	void enterDisyconj(TermParser.DisyconjContext ctx);
	/**
	 * Exit a parse tree produced by {@link TermParser#disyconj}.
	 * @param ctx the parse tree
	 */
	void exitDisyconj(TermParser.DisyconjContext ctx);
	/**
	 * Enter a parse tree produced by {@link TermParser#conctail}.
	 * @param ctx the parse tree
	 */
	void enterConctail(TermParser.ConctailContext ctx);
	/**
	 * Exit a parse tree produced by {@link TermParser#conctail}.
	 * @param ctx the parse tree
	 */
	void exitConctail(TermParser.ConctailContext ctx);
	/**
	 * Enter a parse tree produced by {@link TermParser#conc}.
	 * @param ctx the parse tree
	 */
	void enterConc(TermParser.ConcContext ctx);
	/**
	 * Exit a parse tree produced by {@link TermParser#conc}.
	 * @param ctx the parse tree
	 */
	void exitConc(TermParser.ConcContext ctx);
	/**
	 * Enter a parse tree produced by {@link TermParser#disytail}.
	 * @param ctx the parse tree
	 */
	void enterDisytail(TermParser.DisytailContext ctx);
	/**
	 * Exit a parse tree produced by {@link TermParser#disytail}.
	 * @param ctx the parse tree
	 */
	void exitDisytail(TermParser.DisytailContext ctx);
	/**
	 * Enter a parse tree produced by {@link TermParser#neq}.
	 * @param ctx the parse tree
	 */
	void enterNeq(TermParser.NeqContext ctx);
	/**
	 * Exit a parse tree produced by {@link TermParser#neq}.
	 * @param ctx the parse tree
	 */
	void exitNeq(TermParser.NeqContext ctx);
	/**
	 * Enter a parse tree produced by {@link TermParser#neqtail}.
	 * @param ctx the parse tree
	 */
	void enterNeqtail(TermParser.NeqtailContext ctx);
	/**
	 * Exit a parse tree produced by {@link TermParser#neqtail}.
	 * @param ctx the parse tree
	 */
	void exitNeqtail(TermParser.NeqtailContext ctx);
	/**
	 * Enter a parse tree produced by {@link TermParser#neg}.
	 * @param ctx the parse tree
	 */
	void enterNeg(TermParser.NegContext ctx);
	/**
	 * Exit a parse tree produced by {@link TermParser#neg}.
	 * @param ctx the parse tree
	 */
	void exitNeg(TermParser.NegContext ctx);
	/**
	 * Enter a parse tree produced by {@link TermParser#instantiate}.
	 * @param ctx the parse tree
	 */
	void enterInstantiate(TermParser.InstantiateContext ctx);
	/**
	 * Exit a parse tree produced by {@link TermParser#instantiate}.
	 * @param ctx the parse tree
	 */
	void exitInstantiate(TermParser.InstantiateContext ctx);
	/**
	 * Enter a parse tree produced by {@link TermParser#explist}.
	 * @param ctx the parse tree
	 */
	void enterExplist(TermParser.ExplistContext ctx);
	/**
	 * Exit a parse tree produced by {@link TermParser#explist}.
	 * @param ctx the parse tree
	 */
	void exitExplist(TermParser.ExplistContext ctx);
	/**
	 * Enter a parse tree produced by {@link TermParser#explisttail}.
	 * @param ctx the parse tree
	 */
	void enterExplisttail(TermParser.ExplisttailContext ctx);
	/**
	 * Exit a parse tree produced by {@link TermParser#explisttail}.
	 * @param ctx the parse tree
	 */
	void exitExplisttail(TermParser.ExplisttailContext ctx);
	/**
	 * Enter a parse tree produced by {@link TermParser#arguments}.
	 * @param ctx the parse tree
	 */
	void enterArguments(TermParser.ArgumentsContext ctx);
	/**
	 * Exit a parse tree produced by {@link TermParser#arguments}.
	 * @param ctx the parse tree
	 */
	void exitArguments(TermParser.ArgumentsContext ctx);
	/**
	 * Enter a parse tree produced by {@link TermParser#lambda}.
	 * @param ctx the parse tree
	 */
	void enterLambda(TermParser.LambdaContext ctx);
	/**
	 * Exit a parse tree produced by {@link TermParser#lambda}.
	 * @param ctx the parse tree
	 */
	void exitLambda(TermParser.LambdaContext ctx);
}