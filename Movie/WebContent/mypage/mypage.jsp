<%@page import="vo.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    MemberBean member = (MemberBean)request.getAttribute("member");
    String email = (String)session.getAttribute("email");
    String nick = (String)session.getAttribute("nick");

	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		이메일
		<input type="email" id="email" name="email" value="<%=member.getEmail()%>" readonly><br>
		닉네임
		<input type="text" id="nick" name="nick" value="<%=nick%>" >
		<input type="button" id="nickdup" value="중복체크" Onclick="location.href=member_insert_Form.jsp"><br>
		소개
		<input type="text" id="info" name="info"><br>
		선호하는 감독
		
	</div>
</body>
</html>