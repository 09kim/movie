<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%String nick = (String)session.getAttribute("nick"); %>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript">
	$(document).ready(function() {
		$.ajax('MovieGetGenre.mo',{
			method : "post",
			dataType : "json",
			async: false,
			success : function(data){
				if(data[0].movieTitle){
					$('.genreMovie').prepend('<h1><%=nick %> 님이 좋아하는 장르의 영화들!</h1>')
				}
				$.each(data,function(index,item){
					$('.MovieGenre').append("<div class=MovieGenreMovie>"+
                 		   "<div><a class=MovieGenrePoster><img class=MovieGenrePoster_img></a></div>"+ // title 대신에 포스터클릭하면 넘어가게끔 변경 - 낙원:0930
                 		   "<div class =MovieGenreMovieName></div>"+
                 		   "<div class=MovieGenreNation></div></div>");
                  		$('.MovieGenrePoster_img').eq(index).css("width","250px").css("height","350px");
                  		$('.MovieGenrePoster_img').eq(index).attr("src",item.moviePoster);
	         		   $('.MovieGenreNation').eq(index).text(item.nation);
	                   $('.MovieGenrePoster').eq(index).attr('href','MovieDetailPro.mo?movieSeq='+item.movieSeq+'&query='+item.movieTitle);
	                   $('.MovieGenreMovieName').eq(index).html(item.movieTitle);
				});
				
				$('.MovieGenre').slick({
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
	<div class="genreMovie">
	<div class="MovieGenre"></div>
	</div>
</body>
</html>