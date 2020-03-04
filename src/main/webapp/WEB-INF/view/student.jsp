<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html>
  <tiles:insertDefinition name="header" />
  <body>
    <tiles:insertDefinition name="nav" />
    <iframe width="100%" height="100%" src="../${login}/misTeoremas" frameborder="0"></iframe>
    <tiles:insertDefinition name="footer" />
  </body>
</html>
