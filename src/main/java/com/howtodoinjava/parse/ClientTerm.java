/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.parse;

import com.howtodoinjava.entity.PredicadoId;
import java.util.List;

import org.antlr.v4.runtime.*;

import com.howtodoinjava.entity.Simbolo;
import com.howtodoinjava.service.PredicadoManager;
import com.howtodoinjava.service.SimboloManager;
import com.howtodoinjava.service.SimboloManagerImpl;
import org.springframework.beans.factory.annotation.Autowired;

/**
 *
 * @author federico
 */
public class ClientTerm {
	
    
    public static void main(String[] args) {
		
		
		// Only one argument is neccesary
	/*	if( args.length != 1) {
			System.out.print("<Usage> java ClientComp MyExpression ");
			System.exit(0);
		}
	*/	
		// Feed the argument to the parser
		CharStream in = CharStreams.fromString("C2(C19(C11(c,b),C11(c,a)),C19(b,a))");
		
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
                
                PredicadoId predicadoid2=new PredicadoId();
		
		// Try to parse
		try {		
			//System.out.println(parser.expr().value.toString()) ;
			System.out.println(parser.start_rule(predicadoid2,null,null).value.toStringFinal()) ;
		// Catch the error and show it to the user
		}catch(Exception e) {
			e.printStackTrace();
			System.exit(1);
		}

		// Success
		System.out.print("Parsed properly");
		
    }
}
