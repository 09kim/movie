<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%String nick = (String)session.getAttribute("nick");%>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.min.css">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.js"></script>






<meta charset="UTF-8">
<title>메인</title>
</head>
<body> 
	<div style="width:100%;position: sticky !important;top:0;z-index: 100;">
	<jsp:include page="/inc/top.jsp"/>
	<div class="clear"></div>
	</div>
	<div class="side_banner">
	<img src="${pageContext.request.contextPath}/img/background/side_banner.jpg" onerror="${pageContext.request.contextPath}/img/noImage.gif" style="width:250px;height:600px;">
	<img src="${pageContext.request.contextPath}/img/background/side_banner2.jpg" onerror="${pageContext.request.contextPath}/img/noImage.gif" style="width:250px;height:600px;">
	<img src="${pageContext.request.contextPath}/img/background/side_banner3.jpg" onerror="${pageContext.request.contextPath}/img/noImage.gif" style="width:250px;height:600px;">
	<img src="${pageContext.request.contextPath}/img/background/side_banner4.jpg" onerror="${pageContext.request.contextPath}/img/noImage.gif" style="width:250px;height:600px;">
	</div>
	<input type="hidden" id="temp">
	<input type="hidden" id="weather">
	<section id="main">
	<div class="content">
	<jsp:include page="/recommend/movie_ranking.jsp"/>
	</div>
	<div class="content">
	<jsp:include page="/recommend/movie_recommend_byChart.jsp"/>
	</div>
	<div class="content">
	<jsp:include page="/recommend/movie_recommend_byTemperature.jsp"/>
	</div>
	<%if(nick!=null) {
 		%> 
			<div class="content">
			<jsp:include page="/recommend/expected_grade_chart_byPython.jsp"/>
			</div>
			<div class="content">
			<jsp:include page="/recommend/movie_recommend_byGenre.jsp"/>
			</div>
			<div class="content">
			<jsp:include page="/recommend/movie_recommend_byNation.jsp"/>
			</div>
		<%
 	}%>
	<div class="content">
	<jsp:include page="/recommend/naver_search_ranking.jsp"/>
	</div>
	</section>
	<div class="moveTop" style="cursor:pointer;">TOP</div>
	
	
	
	
	
<script type="text/javascript">
$(document).ready(function(){
   
      // 상단 이동 버튼 기능 추가 - 낙원 : 1016[S]
      $( '.moveTop' ).hide(); // 시작시에 hide로 안보이게 함(밑에 함수는 스크롤동작을했을때만 동작하므로)
	    $( window ).scroll( function() {
          if ( $( this ).scrollTop() > 200 ) {
            $( '.moveTop' ).fadeIn();
          } else {
            $( '.moveTop' ).fadeOut();
          }
        } );
        $( '.moveTop' ).click( function() {
          $( 'html, body' ).animate( { scrollTop : 0 }, 400 );
          return false;
        } );
      // 상단 이동 버튼 기능 추가 - 낙원 : 1016[E]
        
        $('.side_banner').slick({
        	autoplay:true,
        	autoplaySpeed:5000,
//         	variableWidth: true,
        	slidesToShow: 1,
        	  dots: false,
        	     infinite: true,
        	     arrows: false
        });
        
}); // ready()끝;
      
</script>

</body>
</html>