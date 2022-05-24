package com.calclogic.parse;

import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
//import org.springframework.stereotype.Component;

import com.calclogic.lambdacalculo.Term;
import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Const;
import com.calclogic.lambdacalculo.Var;

/**
* @author jean 11-05-2020
*/

public class CombUtilities {
	
	public static Term getTerm(String input) {
		
		// Feed the argument to the parser
		CharStream in = CharStreams.fromString(input);
		
		// Define the lexer for the input and edit its way of catching error
		CombLexer lexer = new CombLexer(in);
		lexer.removeErrorListeners();
		lexer.addErrorListener(ThrowingErrorListener.INSTANCE);
		
		// Generate tokens for the parser
		CommonTokenStream tokens = new CommonTokenStream(lexer);
		
		// Define the parser for the tokens and edit its way of catching error
		CombParser parser = new CombParser(tokens);
		parser.removeErrorListeners();
		parser.addErrorListener(ThrowingErrorListener.INSTANCE);
		
		// get the value of the parser 
		Term t = parser.start_rule().value;
		
		return t;
		
		
	}
        
	public static Term getTermForPrinting(String input, String variables) {
		// get the value of the parser 
		Term t = getTerm(input);
                Term arg1, arg2;
                arg1 = ((App)((App)t).p).q;
                arg2 = ((App)t).q;
                if (!variables.equals("")) {// if no variables you don't need make any reduction
                  String[] vars = variables.split(",");
                  for (int i=0; i<vars.length; i++) {
                    arg1 = new App(arg1,new Var((int)vars[i].trim().charAt(0)));
                    arg2 = new App(arg2,new Var((int)vars[i].trim().charAt(0)));
                  }
		  arg1 = arg1.evaluar();
                  arg2 = arg2.evaluar();
                }
                if (arg1 instanceof Const && ((Const)arg1).getCon().equals("T"))
                    t = arg2;
                else
                    t = new App(new App(new Const(1,"c_{1}"),arg1),arg2);
		return t;
	}
}
