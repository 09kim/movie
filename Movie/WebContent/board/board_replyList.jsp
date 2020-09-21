<%@page import="board.vo.PageInfo"%>
<%@page import="board.vo.ReplyBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
ArrayList<ReplyBean> replyList = (ArrayList<ReplyBean>) request.getAttribute("replyList");
PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
int listCount = pageInfo.getListCount();
int nowPage = pageInfo.getPage();
int maxPage = pageInfo.getMaxPage();
int startPage = pageInfo.getStartPage();
int endPage = pageInfo.getEndPage();
String nick=(String)session.getAttribute("nick");

%>
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
    
    <h1>리뷰의 전체 댓글</h1>
     
    
    <section>
        
        <%
        if(replyList != null && listCount > 0) {
        	
            for(int i = 0; i < replyList.size(); i++) {
            %>
                <div>닉네임 - <a href="Mypage.mp?idx=<%=replyList.get(i).getIdx() %>&page=<%=nowPage %>">
                    <%=replyList.get(i).getNick() %></a></div>
                <div>별점 - <%=replyList.get(i).getGrade() %></div>
                <div>장르 - <%=replyList.get(i).getGenre() %></div>
                <div>영화번호 - <%=replyList.get(i).getMovieSeq() %></div>
                <div>영화제목 -<a href="MovieDetailPro.mo?query=<%=replyList.get(i).getTitle() %>&movieSeq=<%=replyList.get(i).getMovieSeq() %>"><%=reviewList.get(i).getTitle() %></a> </div>
                <div>타입 - <%=replyList.get(i).getType_name() %></div>
                <div>내용 - <%=replyList.get(i).getContent() %></div>
                <div>좋아요 - <%=replyList.get(i).getLike_count() %></div>
                <hr>
                
            <%
            }
            %>   
        </section>
        
        <section>
                <%if(nowPage <= 1){ %>
                        [이전] &nbsp;
                <%} else{ %>
                        <a href="BoardReviewList.bo?page=<%=nowPage-1 %>">[이전]</a> &nbsp;
                <%} %>
            
                <%for(int a = startPage; a <= endPage; a++){
                    if(a == nowPage) { %>
                        [<%=a %>]
                  <%}else{ %>
                        <a href="BoardReviewList.bo?page=<%=a %>">[<%=a %>]</a> &nbsp;
                  <%}
                  } %>
        
                <%if(nowPage >= maxPage){ %>
                    [다음]
                <%} else{ %>
                    <a href="BoardReviewList.bo?page=<%=nowPage+1 %>">[다음]</a>
                <%} %>
    </section>
            <%} else { %>
            
    <section>등록된 글이 없습니다.</section>
            <%} %>

</body>
</html>