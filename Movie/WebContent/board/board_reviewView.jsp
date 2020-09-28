<%@page import="board.vo.ReplyBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.vo.ReviewBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
ArrayList<ReviewBean> reviewList = (ArrayList<ReviewBean>)request.getAttribute("reviewList");
String nick = (String)session.getAttribute("nick"); 
int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/mypagewish.css" rel="stylesheet" type="text/css">

</head>
<jsp:include page="/inc/top.jsp" /><br><br>
<div class="clear"></div>
<body>
    <h2>리뷰내용 상세보기</h2>
         <%
            for(int i = 0; i < reviewList.size(); i++) {
            %>
                <div>닉네임 - <%=reviewList.get(i).getNick() %></div>
                <div>별점 - <%=reviewList.get(i).getGrade() %></div>
                <div>내용 - <%=reviewList.get(i).getContent() %></div>
                <hr>
                <div>좋아요 - <%=reviewList.get(i).getLike_count() %></div>
                <input type="hidden" id="" value="<%=reviewList.get(i).getIdx() %>">
                <hr>
                <input id="like_count" name="like_count" type="button" value="좋아요">
                <a href="BoardReviewDetail.bo?movieSeq=<%=reviewList.get(i).getMovieSeq() %>&idx=<%=reviewList.get(i).getIdx() %>">댓글</a>
                <hr>
               
                
          <%} %>
              
</body>
</html>