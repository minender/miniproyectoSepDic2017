<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>


<c:set var="rootId" value="${rootId}_" scope="request"/>

<div class="row justify-content-center form-group">
	<a class="btn btn-primary" data-toggle="collapse" href="#${rootId}symbolsTable" role="button" aria-expanded="false" aria-controls="symbolsTable">
		Operators:
	</a>
</div>
<div class="collapse form-group" id="${rootId}symbolsTable">
       <div class="btn-toolbar justify-content-center" role="toolbar" aria-label="Toolbar with button groups">
       <%-- THIS SECTION IF FOR SYMBOL BUTTONS--%>
	   <div class="btn-group mr-2 flex-wrap" role="group" aria-label="First group">
	  	<c:forEach items="${simboloList}" var="symbol"> 
	  		<button style="font-size: 50%;" type="button" class="btn btn-secondary" 
	  		onmousedown="insertAtMathjaxDiv('${rootId}', '${symbol.fullLatexNotation('\\FormInput{0}', true)}', ${symbol.getId()}, false);return false;">
	  		$$${symbol.fullLatexNotation("\\Box", false)}$$
	  		</button>
	  	</c:forEach> 
	   </div> 
	   <%-- THIS SECTION IF FOR ALIAS BUTTONS --%>
	   <div class="btn-group mr-2 flex-wrap" role="group" aria-label="First group">
	  	<c:forEach items="${predicadoList}" var="alias"> 
	  		<button style="font-size: 50%;" type="button" class="btn btn-secondary" 
	  		onmousedown="insertAtMathjaxDiv('${rootId}', '${alias.fullLatexNotation('\\FormInput{0}', true)}', '${alias.getId().getAlias()}', true);return false;">
	  		$$${alias.fullLatexNotation("\\Box", false)}$$
	  		</button>
	  	</c:forEach> 
	   </div>
	   </div>
</div>


<div id="${rootId}MathJaxDiv" class="row form-group card text-center border-primary">
	<div class="card-header">
   		${labelName}
 	</div>
 	<div class="card-body d-flex align-items-center justify-content-center">
       \({${prefixMathJax} \FormInput{${rootId}1}}\)
    </div>
</div>



<script src="${pageContext.request.contextPath}/static/js/mathjaxAndSymbols.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/mathjax-MathJax-v2.3-248-g60e0a8c/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
<script>
	//This allows the use of forminput mathjax extension in this view
	MathJax.Hub.Config({
		   extensions: ["tex2jax.js","[MathJax]/extensions/TeX/forminput.js"],
		   jax: ["input/TeX","output/HTML-CSS"],
		   tex2jax: {inlineMath: [["$","$"],["\\(","\\)"]]},
		   TeX: {extensions: ["AMSmath.js","AMSsymbols.js"]}        	   
	});
		
	//DEFINE GLOBAL VARIABLES 
	// Create a symbol dictionary with all their data
	window['${rootId}' + 'simboloDic'] = ${simboloDictionaryCode};
	// Initialize a global dictionary for the mathjax input tree  
	window['${rootId}' + 'jaxInputDictionary'] = {};
	// Parser readable expression associated to the input
	window['${rootId}' + 'parserString'] = 'Input{${rootId}1}';
	// Prefix for the jax element
	window['${rootId}' + 'prefixMathJax'] = '${prefixMathJax}';
	// Prefix for the C notation
	window['${rootId}' + 'prefixCnotation'] = '${prefixCnotation}';
	
	// IMPORTANT: there is some weird bug in mathjax forms were the first time you create a form 
	// it gets deleted and duplicated by mathjax, so you cant work with the first instance, because 
	// all you do with it will get deleted and overwritten by a new fresh FormInput
	// THIS takes cares of it 
	/* setTimeout(function() {
		preSet('${rootId}');
	}, 1000); */
	
	
	
	
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