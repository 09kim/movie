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
				$('.GradeMovie').prepend(' <h1><%=nick %> 님이 높은 점수를 줄것 같은 영화들!</h1><br>');
				for(var i = 0; i<data.length;i++){
					grade = String(data[i]).substring(0,String(data[i]).indexOf(',')); // 명시적 형변환 해줘야지 data 가 문자열 로 됨
					title = String(data[i]).substring(String(data[i]).indexOf(',')+1,String(data[i]).indexOf('/')); // 명시적 형변환 해줘야지 data 가 문자열 로 됨
					movieSeq = String(data[i]).substring(String(data[i]).indexOf('/')+1,String(data[i]).length); // 명시적 형변환 해줘야지 data 가 문자열 로 됨
					poster = getPoster(movieSeq);
					grade = grade/2
					 $('.expectedGrade').append("<div class=movie>"+
                  		   "<img class=poster_img>"+
                  		   "<div><a class=movieName></a></div><div class=grade></div>"+
                  		   "</div>");
                     if(poster){
                     		$('.poster_img').eq(i).attr("src",poster);
                     }else{
                  	 	$('.poster_img').eq(i).attr("src","../../../Movie/img/noImage.gif");
                     }
                     $('.grade').eq(i).append('예상 별점'+grade.toFixed(1));
                     $('.movieName').eq(i).attr('href','MovieDetailPro.mo?query='+title+'&movieSeq='+movieSeq);
                     $('.movieName').eq(i).text(title);
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
	            	   ]
	            	 });
				
				
			}
		});
		
	});
</script>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<div class="GradeMovie">
<div class="expectedGrade"></div>
</div>
</body>
</html>