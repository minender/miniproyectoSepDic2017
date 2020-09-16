/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
 package com.calclogic.lambdacalculo;

import com.calclogic.entity.PredicadoId;
import com.calclogic.parse.IsNotInDBException;
import com.calclogic.parse.TermLexer;
import com.calclogic.parse.TermBaseListener;
import com.calclogic.parse.TermParser;
import com.calclogic.service.SimboloManager;
import com.calclogic.service.PredicadoManager;
import java.util.ArrayList;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.RecognitionException;

/**
 *
 * @author shamuel
 */
public class MakeTerm {

    public MakeTerm() {
    }
    
    public Term makeTerm(String str){
        PredicadoId terminoid = new PredicadoId();
        terminoid.setLogin("admin");
        PredicadoManager terminoManager = null;
        SimboloManager simboloManager = null;
        CharStream in = CharStreams.fromString(str);
        TermLexer lexer = new TermLexer(in);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        TermParser parser = new TermParser(tokens);
        parser.addParseListener(new TermBaseListener());
        Term term;
               
        try{  
            term = parser.start_rule(terminoid,terminoManager,simboloManager).value; 
            return term;
        }
        catch(IsNotInDBException e)
        {
            String hdr = parser.getErrorHeader(e);
            String msg = e.getMessage(); //parser.getErrorMessage(e, TermParser.tokenNames);
        }
        catch(RecognitionException e)
        {
            String hdr = parser.getErrorHeader(e);
            String msg = e.getMessage(); //parser.getErrorMessage(e, TermParser.tokenNames);
        }  
        return null;
    }
    
    public Term makeCuant(String str){
/*        TerminoId terminoid = null;
        TerminoManager terminoManager = null;
        ANTLRStringStream in = new ANTLRStringStream(str);
        //TermLexer lexer = new TermLexer(in);
        FOSchemeLexer lexer = new FOSchemeLexer(in);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        //TermParser parser = new TermParser(tokens);
        FOSchemeParser parser = new FOSchemeParser(tokens);
        Term term;
               
        try{  
            term = parser.start_rule(terminoid,terminoManager).value; 
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
        }  */
        return null;
    }
    
    public ArrayList<Object> makeInsta(String str){
        PredicadoId terminoid = null;
        PredicadoManager terminoManager = null;
        SimboloManager simboloManager = null;
        CharStream in = CharStreams.fromString(str);
        TermLexer lexer = new TermLexer(in);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        TermParser parser = new TermParser(tokens);
        parser.addParseListener(new TermBaseListener());
        ArrayList<Object> listObj;
               
        try{  
            listObj = parser.instantiate(terminoid,terminoManager,simboloManager).value; 
            return listObj;
        }
        catch(IsNotInDBException e)
        {
            String hdr = parser.getErrorHeader(e);
            String msg = e.getMessage(); //parser.getErrorMessage(e, TermParser.tokenNames);
        }
        catch(RecognitionException e)
        {
            String hdr = parser.getErrorHeader(e);
            String msg = e.getMessage(); //parser.getErrorMessage(e, TermParser.tokenNames);
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
