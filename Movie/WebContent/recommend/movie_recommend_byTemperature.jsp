<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%String nick = (String)session.getAttribute("nick"); %>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript">
	$(document).ready(function() {
		
		var latitude, longitude;
		var API_KEY = '19eab104c69d6fa4c412bfe0078fdd0d';
		var temp = '0';
		var weather = 'no';
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
					sessionStorage.setItem("temp",temp);
					sessionStorage.setItem("weather",weather);
					var temperature = sessionStorage.getItem("temp");
					$.ajax('MovieGetTemp.mo',{
						method : "get",
						dataType : "json",
						async: false,
						data : {
							temp : temperature
						},
						success : function(data){
							
							if(data[0].movieTitle){
								$('.tempMovie').prepend('<h1>오늘같은 날씨에 어울리는 영화들!</h1>')
							}
							$.each(data,function(index,item){
								
								// 디자인 맞춤때문에 코드 수정 - 낙원 : 1019 [S]
								 $('.MovieTemp').append("<div class=MovieTempMovie>"+
				                  			'<a class=MovieTempPoster><div class=poster style="background-image: url('+item.moviePoster+'),url(${pageContext.request.contextPath}/img/noImage.gif;"></div></a>'+
// 				                  			 '<div class=nation>'+item.nation+'</div>'+ // 국가 undefined떠서 주석처리 해둠 - 낙원 : 1016
				                  			 '<div class=title>'+item.movieTitle+'</div></div>');   
								
				                   $('.MovieTempPoster').eq(index).attr('href','MovieDetailPro.mo?movieSeq='+item.movieSeq+'&query='+item.movieTitle);
								// 디자인 맞춤때문에 코드 수정 - 낙원 : 1019 [E]
				                   
							});
							
							$('.MovieTemp').slick({
						     	   dots: false,
						            infinite: false,
						            arrows: true,
						            variableWidth:true,
						            speed: 300,
						            slidesToShow: 4,
						            slidesToScroll: 3,
						     	   responsive: [
						     	     {
						     	       breakpoint: 1024,
						     	       settings: {
						     	         slidesToShow: 3,
						     	         slidesToScroll: 3,
						     	         infinite: false,
						     	         dots: false
						     	       }
						     	     },
						     	     {
						     	       breakpoint: 600,
						     	       settings: {
						     	         slidesToShow: 2,
						     	         slidesToScroll: 2
						     	       }
						     	     },
						     	     {
						     	       breakpoint: 480,
						     	       settings: {
						     	         slidesToShow: 1,
						     	         slidesToScroll: 1
						     	       }
						     	     }
						     	   ]
						     	 });	
						}
					
						
					});
				}
			});
		}
			
		window.addEventListener("load",getLocation);
			
		
	});
	
	
</script>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet">
</head>
<body>
<input type="hidden" id="temp">
	<div class="tempMovie">
		<div class="MovieTemp"></div>
	</div>
</body>
</html>