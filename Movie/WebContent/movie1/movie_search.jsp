<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<meta charset="UTF-8">
    <meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <!-- css -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reset19.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style19.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/swiper.css">
    
    <!-- 파비콘 -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/icons/favicon.ico">
    <link rel="apple-touch-icon-precomposed" href="${pageContext.request.contextPath}/assets/icons/favicon_72.png" />
    <link rel="apple-touch-icon-precomposed" sizes="96x96" href="${pageContext.request.contextPath}/assets/icons/favicon_96.png" />
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="${pageContext.request.contextPath}/assets/icons/favicon_144.png" />
    <link rel="apple-touch-icon-precomposed" sizes="192x192" href="${pageContext.request.contextPath}/assets/icons/favicon_192.png" />
    
    <!-- 웹 폰트 -->
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:100,300,400,500,700,900&amp;subset=korean" rel="stylesheet">
    
    <!-- HTLM5shiv ie6~8 -->
    <!--[if lt IE 9]> 
      <script src="${pageContext.request.contextPath}/assets/js/html5shiv.min.js"></script>
      <script type="text/javascript">
         alert("현재 브라우저는 지원하지 않습니다. 크롬 브라우저를 추천합니다.!");
      </script>
   <![endif]-->

<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<script type="text/javascript">
// 기본검색기능을 담당하는 뷰페이지
<<<<<<< HEAD
=======


>>>>>>> branch '태윤' of https://github.com/fmoni1306/movie.git
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
	
	
	
	
		var query = $("#query").val();
		var nick = $("#nick").val();
		query = query.replace(/ /g,'');
		$.ajax('MovieSearchPro.mo',{
			method:"post",
			dataType :"json",
			data:{query:query},
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
<<<<<<< HEAD
						
						
							$('.koreaList').append(' <div class="poster">');
=======
								
							if(image[0]){
								$('#koreaList').append('<div class=nation>'+item2.nation+'</div>');
								$('#koreaList').append('<div class=title><a href=MovieDetailBySearch.mo?movieId='+item2.movieId+'&movieSeq='
										+item2.movieSeq+'&query='+title6+'&image='+image[0]+'&temp='+temp+'&weather='+weather+'>'+title3+'</div>');
								$('#koreaList').append('<div class=runtime>'+item2.runtime+'</div>');
								$('#koreaList').append('<div class=rating>'+item2.rating[0].ratingGrade+'</div>');
								$('#koreaList').append('<div class=poster><img src='+image[0]+'></div>');
							}
// 							else{
// 								$('#koreaList').append('<div class=poster><img src=../../../Movie/img/noImage.gif></div>');
// 							}
						}
						else {
>>>>>>> branch '태윤' of https://github.com/fmoni1306/movie.git
							
<<<<<<< HEAD
=======
							for(var num = 0; num < item2.actor.length ; num++){
								actors = actors + item2.actor[num].actorNm + ", ";	
							}
								
>>>>>>> branch '태윤' of https://github.com/fmoni1306/movie.git
							if(image[0]){
<<<<<<< HEAD
								$('.koreaList').append('<figure><img src='+image[0]+'></figure>');
							}else{
								$('.koreaList').append('<figure><img src=../../../Movie/img/noImage.gif></figure>');
=======
								$('#foreignList').append('<div class=poster><img src='+image[0]+'></div>');
								$('#foreignList').append('<div class=nation>'+item2.nation+'</div>');
								$('#foreignList').append('<div class=title><a href=MovieDetailBySearch.mo?movieId='+item2.movieId+'&movieSeq='
										+item2.movieSeq+'&query='+title5+'&image='+image[0]+'&temp='+temp+'&weather='+weather+'>'+title3+'</div>');
								$('#foreignList').append('<div class=runtime>'+item2.runtime+'</div>');
								$('#foreignList').append('<div class=rating>'+item2.rating[0].ratingGrade+'</div>');
>>>>>>> branch '태윤' of https://github.com/fmoni1306/movie.git
							}
<<<<<<< HEAD
							
							$('.koreaList').append('<div class="rank"><strong>'+idx+'</strong></div></div>'); // 랭킹 보여줌


=======
// 							else{ 포스터 없는거는 거의 대부분 안유명한거라 뺌
// 								$('#foreignList').append('<div class=poster><img src=../../../Movie/img/noImage.gif></div>');
// 							}
						
>>>>>>> branch '태윤' of https://github.com/fmoni1306/movie.git
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
							
<<<<<<< HEAD
// 						$('#actorList').append('<div class=nation>'+item2.nation+'</div>');
// 						$('#actorList').append('<div class=title><a href=MovieDetailPro.mo?movieId'+item2.movieId+'&movieSeq='
// 								+item2.movieSeq+'&query='+title6+'>'+title3+'</div>');
// 						$('#actorList').append('<div class=runtime>'+item2.runtime+'</div>');
// 						$('#actorList').append('<div class=rating>'+item2.rating[0].ratingGrade+'</div>');
// 						if(image[0]){
// 							$('#actorList').append('<div class=poster><img src='+image[0]+'></div>');
// 						}else{
=======
						if(image[0]){
							$('#actorList').append('<div class=nation>'+item2.nation+'</div>');
							$('#actorList').append('<div class=title><a href=MovieDetailBySearch.mo?movieId'+item2.movieId+'&movieSeq='
									+item2.movieSeq+'&query='+title6+'&image='+image[0]+'&temp='+temp+'&weather='+weather+'>'+title3+'</div>');
							$('#actorList').append('<div class=runtime>'+item2.runtime+'</div>');
							$('#actorList').append('<div class=rating>'+item2.rating[0].ratingGrade+'</div>');
							$('#actorList').append('<div class=poster><img src='+image[0]+'></div>');
						}
// 						else{
>>>>>>> branch '태윤' of https://github.com/fmoni1306/movie.git
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
							
<<<<<<< HEAD
// 						$('#directorList').append('<div class=nation>'+item2.nation+'</div>');
// 						$('#directorList').append('<div class=title><a href=MovieDetailPro.mo?movieId'+item2.movieId+'&movieSeq='
// 								+item2.movieSeq+'&query='+title6+'>'+title3+'</div>');
// 						$('#directorList').append('<div class=runtime>'+item2.runtime+'</div>');
// 						$('#directorList').append('<div class=rating>'+item2.rating[0].ratingGrade+'</div>');
// 						if(image[0]){
// 							$('#directorList').append('<div class=poster><img src='+image[0]+'></div>');
// 						}else{
=======
						if(image[0]){
							$('#directorList').append('<div class=poster><img src='+image[0]+'></div>');
							$('#directorList').append('<div class=nation>'+item2.nation+'</div>');
							$('#directorList').append('<div class=title><a href=MovieDetailBySearch.mo?movieId'+item2.movieId+'&movieSeq='
									+item2.movieSeq+'&query='+title6+'&image='+image[0]+'&temp='+temp+'&weather='+weather+'>'+title3+'</div>');
							$('#directorList').append('<div class=runtime>'+item2.runtime+'</div>');
							$('#directorList').append('<div class=rating>'+item2.rating[0].ratingGrade+'</div>');
						}
// 						else{
>>>>>>> branch '태윤' of https://github.com/fmoni1306/movie.git
// 							$('#directorList').append('<div class=poster><img src=../../../Movie/img/noImage.gif></div>');
// 						}
	                  });
				});
			}
	});
		
});
</script>
<title>Insert title here</title>
</head>
<body>
<jsp:include page="/inc/top.jsp" />
<div class="clear"></div>
<%String query=request.getParameter("query"); %>
<%String nick = (String)session.getAttribute("nick"); %>
	<input type="hidden" id="query" name=query value="<%=query%>">
	<input type="hidden" id="temp">
	<input type="hidden" id="weather">
<h1>국내영화</h1>
<section id="movie">
        <div class="container">
            <div class="row">
                <div class="movie">
                    <div class="movie_chart">
                        <div class="swiper-container2">
                           <div class="chart_cont1 swiper-wrapper">
	                           <div class="koreaList">
	                           
								</div>
							 </div>
<!--                                koreaList -->
                           </div>
                        </div>
<!--                         //chart_cont1 -->
                    </div>
                </div>
            </div>
        </div>
    </section>  







 
    
    
    
    
    
    
    
    
    
    
    
    
     <!-- 자바스크립트 라이브러리 -->
    <script src="${pageContext.request.contextPath}/assets/js/jquery.min_1.12.4.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/modernizr-custom.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/ie-checker.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/swiper.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/iframe_api.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/movie.js"></script>
    <script>
        
        //영화차트 이미지 슬라이드
        var swiper = new Swiper('.swiper-container2',{
            slidesPerView: 4,
            spaceBetween: 24,
//            mousewheel: {
//                invert: true,
//            },
            keyboard: {
                enabled: true,
                onlyInViewport: false,
            },
            autoplay: {
                delay: 6000,
            },
            breakpoints: {
                600: {
                    slidesPerView: 1.4,
                    spaceBetween: 24
                },
                768: {
                    slidesPerView: 2,
                    spaceBetween: 24
                },
                960: {
                    slidesPerView: 3,
                    spaceBetween: 24
                }
            }
        });
        
        //영화차트 탭 메뉴
        var movBtn = $(".movie_title > ul > li");    
        var movCont = $(".movie_chart > div");  

        movCont.hide().eq(0).show();

        movBtn.click(function(e){
            e.preventDefault();
            var target = $(this);         
            var index = target.index();  
            movBtn.removeClass("active");   
            target.addClass("active");    
            movCont.css("display","none");
            movCont.eq(index).css("display","block");
        });
        
        //공지사항 탭 메뉴
        var tabMenu = $(".notice");

        //컨텐츠 내용을 숨겨주세요!
        tabMenu.find("ul > li > ul").hide();
        tabMenu.find("li.active > ul").show();

        function tabList(e){
            e.preventDefault();       //#의 기능을 차단
            var target = $(this);
            target.next().show().parent("li").addClass("active").siblings("li").removeClass("active").find("ul").hide();
            //버튼을 클릭하면 ~ div를 보여주고
            //부모의 li 태그에 클래스 추가하고
            //형제의 li 태그에 클래스 제거하고
            //제거한 자식의 div 태그를 숨겨줌 
        }

        tabMenu.find("ul > li > a").click(tabList).focus(tabList);
        
    </script>
    <style>
   .movie_chart {overflow: hidden; }
.movie_chart > div > div > div > div {display: inline-block; width: 292px; margin-right: 23px; }
.movie_chart > div > div > div > div:last-child {margin-right: 0;}
.movie_chart > div > div > div > div .poster {position: relative;}
.movie_chart > div > div > div > div .poster img {display: block;}
.movie_chart > div > div > div > div .poster .rank {position: absolute; top: 17px; left: 0; width: 50px; height: 50px; line-height: 50px; background-color: #38116a; text-align: center; box-shadow: 3px 3px 8px rgba(0,0,0,0.5);}
.movie_chart > div > div > div > div .poster .rank strong {color: #fff; font-size: 20px; text-shadow: 1px 1px 3px rgba(0,0,0,0.5)}
.movie_chart > div > div > div > div .poster .mx {position: absolute; top: 17px; right: 17px;}
.movie_chart > div > div > div > div .poster .mx span {width: 103px; height: 25px; display: block;}
.movie_chart > div > div > div > div .poster .mx .m {background-position: 0 -75px;}
.movie_chart > div > div > div > div .poster .mx .b {background-position: 0 -100px;}
.movie_chart > div > div > div > div .infor {background: #fff; padding: 17px; border: 1px solid #d9d9d9;}
.movie_chart > div > div > div > div .infor h3 {color: #333; font-size: 30px; font-weight: 700; margin-bottom: 20px;}
.movie_chart > div > div > div > div .infor h3 strong {padding-left: 0px;}
.movie_chart > div > div > div > div .infor h3 span {width: 29px; height: 29px; display: inline-block; margin-top: 9px; vertical-align: -2px;}
.movie_chart > div > div > div > div .infor h3 span.all {background-position: -87px -125px;}
.movie_chart > div > div > div > div .infor h3 span.a12 {background-position: -58px -125px;}
.movie_chart > div > div > div > div .infor h3 span.a15 {background-position: 0 -125px;}
.movie_chart > div > div > div > div .infor h3 span.a19 {background-position: -29px -125px;}
.movie_chart > div > div > div > div .infor .infor_btn {overflow: hidden;}
.movie_chart > div > div > div > div .infor .infor_btn a {display: block; float: left; width: 49%; margin-right: 2%; padding: 10px 0; text-align: center; background: #f2f2f2; color: #666; font-size: 18px;}
.movie_chart > div > div > div > div .infor .infor_btn a:last-child {margin-right: 0;}
    </style>
</body>
</html>