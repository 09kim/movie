<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%String nick = (String)session.getAttribute("nick"); %>
<meta charset="UTF-8">
<head>
<title></title>
<script type="text/javascript">
	$(document).ready(function() {
		$.ajax('MovieGetChart.mo',{
			method : "post",
			dataType : "json",
			async: false,
			success : function(data){
				if(data[0].movieTitle){
					$('.chartMovie').prepend('<h1>일간 인기 영화 순위!</h1>')
				}
				$.each(data,function(index,item){
					$('.MovieChart').append("<div class=MovieChartMovie>"+
                 		   "<div><a class=MovieChartPoster><img class=MovieChartPoster_img></a></div>"+
                 		   "<div class =MovieChartMovieName></div>"+
                 		   "</div>");
                  	   $('.MovieChartPoster_img').eq(index).css("width","250px").css("height","350px");
                  	   $('.MovieChartPoster_img').eq(index).attr("src",item.moviePoster);
	                   $('.MovieChartPoster').eq(index).attr('href','MovieDetailPro.mo?movieSeq='+item.movieSeq+'&query='+item.movieTitle);
	                   $('.MovieChartMovieName').eq(index).html(item.movieTitle);
				});
				
				$('.MovieChart').slick({
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
</head>
<body>
	<div class="chartMovie">
		<div class="MovieChart"></div>
	</div>
</body>

</html>