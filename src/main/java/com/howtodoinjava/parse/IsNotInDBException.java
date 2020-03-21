/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.parse;

//import org.antlr.runtime.IntStream;
import org.antlr.v4.runtime.NoViableAltException;
import org.antlr.v4.runtime.Parser;
import org.antlr.v4.runtime.RecognitionException;

/**
 *
 * @author federico
 */
public class IsNotInDBException extends NoViableAltException {

    /**
     * message 
     */
    public String message=" no existe el t&eacute;rmino ";
    /**
     * Creates a new instance of
     * <code>IsNotInDBException</code> without detail message.
     */

    /**
     * Constructs an instance of
     * <code>IsNotInDBException</code> with the specified detail message.
     *
     * @param msg the detail message.
     */
    public IsNotInDBException(Parser recognizer, String message) {
        super(recognizer);
        this.message += message;
    }
    /*public IsNotInDBException(String grammarDecisionDescription,
								int decisionNumber,
								int stateNumber,
								IntStream input,
                                                                String message) {
        super(grammarDecisionDescription,decisionNumber,stateNumber, input);
        this.message += message;
    }*/
}
