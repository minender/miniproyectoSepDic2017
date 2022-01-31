<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>


<c:set var="rootId" value="${rootId}_" scope="request"/>

<div id="${rootId}MathJaxDiv" class="form-group card text-center border-primary">
	<div class="card-header" style="padding-bottom: 2px; padding-top: 2px;">
   		${labelName}
 	</div>
 	<div class="card-body d-flex align-items-center justify-content-center">
       \({${prefixMathJax} \FormInput{${rootId}}}\)
    </div>
</div>


<tiles:insertDefinition name="header" />
<script src="${pageContext.request.contextPath}/static/js/mathjaxAndSymbols.js"></script>
<script>
	
	//DEFINE GLOBAL VARIABLES 
	// Create a symbol dictionary with all their data
	window['${rootId}' + 'simboloDic'] = ${simboloDictionaryCode};
	// Initialize a global dictionary for the mathjax input tree  
	window['${rootId}' + 'jaxInputDictionary'] = {};
	// Parser readable expression associated to the input
	window['${rootId}' + 'parserString'] = 'Input{${rootId}}';
	// Prefix for the jax element
	window['${rootId}' + 'prefixMathJax'] = '${prefixMathJax}';
	// Prefix for the C notation
	window['${rootId}' + 'prefixCnotation'] = '${prefixCnotation}';
	//SET INPUT BOX ASSOCIATED TO THIS VIEW, HERE WE'LL SEND THE DATA	
	window['${rootId}_InputForm'] = '${inputForm}';
	
	// IMPORTANT: there is some weird bug in mathjax forms were the first time you create a form 
	// it gets deleted and duplicated by mathjax, so you cant work with the first instance, because 
	// all you do with it will get deleted and overwritten by a new fresh FormInput
	// THIS takes cares of it, in case the bug appears again
	setTimeout(function() {
		setMathJaxFormAttributes(document.getElementById('${rootId}'), 1, '${rootId}');
		//preSet('${rootId}');
	}, 10000); 
	
	// If a new MathJax input gets added this sets its attributes
	document.getElementById('${rootId}' + "MathJaxDiv").addEventListener('DOMNodeInserted', function( event ) {
	    if(event.target.className == "MathJax_Input"){
  	  		setMathJaxFormAttributes(event.target, 1, '${rootId}');
	    }
	}, false); 
		
	// Set a numeric (but still a string) Id for all aliases, that way we can use them as symbols
	for (var key in window['${rootId}' + 'simboloDic']) {
	    // check if is an alias
	    if (window['${rootId}' + 'simboloDic'][key].hasOwnProperty('numericId')) {           
	    	window['${rootId}' + 'simboloDic'][key]['numericId'] = stringToIntString(key);
	    }
	}
	
</script>