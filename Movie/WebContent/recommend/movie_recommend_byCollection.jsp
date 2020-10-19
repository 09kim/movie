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
		$.ajax('MovieGetCollection.mo',{
			method : "get",
			dataType : "json",
			async: false,
			data:{
				type : 1
			},
			success : function(data){
				$('.collectionMovie1').prepend('<h1> 컬렉션 추천! '+data[0].collection_name+'</h1>')
				
				$.each(data,function(index,item){
					
					$('.Moviecollection1').append("<div class=MovieCollectionMovie>"+
	                 		   "<div><a class=MovieCollectionPoster><img class=MovieCollectionPoster_img></a></div>"+
	                 		   "<div class =MovieCollectiontMovieName></div>"+
	                 		   "</div>");
	                  	   $('.MovieCollectionPoster_img').eq(index).css("width","250px").css("height","350px");
	                  	   $('.MovieCollectionPoster_img').eq(index).attr("src",item.poster);
		                   $('.MovieCollectionPoster').eq(index).attr('href','MovieDetailPro.mo?movieSeq='+item.movieSeq+'&query='+item.title);
		                   $('.MovieCollectionMovieName').eq(index).html(item.movieTitle);
				});
				
				
				$('.Moviecollection1').slick({
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
		
		$.ajax('MovieGetCollection.mo',{
			method : "get",
			dataType : "json",
			async: false,
			data:{
				type : 2
			},
			success : function(data){
				$('.collectionMovie2').prepend('<h1> 컬렉션 추천! '+data[0].collection_name+'</h1>')
				
				$.each(data,function(index,item){
					
					$('.Moviecollection2').append("<div class=MovieCollection2Movie>"+
	                 		   "<div><a class=MovieCollection2Poster><img class=MovieCollection2Poster_img></a></div>"+
	                 		   "<div class =MovieCollectiont2MovieName></div>"+
	                 		   "</div>");
	                  	   $('.MovieCollection2Poster_img').eq(index).css("width","250px").css("height","350px");
	                  	   $('.MovieCollection2Poster_img').eq(index).attr("src",item.poster);
		                   $('.MovieCollection2Poster').eq(index).attr('href','MovieDetailPro.mo?movieSeq='+item.movieSeq+'&query='+item.title);
		                   $('.MovieCollection2MovieName').eq(index).html(item.movieTitle);
				});
				
				
				$('.Moviecollection2').slick({
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
	<div class="collectionMovie1">
	<div class="Moviecollection1"></div>
	</div>
	<div class="collectionMovie2">
	<div class="Moviecollection2"></div>
	</div>
</body>
</html>