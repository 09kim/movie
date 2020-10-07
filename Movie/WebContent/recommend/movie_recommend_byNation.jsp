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
		$.ajax('MovieGetNation.mo',{
			method : "post",
			dataType : "json",
			async: false,
			success : function(data){
				if(data[0].movieTitle){
					$('.nationMovie').prepend('<h1><%=nick %> 님이 좋아하는 국가의 영화들!</h1>')
				}
				$.each(data,function(index,item){
					$('.MovieNation').append("<div class=MovieNationMovie>"+
                 		   "<div><a class=MovieNationPoster><img class=MovieNationPoster_img></a></div>"+
                 		   "<div class =MovieNationMovieName></div>"+
                 		   "<div class=MovieNationNation></div></div>");
                  	   $('.MovieNationPoster_img').eq(index).css("width","250px").css("height","350px");
                  	   $('.MovieNationPoster_img').eq(index).attr("src",item.moviePoster);
	         		   $('.MovieNationNation').eq(index).text(item.nation);
	                   $('.MovieNationPoster').eq(index).attr('href','MovieDetailPro.mo?movieSeq='+item.movieSeq+'&query='+item.movieTitle);
	                   $('.MovieNationMovieName').eq(index).html(item.movieTitle);
				});
				
				$('.MovieNation').slick({
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
	<div class="nationMovie">
	<div class="MovieNation"></div>
	</div>
</body>
</html>