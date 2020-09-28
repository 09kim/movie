<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%String nick = (String)session.getAttribute("nick"); %>
<script src="../../../Movie/js/jquery-3.5.1.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	var latitude, longitude;
	var API_KEY = '19eab104c69d6fa4c412bfe0078fdd0d';
	var temp,weather;
	
	function getLocation(){
		window.navigator.geolocation.getCurrentPosition(current_position);
	}
	
	function current_position(position){
		latitude = position.coords.latitude;
		longitude = position.coords.longitude;
		$.ajax("https://api.openweathermap.org/data/2.5/weather?lat="+latitude
				+"&lon="+longitude+"&appid="+API_KEY+"&units=metric&lang=kr",{
			dataType:"json",
			async:false,
			success:function(data){
				$('#temp').val(data.main.temp);
				$('#weather').val(data.weather[0].main);
				temp = $('#temp').val();
				weather = $('#weather').val();
				
			}
		});
	}
		
	window.addEventListener("load",getLocation);
});
</script>

<!-- <meta charset="utf-8"> -->
<!-- <meta http-equiv="X-UA-Compatible" content="IE=edge"> -->
<!-- <meta name="viewport" content="width=device-width, initial-scale=1"> -->
<%-- <link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet"> --%>
<!-- <script src="js/bootstrap.min.js"></script> -->

<meta charset="UTF-8">
<title></title>
</head>
<body>
	<input type="hidden" id="temp">
	<input type="hidden" id="weather">
	<jsp:include page="/inc/top.jsp" />
	<div class="clear"></div>
	<jsp:include page="/recommend/movie_ranking.jsp"/>
	<%if(nick!=null) {
	%><jsp:include page="/recommend/expected_grade_chart.jsp"/><%
	}%>
	<jsp:include page="/recommend/naver_search_ranking.jsp"/>
</body>
</html>