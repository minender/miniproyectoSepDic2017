<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html>
  <tiles:insertDefinition name="header" />
  <body>
      <style>
          html,body{
              height: 92%;
          }
          .studentIframe{
              height: 100%;
          }
          .container-fluid{
              height: 100%;
              width: 100%;
          }
          #studentIframe{
              overflow-x: hidden;
          }
      </style>
    <tiles:insertDefinition name="nav" />
    <div style="height : 100% !important" id="iframeSpace">
        <iframe id="studentIframe" width="100%" height="100%" src="../${login}/misTeoremas" frameborder="0"></iframe>
    </div>
    <tiles:insertDefinition name="footer" />
  </body>
</html>
