<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%String nick = (String)session.getAttribute("nick");%>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.min.css">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.js"></script>


<meta charset="UTF-8">
<title>메인</title>
</head>
<body> 
	<input type="hidden" id="temp">
	<input type="hidden" id="weather">
	<jsp:include page="/inc/top.jsp" />
	<div class="clear"></div>
	<section id="main">
	<jsp:include page="/recommend/movie_ranking.jsp"/>
	<jsp:include page="/recommend/movie_recommend_byChart.jsp"/>
	<jsp:include page="/recommend/movie_recommend_byTemperature.jsp"/>
	<%if(nick!=null) {
		%>
			<jsp:include page="/recommend/expected_grade_chart_byPython.jsp"/>
			<jsp:include page="/recommend/movie_recommend_byGenre.jsp"/>
			<jsp:include page="/recommend/movie_recommend_byNation.jsp"/>
		<%
	}%>
	<jsp:include page="/recommend/movie_recommend_byCollection.jsp"/>
	<jsp:include page="/recommend/naver_search_ranking.jsp"/>
	</section>
</body>
</html>