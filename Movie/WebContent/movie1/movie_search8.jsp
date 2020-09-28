<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="/inc/top.jsp" />
<!-- <meta http-equiv="X-UA-Compatible" content="IE=edge"> -->
<!-- <meta name="viewport" content="width=device-width, initial-scale=1"> -->
<%-- <link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet"> --%>
<!-- <script src="js/bootstrap.min.js"></script> -->
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/movieboard.css" rel="stylesheet" type="text/css">
<%-- <script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script> --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	
	
	
	
	
	
	var query = $("#query").val();
	query = query.replace(/ /g,'');
	var nick = $("#nick").val();
	$.ajax('MovieSearchPro.mo',{
		method:"post",
		dataType :"json",
		data:{query:query},
		success:function(data){
			$.each(data.Data,function(idx,item){
				// 4번째 오브젝드 Data 안에 것을 가져옴
				var count = item.Count
				$.each(item.Result,function(idx,item2){
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
						var src = item2.posters.split("|")[0]; 
						for(var num = 0; num < item2.actor.length ; num++){
							actors = actors + item2.actor[num].actorNm + ", ";	
						}
// 						$('.koreaList').append('<img class=poster>');
// 						$('.boxOffice').append('<img class=poster>');
                       if(image[0]){
// 						$('.koreaList').append("<img src='"+image[0]+"'>");
						$('.boxOffice').append("<img src='"+image[0]+"'>");
// 						$('.koreaList').append("<img class=poster_img src='"+image[0]+"'>");
//                              $('.koreaList').children('.poster').eq(idx).attr("src",imageSrc);
//                              $('.koreaList').find('.poster').eq(idx2).attr("src",imageSrc);
// 								$('.koreaList').append('<img class="poster">');
// 								$('.boxOffice').append('<img class="poster">');
// 								$('.boxOffice').append('<img class=poster>');
// 								$('.poster').eq(idx).attr("src",image[0]);
// 								$('.poster').eq(idx).attr("src",src);
// 								$('img').eq(idx).attr("src",image[0]);
// 								$('img').eq(idx).attr("src",src);
// 								$('.koreaList').append('<img class=poster src="'+image[0]+'">');
//                              $('.koreaList').children('.poster').eq(idx).attr("src",src);
//                              $('.poster').eq(idx).attr("src",image[0]);
//                              $('.koreaList').children('.poster').eq(idx).attr("src",image[0]);
//                              alert($('.koreaList').find('.poster').eq(idx).attr("src"));
                       }else{
//                     	   $('.poster').eq(idx).attr("src","../../../Movie/img/noImage.gif");
//                     	   $('img').eq(idx).attr("src","../../../Movie/img/noImage.gif");
//                     	   $('.boxOffice').children('.poster').eq(idx).attr("src","../../../Movie/img/noImage.gif");
//                     	   $('.koreaList').children('.poster').eq(idx).attr("src","../../../Movie/img/noImage.gif");
// 						$('.boxOffice').append("<img src='../../../Movie/img/noImage.gif'>");
// 						$('.koreaList').append("<img src='../../../Movie/img/noImage.gif'>");
// 						$('.koreaList').append("<img class=poster_img src='../../../Movie/img/noImage.gif'>");
//                           	 $('.poster').eq(idx).attr("src","");
//                           	alert($('.poster_img').eq(idx).attr("src"));
                       }
					
					} else {
// 						for(var num = 0; num < item2.actor.length ; num++){
// 							actors = actors + item2.actor[num].actorNm + ", ";	
// 						}
							
// 						if(image[0]){
// 							$('#foreignList').append('<div class=poster><img src='+image[0]+'></div>');
// 							$('#foreignList').append('<div class=nation>'+item2.nation+'</div>');
// 							$('#foreignList').append('<div class=title><a href=MovieDetailBySearch.mo?movieId='+item2.movieId+'&movieSeq='
// 									+item2.movieSeq+'&query='+title5+'&image='+image[0]+'&temp='+temp+'&weather='+weather+'>'+title3+'</div>');
// 							$('#foreignList').append('<div class=runtime>'+item2.runtime+'</div>');
// 							$('#foreignList').append('<div class=rating>'+item2.rating[0].ratingGrade+'</div>');
// 						}
                     }
					});
                  });
			
			
			
			
			
			
			
			
			
			
			
			$('.boxOffice').slick({
				  dots: false,
				  infinite: false,
				  breakpoint: 1024,
				  speed: 300,
				  slidesToShow: 4,
				  centerMode: true,
				  variableWidth: true
				});
			
// 				$('.boxOffice').slick({
// 			        dots: false,
// 			        infinite: false,
// 			        arrows: true,
// 			        speed: 300,
// 			        slidesToShow: 4,
// 			        slidesToScroll: 3,
// 			        responsive: [
// 			          {
// 			            breakpoint: 1024,
// 			            settings: {
// 			              slidesToShow: 3,
// 			              slidesToScroll: 3,
// 			              infinite: true,
// 			              dots: true
// 			            }
// 			          },
// 			          {
// 			            breakpoint: 600,
// 			            settings: {
// 			              slidesToShow: 2,
// 			              slidesToScroll: 2
// 			            }
// 			          },
// 			          {
// 			            breakpoint: 480,
// 			            settings: {
// 			              slidesToShow: 1,
// 			              slidesToScroll: 1
// 			            }
// 			          }
// 			          // You can unslick at a given breakpoint now by adding:
// 			          // settings: "unslick"
// 			          // instead of a settings object
// 			        ]
// 			      });
			
			
		} 
	}); // ajax끝 
	
	
	
	
	
	
	
	
	

	
	
	
	
	
	
	
	
}); // ready()끝;
</script>


</head>
<body>
<%-- <jsp:include page="/inc/top.jsp" /> --%>
<%String query=request.getParameter("query"); %>
<%String nick = (String)session.getAttribute("nick"); %>
<input type="hidden" id="query" name=query value="<%=query%>">
<input type="hidden" id="nick" name=nick value="<%=nick%>">
<div class="clear"></div>
   <h1>국내영화</h1>
<!-- 	<div class="koreaList"> -->
<!-- 	</div> -->
	
	<div class="boxOffice"></div>
	

</body>
</html>