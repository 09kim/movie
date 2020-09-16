<%@page import="board.vo.ReviewBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
ReviewBean reviewBean = (ReviewBean) request.getAttribute("reviewBean");
String nowPage = (String) request.getAttribute("nowPage");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <h2>리뷰내용 상세보기</h2>
        <section>
	        <div>닉네임 - <%=reviewBean.getNick() %></div>
	        <div>별점 - <%=reviewBean.getGrade() %></div> 
	        <div>내용 - <%=reviewBean.getContent() %></div>
	        <div>좋아요 - <%=reviewBean.getLike_count() %></div>
        </section>
        <section>
            <a href="BoardReviewReplyForm.bo?idx=<%=reviewBean.getIdx() %>&page=<%=nowPage %>"> [답변] </a>
            <a href="BoardReviewModifyForm.bo?idx=<%=reviewBean.getIdx() %>"> [수정] </a>
            <a href="BoardDeleteForm.bo?idx=<%=reviewBean.getIdx() %>&page=<%=nowPage %>"> [삭제] </a>
            <a href="BoardReviewList.bo?page=<%=nowPage %>">[목록] </a>
            &nbsp;&nbsp;
        </section>
        
</body>
</html>