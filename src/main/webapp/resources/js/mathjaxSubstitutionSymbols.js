
/**
 * This function takes the id of a jaxSubstitutionDiv 
 * , removes wathever was on it, and creates a new fresh jaxSubstitutionDiv
 * based on a new variables list
 * @param newVariables string of variables for example "a,b,c"
 * @param rootId string id of the substitution div
 * @returns
 */
function setJaxSubstitutionVariables(newVariables, rootId){
	
	
	//IF THE LIST IS EMPTY JUST CLEAN THE DIV
	if(emptyString(newVariables)){
		cleanJaxSubstitution(rootId);
		return;
	}
	
	rootId = rootId + '.';
	
	//Array with the form ['x','y','z']
	window[rootId + '_variables']=newVariables.split(',');
	var variables = window[rootId + '_variables'];
	
	//Get the simbolo dicctionary defined within the jaxSubstitution tile
	var dictionarySym = window[rootId+'simboloDic'];
	
	//Get div where will put the mathjax divs
	var varsDivId = rootId+'VariablesDiv';
	var varsDiv = document.getElementById(varsDivId);
	
	
	var id;
	var newDiv;
	varsDiv.innerHTML = '&nbsp;&nbsp;'+newVariables+' := ';
	for(var i = 0; i < variables.length; i++){
		
		//CREATE A NEW DIV AND SET ITS ATTRIBUTES
		newDiv = document.createElement('div');
		id = rootId + variables[i] ;
		newDiv.id = id + 'MathJaxDiv';
		newDiv.style.display = 'inline-block';
		newDiv.innerHTML = '\\( { \\FormInput{'+id+'} } \\)' 
		

		varsDiv.appendChild(newDiv);
		if(i != variables.length - 1){
			varsDiv.innerHTML += ',&nbsp;';
		}
		
		//SET GLOBAL VARIABLES ASSOCIATED TO THE NEW DIV 
		window[id + 'simboloDic'] = dictionarySym;
		window[id + 'jaxInputDictionary'] = {};
		window[id + 'parserString'] = 'Input{' +id+ '}';
		window[id + 'prefixMathJax'] = '';
		window[id + 'prefixCnotation'] = '';
		
	}
	
	MathJax.Hub.Queue(['Typeset', MathJax.Hub, varsDivId]);
	
}


/**
 * This function is meant to replace all Input{Id} text in the parser 
   String of each variable for the current value there is on the actual input boxes
   It will also replace the numericId used for the aliases with their name
   for example 'C23232' by 'Or'
   At the end it will put the whole expression in the substitution div in the input form
   to send to the controller
 * @param rootId id of the jaxSubstitution tile
 * @returns
 */
function setSubstitutionOnInput(rootId){
	
	rootId = rootId + '.';
	
	// Get id of the form we'll send the expression to
	var textareaId = window[rootId + '_InputForm'];
	
	// Get the variables that are right now displaying on the jaxSubstitutionSymbols
	var variables = window[rootId + '_variables'];
	var n = variables.length;
	
	// The result we'll write to the input of textareaid will be saved here
	var leftSide = "";
	var rightSide = "";
	
	// Iteration variables
	var variableRootId;//rootId of the variable
	var inputs;//array of all inputs inside the variable id
	var parserString;//parserString of the current variable
	var simboloDic = window[rootId + 'simboloDic'];
	var alias;
	var parserStringEmpty;
	for(var i = 0; i < n; i++){
		
		// Get all input boxes from the div
		variableRootId = rootId + variables[i];
		
		inputs = document.getElementById(variableRootId + 'MathJaxDiv').getElementsByClassName("MathJax_Input");
		parserString = window[variableRootId + 'parserString'];
		
		// Key will be the id of the form, the value its content
		for(var j = 0; j < inputs.length; j++){
			parserString = parserString.replace("Input{" + inputs[j].id + '}',inputs[j].value)
		}
			
		//Change C form of the aliaes to their actual name 
		parserString = setCtoAliases(parserString, variableRootId);
		
		//Check if the parserString was empty
		parserStringEmpty = emptyString(parserString);
		
		if( !parserStringEmpty ) {
			leftSide = leftSide + variables[i] + ',';
			rightSide = rightSide + parserString + ',';
		}
	}
	
	// Take the last comma out
	leftSide = leftSide.substring(0,leftSide.length - 1);
	leftSide += ':= ';
	rightSide = rightSide.substring(0,rightSide.length - 1);
	
	parserString = leftSide + rightSide;
	
	// In case there was no variable 
	if(leftSide == "" || rightSide == ""){
		parserString = "";
	}
	
	// Set the text we'll send to the controller
	var textarea = $('#'+textareaId);	
	textarea.val(parserString);
	return parserString;
}



/**
 * This function is supossed to delete all contents from the given 
 * jaxSubstitutionDiv with id rootId, it will also clean the input area associated to 
 * it 
 * @param rootId string id of the jaxSubstitution
 * @returns
 */
function cleanJaxSubstitution(rootId){
	

	rootId = rootId + '.';
	
	var textareaId = window[rootId + '_InputForm'];
	
	//The variables of the id will now be empty
	window[rootId + '_variables']=[];
	
	//Empty the variables div
	var varsDiv = document.getElementById(rootId+'VariablesDiv');
	varsDiv.innerHTML = "";
	
	// Empty the input box
	var textarea = $('#'+textareaId);
	textarea.val("");
}

/**
 * This function checks if a string is "" or is made of white spaces
 * @param str
 * @returns true or false
 */

function emptyString(str){
	
	for(var i = 0; i < str.length; i++){
		if(str[i] != " "){
			return false;
		}
	}
	
	return true;
	
}

