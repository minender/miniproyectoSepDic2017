// Generated from .\ProofMethod.g4 by ANTLR 4.8


package com.calclogic.parse;

import com.calclogic.lambdacalculo.Const;
import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Term;
import java.util.LinkedList;


import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link ProofMethodParser}.
 */
public interface ProofMethodListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link ProofMethodParser#start_rule}.
	 * @param ctx the parse tree
	 */
	void enterStart_rule(ProofMethodParser.Start_ruleContext ctx);
	/**
	 * Exit a parse tree produced by {@link ProofMethodParser#start_rule}.
	 * @param ctx the parse tree
	 */
	void exitStart_rule(ProofMethodParser.Start_ruleContext ctx);
	/**
	 * Enter a parse tree produced by {@link ProofMethodParser#method}.
	 * @param ctx the parse tree
	 */
	void enterMethod(ProofMethodParser.MethodContext ctx);
	/**
	 * Exit a parse tree produced by {@link ProofMethodParser#method}.
	 * @param ctx the parse tree
	 */
	void exitMethod(ProofMethodParser.MethodContext ctx);
	/**
	 * Enter a parse tree produced by {@link ProofMethodParser#method_tail}.
	 * @param ctx the parse tree
	 */
	void enterMethod_tail(ProofMethodParser.Method_tailContext ctx);
	/**
	 * Exit a parse tree produced by {@link ProofMethodParser#method_tail}.
	 * @param ctx the parse tree
	 */
	void exitMethod_tail(ProofMethodParser.Method_tailContext ctx);
	/**
	 * Enter a parse tree produced by {@link ProofMethodParser#method_base}.
	 * @param ctx the parse tree
	 */
	void enterMethod_base(ProofMethodParser.Method_baseContext ctx);
	/**
	 * Exit a parse tree produced by {@link ProofMethodParser#method_base}.
	 * @param ctx the parse tree
	 */
	void exitMethod_base(ProofMethodParser.Method_baseContext ctx);
}