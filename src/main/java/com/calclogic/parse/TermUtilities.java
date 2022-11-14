/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.parse;

import com.calclogic.entity.PredicadoId;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.lambdacalculo.Var;
import com.calclogic.service.PredicadoManager;
import com.calclogic.service.SimboloManager;
import java.util.ArrayList;
import java.util.List;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;

/**
 *
 * @author federico
 */
public class TermUtilities {
    
    public static Term getTerm(String input, PredicadoId id, PredicadoManager pm, SimboloManager sm) {
		
		// Feed the argument to the parser
		CharStream in = CharStreams.fromString(input);
		
		// Define the lexer for the input and edit its way of catching error
		TermLexer lexer = new TermLexer(in);
		lexer.removeErrorListeners();
		lexer.addErrorListener(ThrowingErrorListener.INSTANCE);
		
		// Generate tokens for the parser
		CommonTokenStream tokens = new CommonTokenStream(lexer);
		
		// Define the parser for the tokens and edit its way of catching error
		TermParser parser = new TermParser(tokens);
		parser.removeErrorListeners();
		parser.addErrorListener(ThrowingErrorListener.INSTANCE);
		
		// get the value of the parser 
                String[] boundVars = {""};
		Term t = parser.start_rule(id, pm, sm, boundVars).value;
		
		return t;
	}
    
    public static ArrayList<Object> instanciate(String input, PredicadoId id, PredicadoManager pm, SimboloManager sm) {
		
		// Feed the argument to the parser
		CharStream in = CharStreams.fromString(input);
		
		// Define the lexer for the input and edit its way of catching error
		TermLexer lexer = new TermLexer(in);
		lexer.removeErrorListeners();
		lexer.addErrorListener(ThrowingErrorListener.INSTANCE);
		
		// Generate tokens for the parser
		CommonTokenStream tokens = new CommonTokenStream(lexer);
		
		// Define the parser for the tokens and edit its way of catching error
		TermParser parser = new TermParser(tokens);
		parser.removeErrorListeners();
		parser.addErrorListener(ThrowingErrorListener.INSTANCE);
		
		// get the value of the parser 
                String[] boundVars = {""};
		ArrayList<Object> arr = parser.instantiate(id, pm, sm, boundVars).value;
		
		return arr;
	}
    
    public static Term lambda(String input, PredicadoId id, PredicadoManager pm, SimboloManager sm) {
		
		// Feed the argument to the parser
		CharStream in = CharStreams.fromString(input);
		
		// Define the lexer for the input and edit its way of catching error
		TermLexer lexer = new TermLexer(in);
		lexer.removeErrorListeners();
		lexer.addErrorListener(ThrowingErrorListener.INSTANCE);
		
		// Generate tokens for the parser
		CommonTokenStream tokens = new CommonTokenStream(lexer);
		
		// Define the parser for the tokens and edit its way of catching error
		TermParser parser = new TermParser(tokens);
		parser.removeErrorListeners();
		parser.addErrorListener(ThrowingErrorListener.INSTANCE);
		
		// get the value of the parser 
                String[] boundVars = {""};
		Term t = parser.lambda(id, pm, sm, boundVars).value;
		
		return t;
	}
    
        public static List<Var> arguments(String input) {
		
		// Feed the argument to the parser
		CharStream in = CharStreams.fromString(input);
		
		// Define the lexer for the input and edit its way of catching error
		TermLexer lexer = new TermLexer(in);
		lexer.removeErrorListeners();
		lexer.addErrorListener(ThrowingErrorListener.INSTANCE);
		
		// Generate tokens for the parser
		CommonTokenStream tokens = new CommonTokenStream(lexer);
		
		// Define the parser for the tokens and edit its way of catching error
		TermParser parser = new TermParser(tokens);
		parser.removeErrorListeners();
		parser.addErrorListener(ThrowingErrorListener.INSTANCE);
		
		// get the value of the parser 
		return parser.arguments().value;
	}
}
