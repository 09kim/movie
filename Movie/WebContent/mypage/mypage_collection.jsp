<%@page import="javax.websocket.OnClose"%>
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
// function deleteCollection(id){
	
// }
	$(document).ready(function() {
		$('#addMov').click(function(){
			window.open("CollectionSearch.mo",
					"open the window",
					"toolbar=no, width=1000, height=850, top=150, left=150");
		});
		
		$('#showAddCollection').click(function(){
			if($('#showDisplay').css('display') == "none"){
				$('#showDisplay').show();
				$('#showAddCollection').val('컬렉션 추가창 닫기');
			} else {
				$('#showDisplay').hide();
				$('#showAddCollection').val("컬렉션 추가");
			}
		})
			
// 		$('#movies').append("<li>" + $('#hiddenTitle').val() +"</li>");
// 		alert($('#hiddenTitle').val());
		$('#submit').click(function(){
			if($('#subject').val() == ''){
				alert("제목을 입력하세요")
				return false;
			}
			if($('#content').val() == ''){
				alert("내용을 입력하세요")
				return false;
			}
			if($('#movieSeq').length < 1){
				alert("영화를 선택하세요");
				return false;
			} 
		})
		
		
	
				
		
		$('.delBtn').click(function(){
			var idx = $(this).attr('id')
			$.ajax('CollectionDelete.mp',{
				
				data:{idx:idx},
				success:function(rdata){
		      		  

					}
				});
		});
			
		
		
	});
</script>
<meta charset="UTF-8">
<title></title>
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
			<li><a href="MypageCollection.mp">컬렉션</a></li>  
		</ul> 
	</div> 
	
	<div>
		<h2>컬렉션 페이지</h2>
		<div>
			<input type="button" id="showAddCollection" value="컬렉션 추가 하기">
		  <div id="showDisplay" style= display:none>
			<form action="/Movie/MypageCollectionCreate.mp" method="post">
				<h3>컬렉션 이름</h3><input type="text" name="subject" id="subject"><br>
				<h3>컬렉션 내용</h3><textarea name ="content" id="content"></textarea><br>
				<input type="button" value="작품추가" id="addMov">
				<div id="movies">
				    

				</div>
				<input type="submit" value="생성" id="submit">
	
			</form>
			</div>
			<br>
			<section>
				<%=nick %> 님의 컬렉션 목록 <br>
				<% for(int i = 0; i < collection.size(); i++) {%>
					<h2>컬렉션 명:<%=collection.get(i).getCollection_name() %></h2><input type="button" class ="delBtn" id="<%=collection.get(i).getIdx()%>" onclick="deleteCollection(this.id)" value="삭제"><br>
					<h4>컬렉션 내용:<%=collection.get(i).getContent() %></h4><br>
					<%for(int o = 0; o < collection.get(i).getTitle().split(",").length; o++){%>
						<img src="<%=collection.get(i).getPoster().split(",")[o]%>"><br>
						<a href="MovieDetailPro.mo?movieSeq=<%=collection.get(i).getMovieSeq().split(",")[o]%>
						&query=<%=collection.get(i).getTitle().split(",")[o]%>"><%=collection.get(i).getTitle().split(",")[o]%></a><br>
<%-- 						<%=collection.get(i).getMovieSeq().split(",")[o]%><br> --%>
					<%} %><br>
					
					
			<%}%>
			</section>
		</div>
	</div>
	
	
	
</section>

	
</body>
</html>