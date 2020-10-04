<%@page import="mypage.vo.CollectionBean"%>
<%@page import="mypage.vo.MypageBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% ArrayList<CollectionBean> collection = (ArrayList<CollectionBean>)(request.getAttribute("collection")); 
   String nick = (String)session.getAttribute("nick"); %>

<!DOCTYPE html>
<html>
<head>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/mypagewish.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/mypageboard.css" rel="stylesheet" type="text/css">
<script src="../../../Movie/js/jquery-3.5.1.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('#addMov').click(function(){
			window.open("CollectionSearch.mo",
					"open the window",
					"toolbar=no, width=1000, height=850, top=150, left=150");
		});
			
// 		$('#movies').append("<li>" + $('#hiddenTitle').val() +"</li>");
// 		alert($('#hiddenTitle').val());
		
		
	});
</script>
<meta charset="UTF-8">
<title></title>
<%-- <% String title = (String)session.getAttribute("title"); %> --%>
<%-- <% String nick = (String)session.getAttribute("nick"); %> --%>
<%-- <% String poster = (String)session.getAttribute("poster"); %> --%>
<%-- <% Integer movieSeq = (Integer)session.getAttribute("movieSeq"); %> --%>
<%-- <% ArrayList<CollectionBean> list = (ArrayList<CollectionBean>)(session.getAttribute("list")); %> --%>

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
			<li><a href="BoardReviewList.bo">리뷰</a></li>
		</ul> 
	</div> 
	
	<div>
		<h2>컬렉션 페이지</h2>
		<div>
			<form action="/Movie/MypageCollectionCreate.mp" method="post">
				<input type="text" name="subject"><br>
				<textarea name ="content"></textarea><br>
				<input type="button" value="작품추가" id="addMov">
				<div id="movies">
<%-- 				  <% if(title != null && nick != null && poster != null && !(movieSeq.equals(null))) {%> --%>
<%-- 				  <%for(int i = 0; i < list.size(); i++) {%> --%>
<%-- 				  	<%= list.get(i).getTitle() %> --%>
<%-- 				   <%= nick %> --%>
<%-- 				    <%= title %> --%>
<%-- 				    <%= poster %> --%>
<%-- 				    <%= movieSeq %>  --%>
<%-- 				    <% } %> --%>
<%-- 				    <%} %> --%>
				    

				</div>
				<input type="submit" value="생성">
	
			</form>
			
			<div>
<%-- 				<%=nick %> 님의 컬렉션 목록 <br> --%>
<%-- 				<% for(int i = 0; i < collection.size(); i++) {%> --%>
<%-- 					<%=collection.get(i).getCollection_name() %> --%>
<%-- 					<%for(int o = 0; o < collection.get(i).getTitle().length(); o++){%> --%>
<%-- 						<%=collection.get(o).getTitle().split(",")%> --%>
<%-- 						<%=collection.get(o).getMovieSeq().split(",")%> --%>
<%-- 						<%=collection.get(o).getPoster().split(",")%> --%>
<%-- 					<%} %><br> --%>
					
					
<%-- 			<%}%> --%>
			</div>
		</div>
	</div>
	
	
	
</section>

	
</body>
</html>