<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<%@ include file="/frontcommon/meta.jsp" %>
<%@ include file="/frontcommon/style_script.jsp"%>
<title>后台管理系统</title>
<decorator:head/>
<script type="text/javascript">
	if(top.location!=self.location)
	{
		top.location=self.location;
	}
</script>
</head>
<body>
<%@ include file="/frontcommon/top.jsp" %>
<decorator:body/>
<%@ include file="/frontcommon/bottom.jsp" %>
</body>
</html>

