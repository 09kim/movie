<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width">

<!-- css -->
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/swiper.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/style19.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/slick.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/reset19.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/font-awesome.css" rel="stylesheet" type="text/css">


<title>Insert title here</title>
</head>
<body>
 <section id="movie">
        <div class="container">
            <div class="row">
<!--                 <h2 class="ir_so">영화 예매</h2> -->
                <div class="movie">
                    <div class="movie_chart">
                        <div class="swiper-container2">
                           <div class="chart_cont1 swiper-wrapper">
                               <div class="swiper-slide">
                                   <div class="poster">
                                       <figure>
                                           <img src="assets/img/poster01.jpg" srcset="assets/img/poster01@2.jpg 2x" alt="침묵">
                                       </figure>
                                       <div class="rank"><strong>1</strong></div>
                                       <div class="mx">
                                           <span class="icon m ir_pm">MX</span>
                                           <span class="icon b ir_pm">Boutique</span>
                                       </div>
                                   </div>
                                   <div class="infor">
                                       <h3><span class="icon all ir_pm">전체관람가</span> <strong>침묵</strong></h3>
                                       <div class="infor_btn">
                                           <a href="#">상세정보</a>
                                           <a href="#">예매하기</a>
                                       </div>
                                   </div>
                               </div>
                               <div class="swiper-slide">
                                   <div class="poster">
                                       <figure>
                                           <img src="assets/img/poster01.jpg" srcset="assets/img/poster01@2.jpg 2x" alt="침묵">
                                       </figure>
                                       <div class="rank"><strong>1</strong></div>
                                       <div class="mx">
                                           <span class="icon m ir_pm">MX</span>
                                           <span class="icon b ir_pm">Boutique</span>
                                       </div>
                                   </div>
                                   <div class="infor">
                                       <h3><span class="icon all ir_pm">전체관람가</span> <strong>침묵</strong></h3>
                                       <div class="infor_btn">
                                           <a href="#">상세정보</a>
                                           <a href="#">예매하기</a>
                                       </div>
                                   </div>
                               </div>
                               <div class="swiper-slide">
                                   <div class="poster">
                                       <figure>
                                           <img src="assets/img/poster01.jpg" srcset="assets/img/poster01@2.jpg 2x" alt="침묵">
                                       </figure>
                                       <div class="rank"><strong>1</strong></div>
                                       <div class="mx">
                                           <span class="icon m ir_pm">MX</span>
                                           <span class="icon b ir_pm">Boutique</span>
                                       </div>
                                   </div>
                                   <div class="infor">
                                       <h3><span class="icon all ir_pm">전체관람가</span> <strong>침묵</strong></h3>
                                       <div class="infor_btn">
                                           <a href="#">상세정보</a>
                                           <a href="#">예매하기</a>
                                       </div>
                                   </div>
                               </div>
                           </div>
                        </div>
                        <!-- //chart_cont1-->
                        
                    </div>
                </div>
            </div>
        </div>
    </section>  
    <!-- //movie -->
    
    
    
    
    
    
    
    
    
    
    
    
    <!-- 자바스크립트 라이브러리 -->
    <script src="assets/js/jquery.min_1.12.4.js"></script>
    <script src="assets/js/modernizr-custom.js"></script>
    <script src="assets/js/ie-checker.js"></script>
    <script src="assets/js/swiper.min.js"></script>
    <script src="assets/js/iframe_api.js"></script>
    <script src="assets/js/movie.js"></script>
    <script>
        //배너 이미지 슬라이드
        var swiper = new Swiper('.swiper-container',{
            pagination: {
                el: '.swiper-pagination',
            },
            navigation: {
                nextEl: '.swiper-button-next',
                prevEl: '.swiper-button-prev',
            },
            autoplay: {
                delay: 5000,
            },
        });
        
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
    .movie {padding: 100px 0;}
.movie_title {overflow: hidden; margin-bottom: 60px;}
.movie_title ul {overflow: hidden; width: 848px; margin: 0 auto;}
.movie_title li {float: left; width: 210px; margin-right: -1px; text-align: center; border: 1px solid #c4c4c4;}
.movie_title li a {display: block; padding: 15px 0; font-size: 18px; color: #666; font-weight: 700;}
.movie_title li.active a {background: #666; color: #fff;}
.movie_chart {overflow: hidden; }
.movie_chart > div > div > div {display: inline-block; width: 292px; margin-right: 23px; }
.movie_chart > div > div > div:last-child {margin-right: 0;}
.movie_chart > div > div > div .poster {position: relative;}
.movie_chart > div > div > div .poster img {display: block;}
.movie_chart > div > div > div .poster .rank {position: absolute; top: 17px; left: 0; width: 50px; height: 50px; line-height: 50px; background-color: #38116a; text-align: center; box-shadow: 3px 3px 8px rgba(0,0,0,0.5);}
.movie_chart > div > div > div .poster .rank strong {color: #fff; font-size: 20px; text-shadow: 1px 1px 3px rgba(0,0,0,0.5)}
.movie_chart > div > div > div .poster .mx {position: absolute; top: 17px; right: 17px;}
.movie_chart > div > div > div .poster .mx span {width: 103px; height: 25px; display: block;}
.movie_chart > div > div > div .poster .mx .m {background-position: 0 -75px;}
.movie_chart > div > div > div .poster .mx .b {background-position: 0 -100px;}
.movie_chart > div > div > div .infor {background: #fff; padding: 17px; border: 1px solid #d9d9d9;}
.movie_chart > div > div > div .infor h3 {color: #333; font-size: 30px; font-weight: 700; margin-bottom: 20px;}
.movie_chart > div > div > div .infor h3 strong {padding-left: 0px;}
.movie_chart > div > div > div .infor h3 span {width: 29px; height: 29px; display: inline-block; margin-top: 9px; vertical-align: -2px;}
.movie_chart > div > div > div .infor h3 span.all {background-position: -87px -125px;}
.movie_chart > div > div > div .infor h3 span.a12 {background-position: -58px -125px;}
.movie_chart > div > div > div .infor h3 span.a15 {background-position: 0 -125px;}
.movie_chart > div > div > div .infor h3 span.a19 {background-position: -29px -125px;}
.movie_chart > div > div > div .infor .infor_btn {overflow: hidden;}
.movie_chart > div > div > div .infor .infor_btn a {display: block; float: left; width: 49%; margin-right: 2%; padding: 10px 0; text-align: center; background: #f2f2f2; color: #666; font-size: 18px;}
.movie_chart > div > div > div .infor .infor_btn a:last-child {margin-right: 0;}
    </style>
</body>
</html>