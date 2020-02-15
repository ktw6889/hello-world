<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0" />
<title>공통 저장</title>
</head>
<script type="text/javascript">
<%
String flag = (String)request.getAttribute("FLAG");
String infos = (String)request.getAttribute("INFOS");

if("SAVESUCCESS".equals(flag)) {
%>
	if(parent.page.controller.saveSuccess) {
		parent.page.controller.saveSuccess('<%=infos%>');
	}
<%
} else if("SAVEFAIL".equals(flag)) {
%>
	if(parent.page.controller.saveFail) {
		parent.page.controller.saveFail();
	}
<%	
} else {
%>
	if(parent.page.loading) {
		parent.page.loading(false);	
	}
<%	
}
%>
</script>
<body>
공통 저장
</body>
</html>