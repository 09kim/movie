<%@page import="member.vo.MemberBEAN"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    MemberBEAN member = (MemberBEAN)request.getAttribute("member");
//     String email = (String)session.getAttribute("email");
//     String nick = (String)session.getAttribute("nick");
    
    
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		이메일<br>
		<input type="email" id="email" name="email" value="<%=member.getEmail()%>" >
		닉네임<br>
		<input type="text" id="nick" name="nick" value="<%=member.getNick()%>" >
		소개<br>
		<input type="text" id="info" name="info">
	</div>
</body>
</html>