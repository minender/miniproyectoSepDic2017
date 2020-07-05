package com.howtodoinjava.parse;

import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.springframework.stereotype.Component;

import com.howtodoinjava.lambdacalculo.Term;

/**
* @author jean 11-05-2020
*/

@Component
public class CombUtilities {
	
	public CombUtilities() {
	}
	
	public Term getTerm(String input) {
		
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
}
