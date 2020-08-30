<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="MovieSearch.mo">
<input type="text" name="query">
<input type="submit" value="검색">
</form>
<%if(session.getAttribute("email") == null){ %>
<a href="GradeMovie.mo">평점</a>
<a href="MemberLoginForm.me">로그인</a>
<a href="MemberJoinForm.me">회원가입</a>
<%} else if(session.getAttribute("email").equals("admin")){%>
<a href="GradeMovie.mo">평점</a>
<a href="MemberLogout.me">로그아웃</a>
<a href="MemberJoinForm.me">회원관리</a>
<%} else{ %>
<a href="GradeMovie.mo">평점</a>
<a href="MemberLogout.me">로그아웃</a>
<a href="MemberJoinForm.me">마이페이지</a>
<%} %>


</body>
</html>