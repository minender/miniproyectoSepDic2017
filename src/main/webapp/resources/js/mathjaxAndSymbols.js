// Author Jean 22/05/2020


/**
   This function takes the id of a div (that must have a mathjax jax element) and some text (latex formated)
   and replaces the input box where the user was holding its mouse with the recently clicked
   operator
 * @param rootId string given by the user to represent this whole functionality
 * @param text string that represents the notation of the button that was clicked
 * @param simboloId int that is the id of the symbol of the button that as clicked
 * @param isAlias boolean that tells us if is an alias what we need to insert 
 * @param alias string that represents the alias name
 * @returns nothing
 */
function insertAtMathjaxDiv(rootId,text,simboloId, isAlias){
	
	// Get global variables from the outside
	var id = rootId + 'MathJaxDiv';// id of the jax div
	var jaxInputDictionary = window[rootId + "jaxInputDictionary"];// get the global dictionary of the jax expression
	var simboloDic = window[rootId + 'simboloDic'];
	
	
	// Request jax elements
	var input = document.activeElement; // get the input box where the cursor was
	var math = MathJax.Hub.getAllJax(id)[0]; // get the jax alement from the div
	var originalMathJax = math.originalText; // get the old mathjax text

	var idParentBox = input.id; // get the id of the input box        	
	var createdChilds = []; // here the created child id's must be saved
	
	// if the class is MathJax_Input its a proper input box 
	if(input && (input.classList.contains("MathJax_Input"))){
		
		// SAVE THE OLD CONTENT FROM THE BOXES
		var saveDictionary = saveMathJaxFormContent(id);
		        		
		// SET THE NEW MATHJAX 
		
		var parentBox = "\\FormInput{" + idParentBox + "}"; // this is how the old box should look in the old  mathjax text
		var idLeftChild = idParentBox + "1";
		var idRightChild = idParentBox + "2";
		var parserRight = '';
		var parserLeft = '';
		
		var replaced1 = false;	
		var newNotation = text.replace("\\FormInput{1}",function(token){replaced1 = true; return "\\FormInput{" + idLeftChild + "}";}); // we replace left child's id with the proper position
		
		// If left child was inserted
		if(replaced1){
			createdChilds.push(idLeftChild);
			parserRight = 'Input{' + idLeftChild + '}';
		}
		
		var replaced2 = false;
		newNotation = newNotation.replace("\\FormInput{2}", function(token){replaced2 = true; return "\\FormInput{" + idRightChild + "}";});// we replace right child's id with the proper position
		
		// If right child was inserted
		if(replaced2){
			createdChilds.push(idRightChild);
			parserLeft = 'Input{' + idRightChild + '},';
		}
		
		// UPDATE STRING FOR PARSER
		
		var parserExp = 'C' + simboloId;
		
		// If is an alias use its numericId and redefine left and right
		if(isAlias){
			parserExp = 'C' + window[rootId + 'simboloDic'][simboloId]['numericId'];
			
			var comma = ',';
			if(!replaced2){
				comma = '';
			}
			
			// Change order of childs
			var tmp = parserLeft;
			parserLeft = parserRight + comma;
			parserRight = tmp.slice(0, -1);
		}
		
		parserExp =  parserExp + '(' + parserLeft + parserRight + ')';
			
		// Update the global expression
		var oldExpr = 'Input{' + idParentBox + '}';
		window[ rootId + 'parserString'] = window[ rootId + 'parserString'].replace(oldExpr, parserExp);
		
		
		// CHECK IF THE NEW NOTATION NEEDS PARS OR NOT
		
		var leftPar = '(';
		var rightPar = ')';
		
		var variableName;
		var parentSimboloId = jaxInputDictionary[idParentBox];
		
		var lastChar = idParentBox[idParentBox.length -1 ];
		
		// Depending on the fact that the parent is left or not we get our notacion variable name
		if( lastChar == '1'){
			variableName = simboloDic[parentSimboloId]['notacionVariables'][0];
		}else if( lastChar == '2'){
			variableName = simboloDic[parentSimboloId]['notacionVariables'][1];
		}
		
		var m = simboloDic[parentSimboloId]['precedence'];
		var n = simboloDic[simboloId]['precedence'];
		var arguments = simboloDic[simboloId]['arguments'];
		
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
		
	// In case nothing has been written yet
	}else if (originalMathJax == "{}"){
		
		// Define the base id's
		var leftId = rootId + '1';
		var rightId = rootId + '2';
		
		var leftChildExists = false;
		var rightChildExists = false;
		
		//Replace the "FormInput{1}" for "FormInput{rootId1}"
		var newMathJax = text.replace("\\FormInput{1}", function(token){leftChildExists = true; return "\\FormInput{" + leftId + "}";});
		newMathJax = newMathJax.replace("\\FormInput{2}", function(token){rightChildExists = true; return "\\FormInput{" + rightId + "}";});
		
		parserExp = 'C' + simboloId;
		
		
		var rightParser = '';
		var leftParser = '';
	
		if(leftChildExists){
			createdChilds.push(leftId);
			rightParser = 'Input{' + leftId +'}';
		}
		if(rightChildExists){
			createdChilds.push(rightId);
			leftParser = 'Input{' + rightId +'},';
		}
		
		// If is an alias use its numericId and redefine left and right
		if(isAlias){
			parserExp = 'C' + window[rootId + 'simboloDic'][simboloId]['numericId'];
			
			var comma = ',';
			if(!replaced2){
				comma = '';
			}
			
			// Change order of childs
			var tmp = leftParser;
			leftParser = rightParser + comma;
			rightParser = tmp.slice(0, -1);
		}
		
		// GENERATE THE NEW PARSER STRING
		parserExp =  parserExp + '(' + leftParser + rightParser + ')';
		
		
		window[ rootId + 'parserString'] = parserExp;
			
		newMathJax = "\\ {"+newMathJax+"}\\ ";
		
		// Render the new text in the div 
        MathJax.Hub.Queue(["Text",math,newMathJax]);
        
	// In other case do nothing
	}else{
		return;
	}
	
	
	// Set in the global dictionary which symbol id is 
	// associated to the new created inputs 
	createdChilds.forEach(element => jaxInputDictionary[element]=simboloId);
	
	
};


/**
 * This function set the mathjax form currently displaying 
   to the correct attributes, maxlength is a string that 
   that represents how many characters can the input have
 * @param form mathjax form to set attributes of
 * @param maxlength how many characters to allow in the input box
 * @param rootId id that identifies this whole functionality
 * @returns nothing
 */
function setMathJaxFormAttributes(form, maxlength, rootId) {

	form.maxLength = maxlength;
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
 * @param divId if of the jax div
 * @returns dinctionary with saved data of the input boxes by id
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
 * @param dictionarySave
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
 * @param rootId id that identifies this whole functionality
 * @returns new string jax without the deleted stuff
 */
function deleteOperator(FormId, rootId){
	
	var id = rootId + "MathJaxDiv";
	var input = document.getElementById(FormId); // get the input box
	var math = MathJax.Hub.getAllJax(id)[0]; // get the jax alement from the div
	var originalMathJax = math.originalText; // get the old mathjax text
	var oldParentId = FormId.substring(0, FormId.length - 1);// the id the new input box will have
	var result;


	var lastChar = FormId[FormId.length-1];// the last char of the id tells us if is right or left child

	//FIRST DELETE FROM THE ACTUAL PARSER STRING
	deleteOperatorParserString(FormId, rootId)
	
	// If the deleted input box was one of the first ones to be born
	// return empty string 
	if( FormId.length < rootId.length + 2){
		result = "{}";
		// Render the new text in the div 
        MathJax.Hub.Queue(["Text",math,result]);
		return "{}";
	}
	
	
	// SAVE THE OLD CONTENT FROM THE BOXES
	var saveDictionary = saveMathJaxFormContent(id);
	
	// Error message
	var error = "Wrong input on the mathjax div, check there are parenthesis";
	var n = originalMathJax.length;
	
	// Must know if this was a right child or a left child
	var leftChild = (lastChar == '1');
	
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
		result =  originalMathJax.replace(toReplace, "\\FormInput{" + oldParentId + "}");
		
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
 * @returns nothing
 */
function deleteOperatorParserString(formId, rootId){
	
	var oldParentId = formId.substring(0, formId.length - 1);// the id the new input box will have
	
	var lastChar = formId[formId.length-1];// the last char of the id tells us if is right or left child

	
	// If the deleted input box was one of the first ones to be born
	// return empty string 
	if( formId.length < rootId.length + 2){
		parserString = "";
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
 * @param textareaId if of the textarea where u need to put the expression to send
 * @returns
 */
function setInputValueOnParser(rootId,textareaId){
	
	// Get all input boxes from the div
	var inputs = $('#' + rootId + 'MathJaxDiv' + ' .MathJax_Input').toArray();
	var parserString = window[rootId + 'parserString'];
	var simboloDic = window[rootId + 'simboloDic'];
	
	// Key will be the id of the form, the value its content
	inputs.forEach(element => parserString = parserString.replace("Input{" + element.id + '}', element.value));
	
	var alias;
	for (var key in simboloDic) {
	    // check if is an alias
		alias = simboloDic[key];
	    if (alias.hasOwnProperty('numericId')) {           
	    	parserString = parserString.replace(new RegExp('C' + alias['numericId'], 'g'), key);
	    }
	}
	
	// Set the text we'll send to the controller
	var textarea = $('#'+textareaId);
	textarea.val(parserString);
	return parserString;
}


/**
 * This function resets the jax div with the given id, the textare with the given id 
   and the global variable parserString
 * @param rootId id that user uses to identify thins functionality
 * @param textareaId String id of the input box
 * @returns nothing
 */
function cleanJax(rootId, textareaId){
	
	var jaxDivId = rootId + "MathJaxDiv";
	var math = MathJax.Hub.getAllJax(jaxDivId)[0]; // get the jax alement from the div
	MathJax.Hub.Queue(["Text",math,"{}"]);
	window[rootId + 'parserString'] = "";
	$('#' + textareaId).val("");
	
}

/**
 * this function takes a string and turns it into its integer string representation
 * @param string the string to conver
 * @returns String converted in integers
 */
function stringToIntString(string){
	var output = "";
	for (var i = 0, len = string.length; i < len; i++) {
	      output += string.charCodeAt(i).toString();
	}
	return output;
}



