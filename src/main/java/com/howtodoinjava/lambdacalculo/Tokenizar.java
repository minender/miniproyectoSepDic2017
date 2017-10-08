package com.howtodoinjava.lambdacalculo;

import java.util.ArrayList;
import java.util.StringTokenizer;

/**
 *
 * @author shamuel
 */
public class Tokenizar {
    String name;
    ArrayList<String> vars;
    
    public Tokenizar() {
        vars = new ArrayList<String>();
    }

    public String getName() {
        return name;
    }

    public ArrayList<String> getVars() {
        return vars;
    }
    
    public void tokenizacion(String string){
    
        StringTokenizer token, subToken;
    
        token = new StringTokenizer(string, "(");
        name = token.nextToken();

        subToken = new StringTokenizer(token.nextToken().toString().replace(")", ""),",");    

        while( subToken.hasMoreElements()) {
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
