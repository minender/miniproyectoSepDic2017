/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.parse;

import com.calclogic.lambdacalculo.Term;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;

/**
 *
 * @author federico
 */
public class ClientProofMethodTester {
    	public static void main(String[] args) throws IOException {
		
		CharStream in;
		ProofMethodLexer lexer;
		CommonTokenStream tokens;
		ProofMethodParser parser;
		
		try {
            BufferedReader br = new BufferedReader(new FileReader("/home/federico/NetBeansProjects/Logica/miniproyectoSepDic2017/src/main/java/com/calclogic/parse/CasosDePruebaProofMethod.txt"));
		    String line;
		    int line_no = 1;
		    while ((line = br.readLine()) != null) {
		    	line = line.replace("\'", "");
		    	
		    	in = CharStreams.fromString(line);
		    	
		    	lexer = new ProofMethodLexer(in);
		    	lexer.removeErrorListeners();
				lexer.addErrorListener(ThrowingErrorListener.INSTANCE);
				
				tokens = new CommonTokenStream(lexer);
				
				parser = new ProofMethodParser(tokens);
				parser.removeErrorListeners();
				parser.addErrorListener(ThrowingErrorListener.INSTANCE);
				
				// Try to parse
				try {		
					Term t = parser.start_rule().value;
                                        System.out.println();
					System.out.print(Integer.toString(line_no).concat(" GOOD"));
                                        System.out.println(" "+t.toStringFinal());
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
