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
	<section>
		<form action="MypagePro.mp" method="post" name="mypageform">
		이메일
		<input type="email" id="email" name="email" value="<%=memberBean.getEmail()%>"><br>
		닉네임
		<input type="text" id="nick" name="nick" value="<%=nick%>" >
<!-- 		중복체크 -->
		<input type="button" id="dupchek" name="dupchek" value="중복체크"><br>
<!-- 		<button onclick="location.href='dupchek'">중복체크</button><br> -->
		소개
		<input type="text" id="infoup" name="info"><br>
		선호하는 감독<br>
<!-- 		<input type="button" id="update" name="update" value="등록">  -->
		</form>
	</section>
<!-- 	<section id="update"> -->
<!-- 	<input type="submit" value="등록" />&nbsp;&nbsp; -->
<!-- 	</section> -->
</body>
</html>
















