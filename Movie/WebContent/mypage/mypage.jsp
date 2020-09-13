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
<title>MyPage - MyPage</title>
<link href="css/default.css" rel="stylesheet" type="text/css">
<link href="css/mypageboard.css" rel="stylesheet" type="text/css">
</head>
<body>
<!-- 헤더 -->
<jsp:include page="/inc/top.jsp" />
<div class="clear"></div>
<!-- 헤더 -->

<section id="main">
	<!-- 왼쪽메뉴 -->
	<div id="sub_menu"> 
		<ul>
			<li><a href="Mypage.mp">마이 페이지</a></li>
			<li><a href="MypageGrade.mp">평가한 영화</a></li>
			<li><a href="MypageSelectWish.mp">좋아요 누른 영화</a></li>
		</ul> 
	</div> 
	
	<div id="myinfo">
		이메일
		<input type="email" id="email" name="email" value="<%=memberBean.getEmail()%>"><br>
		닉네임
		<input type="text" id="nick" name="nick" value="<%=nick%>" ><br>
		소개
		<input type="text" id="infoup" name="info"><br>
		선호하는 감독 <br>
		<a href="MypageForm.mp">프로필수정</a>
	</div>
</section>
</body>
</html>