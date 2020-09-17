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
				<li><a href="MypageWish.mp">좋아요 누른 영화</a></li>
			</ul>
		</div>
		<!-- 왼쪽메뉴 -->

		<div id="myinfo">
			내가 평가한 영화 목록 :<span><%=listCount%></span>
			<%
				if (gradeList != null && listCount > 0) {
				for (int i = 0; i < gradeList.size(); i++) {
			%>
			<div id="gradelist">
				<ul>
					<li><a>Poster</a>
						<div id="movieInfo">
							<div><%=gradeList.get(i).getTitle()%></div>
							<div><%=gradeList.get(i).getGrade()%></div>
							<!--
						 2.0으로 나누기 끝자리 0이면 정수로만보여주기 나머지가 0이면 인트 등등방법  -->
						</div></li>
				</ul>
			</div>
			<%
				}
			} else {
			%>
			아직 평가한 영화가 없습니다.
			<%
				}
			%>
		</div>
	</section>
</body>
</html>