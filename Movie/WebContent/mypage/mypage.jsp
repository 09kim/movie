<%@page import="vo.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    MemberBean memberBean = (MemberBean)request.getAttribute("memberBean");
//     String email = (String)session.getAttribute("email");
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
		<input type="email" id="email" name="email" value="<%=memberBean.getEmail()%>"><br>
		닉네임
		<input type="text" id="nick" name="nick" value="<%=nick%>" ><br>
		소개
		<input type="text" id="infoup" name="info"><br>
		선호하는 감독 <br>
		<a href="MypageForm.mp">프로필수정</a>
		
	</div>
</body>
</html>