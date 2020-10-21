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
					
					
					// 디자인 맞춤때문에 코드 수정 - 낙원 : 1019 [S]
					  $('.expectedGrade').append("<div class=expectedGradeMovie>"+
              			'<a class=expectedGradePoster><div class=poster style="background-image: url('+poster+'),url(${pageContext.request.contextPath}/img/noImage.gif;"></div></a>'+
              			 '<div class=title>'+title+'</div><div class=grade></div></div>');
              		// 디자인 맞춤때문에 코드 수정 - 낙원 : 1019 [E]
                     
                     $('.grade').eq(i).append('예상 별점'+grade.toFixed(1));
              		$('.grade').eq(i).css('color','#FFFF00');
                     $('.expectedGradePoster').eq(i).attr('href','MovieDetailPro.mo?movieSeq='+movieSeq+'&query='+title);
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
		
	}); // ready()끝
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