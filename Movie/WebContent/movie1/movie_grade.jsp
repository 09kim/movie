<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<%String nick = (String)session.getAttribute("nick"); %>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/jquery-ui.css" type="text/css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/moviecss/movie.css" rel="stylesheet" type="text/css">
<style type="text/css">
/* .movieList {margin-top: 100px;} */
.thisMovie{
	float:left;
/* 	padding:20px; */
	margin-left: 30px;
}

</style>
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-ui.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var nick = $('#nick').val();
	
	function starClick(param,grade,image){
		  	  $.ajax("setGrade.mo",{
		  		  method:"post",
		          data:{
		         	   data:param,
		         	   grade:grade,
		         	   nick:nick,
		         	   image:image
		         	   },
		          success:function(data){
		            }
		  	  }
		)
	}
	
	
   	 
   	
    
	
   // 랜덤한 영화를 보여주는 Jqeury 문
   $('#categoryMovie').change(function(){
      var type = $('#categoryMovie option:selected').val();
//       $(".thisMovie").remove();
	if($('.slick-track').length>0){
// 	alert("객체있음")
//     $('.movieList').unslick();
    $('.thisMovie').remove();
//     $('.slick-track').remove();
	}else{
// 		alert("객체없음");
		
		 $('.movieList').slick({
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
//       $(".thisMovie").children().remove();
            $.ajax("GradeMoviePro.mo",{
               method:"get",
               dataType :"json",
               data:{type:type},
               success:function(data){
            	   var grade = 0;
            	  
                  $.each(data.Data,function(idx,item){
                     var i =1;
                     var l =1;
                     
                     $.each(item.Result,function(idx,item2){
                    	
                        var num = 0;
                        var image = item2.posters.split("|")
                        var title = item2.title
                        var titleNoSpace = title.replace(/ /g, '');
                        var title2 = titleNoSpace.replace(/!HS/g,'')
                        var title3 = title2.replace(/!HE/g,'')
                        var title5 = title3.trim();
                        var title6 =  encodeURIComponent(title5);
                        
                        
                        
                        
                        if(image[0]){
                        
                        $('.caption').html('<h1>'+nick+'님에게 추천하는 '+type+'장르 영화</h1>');
                        
                        
                        // 새로 장르 갱신시에 .thisMovie를 remove해버리면 슬릭슬라이더까지 모두 삭제되는 문제때문에 새로운 객체 생성방식이 아닌 기존에 있는 슬라이더 틀에 슬라이드를 추가하는식으로 구문을 변경 - 낙원 : 1018[S]
                        $('.movieList').slick('slickAdd',"<div class=thisMovie>"
                                +'<a class="link"><div class=poster style="background-image: url('+image[0]+'),url(${pageContext.request.contextPath}/img/noImage.gif;"></div></a>'
                                 +'<div class=title>'+title+'</div>'
                                + "<span class=star-input style=width:200px;margin-left:75px;text-align:center;>"
                                +   "<span class=input style=width:200px;margin:0 auto;text-align:center;>"
                                
                             
                                +'<input type="button" class="c1" ><label style= "width: 10px; z-index: 10;" class="l1">1</label>'
                                +'<input type="button" class="c2" ><label style= "width: 20px; z-index: 9;" class="l2">2</label>'
                                +'<input type="button" class="c3" ><label style= "width: 30px; z-index: 8;" class="l3">3</label>'
                                +'<input type="button" class="c4" ><label style= "width: 40px; z-index: 7;" class="l4">4</label>'
                                +'<input type="button" class="c5" ><label style= "width: 50px; z-index: 6;" class="l5">5</label>'
                                +'<input type="button" class="c6" ><label style= "width: 60px; z-index: 5;" class="l6">6</label>'
                                +'<input type="button" class="c7" ><label style= "width: 70px; z-index: 4;" class="l7">7</label>'
                                +'<input type="button" class="c8" ><label style= "width: 80px; z-index: 3;" class="l8" >8</label>'
                                +'<input type="button" class="c9" ><label style= "width: 90px; z-index: 2;" class="l9">9</label>'
                                +'<input type="button" class="c10"><label style= "width: 100px; z-index: 1;" class="l10">10</label>'
                                + '</span></span></div>' );
                        
                             // 새로 장르 갱신시에 .thisMovie를 remove해버리면 슬릭슬라이더까지 모두 삭제되는 문제때문에 새로운 객체 생성방식이 아닌 기존에 있는 슬라이더 틀에 슬라이드를 추가하는식으로 구문을 변경 - 낙원 : 1018[S]
                        
                        // 기존 생성구문 주석 처리 - 낙원 :[S]
//                         $('.movieList').append('<div class=thisMovie>'
// //                                 +'<div class=poster>'
// //                                 +'<a class="link" onclick="window.open('+url+',"[갓챠]"'+title+'"의 상세 정보","resizable=no width=2000 height=2500");return false"><div class=poster style="background-image: url('+image[0]+'),url(${pageContext.request.contextPath}/img/noImage.gif;"></div></a>'
//                                 +'<a class="link"><div class=poster style="background-image: url('+image[0]+'),url(${pageContext.request.contextPath}/img/noImage.gif;"></div></a>'
// //                                 +'<img class="poster_img">'
// //                                 +'</div>'
//                                  +'<div class=title>'+title+'</div>'
// //                                 +'<a class="link"></a>'
// //                                 + "<br>"
//                                 + "<span class=star-input style=width:250px;margin-left:75px;text-align:center;>"
//                                 +   "<span class=input style=width:250px;margin:0 auto;text-align:center;>"
                                
                             
//                                 +'<input type="button" class="c1" ><label style= "width: 10px; z-index: 10;" class="l1">1</label>'
//                                 +'<input type="button" class="c2" ><label style= "width: 20px; z-index: 9;" class="l2">2</label>'
//                                 +'<input type="button" class="c3" ><label style= "width: 30px; z-index: 8;" class="l3">3</label>'
//                                 +'<input type="button" class="c4" ><label style= "width: 40px; z-index: 7;" class="l4">4</label>'
//                                 +'<input type="button" class="c5" ><label style= "width: 50px; z-index: 6;" class="l5">5</label>'
//                                 +'<input type="button" class="c6" ><label style= "width: 60px; z-index: 5;" class="l6">6</label>'
//                                 +'<input type="button" class="c7" ><label style= "width: 70px; z-index: 4;" class="l7">7</label>'
//                                 +'<input type="button" class="c8" ><label style= "width: 80px; z-index: 3;" class="l8" >8</label>'
//                                 +'<input type="button" class="c9" ><label style= "width: 90px; z-index: 2;" class="l9">9</label>'
//                                 +'<input type="button" class="c10"><label style= "width: 100px; z-index: 1;" class="l10">10</label>'
//                                 + '</span></span></div>' );
                        // 기존 생성구문 주석 처리 - 낙원 :[E]
                        
                        }
                        
//                         $('.poster_img:eq(idx)').attr("src="+image[idx]);
                           
							                           
//                         if(image[0]){
//                         	$('.poster_img').eq(idx).attr("src",image[0]);
//                             $('.link').eq(idx).text(title);
//                             $('.link').eq(idx).attr("href",'MovieDetailPro.mo?movieId='+item2.movieId+'&movieSeq='
//                                   +item2.movieSeq+'&query='+title5);


//                             var url = 'MovieDetailModal.mo?movieId='+item2.movieId+'&movieSeq='
//                             +item2.movieSeq+'&query='+title5

//                             var url = 'MovieDetailModal.mo?movieId='+item2.movieId+'&movieSeq='+item2.movieSeq+'&query='+title5+'&image='+image[0];
//                             var url = 'MovieDetailBySearch.mo?movieId='+item2.movieId+'&movieSeq='+item2.movieSeq+'&query='+title5+'&image='+image[0];
                          
							var url = 'MovieDetailPro.mo?movieSeq='+item2.movieSeq+'&query='+title6;
//                             $('.link').eq(idx).attr("href",url);
                            $('.link').click(function(){

                            window.open(url, "[갓챠]"+title+"의 상세 정보", "width:2500,height:2500,scrollbars:no");
//                                 $('#dialog-message').dialog({
//                               		 modal: true,
//                               		  open: function () {
//                               		 $(this).load(url);
//                               		  },
//                               		height: 2000,

//                                     width: 1500,

//                                     title: '디테일 페이지'



//                               	 }); 
                                });
                            
                            var nation = item2.nation.split(",");
                            $('.c1').eq(idx).val(item2.director[0].directorNm+"/"+nation[0]+"/"+title5+"/"+item2.movieSeq+"/"+item2.runtime+"/"+item2.genre+"/"+item2.prodYear);
                           
//                         }else{
//                         	$('.thisMovie').eq(idx).hide();
// //                            $('.poster_img').eq(idx).attr("src",'../../../Movie/img/noImage.gif');
//                         }
                        
                        

                        
                        // 10개의 라벨에 각기 다른 값을 부여하기위한 반복문
                        for(var o=1;o<11;o++){
                        $('.c'+o).eq(idx).attr("id","p"+i++);
                        }
                    	 // 10개의 라벨에 각기 다른 값을 부여하기위한 반복문
                        for(var o=1;o<11;o++){
                        $('.l'+o).eq(idx).attr("for","p"+l++);
                        }
                        var image = image[0];
                        var garde= 0;
						var movieSeq =""	
	                        $('.c1').eq(idx).click(function(){
	                           alert(title + " | " + "0.5점 등록");
	                           var grade=1;
	                           var data = $('.c1').eq(idx).val();
	                           starClick(data,grade,image);
	                           $('.thisMovie').eq(idx).hide();
	                        });
	                        
	                        $('.c2').eq(idx).click(function(){
	                           alert(title +  " | " + "1점 등록");
	                        	var grade = 2;
	                           var data = $('.c1').eq(idx).val();
	                           starClick(data,grade,image);
	                           $('.thisMovie').eq(idx).hide();
	                          
	                        });
	                        $('.c3').eq(idx).click(function(){
	                           alert(title +  " | " +  "1.5점 등록");
	                           var grade = 3;
	                           var data = $('.c1').eq(idx).val();
	                           starClick(data,grade,image);
	                           $('.thisMovie').eq(idx).hide();
	                           
	                        });
	                        
	                        $('.c4').eq(idx).click(function(){
	                           alert(title +  " | " +  "2점 등록");
	                           var grade = 4;
	                           var data = $('.c1').eq(idx).val();
	                           starClick(data,grade,image);
	                           $('.thisMovie').eq(idx).hide();
	                        });
	                        
	                        $('.c5').eq(idx).click(function(){
	                           alert(title +  " | " +  "2.5점 등록");
	                           var grade = 5;
	                           var data = $('.c1').eq(idx).val();
	                           starClick(data,grade,image); 
	                           $('.thisMovie').eq(idx).hide();
	                        });
	                        
	                        $('.c6').eq(idx).click(function(){
	                            alert(title +  " | " +  "3점 등록");
	                            var grade = 6;
	                            var data = $('.c1').eq(idx).val();
	                            starClick(data,grade,image);
	                            $('.thisMovie').eq(idx).hide();
	                            
	                        });
	                        $('.c7').eq(idx).click(function(){
	                            alert(title +  " | " +  "3.5점 등록");
	                            var grade=7;
		                        var data = $('.c1').eq(idx).val();
		                        starClick(data,grade,image);
		                        $('.thisMovie').eq(idx).hide();
	                        });
	                        $('.c8').eq(idx).click(function(){
	                            alert(title +  " | " +  "4점 등록");
	                            var grade=8;
		                        var data = $('.c1').eq(idx).val();
		                        starClick(data,grade,image);
		                        $('.thisMovie').eq(idx).hide();
	                        });
	                        $('.c9').eq(idx).click(function(){
	                            alert(title +  " | " +  "4.5점 등록");
	                            var grade=9;
		                        var data = $('.c1').eq(idx).val();
		                        starClick(data,grade,image);
		                        $('.thisMovie').eq(idx).hide();
	                        });
	                        $('.c10').eq(idx).click(function(){
	                            alert(title +  " | " +  "5점 등록");
	                            var grade=10;
		                        var data = $('.c1').eq(idx).val();
		                        starClick(data,grade,image);
		                        $('.thisMovie').eq(idx).hide();
	                        });
	              	  	 
	                        
                  
                  });//each문 끝남
              });
                     
                     
           }
               
               
               
        });
   });
   
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
  
   
});
</script>
</head>
<body>
	<!-- 헤더 -->
	<div style="width:100%;position: sticky !important;top:0;z-index: 100;">
	<jsp:include page="/inc/top.jsp"/>
	<div class="clear"></div>
	</div>
	<!-- 헤더 -->
	
	
<section id="main">	
<input type="hidden" id = "nick" class="nick" value=<%=nick %>>
<select style="position: fixed; top:100px;" id="categoryMovie">
<option >정렬기준</option>
<option id ="random" value="random">랜덤</option>
<option id ="comedy" value="코메디">코메디</option>
<option id ="nwar" value="느와르">느와르</option>
<option id ="crime" value="범죄">범죄</option>
<option id ="drama" value="드라마">드라마</option>
<option id ="romance" value="로맨스">로맨스</option>
<option id ="thriller" value="스릴러">스릴러</option>
<option id ="war" value="전쟁">전쟁</option>
<option id ="family" value="가족">가족</option>
<option id ="fantasy" value="판타지">판타지</option>
<option id ="action" value="액션">액션</option>
<option id ="sf" value="SF">SF</option>
<option id ="animation" value="애니메이션">애니메이션</option>
<option id ="character" value="인물">인물</option>
<option id ="horror" value="공포">공포</option>
<option id ="mystery" value="미스터리">미스터리</option>
<option id ="melo" value="멜로">멜로/로맨스</option>
<option id ="adventure" value="어드벤처">어드벤처</option>
</select><br>
<div class="content">
<div class="caption"></div>
<div class="movieList"></div>
</div>
<div id="dialog-message">

</div>
</section>
<div class="moveTop" style="cursor:pointer;">TOP</div>
<style type="text/css">
body{background-color: #14141f;}
.title{width: 250px;text-align: center;text-overflow: ellipsis;white-space: nowrap;overflow: hidden;}
.nation{width: 250px;text-align: center;text-overflow: ellipsis;white-space: nowrap;overflow: hidden;}
.rating{width: 250px;text-align: center;text-overflow: ellipsis;white-space: nowrap;overflow: hidden;}
</style>
</body>
</html>