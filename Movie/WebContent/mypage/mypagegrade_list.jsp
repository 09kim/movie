<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%String nick = (String)session.getAttribute("nick"); %>
<meta charset="UTF-8">
<title>MyPage - GradeList</title>
</head>
<body>
<jsp:include page="/inc/top.jsp" />
<br><br><br><br>
내가 평가한 영화 목록
<div id="gradelist">
	<ul>
		<li>
			<a>Poster</a>
			<div id="movieInfo">
				<div>Title</div>
				<div>Grade</div>
			</div>
			
		</li>
	</ul>

</div>
</body>
</html>