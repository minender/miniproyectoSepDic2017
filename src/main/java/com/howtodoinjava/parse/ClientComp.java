package com.howtodoinjava.parse;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.misc.ParseCancellationException;

public class ClientComp {

	// Customized error handler class 
	// rescued from https://stackoverflow.com/questions/18132078/handling-errors-in-antlr4
	public static class ThrowingErrorListener extends BaseErrorListener {

		   public static final ThrowingErrorListener INSTANCE = new ThrowingErrorListener();

		   @Override
		   public void syntaxError(Recognizer<?, ?> recognizer, Object offendingSymbol, int line, int charPositionInLine, String msg, RecognitionException e)
		      throws ParseCancellationException {
		         throw new ParseCancellationException("line " + line + ":" + charPositionInLine + " " + msg);
		      }
	}
	
	public static void main(String[] args) {
		
		
		// Only one argument is neccesary
		if( args.length != 1) {
			System.out.print("<Usage> java ClientComp MyExpression ");
			System.exit(0);
		}
		
		// Feed the argument to the parser
		CharStream in = CharStreams.fromString(args[0]);
		
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
		
		// Try to parse
		try {		
			parser.expr();
		// Catch the error and show it to the user
		}catch(Exception e) {
			System.out.print(e.getMessage());
			System.exit(1);
		}

		// Success
		System.out.print("Parsed properly");
		
	}

}


