<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<c:choose>
    <c:when test='${collapse.equals("collapse")}'>
      <div class="row justify-content-center form-group">
	<a class="btn btn-primary" data-toggle="collapse" href="#symbolsTable" role="button" aria-expanded="false" aria-controls="symbolsTable">
		Operators:
	</a>
      </div>
    </c:when>
</c:choose>
<div class="${collapse} form-group" id="symbolsTable">
       <div class="btn-toolbar justify-content-center" role="toolbar" aria-label="Toolbar with button groups">
       <%-- THIS SECTION IF FOR SYMBOL BUTTONS--%>
	   <div class="btn-group mr-2 flex-wrap" role="group" aria-label="First group">
	  	<c:forEach items="${simboloList}" var="symbol"> 
	  		<button style="font-size: 50%;" type="button" class="btn btn-default" 
	  		onmousedown="insertAtMathjaxDiv('${symbol.fullLatexNotation('\\FormInput{0}', true)}', ${symbol.getId()}, false);return false;">
	  		$$${symbol.fullLatexNotation("\\Box", false)}$$
	  		</button>
	  	</c:forEach> 
	   </div> 
	   <%-- THIS SECTION IF FOR ALIAS BUTTONS --%>
	   <div class="btn-group mr-2 flex-wrap" role="group" aria-label="First group">
	  	<c:forEach items="${predicadoList}" var="alias"> 
	  		<button style="font-size: 50%;" type="button" class="btn btn-default" 
	  		onmousedown="insertAtMathjaxDiv('${alias.fullLatexNotation('\\FormInput{0}', true)}', '${alias.getId().getAlias()}', true);return false;">
	  		$$${alias.fullLatexNotation("\\Box", false)}$$
	  		</button>
	  	</c:forEach> 
	   </div>
	   </div>
</div>



<script src="${pageContext.request.contextPath}/static/js/mathjaxAndSymbols.js"></script>
<tiles:insertDefinition name="header" />