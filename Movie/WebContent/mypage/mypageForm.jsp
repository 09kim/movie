<%@page import="member.vo.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	MemberBean memberBean = (MemberBean) request.getAttribute("memberBean");
//     String email = (String)session.getAttribute("email");
String nick = (String) session.getAttribute("nick");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/css/default.css"
	rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/mypageboard.css"
	rel="stylesheet" type="text/css">
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
				<li><a href="BoardReviewList.bo">리뷰</a></li>
			</ul>
		</div>
		<!-- 왼쪽메뉴 -->

		<div id="myinfo">
			<!-- css / 프로필 박스 (프로필 사진 및 수정 기능 넣을 곳) -->
			<div id="profilebox">
				<form action="MypagePro.mp" method="post" name="mypageform">
					<article id="profile-article">
						<div class="img-box">
							<img class="profile" src="img/noneprofile.png">
						</div>

						<div class="info-box">
							<input type="text" id="nick" name="nick" value="<%=nick%>"><br>
							<input type="email" id="email" name="email"
								value="<%=memberBean.getEmail()%>"><br>
							<textarea rows="5" cols="30" id="infoup" name="info">
						<%
							if (memberBean.getBio() != null) {
							out.print(memberBean.getBio());
						} else {
							out.print("소개글을 작성해주세요.");
						}
						%>
						</textarea>
						</div>

						<div class="clear"></div>
						<div class="profile-update">
							<input type="submit" id="update" name="update" value="수정">
							<input type="button" value="취소"
								onclick="location.href='Mypage.mp'">
						</div>
					</article>
				</form>
			</div>
		</div>
	</section>
</body>
</html>