<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<script src="../../../Movie/js/jquery-3.5.1.js"></script>
<script type="text/javascript">
// 기본검색기능을 담당하는 뷰페이지


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
				temp = data.main.temp;
				weather = data.weather[0].main;
				$('#temp').val(temp);
				$('#weather').val(weather);
			}
		});
	}
		
	window.addEventListener("load",getLocation);
	
	
	
	
		
		var query = $("#query").val();
		var nick = $("#nick").val();
		console.log(nick);
		query = query.replace(/ /g,'');
		$.ajax('MovieSearchPro.mo',{
			method:"post",
			dataType :"json",
			data:{query:query
				},
			success:function(data){
				// 처음 결과 4개의 배열구조
				$.each(data.Data,function(idx,item){
					// 4번째 오브젝드 Data 안에 것을 가져옴
					var count = item.Count
						
					$.each(item.Result,function(idx,item2){
						// 가져오너 Data 안에 Result 데이터를가져옴( 우리가원하는 값들이 여기 모두 들어있음)
						var title = item2.title // 타이블을 변수 지정
						var titleNoSpace = title.replace(/ /g, ''); // 타이틀 공백제거
						var title2 = titleNoSpace.replace(/!HS/g,'') // 검색어는 !HS , !HE 로 둘러 싸여있어서 제거해줌
						var title3 = title2.replace(/!HE/g,'')
						var title5 = title3.trim(); // 양쪽끝에 공백을 제거해줌
						var title6 =  encodeURIComponent(title5);
						var actors="";
						
						var image = item2.posters.split("|") // 포스터 데이터는 | 로 구분되어있어서 스플리 처리함 ( 여러개 있음 )
						var nation = item2.nation
						
						if(nation == "대한민국"){ // 국내 국외 영화구분을 위한 제어문
							
							for(var num = 0; num < item2.actor.length ; num++){
								actors = actors + item2.actor[num].actorNm + ", ";	
							}
								
							if(image[0]){
								$('#koreaList').append('<div class=nation>'+item2.nation+'</div>');
								$('#koreaList').append('<div class=title><a href=MovieDetailBySearch.mo?movieId='+item2.movieId+'&movieSeq='
										+item2.movieSeq+'&query='+title6+'&image='+image[0]+'>'+title3+'</div>');
								$('#koreaList').append('<div class=runtime>'+item2.runtime+'</div>');
								$('#koreaList').append('<div class=rating>'+item2.rating[0].ratingGrade+'</div>');
								$('#koreaList').append('<div class=poster><img src='+image[0]+'></div>');
							}
// 							else{
// 								$('#koreaList').append('<div class=poster><img src=../../../Movie/img/noImage.gif></div>');
// 							}
						}
						else {
							
							for(var num = 0; num < item2.actor.length ; num++){
								actors = actors + item2.actor[num].actorNm + ", ";	
							}
								
							if(image[0]){
								$('#foreignList').append('<div class=poster><img src='+image[0]+'></div>');
								$('#foreignList').append('<div class=nation>'+item2.nation+'</div>');
								$('#foreignList').append('<div class=title><a href=MovieDetailBySearch.mo?movieId='+item2.movieId+'&movieSeq='
										+item2.movieSeq+'&query='+title5+'&image='+image[0]+'>'+title3+'</div>');
								$('#foreignList').append('<div class=runtime>'+item2.runtime+'</div>');
								$('#foreignList').append('<div class=rating>'+item2.rating[0].ratingGrade+'</div>');
							}
// 							else{ 포스터 없는거는 거의 대부분 안유명한거라 뺌
// 								$('#foreignList').append('<div class=poster><img src=../../../Movie/img/noImage.gif></div>');
// 							}
						
						}
						
					
						
	                  });
				});
			}
	});
		// 배우 검색 기능을 담당하는 Jquery문
		$.ajax('MovieSearchActorPro.mo',{
			method:"get",
			dataType :"json",
			data:{query:query},
			success:function(data){
				
				$.each(data.Data,function(idx,item){
					
					var count = item.Count
						
					$.each(item.Result,function(idx,item2){
						
						var title = item2.title
						var titleNoSpace = title.replace(/ /g, '');
						var title2 = titleNoSpace.replace(/!HS/g,'')
						var title3 = title2.replace(/!HE/g,'');
						var title5 = title3.trim();
						var title6 =  encodeURIComponent(title5);
						var actors="";
						
						var image = item2.posters.split("|")
						
						for(var num = 0; num < item2.actor.length ; num++){
							actors = actors + item2.actor[num].actorNm + ", ";	
						}
							
						if(image[0]){
							$('#actorList').append('<div class=nation>'+item2.nation+'</div>');
							$('#actorList').append('<div class=title><a href=MovieDetailBySearch.mo?movieId'+item2.movieId+'&movieSeq='
									+item2.movieSeq+'&query='+title6+'&image='+image[0]+'>'+title3+'</div>');
							$('#actorList').append('<div class=runtime>'+item2.runtime+'</div>');
							$('#actorList').append('<div class=rating>'+item2.rating[0].ratingGrade+'</div>');
							$('#actorList').append('<div class=poster><img src='+image[0]+'></div>');
						}
// 						else{
// 							$('#actorList').append('<div class=poster><img src=../../../Movie/img/noImage.gif></div>');
// 						}
	                  });
				});
			}
	});
		// 감독검색을 담당하는 Jquery문
		$.ajax('MovieSearchDirectorPro.mo',{
			method:"get",
			dataType :"json",
			data:{query:query},
			async:false,
			success:function(data){
				
				$.each(data.Data,function(idx,item){
					
					var count = item.Count
						
					$.each(item.Result,function(idx,item2){
						
						var title = item2.title
						var titleNoSpace = title.replace(/ /g, '');
						var title2 = titleNoSpace.replace(/!HS/g,'');
						var title3 = title2.replace(/!HE/g,'');
						var title5 = title3.trim();
						var title6 =  encodeURIComponent(title5);
						var actors="";
						
						var image = item2.posters.split("|")
						
						for(var num = 0; num < item2.actor.length ; num++){
							actors = actors + item2.actor[num].actorNm + ", ";	
						}
							
						if(image[0]){
							$('#directorList').append('<div class=poster><img src='+image[0]+'></div>');
							$('#directorList').append('<div class=nation>'+item2.nation+'</div>');
							$('#directorList').append('<div class=title><a href=MovieDetailBySearch.mo?movieId'+item2.movieId+'&movieSeq='
									+item2.movieSeq+'&query='+title6+'&image='+image[0]+'>'+title3+'</div>');
							$('#directorList').append('<div class=runtime>'+item2.runtime+'</div>');
							$('#directorList').append('<div class=rating>'+item2.rating[0].ratingGrade+'</div>');
						}
// 						else{
// 							$('#directorList').append('<div class=poster><img src=../../../Movie/img/noImage.gif></div>');
// 						}
	                  });
				});
			}
	});
		
});
</script>
</head>
<body>
<section id="main">
<jsp:include page="/inc/top.jsp" />
<div class="clear"></div>
<%String query=request.getParameter("query"); %>
<%String nick = (String)session.getAttribute("nick"); %>

	<input type="hidden" id="query" name=query value="<%=query%>">
	<input type="hidden" id="temp">
	<input type="hidden" id="weather">
<h1>국내영화</h1>
	<section id="koreaList">
	</section>
<h1>국외영화</h1>
	<section id="foreignList">
	</section>
<h1>영화인 검색 결과</h1>
	<section id="actorList"></section>
<h1>감독 검색 결과</h1>
	<section id="directorList"></section>
</section>
</body>
</html>
