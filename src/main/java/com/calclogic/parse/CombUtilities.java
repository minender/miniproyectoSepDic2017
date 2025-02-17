package com.calclogic.parse;

import com.calclogic.lambdacalculo.Phi;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
//import org.springframework.stereotype.Component;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.service.SimboloManager;

/**
* @author jean 11-05-2020
*/

public class CombUtilities {
	
	public static Term getTerm(String input, String usr, SimboloManager s) {
		
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
                
		Term t = null;
                if (s != null) {
                    Phi.stInd = 1;
                }//Phi.stInd = 1;
                    t = parser.start_rule(usr,s).value;
                    //if (t instanceof Phi) ((Phi)t).computeType();
		return t;
	}
}
