<%@page import="java.util.ArrayList"%>
<%@page import="board.vo.ReviewBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
ArrayList<ReviewBean> reviewList = (ArrayList<ReviewBean>)request.getAttribute("reviewList");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <h2>리뷰내용 상세보기</h2>
        <%=reviewList.get(1).getNick() %>
         <%
            for(int i = 0; i < reviewList.size(); i++) {
            %>
                <div>닉네임 - <%=reviewList.get(i).getNick() %></div>
                <div>별점 - <%=reviewList.get(i).getGrade() %></div>
                <div>내용 - <%=reviewList.get(i).getContent() %></div>
                <div>좋아요 - <%=reviewList.get(i).getLike_count() %></div>
                <hr>
                
            <%
            }
            %>   
            
            
</body>
</html>