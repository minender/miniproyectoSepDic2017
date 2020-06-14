package com.howtodoinjava.entity;

import java.util.ArrayList;

public abstract class notacionOwner {
	
	private String notacion;
	
	public String getNotacion() {
		return notacion;
	}

	public void setNotacion(String notacion) {
		this.notacion = notacion;
	}
	
	public String getNotacion_latex() {
		return "no_op";
	};
	
	/**
     * This method returns a list with the variables names of this symbol's
     * notation, for example for %(a1) %(op) %(a2) would return ["a1", "a2"]
     * @return ArrayList of variable names
     */
    public  ArrayList<String> getNotacionVariables(){
    	// Original notation
    	String notacion = this.getNotacion();
    	
    	int n = notacion.length();
    	ArrayList<String> result = new ArrayList<String>();;
    	
 
    	char currentChar;
    	String currentVar;
    	
    	for(int i = 0; i < n; i++){
    		
    		currentChar = notacion.charAt(i);
    		
    		if(currentChar == '%'){
    			
    			i = i + 2; // skip this '%(' 
    			currentChar = notacion.charAt(i);
    			currentVar = "";
    			
    			while(currentChar != ')'){
    				
    				currentVar += currentChar;
    				
    				i++;
    				currentChar = notacion.charAt(i);
    				if(i > n){
    					throw new IllegalArgumentException("Error some parentheses wasn't closed");
    				}
    				
    			}	
    			
    			if(!currentVar.equals("op")) {
    				result.add('\'' + currentVar + '\'');
    				
    			}
    			
    		}
    	}
    	
    	return result;
    }
    
    /**
     * @author jean
     * @param newVariables string that with which you want to replace the variables
     * @param extraBackSlash boolean that represents if you want to add another backslash 
     * to every backslash in the answer, this usually should be false but sometimes in jsp
     * views your first backslash will get consumed so you'll need another
     * @return String that represents this expresion in latex
     */
    public String fullLatexNotation(String newVariables, Boolean extraBackSlash) {
    	
    	// Original notation
    	String notacionString = this.getNotacion();
    	
    	// Final answer
    	String latexString;
    	
    	// If we are inserting a form input we need to know in order to add a proper id
    	boolean forminput = false;
    	String newId;
    
    	if( newVariables.length() > 11 && newVariables.substring(0, 10).equals("\\FormInput")) {
    		forminput = true;
    	}
    	
    	// List of char where we'll store the answer
    	StringBuilder result = new StringBuilder();
    	// Here the variable between %(_) will be stored
    	String currentVariable;
    	// Here were the variable start index is 
    	int variableStart;
    	
    	// Current char being studied
    	char currentChar;
    	
    	int n = notacionString.length();
    	
    	// Check each char of the notation
    	for (int i=0; i<n; i++) {
    		
    		currentChar =  notacionString.charAt(i);
    		
    		// If we find a % is the beginning of a variable
    		if(currentChar == '%') {
    			
    			// Mark the beginnig
    			variableStart = i;
    			
    			// Skip the rest of the variable
    			while( currentChar != ')') {
    				i++;
    				currentChar =  notacionString.charAt(i);
    				
    				// In case some par wasnt closed in the notation
    				if(i > n) {
    					throw new IllegalArgumentException("Error some parentheses wasn't closed");
    				}
    			}
    			
    			// Get the variable
    			currentVariable = notacionString.substring(variableStart, i+1);
    			
    			// If is an op we must get the latex notation of the symbol
    			if( currentVariable.equals("%(op)")) {
    				currentVariable = this.getNotacion_latex();
    			
    			// If not must be replaced with an empty box
    			}else {
    				currentVariable = newVariables;
    				
    				// In case we are seeing a forminput we must change its id
    				if(forminput) {
    					newId = "{" + notacionString.charAt(i-1) + "}";
    					currentVariable = currentVariable.replaceFirst("\\{.*\\}", newId);
    				}
    			}
    			
    			// Add the proper new variable
    			result.append(currentVariable);
    			
    		
    		// Else simply add the character to the result
    		}else{
    			
    			result.append(currentChar);
    		}
    		
    		
    	}
    	
    	latexString = result.toString();
    	
    	
    	// In case we need an extra backslash because jslt consumes our backslash we add it
    	if(extraBackSlash) {
    		
    		result = new StringBuilder();
    			
    		for(int i=0; i<latexString.length(); i++) {
    			currentChar = latexString.charAt(i);
    			if(currentChar == '\\') {
    				result.append('\\');
    			}
    			result.append(currentChar);
    		}
    		
    		latexString = result.toString();
    	}
    	
    	
    	return latexString;
    	
    }

	
}
