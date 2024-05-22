// Generated from .\Type.g4 by ANTLR 4.8

    
package com.calclogic.parse; 

import com.calclogic.lambdacalculo.*;   
    

import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link TypeParser}.
 */
public interface TypeListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link TypeParser#start_rule}.
	 * @param ctx the parse tree
	 */
	void enterStart_rule(TypeParser.Start_ruleContext ctx);
	/**
	 * Exit a parse tree produced by {@link TypeParser#start_rule}.
	 * @param ctx the parse tree
	 */
	void exitStart_rule(TypeParser.Start_ruleContext ctx);
	/**
	 * Enter a parse tree produced by {@link TypeParser#term}.
	 * @param ctx the parse tree
	 */
	void enterTerm(TypeParser.TermContext ctx);
	/**
	 * Exit a parse tree produced by {@link TypeParser#term}.
	 * @param ctx the parse tree
	 */
	void exitTerm(TypeParser.TermContext ctx);
	/**
	 * Enter a parse tree produced by {@link TypeParser#tail}.
	 * @param ctx the parse tree
	 */
	void enterTail(TypeParser.TailContext ctx);
	/**
	 * Exit a parse tree produced by {@link TypeParser#tail}.
	 * @param ctx the parse tree
	 */
	void exitTail(TypeParser.TailContext ctx);
	/**
	 * Enter a parse tree produced by {@link TypeParser#head}.
	 * @param ctx the parse tree
	 */
	void enterHead(TypeParser.HeadContext ctx);
	/**
	 * Exit a parse tree produced by {@link TypeParser#head}.
	 * @param ctx the parse tree
	 */
	void exitHead(TypeParser.HeadContext ctx);
}