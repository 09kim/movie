<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- <meta charset="utf-8"> -->
<!-- <meta http-equiv="X-UA-Compatible" content="IE=edge"> -->
<!-- <meta name="viewport" content="width=device-width, initial-scale=1"> -->
<%-- <link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet"> --%>
<!-- <script src="js/bootstrap.min.js"></script> -->
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/movieboard.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.min.css">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.js"></script>
<script type="text/javascript">
// 기본검색기능을 담당하는 뷰페이지
$(document).ready(function() {
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
	
	
	
	
		var query = $("#query").val();
		var nick = $("#nick").val();
		query = query.replace(/ /g,'');
		$.ajax('MovieSearchPro.mo',{
			method:"post",
			dataType :"json",
			data:{query:query},
			success:function(data){
// 				$('#koreaList').append('<div aria-live="polite" class="slick-list draggable" style="padding: 0px 50px;"><div class="slick-track" role="listbox" style="opacity: 1; width: 35000px; transform: translate3d(526px, 0px, 0px);"><img src="/Movie/img/noImage.gif" class="slick-slide slick-current slick-center" data-slick-index="0" aria-hidden="true" tabindex="-1" role="option" aria-describedby="slick-slide00" style=""><img src="/Movie/img/noImage.gif" class="slick-slide" data-slick-index="1" aria-hidden="true" tabindex="-1" role="option" aria-describedby="slick-slide01"><img src="/Movie/img/noImage.gif" class="slick-slide" data-slick-index="2" aria-hidden="true" tabindex="-1" role="option" aria-describedby="slick-slide02"><img src="/Movie/img/noImage.gif" class="slick-slide" data-slick-index="3" aria-hidden="true" tabindex="-1" role="option" aria-describedby="slick-slide03"><img src="/Movie/img/noImage.gif" class="slick-slide" data-slick-index="4" aria-hidden="true" tabindex="-1" role="option" aria-describedby="slick-slide04"><img src="/Movie/img/noImage.gif" class="slick-slide" data-slick-index="5" aria-hidden="true" tabindex="-1" role="option" aria-describedby="slick-slide05"><img src="/Movie/img/noImage.gif" class="slick-slide" data-slick-index="6" aria-hidden="true" tabindex="-1" role="option" aria-describedby="slick-slide06"></div></div>');
// 				$('#koreaList').append('<div class="slick-track" role="listbox" style="opacity: 1; width: 35000px; transform: translate3d(526px, 0px, 0px);"><img src="/Movie/img/noImage.gif" class="slick-slide slick-current slick-center" data-slick-index="0" aria-hidden="true" tabindex="-1" role="option" aria-describedby="slick-slide00" style=""><img src="/Movie/img/noImage.gif" class="slick-slide" data-slick-index="1" aria-hidden="true" tabindex="-1" role="option" aria-describedby="slick-slide01"><img src="/Movie/img/noImage.gif" class="slick-slide" data-slick-index="2" aria-hidden="true" tabindex="-1" role="option" aria-describedby="slick-slide02"><img src="/Movie/img/noImage.gif" class="slick-slide" data-slick-index="3" aria-hidden="true" tabindex="-1" role="option" aria-describedby="slick-slide03"><img src="/Movie/img/noImage.gif" class="slick-slide" data-slick-index="4" aria-hidden="true" tabindex="-1" role="option" aria-describedby="slick-slide04"><img src="/Movie/img/noImage.gif" class="slick-slide" data-slick-index="5" aria-hidden="true" tabindex="-1" role="option" aria-describedby="slick-slide05"><img src="/Movie/img/noImage.gif" class="slick-slide" data-slick-index="6" aria-hidden="true" tabindex="-1" role="option" aria-describedby="slick-slide06"></div>');
// 				$('.slick').addClass('before');
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
						
						
// 							var sectionKoreaList = document.createElement('section');
// 							sectionKoreaList.setAttribute("id","koreaList");
// 							var divPoster = document.createElement('div.poster');
// 							var img = document.createElement('img');
// 							img.src = image[0];
// 							divPoster.appendChild(img);
// // 							var text = document.createTextNode(image[0]);
// 							document.getElementById('koreaList').appendChild(divPoster);
// 							document.getElementById('koreaList').appendChild('<img src='+image[0]+' class="slick-slide slick-current slick-center" data-slick-index="0" aria-hidden="true" tabindex="-1" role="option" aria-describedby="slick-slide00" style="">');
// 							$('#koreaList').append(img);
// 							append, appendTo
// 							위에서 만든 태그를 추가해봅시다. 맨 마지막 자식 요소로 추가됩니다. 부모.append(자식) 또는 자식.appendTo(부모)처럼 하면 됩니다.

// 							$('#zero').append($div);
// 							$div.appendTo($('#zero'));
// 							document.getElementById('zero').appendChild(div);
						
						
						
						
						
// 								$('#koreaList').append('<img src='+image[0]+' class="slick-slide slick-current slick-center" data-slick-index="0" aria-hidden="true" tabindex="-1" role="option" aria-describedby="slick-slide00" style="">');
// 								$('#koreaList').append('<div class=poster><img src='+image[0]+'></div>');
							if(image[0]){
								$('#koreaList').append('<div class=nation>'+item2.nation+'</div>');
								$('#koreaList').append('<div class=title><a href=MovieDetailBySearch.mo?movieId='+item2.movieId+'&movieSeq='
										+item2.movieSeq+'&query='+title6+'&image='+image[0]+'&temp='+temp+'&weather='+weather+'>'+title3+'</div>');
								$('#koreaList').append('<div class=runtime>'+item2.runtime+'</div>');
								$('#koreaList').append('<div class=rating>'+item2.rating[0].ratingGrade+'</div>');
								$('#koreaList').append('<div class=poster><img src='+image[0]+'></div>');
							}
							else{
								$('#koreaList').append('<div class=poster><img src=../../../Movie/img/noImage.gif></div>');
							}
						}
						
						else {
							for(var num = 0; num < item2.actor.length ; num++){
								actors = actors + item2.actor[num].actorNm + ", ";	
							}
								
							if(image[0]){
								$('#foreignList').append('<div class=poster><img src='+image[0]+'></div>');
								$('#foreignList').append('<div class=nation>'+item2.nation+'</div>');
								$('#foreignList').append('<div class=title><a href=MovieDetailBySearch.mo?movieId='+item2.movieId+'&movieSeq='
										+item2.movieSeq+'&query='+title5+'&image='+image[0]+'&temp='+temp+'&weather='+weather+'>'+title3+'</div>');
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
			method:"post",
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
									+item2.movieSeq+'&query='+title6+'&image='+image[0]+'&temp='+temp+'&weather='+weather+'>'+title3+'</div>');
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
			method:"post",
			dataType :"json",
			data:{query:query},
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
									+item2.movieSeq+'&query='+title6+'&image='+image[0]+'&temp='+temp+'&weather='+weather+'>'+title3+'</div>');
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
	
	
	
	
   
               $('#koreaList').slick({
                  dots: false,
                  infinite: false,
                  arrows: true,
                  speed: 300,
                  slidesToShow: 4,
                  slidesToScroll: 3,
                  responsive: [
                    {
                      breakpoint: 1024,
                      settings: {
                        slidesToShow: 3,
                        slidesToScroll: 3,
                        infinite: true,
                        dots: true
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
                    // You can unslick at a given breakpoint now by adding:
                    // settings: "unslick"
                    // instead of a settings object
                  ]
                }); // slick()끝
               
       
       
       
}); // ready() 끝;
   
   
</script>
<title>Insert title here</title>
</head>
<body>

<section id="main">
<jsp:include page="/inc/top.jsp" />
<div class="clear"></div>
<%String query=request.getParameter("query"); %>
<%String nick = (String)session.getAttribute("nick"); %>
	<input type="hidden" id="query" name=query value="<%=query%>">
	<input type="hidden" id="nick" name=nick value="<%=nick%>">
<h1>국내영화</h1>
	<section id="koreaList">
<%-- 	<img src="${pageContext.request.contextPath}/img/noImage.gif"> --%>
<%-- 	<img src="${pageContext.request.contextPath}/img/noImage.gif"> --%>
<%-- 	<img src="${pageContext.request.contextPath}/img/noImage.gif"> --%>
<%-- 	<img src="${pageContext.request.contextPath}/img/noImage.gif"> --%>
<%-- 	<img src="${pageContext.request.contextPath}/img/noImage.gif"> --%>
<%-- 	<img src="${pageContext.request.contextPath}/img/noImage.gif"> --%>
<%-- 	<img src="${pageContext.request.contextPath}/img/noImage.gif"> --%>
	</section>
<!-- <h1>국외영화</h1> -->
<!-- 	<section id="foreignList"> -->
<!-- 	</section> -->
<!-- <h1>영화인 검색 결과</h1> -->
<!-- 	<section id="actorList"></section> -->
<!-- <h1>감독 검색 결과</h1> -->
<!-- 	<section id="directorList"></section> -->
</section>



</body>
</html>