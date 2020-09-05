<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="css.mo" type="text/css" rel="stylesheet">
<%String nick = (String)session.getAttribute("nick"); %>
<meta charset="UTF-8">
<title></title>
</head>
<body>

<jsp:include page="/inc/top.jsp" />
<div class="clear"></div>
<%if(nick == null){ %>
<!-- <a href="GradeMovie.mo">평점</a> -->
<!-- <a href="MemberLoginForm.me">로그인</a> -->
<a href="MemberJoinForm.me">회원가입</a>
<a href="MovieRanking.mo">박스오피스</a>
<%} else if(nick.equals("admin")){%>
<!-- <a href="GradeMovie.mo">평점</a> -->
<!-- <a href="MemberLogout.me">로그아웃</a> -->
<a href="MemberList.me">회원관리</a>
<a href="">회원관리</a>
<%} else{ %>
<!-- <a href="GradeMovie.mo">평점</a> -->
<!-- <a href="MemberLogout.me">로그아웃</a> -->
<a href="mypage.mo?nick=<%=nick%>">마이페이지</a>
<a href="MovieRanking.mo">박스오피스</a>
<%} %>
<br>


</body>
</html>