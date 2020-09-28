<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
// 기본검색기능을 담당하는 뷰페이지
// $(document).ready(function(){
	
// 	var latitude, longitude;
// 	var API_KEY = '19eab104c69d6fa4c412bfe0078fdd0d';
// 	var temp,weather;
	
// 	function getLocation(){
// 		window.navigator.geolocation.getCurrentPosition(current_position);
// 	}
	
// 	function current_position(position){
// 		latitude = position.coords.latitude;
// 		longitude = position.coords.longitude;
// 		$.ajax("https://api.openweathermap.org/data/2.5/weather?lat="+latitude
// 				+"&lon="+longitude+"&appid="+API_KEY+"&units=metric&lang=kr",{
// 			dataType:"json",
// 			async:false,
// 			success:function(data){
// 				$('#temp').val(data.main.temp);
// 				$('#weather').val(data.weather[0].main);
// 				temp = $('#temp').val();
// 				weather = $('#weather').val();
// 			}
// 		});
// 	}
		
// 	window.addEventListener("load",getLocation);
	
	
	
	
// 		var query = $("#query").val();
// 		var nick = $("#nick").val();
// 		query = query.replace(/ /g,'');
// 		$.ajax('MovieSearchPro.mo',{
// 			method:"post",
// 			dataType :"json",
// 			data:{query:query},
// 			success:function(data){
// 				// 처음 결과 4개의 배열구조
// 				$.each(data.Data,function(idx,item){
// 					// 4번째 오브젝드 Data 안에 것을 가져옴
// 					var count = item.Count
						
// 					$.each(item.Result,function(idx,item2){
// 						// 가져오너 Data 안에 Result 데이터를가져옴( 우리가원하는 값들이 여기 모두 들어있음)
// 						var title = item2.title // 타이블을 변수 지정
// 						var titleNoSpace = title.replace(/ /g, ''); // 타이틀 공백제거
// 						var title2 = titleNoSpace.replace(/!HS/g,'') // 검색어는 !HS , !HE 로 둘러 싸여있어서 제거해줌
// 						var title3 = title2.replace(/!HE/g,'')
// 						var title5 = title3.trim(); // 양쪽끝에 공백을 제거해줌
// 						var title6 =  encodeURIComponent(title5);
// 						var actors="";
						
// 						var image = item2.posters.split("|") // 포스터 데이터는 | 로 구분되어있어서 스플리 처리함 ( 여러개 있음 )
// 						var nation = item2.nation
// 						if(nation == "대한민국"){ // 국내 국외 영화구분을 위한 제어문
							
// 							for(var num = 0; num < item2.actor.length ; num++){
// 								actors = actors + item2.actor[num].actorNm + ", ";	
// 							}
							
// 						    // div 클래스 .koreaList 하나 추가함, css 테스트 해봐야함 - 낙원 : 0927
// 							$('.koreaList').append('<div class="swiper-slide"></div>');
// 							$('.koreaList').append(' <div class="poster">');
							
// 							if(image[0]){
// 								$('.koreaList').append('<figure><img src='+image[0]+'></figure>');
// 							}else{
// 								$('.koreaList').append('<figure><img src=../../../Movie/img/noImage.gif></figure>');
// 							}
// 							$('.koreaList').append('<div class="rank"><strong>'+idx+'</strong></div>'); // 랭킹 보여줌
// 							$('.koreaList').append('<div class="mx">');
// 							$('.koreaList').append('<span class="icon m ir_pm">MX</span>');
// 							$('.koreaList').append('<span class="icon b ir_pm">Boutique</span>');
// 							$('.koreaList').append('</div>');
// 							$('.koreaList').append('</div>');
// 							$('.koreaList').append('<div class="infor">');
// 							$('.koreaList').append('<h3><span class="icon all ir_pm">전체관람가</span> <strong>침묵</strong></h3>');
// 							$('.koreaList').append('<div class="infor_btn">');
// 							$('.koreaList').append('<a href="#">상세정보</a>');
// 							$('.koreaList').append('<a href="#">예매하기</a>');
// 							$('.koreaList').append('</div>');
// 							$('.koreaList').append('</div>');
// // 							$('.koreaList').append('</div>');
// 							// 낙원 div - 끝
							
								
// 							if(image[0]){
// 								$('#koreaList').append('<div class=nation>'+item2.nation+'</div>');
// 								$('#koreaList').append('<div class=title><a href=MovieDetailBySearch.mo?movieId='+item2.movieId+'&movieSeq='
// 										+item2.movieSeq+'&query='+title6+'&image='+image[0]+'&temp='+temp+'&weather='+weather+'>'+title3+'</div>');
// 								$('#koreaList').append('<div class=runtime>'+item2.runtime+'</div>');
// 								$('#koreaList').append('<div class=rating>'+item2.rating[0].ratingGrade+'</div>');
// 								$('#koreaList').append('<div class=poster><img src='+image[0]+'></div>');
// 							}
// // 							else{
// // 								$('#koreaList').append('<div class=poster><img src=../../../Movie/img/noImage.gif></div>');
// // 							}
// 						}
// 						else {
// 							for(var num = 0; num < item2.actor.length ; num++){
// 								actors = actors + item2.actor[num].actorNm + ", ";	
// 							}
								
// 							if(image[0]){
// 								$('#foreignList').append('<div class=poster><img src='+image[0]+'></div>');
// 								$('#foreignList').append('<div class=nation>'+item2.nation+'</div>');
// 								$('#foreignList').append('<div class=title><a href=MovieDetailBySearch.mo?movieId='+item2.movieId+'&movieSeq='
// 										+item2.movieSeq+'&query='+title5+'&image='+image[0]+'&temp='+temp+'&weather='+weather+'>'+title3+'</div>');
// 								$('#foreignList').append('<div class=runtime>'+item2.runtime+'</div>');
// 								$('#foreignList').append('<div class=rating>'+item2.rating[0].ratingGrade+'</div>');
// 							}
// // 							else{ 포스터 없는거는 거의 대부분 안유명한거라 뺌
// // 								$('#foreignList').append('<div class=poster><img src=../../../Movie/img/noImage.gif></div>');
// // 							}
						
// 						}
						
// 	                  });
// 				});
// 			}
// 	});
// 		// 배우 검색 기능을 담당하는 Jquery문
// 		$.ajax('MovieSearchActorPro.mo',{
// 			method:"post",
// 			dataType :"json",
// 			data:{query:query},
// 			success:function(data){
// 				$.each(data.Data,function(idx,item){
					
// 					var count = item.Count
						
// 					$.each(item.Result,function(idx,item2){
						
// 						var title = item2.title
// 						var titleNoSpace = title.replace(/ /g, '');
// 						var title2 = titleNoSpace.replace(/!HS/g,'')
// 						var title3 = title2.replace(/!HE/g,'');
// 						var title5 = title3.trim();
// 						var title6 =  encodeURIComponent(title5);
// 						var actors="";
// 						var image = item2.posters.split("|")
						
// 						for(var num = 0; num < item2.actor.length ; num++){
// 							actors = actors + item2.actor[num].actorNm + ", ";	
// 						}
							
// 						if(image[0]){
// 							$('#actorList').append('<div class=nation>'+item2.nation+'</div>');
// 							$('#actorList').append('<div class=title><a href=MovieDetailBySearch.mo?movieId'+item2.movieId+'&movieSeq='
// 									+item2.movieSeq+'&query='+title6+'&image='+image[0]+'&temp='+temp+'&weather='+weather+'>'+title3+'</div>');
// 							$('#actorList').append('<div class=runtime>'+item2.runtime+'</div>');
// 							$('#actorList').append('<div class=rating>'+item2.rating[0].ratingGrade+'</div>');
// 							$('#actorList').append('<div class=poster><img src='+image[0]+'></div>');
// 						}
// // 						else{
// // 							$('#actorList').append('<div class=poster><img src=../../../Movie/img/noImage.gif></div>');
// // 						}
// 	                  });
// 				});
// 			}
// 	});
// 		// 감독검색을 담당하는 Jquery문
// 		$.ajax('MovieSearchDirectorPro.mo',{
// 			method:"post",
// 			dataType :"json",
// 			data:{query:query},
// 			success:function(data){
				
// 				$.each(data.Data,function(idx,item){
					
// 					var count = item.Count
						
// 					$.each(item.Result,function(idx,item2){
						
// 						var title = item2.title
// 						var titleNoSpace = title.replace(/ /g, '');
// 						var title2 = titleNoSpace.replace(/!HS/g,'');
// 						var title3 = title2.replace(/!HE/g,'');
// 						var title5 = title3.trim();
// 						var title6 =  encodeURIComponent(title5);
// 						var actors="";
						
// 						var image = item2.posters.split("|")
						
// 						for(var num = 0; num < item2.actor.length ; num++){
// 							actors = actors + item2.actor[num].actorNm + ", ";	
// 						}
							
// 						if(image[0]){
// 							$('#directorList').append('<div class=poster><img src='+image[0]+'></div>');
// 							$('#directorList').append('<div class=nation>'+item2.nation+'</div>');
// 							$('#directorList').append('<div class=title><a href=MovieDetailBySearch.mo?movieId'+item2.movieId+'&movieSeq='
// 									+item2.movieSeq+'&query='+title6+'&image='+image[0]+'&temp='+temp+'&weather='+weather+'>'+title3+'</div>');
// 							$('#directorList').append('<div class=runtime>'+item2.runtime+'</div>');
// 							$('#directorList').append('<div class=rating>'+item2.rating[0].ratingGrade+'</div>');
// 						}
// // 						else{
// // 							$('#directorList').append('<div class=poster><img src=../../../Movie/img/noImage.gif></div>');
// // 						}
// 	                  });
// 				});
// 			}
// 	});
		
// });




// 자바 스크립트

const carouselSlide = document.querySelector('.carousel-slide');
const carouselImages = document.querySelectorAll('.carousel-slide img');

const prevBtn = document.querySelector('#prevBtn');
const nextBtn = document.querySelector('#nextBtn');

let counter = 1;
const size = carouselImages[0].clientWidth;
carouselSlide.style.transform = 'translateX(' + (-size * counter) + 'px)';

// Buttons
nextBtn.addEventListener('click', ()=> {
  if(counter >= carouselImages.length -1) return;
  carouselSlide.style.transition = "transform 0.4s ease-in-out";
  counter++;
  carouselSlide.style.transform = 'translateX(' + (-size * counter) + 'px)';
});

prevBtn.addEventListener('click', ()=> {
  if(counter <= 0) return;
  carouselSlide.style.transition = "transform 0.4s ease-in-out";
  counter--;
  carouselSlide.style.transform = 'translateX(' + (-size * counter) + 'px)';
});

// Jump to First/Last Slide
carouselSlide.addEventListener('transitionend', () => {
  console.log(carouselImages[counter]);
  if (carouselImages[counter].id === 'lastClone'){
    carouselSlide.style.transition = 'none'; // 트랜지션 효과 없애기
    counter = carouselImages.length -2; // couter 초기화
    carouselSlide.style.transform = 'translateX(' + (-size * counter) + 'px)'; // 실제 마지막 이미지로 이동.
  } else if (carouselImages[counter].id === 'firstClone') {
    carouselSlide.style.transition = 'none';
    counter = carouselImages.length - counter; // couter 초기화
    carouselSlide.style.transform = 'translateX(' + (-size * counter) + 'px)';
  }
});

</script>

<meta charset="UTF-8">
<title>Insert title here</title>
 <meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<style>
.carousel-container{
/*   width: 900px; */
  width: auto;
  margin: 30px auto;
  border: 0px solid #000;
  overflow: hidden;
  position: relative;
}
.carousel-slide{
  display: flex;
  width: 100%;
  height: 450px;
}
#prevBtn{
  position:absolute;
  top: 50%;
  left: 0;
  transform: translate(0%, -50%);
  width: 20px;
  height: 36px;
  background: url(img/carousel_prevBtn.png) no-repeat;
  text-indent: -9999px;
}
#nextBtn{
  position:absolute;
  top: 50%;
  right: 0;
  transform: translate(0%, -50%);
  width: 20px;
  height: 36px;
  background: url(img/carousel_nextBtn.png) no-repeat;
  text-indent: -9999px;
}
</style>
</head>
<body>
<div class="carousel-container">
  <div class="carousel-slide">
    <img src="${pageContext.request.contextPath}/img/slide5.jpg" id="lastClone">
    <img src="${pageContext.request.contextPath}/img/slide1.jpg">
    <img src="${pageContext.request.contextPath}/img/slide2.jpg">
    <img src="${pageContext.request.contextPath}/img/slide3.jpg">
    <img src="${pageContext.request.contextPath}/img/slide4.jpg">
    <img src="${pageContext.request.contextPath}/img/slide5.jpg">
    <img src="${pageContext.request.contextPath}/img/slide1.jpg" id="firstClone">
  </div>
  <button id="prevBtn">Prev</button>
  <button id="nextBtn">Next</button>
</div>
</body>
</html>