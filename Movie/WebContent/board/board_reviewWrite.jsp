<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/moviecss/movie.css" rel="stylesheet" type="text/css">

</head>
<jsp:include page="../inc/top.jsp" />
<div class="clear"></div><br><br><br>
<body>
<%
// session.setAttribute("관리자", "nick");
String nick = (String)session.getAttribute("nick");
if(nick == null) {
	response.sendRedirect("/Movie/member/member_login.jsp");
}
%>

<%
// int idx = Integer.parseInt(request.getParameter("idx"));
// // String nick = request.getParameter("nick");
// int grade = Integer.parseInt(request.getParameter("grade"));
// String genre = request.getParameter("genre");
// int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
// String title = request.getParameter("title");
// String type_name = request.getParameter("type_name");
// // String content = request.getParameter("content");
// int like_count = Integer.parseInt(request.getParameter("like_count"));
%>
    <h2>리뷰 작성</h2>
    
    <form action="BoardReviewWritePro.bo" method="post">
        <!-- 나중에 다 불러와야함 -->
        <div>NO. <input type="text" name="idx" ></div>
        <div>닉네임 <input type="text" name="nick" value=<%=nick %> readonly="readonly"></div>
        <div>별점 <input type="text" name="grade" ></div>
        <div>장르 <input type="text" name="genre" ></div>
        <div>영화번호 <input type="text" name="movieSeq" ></div>
        <div>영화제목 <input type="text" name="title" ></div>
        <div>타입 <input type="text" name="type_name" ></div>
        <div>내용 <textarea rows="10" cols="20" name="content"></textarea></div>
        <div>좋아요 <input type="text" name="like_count" ></div>
                
        <input type="submit" value="리뷰달기">
        <input type="reset" value="다시쓰기">
    
    </form>

</body>
</html>