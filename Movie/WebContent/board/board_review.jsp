<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../../../Movie/js/jquery-3.5.1.js"></script>
<script type="text/javascript">

$(document).ready(function() {
	
	$.ajax('ReviewPro.mo', {
		data:{
	
		},
		success: function(data) {
			alert("성공");
		}
		
	});
	
	$('#btn').one("click", function(data) {
		$.ajax('ReviewPro.mo', {
			data: {
				secret: $('#secret').val(),
				review: $('#review').val(),
				star: $('#star').val()
			},
			success: function(data) {
// 				$('div').html(data);
			    $('#reviewCommand').append('<textarea id=review cols=50 rows=20 placeholder="내용"></textarea>')
			    $('#reviewCommand').append('<input type=checkbox id=secret> 비밀댓글')
                $('#reviewCommand').append('<div class=star>별점</div>')
                $('#reviewCommand').append('<input type="button" value="확인" id="ok">')
                
			}
		});
	});
	
});

</script>
</head>
<body>
<%
String title = request.getParameter("title");
String genre = request.getParameter("genre");
String openDt = request.getParameter("openDt");

%>
   <h1>리뷰</h1>
   
   <div>영화 포스터</div> <!-- 영화 포스터 -->
   <div id="title"><%=title %></div> <!-- 영화 제목 -->
   <div id="openDate"><%=openDt %></div> <!-- 개봉일 -->
   <div id="genre"><%=genre %></div> <!-- 장르 -->
   <div id="nation">국가</div> <!-- 제작국가 -->
   
   <hr>
   
   <input type="button" value="보고싶어요" id="btn">
   <div id="reviewCommand"></div>
<!--    <div id="secret"></div> -->
<!--    <div id="star"> 별점</div> -->
   
   <hr>
   

</body>
</html>