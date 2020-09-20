<%@page import="board.vo.PageInfo"%>
<%@page import="board.vo.ReviewBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
ArrayList<ReviewBean> reviewList = (ArrayList<ReviewBean>) request.getAttribute("reviewList");
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
    
    <h1><%=nick %> 님이 남긴 리뷰</h1>
     
    
    <section>
        
        <%
        if(reviewList != null && listCount > 0) {
        %>
<!--             <div>No. </div> -->
<!--             <div>닉네임 </div> -->
<!--             <div>별점 </div> -->
<!--             <div>영화제목 </div> -->
<!--             <div>내용 </div> -->
<!--             <div>좋아요 </div> -->
            
            <%
            for(int i = 0; i < reviewList.size(); i++) {
            %>
                <div>닉네임 - <a href="Mypage.mp?idx=<%=reviewList.get(i).getIdx() %>&page=<%=nowPage %>">
                    <%=reviewList.get(i).getNick() %></a></div>
                <div>별점 - <%=reviewList.get(i).getGrade() %></div>
                <div>장르 - <%=reviewList.get(i).getGenre() %></div>
                <div>영화번호 - <%=reviewList.get(i).getMovieSeq() %></div>
                <div>영화제목 -<a href="MovieDetailPro.mo?query=<%=reviewList.get(i).getTitle() %>&movieSeq=<%=reviewList.get(i).getMovieSeq() %>"><%=reviewList.get(i).getTitle() %></a> </div>
                <div>타입 - <%=reviewList.get(i).getType_name() %></div>
                <div>내용 - <%=reviewList.get(i).getContent() %></div>
                <div>좋아요 - <%=reviewList.get(i).getLike_count() %></div>
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