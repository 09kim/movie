<%@page import="mypage.vo.MypageBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String nick = (String) session.getAttribute("nick");
ArrayList<MypageBean> gradeList = (ArrayList<MypageBean>) request.getAttribute("gradeList");
int listCount = (int) request.getAttribute("listCount");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyPage - GradeList</title>
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
			</ul>
		</div>
		<!-- 왼쪽메뉴 -->

		<div id="myinfo">
			<header class="grade-header">
				<h2>내가 평가한 영화</h2> <span><%=listCount%></span>
			</header>
			<div class="clear"></div>
			<hr>
			<div class="clear"></div>
			<div id="gradelist">
				<ul>
			<%
				if (gradeList != null && listCount > 0) {
				for (int i = 0; i < gradeList.size(); i++) {
			%>
					<li><a>Poster</a>
						<div id="movieInfo">
							<div><%=gradeList.get(i).getTitle()%></div>
							<div>
							<% 
							double grade = gradeList.get(i).getGrade();
							if((grade % 2.0) == 0){
								out.print((int)(grade/2.0));
							}else {
								out.print(grade/2.0);
							}
							%>
							</div>
							<!--
						 2.0으로 나누기 끝자리 0이면 정수로만보여주기 나머지가 0이면 인트 등등방법  -->
						</div></li>
			<%
				}
			} 	
				else {
			%>
			<li>아직 평가한 영화가 없습니다.</li>
			<%
				}
			%>
				</ul>
			</div>
		</div>
	</section>
</body>
</html>