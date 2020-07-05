package com.howtodoinjava.parse;

import com.howtodoinjava.lambdacalculo.Term;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;


/**
* @author jean 11-05-2020
*/

public class ClientCompTester {
	
	public static void main(String[] args) throws IOException {
		
		CharStream in;
		CombLexer lexer;
		CommonTokenStream tokens;
		CombParser parser;
		
		try {
            BufferedReader br = new BufferedReader(new FileReader("/Users/capi/Desktop/mini_desktop/Universidad/MiniProyecto/git-miniproyecto/miniproyectoSepDic2017/src/main/java/com/howtodoinjava/parse/CasosDePrueba.txt"));
		    String line;
		    int line_no = 1;
		    while ((line = br.readLine()) != null) {
		    	line = line.replace("\'", "");
		    	
		    	in = CharStreams.fromString(line);
		    	
		    	lexer = new CombLexer(in);
		    	lexer.removeErrorListeners();
				lexer.addErrorListener(ThrowingErrorListener.INSTANCE);
				
				tokens = new CommonTokenStream(lexer);
				
				parser = new CombParser(tokens);
				parser.removeErrorListeners();
				parser.addErrorListener(ThrowingErrorListener.INSTANCE);
				
				// Try to parse
				try {		
					Term t = parser.start_rule().value;
                                        System.out.println();
					System.out.print(Integer.toString(line_no).concat(" GOOD"));
                                        System.out.println(" "+t.invBD().toStringFinal());
				// Catch the error and show it to the user
				}catch(Exception e) {
					System.out.println(Integer.toString(line_no).concat(" BAD"));
	
				}
		    	line_no++;
		    }
		}
                catch (Exception e) {;}
	}
}
