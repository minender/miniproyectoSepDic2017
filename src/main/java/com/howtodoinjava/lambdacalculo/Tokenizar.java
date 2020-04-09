package com.howtodoinjava.lambdacalculo;

import java.util.ArrayList;
import java.util.StringTokenizer;

/**
 *
 * @author shamuel
 */
public class Tokenizar {
    private String name;
    private String arguments;
    private ArrayList<String> vars;
    
    public Tokenizar() {
        vars = new ArrayList<String>();
    }

    public String getName() {
        return name;
    }
    
    public String getArguments() {
        return arguments;
    }

    public ArrayList<String> getVars() {
        return vars;
    }
    
    public void tokenizacion(String string){
    
        StringTokenizer token, subToken;
        
        token = new StringTokenizer(string, "(");
        name = token.nextToken();
        arguments = token.nextToken().toString().replace(")", "");

        subToken = new StringTokenizer(arguments,",");    

        while( subToken.hasMoreElements() ) {
           String aux = subToken.nextElement().toString();
           try{
               if ((aux.length() < 2) && !(aux.startsWith(" ")) ) {
                    vars.add(aux);
               }
            }catch(Exception e){
               System.out.println("ERROR: Introduzca nuevamente los datos");
            }
        }
    }
    
    public void tokenArgs(String string){
    
        StringTokenizer subToken;
        
        arguments = string;

        subToken = new StringTokenizer(arguments,",");    

        while( subToken.hasMoreElements() ) {
           String aux = subToken.nextElement().toString();
           try{
               if ((aux.length() < 2) && !(aux.startsWith(" ")) ) {
                    vars.add(aux);
               }
            }catch(Exception e){
               System.out.println("ERROR: Introduzca nuevamente los datos");
            }
        }
    }
    
}
