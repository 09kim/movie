<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- <meta charset="utf-8"> -->
<!-- <meta http-equiv="X-UA-Compatible" content="IE=edge"> -->
<!-- <meta name="viewport" content="width=device-width, initial-scale=1"> -->
<%-- <link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet"> --%>
<!-- <script src="js/bootstrap.min.js"></script> -->

<%String nick = (String)session.getAttribute("nick"); %>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<jsp:include page="/inc/top.jsp" />
	<div class="clear"></div>
	<section id="main"></section>
	<a href="Python.me?nick=<%=nick%>">파이썬테스트</a>
</body>
</html>