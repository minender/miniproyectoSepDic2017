// Generated from Comb.g4 by ANTLR 4.8

	
package com.howtodoinjava.parse; 

import com.howtodoinjava.lambdacalculo.*;	
import java.util.LinkedList;	
	

import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link CombParser}.
 */
public interface CombListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link CombParser#start_rule}.
	 * @param ctx the parse tree
	 */
	void enterStart_rule(CombParser.Start_ruleContext ctx);
	/**
	 * Exit a parse tree produced by {@link CombParser#start_rule}.
	 * @param ctx the parse tree
	 */
	void exitStart_rule(CombParser.Start_ruleContext ctx);
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
	 * Enter a parse tree produced by {@link CombParser#term}.
	 * @param ctx the parse tree
	 */
	void enterTerm(CombParser.TermContext ctx);
	/**
	 * Exit a parse tree produced by {@link CombParser#term}.
	 * @param ctx the parse tree
	 */
	void exitTerm(CombParser.TermContext ctx);
	/**
	 * Enter a parse tree produced by {@link CombParser#term_base}.
	 * @param ctx the parse tree
	 */
	void enterTerm_base(CombParser.Term_baseContext ctx);
	/**
	 * Exit a parse tree produced by {@link CombParser#term_base}.
	 * @param ctx the parse tree
	 */
	void exitTerm_base(CombParser.Term_baseContext ctx);
	/**
	 * Enter a parse tree produced by {@link CombParser#term_tail}.
	 * @param ctx the parse tree
	 */
	void enterTerm_tail(CombParser.Term_tailContext ctx);
	/**
	 * Exit a parse tree produced by {@link CombParser#term_tail}.
	 * @param ctx the parse tree
	 */
	void exitTerm_tail(CombParser.Term_tailContext ctx);
	/**
	 * Enter a parse tree produced by {@link CombParser#variable_list}.
	 * @param ctx the parse tree
	 */
	void enterVariable_list(CombParser.Variable_listContext ctx);
	/**
	 * Exit a parse tree produced by {@link CombParser#variable_list}.
	 * @param ctx the parse tree
	 */
	void exitVariable_list(CombParser.Variable_listContext ctx);
	/**
	 * Enter a parse tree produced by {@link CombParser#variable_list_tail}.
	 * @param ctx the parse tree
	 */
	void enterVariable_list_tail(CombParser.Variable_list_tailContext ctx);
	/**
	 * Exit a parse tree produced by {@link CombParser#variable_list_tail}.
	 * @param ctx the parse tree
	 */
	void exitVariable_list_tail(CombParser.Variable_list_tailContext ctx);
	/**
	 * Enter a parse tree produced by {@link CombParser#term_list}.
	 * @param ctx the parse tree
	 */
	void enterTerm_list(CombParser.Term_listContext ctx);
	/**
	 * Exit a parse tree produced by {@link CombParser#term_list}.
	 * @param ctx the parse tree
	 */
	void exitTerm_list(CombParser.Term_listContext ctx);
	/**
	 * Enter a parse tree produced by {@link CombParser#term_list_tail}.
	 * @param ctx the parse tree
	 */
	void enterTerm_list_tail(CombParser.Term_list_tailContext ctx);
	/**
	 * Exit a parse tree produced by {@link CombParser#term_list_tail}.
	 * @param ctx the parse tree
	 */
	void exitTerm_list_tail(CombParser.Term_list_tailContext ctx);
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
	 * Enter a parse tree produced by {@link CombParser#phi_tail}.
	 * @param ctx the parse tree
	 */
	void enterPhi_tail(CombParser.Phi_tailContext ctx);
	/**
	 * Exit a parse tree produced by {@link CombParser#phi_tail}.
	 * @param ctx the parse tree
	 */
	void exitPhi_tail(CombParser.Phi_tailContext ctx);
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
	/**
	 * Enter a parse tree produced by {@link CombParser#prove_base}.
	 * @param ctx the parse tree
	 */
	void enterProve_base(CombParser.Prove_baseContext ctx);
	/**
	 * Exit a parse tree produced by {@link CombParser#prove_base}.
	 * @param ctx the parse tree
	 */
	void exitProve_base(CombParser.Prove_baseContext ctx);
}