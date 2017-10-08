/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.lambdacalculo;

import com.howtodoinjava.entity.TerminoId;
import com.howtodoinjava.parse.FOSchemeLexer;
import com.howtodoinjava.parse.FOSchemeParser;
import com.howtodoinjava.parse.IsNotInDBException;
import com.howtodoinjava.parse.TermLexer;
import com.howtodoinjava.parse.TermParser;
import com.howtodoinjava.service.TerminoManager;
import java.util.ArrayList;
import org.antlr.runtime.ANTLRStringStream;
import org.antlr.runtime.CommonTokenStream;
import org.antlr.runtime.RecognitionException;

/**
 *
 * @author shamuel
 */
public class MakeTerm {

    public MakeTerm() {
    }
    
    public Term makeTerm(String str){
        TerminoId terminoid = new TerminoId();
        terminoid.setLogin("admin");
        TerminoManager terminoManager = null;
        ANTLRStringStream in = new ANTLRStringStream(str);
        TermLexer lexer = new TermLexer(in);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        TermParser parser = new TermParser(tokens);
        Term term;
               
        try{  
            term = parser.start_rule(terminoid,terminoManager); 
            return term;
        }
        catch(IsNotInDBException e)
        {
            String hdr = parser.getErrorHeader(e);
            String msg = parser.getErrorMessage(e, TermParser.tokenNames);
        }
        catch(RecognitionException e)
        {
            String hdr = parser.getErrorHeader(e);
            String msg = parser.getErrorMessage(e, TermParser.tokenNames);
        }  
        return null;
    }
    
    public Term makeCuant(String str){
        TerminoId terminoid = null;
        TerminoManager terminoManager = null;
        ANTLRStringStream in = new ANTLRStringStream(str);
        //TermLexer lexer = new TermLexer(in);
        FOSchemeLexer lexer = new FOSchemeLexer(in);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        //TermParser parser = new TermParser(tokens);
        FOSchemeParser parser = new FOSchemeParser(tokens);
        Term term;
               
        try{  
            term = parser.start_rule(terminoid,terminoManager); 
            return term;
        }
        catch(IsNotInDBException e)
        {
            String hdr = parser.getErrorHeader(e);
            String msg = parser.getErrorMessage(e, TermParser.tokenNames);
        }
        catch(RecognitionException e)
        {
            String hdr = parser.getErrorHeader(e);
            String msg = parser.getErrorMessage(e, TermParser.tokenNames);
        }  
        return null;
    }
    
    
    public ArrayList<Object> makeInsta(String str){
        TerminoId terminoid = null;
        TerminoManager terminoManager = null;
        ANTLRStringStream in = new ANTLRStringStream(str);
        TermLexer lexer = new TermLexer(in);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        TermParser parser = new TermParser(tokens);
        ArrayList<Object> listObj;
               
        try{  
            listObj = parser.instantiate(terminoid,terminoManager); 
            return listObj;
        }
        catch(IsNotInDBException e)
        {
            String hdr = parser.getErrorHeader(e);
            String msg = parser.getErrorMessage(e, TermParser.tokenNames);
        }
        catch(RecognitionException e)
        {
            String hdr = parser.getErrorHeader(e);
            String msg = parser.getErrorMessage(e, TermParser.tokenNames);
        }  
        return null;
    }
    
    public Term makeApp(String izq, String der){      
        MakeTerm mk = new MakeTerm();
        Term v = mk.makeTerm(izq);
        Term v1 = mk.makeTerm(der);
        Term tty =  new App(new App(new Const("\\equiv"),v1), v);
        return tty;
    }
    
 
}
