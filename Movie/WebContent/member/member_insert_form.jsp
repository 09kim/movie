<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="MemberWritePro.me">
이메일 : <input type="text" name="email"> &nbsp;&nbsp; <input type="button" value="이메일 중복체크" id="dupEmail"> <br> 
패스워드 : <input type="password" name="pass"> <br> 
닉네임 : <input type="text" name="nick"> &nbsp;&nbsp; <input type="button" value="닉네임 중복체크" id="dupNick"> <br>
연락처 : <input type="text" name="phone"> &nbsp;&nbsp; <input type="button" value="연락처 중복체크" id="dupNick"> <br>
<input type="submit" value="가입">
</form>
</body>
</html>