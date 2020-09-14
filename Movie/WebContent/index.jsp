<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%String nick = (String)session.getAttribute("nick"); %>
<meta charset="UTF-8">
<title></title>
<!-- <link href="css/default.css" rel="stylesheet" type="text/css"> -->
</head>
<body>
<jsp:include page="/inc/top.jsp" />
<div class="clear"></div>
<section id="main">
</section>
<a href="Python.me?nick=<%=nick%>">파이썬테스트</a>
</body>
</html>