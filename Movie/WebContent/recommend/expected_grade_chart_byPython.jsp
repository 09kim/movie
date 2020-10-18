<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%String nick = (String)session.getAttribute("nick"); %>
<script type="text/javascript">
	$(document).ready(function() {
		var poster;
		var movieSeq;
		var title;
		var grade;
		function getPoster(movieSeq){
			$.ajax('MovieGetPoster.mo',{
				method : "get",
				data : {
					movieSeq : movieSeq
				},
				async: false,
				success : function(data){
					poster = data;
				}
			});
			return poster;
		}
		
		$.ajax('MovieExpected.mo',{
			method : "get",
			dataType : "json",
			data : {
				nick : '<%=nick%>'
			},
			async: false,
			success : function(data) {
				if(data){
					$('.GradeMovie').prepend(' <h1><%=nick %> 님이 높은 점수를 줄것 같은 영화들!</h1><br>');
				}
				for(var i = 0; i<data.length;i++){
					grade = String(data[i]).substring(0,String(data[i]).indexOf(',')); // 명시적 형변환 해줘야지 data 가 문자열 로 됨
					title = String(data[i]).substring(String(data[i]).indexOf(',')+1,String(data[i]).indexOf('/')); // 명시적 형변환 해줘야지 data 가 문자열 로 됨
					movieSeq = String(data[i]).substring(String(data[i]).indexOf('/')+1,String(data[i]).length); // 명시적 형변환 해줘야지 data 가 문자열 로 됨
					poster = getPoster(movieSeq);
					grade = grade/2
					
					// 디자인 수정을 위해서 기존 양식 주석처리 - 낙원 : 1016[S]
// 					 $('.expectedGrade').append("<div class=expectedGradeMovie>"+
//                   		   "<a class=expectedGradePoster><img class=expectedGradePoster_img></a>"+
//                   		   "<div><div class=expectedGradeMovieName></div></div><div class=grade></div>"+
//                   		   "</div>");
					// 디자인 수정을 위해서 기존 양식 주석처리 - 낙원 : 1016[E]
					
					
					
					  $('.expectedGrade').append("<div class=expectedGradeMovie>"+
//               			 '<div class=poster><a href=MovieDetailBySearch.mo?movieId='+item2.movieId+'&movieSeq='+item2.movieSeq+'&query='+title6+'&image='+image[0]+'&temp='+temp+'&weather='+weather+'><img style=width:250px;height:350px; src='+image[0]+'></a></div>'+
              			'<a class=expectedGradePoster><div class=poster style="background-image: url('+poster+'),url(${pageContext.request.contextPath}/img/noImage.gif;"></div></a>'+
//               			 '<div class=poster><a href=MovieDetailBySearch.mo?movieId='+item2.movieId+'&movieSeq='+item2.movieSeq+'&query='+title6+'&image='+image[0]+'&temp='+temp+'&weather='+weather+'><img style=width:250px;height:350px;margin-right:20px; src='+image[0]+'></a></div>'+
              			 '<div class=title>'+title+'</div><div class=grade></div></div>');
					
					
					
                   
					// 이미지 로딩 못하면 onerror처리하도록 해서 이부분은 불필요해서 주석 처리 - 낙원 : 1016[S]
//                      if(poster){
//                     	 $('.expectedGradePoster_img').eq(i).css("width","250px").css("height","350px");
//                      		$('.expectedGradePoster_img').eq(i).attr("src",poster);
//                      }else{
//                     	 $('.expectedGradePoster_img').eq(index).css("width","250px").css("height","350px");
//                   	 	$('.expectedGradePoster_img').eq(i).attr("src","../../../Movie/img/noImage.gif");
//                      }
                    // 이미지 로딩 못하면 onerror처리하도록 해서 이부분은 불필요해서 주석 처리 - 낙원 : 1016[E]
                     
                     
                     $('.grade').eq(i).append('예상 별점'+grade.toFixed(1));
                     $('.expectedGradePoster').eq(i).attr('href','MovieDetailPro.mo?movieSeq='+movieSeq+'&query='+title);
//                      $('.expectedGradeMovieName').eq(i).text(title); // title css 적용을 위해서 주석처리 - 낙원 : 1016
				}
				
				
				$('.expectedGrade').slick({
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
		
	});
</script>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet">
<meta charset="UTF-8">
<title></title>
</head>
<body>
<div class="GradeMovie">
<div class="expectedGrade"></div>
</div>
</body>
</html>