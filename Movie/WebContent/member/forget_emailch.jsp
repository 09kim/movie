<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 낙원(0902:헤더 추가) -->
<jsp:include page="/inc/top.jsp" />
<div class="clear"></div>
<!-- /낙원(0902:헤더 추가) -->


	<form action="ForgetPro.me" method="POST">
		<h2>비밀번호 찾기</h2>
		<hr>
		<h4>입력하신 이메일로 발송된 인증번호를 입력해주세요.</h4>
		이메일 : <input type="text" name="email" required="required"><br>
		<input type="submit" value="다음">
	</form>
</body>
</html>