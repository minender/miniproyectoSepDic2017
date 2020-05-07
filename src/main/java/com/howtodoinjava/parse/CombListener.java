// Generated from Comb.g4 by ANTLR 4.8

	
package com.howtodoinjava.parse; 

import com.howtodoinjava.lambdacalculo.*;	
	
	

import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link CombParser}.
 */
public interface CombListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link CombParser#expr}.
	 * @param ctx the parse tree
	 */
	void enterExpr(CombParser.ExprContext ctx);
	/**
	 * Exit a parse tree produced by {@link CombParser#expr}.
	 * @param ctx the parse tree
	 */
	void exitExpr(CombParser.ExprContext ctx);
	/**
	 * Enter a parse tree produced by {@link CombParser#aux_expr}.
	 * @param ctx the parse tree
	 */
	void enterAux_expr(CombParser.Aux_exprContext ctx);
	/**
	 * Exit a parse tree produced by {@link CombParser#aux_expr}.
	 * @param ctx the parse tree
	 */
	void exitAux_expr(CombParser.Aux_exprContext ctx);
	/**
	 * Enter a parse tree produced by {@link CombParser#variable}.
	 * @param ctx the parse tree
	 */
	void enterVariable(CombParser.VariableContext ctx);
	/**
	 * Exit a parse tree produced by {@link CombParser#variable}.
	 * @param ctx the parse tree
	 */
	void exitVariable(CombParser.VariableContext ctx);
	/**
	 * Enter a parse tree produced by {@link CombParser#par_expr}.
	 * @param ctx the parse tree
	 */
	void enterPar_expr(CombParser.Par_exprContext ctx);
	/**
	 * Exit a parse tree produced by {@link CombParser#par_expr}.
	 * @param ctx the parse tree
	 */
	void exitPar_expr(CombParser.Par_exprContext ctx);
	/**
	 * Enter a parse tree produced by {@link CombParser#constant}.
	 * @param ctx the parse tree
	 */
	void enterConstant(CombParser.ConstantContext ctx);
	/**
	 * Exit a parse tree produced by {@link CombParser#constant}.
	 * @param ctx the parse tree
	 */
	void exitConstant(CombParser.ConstantContext ctx);
	/**
	 * Enter a parse tree produced by {@link CombParser#constant_phi}.
	 * @param ctx the parse tree
	 */
	void enterConstant_phi(CombParser.Constant_phiContext ctx);
	/**
	 * Exit a parse tree produced by {@link CombParser#constant_phi}.
	 * @param ctx the parse tree
	 */
	void exitConstant_phi(CombParser.Constant_phiContext ctx);
	/**
	 * Enter a parse tree produced by {@link CombParser#comb_index}.
	 * @param ctx the parse tree
	 */
	void enterComb_index(CombParser.Comb_indexContext ctx);
	/**
	 * Exit a parse tree produced by {@link CombParser#comb_index}.
	 * @param ctx the parse tree
	 */
	void exitComb_index(CombParser.Comb_indexContext ctx);
	/**
	 * Enter a parse tree produced by {@link CombParser#cb_pair}.
	 * @param ctx the parse tree
	 */
	void enterCb_pair(CombParser.Cb_pairContext ctx);
	/**
	 * Exit a parse tree produced by {@link CombParser#cb_pair}.
	 * @param ctx the parse tree
	 */
	void exitCb_pair(CombParser.Cb_pairContext ctx);
}