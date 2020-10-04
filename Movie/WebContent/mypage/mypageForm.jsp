<%@page import="member.vo.MemberBean"%>
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
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/mypageboard.css" rel="stylesheet" type="text/css">
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
			<li><a href="MypageForm.mp">마이 페이지</a></li>
			<li><a href="MypageGrade.mp">평가한 영화</a></li>
			<li><a href="MypageWish.mp">좋아요 누른 영화</a></li>
			<li><a href="BoardReviewList.bo">리뷰</a></li>
			
		</ul> 
	</div> 
	<!-- 왼쪽메뉴 -->
	
		<div id="myinfo"> 
			<form action="MypagePro.mp" method="post" name="mypageform">
			이메일
			<input type="email" id="email" name="email" value="<%=memberBean.getEmail()%>"><br>
			닉네임
			<input type="text" id="nick" name="nick" value="<%=nick%>" >
	<!-- 		중복체크 -->
			<input type="button" id="dupchek" name="dupchek" value="중복체크" ><br>
			소개
			<input type="text" id="infoup" name="info"><br>
			선호하는 감독<br>
			<input type="button" id="update" name="update" value="등록"> 
			</form>
		</div>
	</section>
</body>
</html>