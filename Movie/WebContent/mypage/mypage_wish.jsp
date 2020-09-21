<%@page import="mypage.vo.MypageBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String nick = (String) session.getAttribute("nick");
ArrayList<MypageBean> wishMovie = (ArrayList<MypageBean>)request.getAttribute("wishMovie");
%>
<!DOCTYPE html>
<html>
<head>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/mypagewish.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/mypageboard.css" rel="stylesheet" type="text/css">
<script src="../../../Movie/js/jquery-3.5.1.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('.btn-like').each(function() {
			var wishInfo = $(this).val().split(",");
			var wish = wishInfo[2];

			if (wish == "Y") {
				$(this).addClass("done");
			} else { // 기본이 없는 클래스라 remove가 필요없음
				$(this).removeClass("done");
			}
		});

		$('.btn-like').click(function() {
				var wishInfo = $(this).val().split(",");
				var nick = wishInfo[0];
				var title = wishInfo[1];
				var wish = wishInfo[2];
				var movieSeq = wishInfo[3];
				var idx = wishInfo[4];
 			if (confirm(title + "을(를) 보고싶어요 리스트에서 제외 하시겠습니까?")) {

	   			 $.ajax('MypageChangeWish.mp',{
	   					data:{nick:nick,movieSeq:movieSeq,title:title},
	   					success:function(rdata){
	  			 				if(rdata=="Y"){
	  	   							window.location.replace("http://localhost:8080/Movie/MypageWish.mp");
  	   							}
	   						}
	 					});
	 			} else {
	 				alert("취소 하셨습니다.");
	 			}
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
		</ul> 
	</div> 
	
	<div id="myinfo">
		<section id="listForm">
		<h2><%=nick %>님의 보고싶어요 리스트</h2>
		<table>
				<tr>
		<% for(MypageBean wishInfo : wishMovie) {%>
					<td id="wishMovie" align="center">
					<%if(wishInfo.getPoster()!=null){ %>
					<a href="MovieDetailPro.mo?movieSeq=<%=wishInfo.getMovieSeq()%>&query=<%=wishInfo.getTitle()%>"><img src="<%=wishInfo.getPoster()%>"></a><br><%=wishInfo.getTitle() %>
					<%} else { %>
					<a href="MovieDetailPro.mo?movieSeq=<%=wishInfo.getMovieSeq() %>&query=<%=wishInfo.getTitle()%>"><img src="../../../Movie/img/noImage.gif"></a><br><%=wishInfo.getTitle() %>
					<%} %>
					<%if(wishInfo.getWish().equals("Y")){ %>
					<button class="btn-like" value="<%=nick%>,<%=wishInfo.getTitle() %>,<%=wishInfo.getWish() %>,<%=wishInfo.getMovieSeq() %>,<%=wishInfo.getIdx()%>">❤️</button></td>
					<% }%>
			<%}%>
			</tr>
		</table>
		</section>
	</div>
</section>

	
</body>
</html>