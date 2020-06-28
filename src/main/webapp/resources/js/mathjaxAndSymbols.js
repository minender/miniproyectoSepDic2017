// Author Jean 22/05/2020


/**
   This function takes the id of a div (that must have a mathjax jax element) and some text (latex formated)
   and replaces the input box where the user was holding its mouse with the recently clicked
   operator
 * @param text string that represents the notation of symbol associated to the button that was clicked
 * @param simboloId int that is the id of the symbol of the button that as clicked
 * @param isAlias boolean that tells us if is an alias what we need to insert 
 * @returns nothing
 */
function insertAtMathjaxDiv(text,simboloId, isAlias){
	
	var input = document.activeElement; // get the input box where the cursor was
	
	// if the cursor was not on any element, or the element wasnt a Math_Jax 
	// input field, return
	if(!input || !(input.classList.contains("MathJax_Input"))){
		return 
	}
	
	var rootId = input.getAttribute('data-rootId');
	
	// Get global variables from the outside
	var id = rootId + 'MathJaxDiv';// id of the jax div
	var jaxInputDictionary = window[rootId + "jaxInputDictionary"];// get the global dictionary of the jax expression
	var simboloDic = window[rootId + 'simboloDic'];
	
	// Request jax elements
	var math = MathJax.Hub.getAllJax(id)[0]; // get the jax alement from the div
	var originalMathJax = math.originalText; // get the old mathjax text

	// Util data 
	var idParentBox = input.id; // get the id of the input box        	
	var createdChilds = []; // here the created child id's must be saved
	var notacionLatexVariables = simboloDic[simboloId]['notacionVariables'];//get the notation variables of the symbol
	
	
	// SAVE THE OLD CONTENT FROM THE BOXES
	var saveDictionary = saveMathJaxFormContent(id);
	        		
	// SET THE NEW MATHJAX 
	
	var parentBox = "\\FormInput{" + idParentBox + "}"; // this is how the old box should look in the old  mathjax text
	var idLeftChild = idParentBox + "1";
	var idRightChild = idParentBox + "2";
	var parserRight = '';
	var parserLeft = '';
	var leftChildInLatex1 = false;//Will be true if in the latex notation the left child is supossed to be also left
	var leftChildInLatex2;
	
	var replaced1 = false;	
	var newNotation = text.replace("\\FormInput{1}",function(token){replaced1 = true; return "\\FormInput{" + idLeftChild + "}";}); // we replace left child's id with the proper position
	
	// If left child was inserted
	if(replaced1){
		parserLeft = 'Input{' + idLeftChild + '}';
		
		// Check if the node is also left in the latex notation order 
		var var1 = notacionLatexVariables[0];
		if(var1[var1.length - 1] == '1'){leftChildInLatex1 = true;}
		createdChilds.push([idLeftChild, {'simboloId' : simboloId,'isLeftLatex' : leftChildInLatex1 }]);
	}
	
	var replaced2 = false;
	newNotation = newNotation.replace("\\FormInput{2}", function(token){replaced2 = true; return "\\FormInput{" + idRightChild + "}";});// we replace right child's id with the proper position
	
	// If right child was inserted
	if(replaced2){
		parserRight = 'Input{' + idRightChild + '}';
		// 2nd child is the opposite of first child 
		leftChildInLatex2 = !leftChildInLatex1;
		createdChilds.push([idRightChild, {'simboloId' : simboloId,'isLeftLatex' : leftChildInLatex2 }]);
	}
	
	// UPDATE STRING FOR PARSER
	
	var parserExp = 'C' + simboloId;
	
	var comma = '';
	if(replaced2){
		comma = ',';
	}
	
	// If is an alias use its numericId and redefine left and right
	if(isAlias){
		parserExp = 'C' + simboloDic[simboloId]['numericId'];
	}
	
	parserExp =  parserExp + '(' + parserLeft + comma +  parserRight + ')';
		
	// Update the global expression
	var oldExpr = 'Input{' + idParentBox + '}';
	window[ rootId + 'parserString'] = window[ rootId + 'parserString'].replace(oldExpr, parserExp);
	
	
	// CHECK IF THE NEW NOTATION NEEDS PARS OR NOT
	
	var leftPar = '(';
	var rightPar = ')';
	
	
	// Data for the rules
	var variableName;
	var m;
	var n;
	var arguments;
	var parentSimboloId;
	// If parent was the first box there is no symbol associated to it 
	if(idParentBox.length <= rootId.length){
		//Generate fake data to trigger rule1
		variableName = 'a1';
		m = 0;
		n = 1;
		arguments = 0;
		parentSimboloId = "";
	}else{
		
		parentSimboloId = jaxInputDictionary[idParentBox]['simboloId'];
		
		// Depending on the fact that the parent is left or not we get our notacion variable name
		if(jaxInputDictionary[idParentBox]['isLeftLatex']){
			variableName = simboloDic[parentSimboloId]['notacionVariables'][0];
		}else{
			variableName = simboloDic[parentSimboloId]['notacionVariables'][1];
		}
		
		m = simboloDic[parentSimboloId]['precedence'];
		n = simboloDic[simboloId]['precedence'];
		arguments = simboloDic[simboloId]['arguments'];
	}
	

	// Rule 1
	if(n > m && (variableName.match(/^aa?(1|2)$/))){
		leftPar = '';
		rightPar = '';
	}
	
	// Rule 2
	if(simboloId == parentSimboloId && variableName.match(/^aa(1|2)$/)){
		leftPar = '';
		rightPar = '';
	}
	
	// Rule 3
	if(arguments == 0){
		leftPar = '';
		rightPar = '';
	}
	
	// Rule 4
	if((variableName.match(/^na(1|2)$/))){
		leftPar = '';
		rightPar = '';
	}

	
	var newMathJax = originalMathJax.replace(parentBox, "\\ {" + leftPar + newNotation + rightPar + "}\\ " );// Finally we replace the old box with the whole new notation 
	
	MathJax.Hub.Queue(["Text",math,newMathJax]);// refresh the mathjax div
	
	// LOAD THE OLD INPUT IN THE RESPECTIVE BOXES 
	loadMathJaxFormContent(id, saveDictionary);
		
	// Set in the global dictionary which symbol id is 
	// associated to the new created inputs and also extra information
	createdChilds.forEach(element => jaxInputDictionary[element[0]]=element[1]);
	
};


/**
 * This function set the mathjax form 
   to the correct attributes
 * @param form mathjax form to set attributes of
 * @param maxlength how many characters to allow in the input box
 * @param rootId id that identifies this whole functionality
 * @returns nothing
 */
function setMathJaxFormAttributes(form, maxlength, rootId) {

	
	form.maxLength = maxlength;
	form.setAttribute('data-rootId', rootId);
	form.onkeydown = function() {
	    var key = event.keyCode || event.charCode;

	    // If the user presses del and the input box was empty we must delete this operator 
	    // in the mathjax div
	    if( (key == 8 || key == 46) && this.value == "" ) {
	    	
	    	deleteOperator(this.id, rootId);
	    		
	    }    
	}
}


/**
 * This function receives the id of the mathjax div 
   and saves the content of all forms in there in a 
   dictionary
 * @param divId id of the jax div
 * @returns dinctionary with key the id of the input form and value its content
 */
function saveMathJaxFormContent(divId){
	
	// Get all input boxes from the div
	var inputs = $('#' + divId + ' .MathJax_Input').toArray();

	// This dictionary will save that content
	var dictionary ={}
	
	// Key will be the id of the form, the value its content
	inputs.forEach(element => dictionary[element.id] = element.value);
	
	return dictionary;
}


/**
 * This function loads the content from the save function 
   dictionary
 * @param divId if of the jax div
 * @param dictionarySave dictionary from save
 * @returns nothing
 */
function loadMathJaxFormContent(divId, dictionarySave){
	
	// Get the new input boxes
	var inputs = $('#' + divId + ' .MathJax_Input').toArray();
	// Set the value of each new input box to its old value
	inputs.forEach(function(element){
		if(dictionarySave.hasOwnProperty(element.id)){
			element.value =  dictionarySave[element.id];
		}
	});
}


/**
 * This function deletes the operator asociated to the form 
   owner of FormId from the div and replaces the whole 
   operator expresion with a new input form, for example 
   if the div had this (x + (y - _)) and we delete the form
   we'll now have (x + _)
 * @param FormId id of them form input where delete was requested
 * @param rootId id that identifies the jaxDiv 
 * @returns new string for jax to display 
 */
function deleteOperator(FormId, rootId){
	
	var id = rootId + "MathJaxDiv";
	var input = document.getElementById(FormId); // get the input box
	var math = MathJax.Hub.getAllJax(id)[0]; // get the jax alement from the div
	var originalMathJax = math.originalText; // get the old mathjax text
	var oldParentId = FormId.substring(0, FormId.length - 1);// the id the new input box will have
	var result;

	//Global variables
	var jaxInputDictionary = window[rootId + "jaxInputDictionary"];// get the global dictionary of the jax expression

	//FIRST DELETE FROM THE ACTUAL PARSER STRING
	deleteOperatorParserString(FormId, rootId);
	
	// If the deleted input box was the first one to be born
	// return empty string 
	if( FormId.length <= rootId.length){
		return cleanMathJax(rootId);
	}
	
	
	// SAVE THE OLD CONTENT FROM THE BOXES
	var saveDictionary = saveMathJaxFormContent(id);
	
	// Error message
	var error = "Wrong input on the mathjax div, check there are parenthesis";
	var n = originalMathJax.length;
	
	// Must know if this was a right side or left side in the latex string
	var leftChild = jaxInputDictionary[FormId]['isLeftLatex'];
	// Get the index from which we'll start studying the string to replace the expression
	var indexFormId = originalMathJax.indexOf("\\FormInput{" + FormId + '}');
	
	var leftPar = 0;// amount of ( char
	var rightPar = 0;// amount of ) char
	var i = indexFormId ;// count where the form starts
	var result;
	var currentChar = originalMathJax[i];
	
	if (leftChild) {
		
		
		var toReplace = "{";
		
		// Must move till wherever is the open par
		while(currentChar != '{' || originalMathJax[i-2]!="\\"){
			i--;
			currentChar = originalMathJax[i];
			
			if(i < -1){
				throw error;
			}

		}
		
		leftPar++;
				
		// Iterate till get the index of the closing par
		while((currentChar != '}') || (leftPar != rightPar)){
			       		       			       			
			i++;
			currentChar = originalMathJax[i];
		
			if(currentChar == '{'){
				leftPar++;
			}else if(currentChar == '}'){
				rightPar++;
			}
			
			toReplace += currentChar;
			
			// If we went over the original mathjax length something went wrong
			if(i > n){
				throw error;
			}
		}
		
		toReplace = "\\ " + toReplace + "\\ ";
		
		// Now toReplace should have the whole expression we need to delete
		result =  originalMathJax.replace(toReplace, "\\FormInput{" + oldParentId + "}");
		
	}else{
		
		var toReplace = "}";
		
		
		// Must move till wherever is the close par
		while(currentChar != '}' || originalMathJax[i+1]!="\\"){
			i++;
			currentChar = originalMathJax[i];
			
			// If we went over the original mathjax length something went wrong
			if(i > n){
				throw error;
			}

		}
		
		rightPar++;
		
		// Iterate till get the index of the closing par
		while((currentChar != '{') || (leftPar != rightPar)){
			
			i--;
			currentChar = originalMathJax[i];
			
			if(currentChar == '{'){
				leftPar++;
			}else if(currentChar == '}'){
				rightPar++;
			}
			
			toReplace = currentChar + toReplace;
			
			
			// If reach -1 something went wron most likely a wrong mathjax input
			if(i < -1){
				throw error;
			}
			
		}

		toReplace = "\\ " + toReplace + "\\ ";
		
		// Now toReplace should have the whole expression we need to delete	
		result = originalMathJax.replace(toReplace, "\\FormInput{" + oldParentId + "}");
				
	}
	
	// Render the new text, also set the new input box attributes
	MathJax.Hub.Queue(["Text",math,result]);
	
	
	//LOAD OLD INPUT BOXES CONTENT
    loadMathJaxFormContent(id, saveDictionary);
    	
    return result;
    	   	
}

/**
 * similar to deleteOperator but is in charge of the ParserString
 * @param formId id of a form inside the operator we want to delete
 * @param rootId id associated to the jaxDiv 
 * @returns nothing
 */
function deleteOperatorParserString(formId, rootId){
	
	var oldParentId = formId.substring(0, formId.length - 1);// the id the new input box will have
	
	var lastChar = formId[formId.length-1];// the last char of the id tells us if is right or left child

	
	// If the deleted input box was the first one to be born
	// return empty string 
	if( formId.length <= rootId.length){
		cleanParserString(rootId);
		return;
	}
	
	// Error message
	var error = "Wrong input on the mathjax div, check there are parenthesis";
	// Get a copy of the parser variable string and work with this 
	var parserString = window[rootId + 'parserString'];
	var n = parserString.length;
	
	// Must know if this was a right child or a left child
	var leftChild = (lastChar == '2');
	
	// Get the index from which we'll start studying the string to replace the expression
	var indexFormId = parserString.indexOf("Input{" + formId + '}');
	var leftPar = 0;// amount of ( char
	var rightPar = 0;// amount of ) char
	var i = indexFormId ;// count where the form starts
	var result;
	var currentChar = parserString[i];
	

	if(leftChild){
		
		var toReplace = "C";
		
		while(currentChar != 'C'){
			i--;
			currentChar = parserString[i];
			if(i < -1){
				throw error;
			}
		}
		
		
		while((currentChar != ')') || (leftPar != rightPar)){
			
			i++;
			currentChar = parserString[i];
			
			if(currentChar == '('){
				leftPar++;
			}else if(currentChar == ')'){
				rightPar++;
			}
			
			toReplace += currentChar;
			
			// If we went over the original mathjax length something went wrong
			if(i > n){
				throw error;
			}
			
		}
		
		result = parserString.replace(toReplace, 'Input{' + oldParentId + '}');
		
	}else{
		
		var toReplace = ")";
		
		while(currentChar != ')'){
			i++;
			currentChar = parserString[i];
			if(i > n){
				throw error;
			}
		}
		
		rightPar++;
		
		while((currentChar != 'C') || (leftPar != rightPar)){
			i--;
			currentChar = parserString[i];
			
			if(currentChar == '('){
				leftPar++;
			}else if(currentChar == ')'){
				rightPar++;
			}
			
			toReplace = currentChar + toReplace;
		
			// If reach -1 something went wron most likely a wrong mathjax input
			if(i < -1){
				throw error;
			}
		}
		
		result = parserString.replace(toReplace, 'Input{' + oldParentId + '}');
	}
	
	// Update global variable of the parserString
	window[rootId + 'parserString'] = result;
		
}


/**
 * This function is meant to replace all Input{Id} text in the parser
   String for the current value there is on the actual input boxes
   It will also replace the numericId used for the aliases with their name
   for example 'C23232' by 'Or'
   Finally it will send the properly formated expression to textarea id
 * @param rootId id of the jaxDiv
 * @returns
 */
function setInputValueOnParser(rootId){
	
	rootId += '_';
	
	var textareaId = window[rootId + '_InputForm'];
	
	// Get all input boxes from the div
	var inputs = $('#' + rootId + 'MathJaxDiv' + ' .MathJax_Input').toArray();
	var parserString = window[rootId + 'parserString'];
	var simboloDic = window[rootId + 'simboloDic'];
	
	// Key will be the id of the form, the value its content
	inputs.forEach(element => parserString = parserString.replace("Input{" + element.id + '}', element.value));
	
	
	//Change C form of the aliaes to their actual name 
	parserString = setCtoAliases(parserString, rootId);
	
	// Set the text we'll send to the controller
	var textarea = $('#'+textareaId);
	var prefix = window[rootId + 'prefixCnotation'];
	if(parserString.length == 0){ prefix = '';}
	textarea.val(prefix + parserString);
	return parserString;
}


/**
 * This function resets the jax div with the given id
 * @param rootId id of the jaxDiv
 * @returns nothing
 */
function cleanJax(rootId){
	
	
	rootId += '_';
	 
	var textareaId = window[rootId + '_InputForm'];
	
	cleanMathJax(rootId);// Reset math jax div
	cleanParserString(rootId);// Reset Parser string
	$('#' + textareaId).val("");// Make input be empty
	
}

/**
 * clean mathjax in jaxDiv
 * @param rootId id of the jaxDiv with '_' appended to the end
 * @returns
 */
function cleanMathJax(rootId){
	var jaxDivId = rootId + "MathJaxDiv";
	var math = MathJax.Hub.getAllJax(jaxDivId)[0]; // get the jax alement from the div
	var startText = "{" + window[rootId + 'prefixMathJax'] + "\\FormInput{" + rootId + "}}";
	MathJax.Hub.Queue(["Text",math,startText]);
	return startText;
}
/**
 * clean parserString in jaxDiv
 * @param rootId id of the jaxDiv with '_' appended to the end
 * @returns
 */
function cleanParserString(rootId){
	var startText = "Input{" + rootId + "}";
	window[rootId + 'parserString'] = startText;
	return startText;
}

/**
 * this function takes a string and turns it into its integer string representation
 * @param string the string to conver
 * @returns String converted in integers
 */
function stringToIntString(string){
	var output = "0";// this ensures is unique because the other symbols cant start at 0
	for (var i = 0, len = string.length; i < len; i++) {
	      output += string.charCodeAt(i).toString();
	}
	return output;
}


/**
 * This function takes a C notation with the information neccesary to set
 * the jaxInputDictionary for the given notation, sets the dictionary, turns the 
 * notation into the proper C notation and sets the parseString 
 * This function is meant to be used when the user generates a leibnz by using 
 * the mouse. This function also sets the new latex notation in mathjax
 * An example of what this method takes as argument is ambda z.C1(Input{q,leibnizSymbolsId_2,phatherOpId1},Input{z,leibnizSymbolsId_1,phatherOpId1})
 * @param cNotation C notation to recover from
 * @param latexNotation latex notation to display
 * @returns
 */
function inferRecoverC(cNotation, latexNotation){
	
	var n = cNotation.length;
	const error = "Wrong Input, missing closing } or a , ";
	var newParserString = "";
	var variablesSaved = {};
	
	//Add prefix to latexNotation
	latexNotation = window['leibnizSymbolsId_prefixMathJax'] + latexNotation;
	
	// Global Variables
	var jaxInputDictionary = window["leibnizSymbolsId_jaxInputDictionary"];
	var simboloDic = window['leibnizSymbolsId_simboloDic'];
	
	// Iteration variables
	var id;
	var parentSymbolId;
	var variable;
	var currentChar;
	var startIndex;
	var args;
	var arg;
	var var1;
    for(var i = 0; i<n; i++){
    	
    	currentChar = cNotation[i];
    	
    	
    	// If find an Input box information study it 
    	if(currentChar == 'I' && cNotation.substring(i, i + 6) == "Input{"){
    		
    		i += 6;
    		currentChar = cNotation[i];
    		args = [];
    		while(currentChar != '}'){	
    			arg = '';
    			while(currentChar != ',' && currentChar != '}'){		
    				arg += currentChar;
    				i++;
    	    		currentChar = cNotation[i];
    	    		if( i > n ){ throw error;}
    	    		if( currentChar == '}'){ i--;}
    			}
    			args.push(arg);
    			i++;
	    		currentChar = cNotation[i];
    		}
    		
    		variable = args[0];
    		id = args[1];
    		parentSymbolId = args[2].replace("phatherOpId", "");//take only the id 
    		
    		
    		
    		newParserString += "Input{" + id ;
    		variablesSaved[id] = variable;
    		
    		// SET INFORMATION OF THIS INPUT IN THE GLOBAL DICTIONARY
    		
    		jaxInputDictionary[id] = {};
    		
    		// If the element is different than the root
    		if(parentSymbolId != ""){
    			// set left or right child in latex notation
    			var1 = simboloDic[parentSymbolId]['notacionVariables'][0];
    			jaxInputDictionary[id]['isLeftLatex'] = (var1[var1.length - 1] == id[id.length - 1]);
    		}
    		
    		// set parent symbol
    		jaxInputDictionary[id]['simboloId'] = parentSymbolId;
    		
    		
    	}
    	
    	newParserString += currentChar;
    	
    }
    
    // Change all the aliases for their C representation
    newParserString = setAliasesToC(newParserString, 'leibnizSymbolsId_');
    
    // Update the global parser string 
    window['leibnizSymbolsId_parserString'] = newParserString;
    
    // Update the jax expression
    var math = MathJax.Hub.getAllJax('leibnizSymbolsId_MathJaxDiv')[0];
    MathJax.Hub.Queue(["Text",  math, "{" +latexNotation + "}"]);
    
    // Load the variables on the input boxes
    loadMathJaxFormContent('leibnizSymbolsId_MathJaxDiv',  variablesSaved);
    return newParserString;
	
}

/**
 * This function is meant to replace all aliases in a C notation 
 * for their C representation for example Or(a,b) by C012323(a,b)
 * @param Cnotation String 
 * @returns result : String updated notation 
 */
function setAliasesToC(Cnotation, rootId){
	
	var simboloDic = window[rootId + 'simboloDic'];
	
	var result = Cnotation;
	
	var aliasToReplace;
	var replacement;
	// Set a numeric (but still a string) Id for all aliases, that way we can use them as symbols
	for (var key in simboloDic) {
	    // check if is an alias
	    if (simboloDic[key].hasOwnProperty('numericId')) {
	    	
	    	aliasToReplace = key + '\\(';
	    	replacement = 'C' + simboloDic[key]['numericId'] + '(';
	    	
	    	// Replace all instances of this aliases by its C representation
	    	result = result.replace(new RegExp(aliasToReplace,'g'), replacement);
	    }
	}
	
	return result;
}

/**
 * This function is meant to replace all C notation of aliases 
 * for their alias representation for example  C012323(a,b) by Or(a,b)
 * @param Cnotation String 
 * @returns result : String updated notation 
 */
function setCtoAliases(Cnotation, rootId){
var simboloDic = window[rootId + 'simboloDic'];
	
	var result = Cnotation;
	
	var aliasToReplace;
	var replacement;
	// Set a numeric (but still a string) Id for all aliases, that way we can use them as symbols
	for (var key in simboloDic) {
	    // check if is an alias
	    if (simboloDic[key].hasOwnProperty('numericId')) {
	    	
	    	replacement = key + '(';
	    	aliasToReplace = 'C' + simboloDic[key]['numericId'] + '\\(';
	    	
	    	// Replace all instances of this aliases by its C representation
	    	result = result.replace(new RegExp(aliasToReplace,'g'), replacement);
	    }
	}
	
	return result;
	
}

/**
 * This functions creates and later deletes a MathJax FormInput, this is neccesary to 
 * take care of a bug that MathJax has
 * @param rootId
 * @returns nothing
 */
function preSet(rootId){
	
	var id = rootId + "MathJaxDiv";
	var math = MathJax.Hub.getAllJax(id)[0]; // get the jax alement from the div
	
	// Render the new text, also set the new input box attributes
	MathJax.Hub.Queue(["Text",math,"{\\FormInput{" + rootId + "0}}"]);
	
	setTimeout(function() {
		MathJax.Hub.Queue(["Text",math,"{}"]);
	}, 100);
	
}


