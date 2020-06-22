<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<c:set var="rootId" value="${rootId}." scope="request"/>


<div id="${rootId}SubstitutionDiv" class="row form-group card text-center border-primary" >
	<div class="card-header">
   		${labelName}
 	</div>
 	
 	<div id="${rootId}VariablesDiv" class="card-body d-flex align-items-center justify-content-center">
    </div>
</div>



<script src="${pageContext.request.contextPath}/static/js/mathjaxAndSymbols.js"></script>
<script src="${pageContext.request.contextPath}/static/js/mathjaxSubstitutionSymbols.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/mathjax-MathJax-v2.3-248-g60e0a8c/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
<script>
	//This allows the use of forminput mathjax extension in this view
	MathJax.Hub.Config({
		   extensions: ["tex2jax.js","[MathJax]/extensions/TeX/forminput.js"],
		   jax: ["input/TeX","output/HTML-CSS"],
		   tex2jax: {inlineMath: [["$","$"],["\\(","\\)"]]},
		   TeX: {extensions: ["AMSmath.js","AMSsymbols.js"]}        	   
	});
	
	
	//SET INPUT BOX ASSOCIATED TO THIS VIEW, HERE WE'LL SEND THE DATA	
	window['${rootId}_InputForm'] = '${inputForm}';
	
	//SET VARIABLES ARRAY
	window['${rootId}_variables'] = []; //by default we have no variables
	
	
	//SET SYMBOL DICTIONARY 
	window['${rootId}simboloDic'] = ${simboloDictionaryCode};
	var dictionarySym = window['${rootId}simboloDic'];
	
	// Set a numeric (but still a string) Id for all aliases, that way we can use them as symbols
	for (var key in dictionarySym) {
	    // check if is an alias
	    if (dictionarySym[key].hasOwnProperty('numericId')) {           
	    	dictionarySym[key]['numericId'] = stringToIntString(key);
	    }
	}
	
	//SET DIV LISTENER FOR ALL MATHJAX DIVS
	var varsDivId = '${rootId}VariablesDiv';
	var varsDiv = document.getElementById(varsDivId);
	varsDiv.addEventListener('DOMNodeInserted', function( event ) {
	
	    if(event.target.className == "MathJax_Input"){
	    	
	    	// First find the fist dot
	    	var formId = event.target.id;
	    	var n = formId.length;
	    	var end;
	    	for(var k = 0; k<n; k++){
	    		if(formId[k] == '.'){
	    			end = k + 1;
	    		}
	    	}
	    	
	    	// Next find the first one, the id is all till the one
	    	for(var k = end; k<n; k++){
	    		if(formId[k] == '1' || formId[k] == '2'){
	    			end = k;
	    			break;
	    		}
	    		if(k == n - 1){
	    			end = k + 1;
	    		}
	    	}
	    	    	
	    	var rootId = formId.substring(0, end);
	    	
  	  		setMathJaxFormAttributes(event.target, 1, rootId);
	    	
	    }
	});
	
	
	
</script>