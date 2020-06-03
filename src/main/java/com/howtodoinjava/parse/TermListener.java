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
	 * Enter a parse tree produced by {@link TermParser#lambda}.
	 * @param ctx the parse tree
	 */
	void enterLambda(TermParser.LambdaContext ctx);
	/**
	 * Exit a parse tree produced by {@link TermParser#lambda}.
	 * @param ctx the parse tree
	 */
	void exitLambda(TermParser.LambdaContext ctx);
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
	 * Enter a parse tree produced by {@link TermParser#arguments}.
	 * @param ctx the parse tree
	 */
	void enterArguments(TermParser.ArgumentsContext ctx);
	/**
	 * Exit a parse tree produced by {@link TermParser#arguments}.
	 * @param ctx the parse tree
	 */
	void exitArguments(TermParser.ArgumentsContext ctx);
}