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
	                 		   "<div><a class=MovieCollectionPoster><div class=poster style=background-image:url("+item.poster+"),url('../../../Movie/img/noImage.gif')></div></a></div>"+
	                 		   "<div class =MovieCollectionMovieName></div>"+
	                 		   "</div>");
		                   $('.MovieCollectionPoster').eq(index).attr('href','MovieDetailPro.mo?movieSeq='+item.movieSeq+'&query='+item.title);
		                   $('.MovieCollectionMovieName').eq(index).html(item.title);
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
	                 		   "<div><a class=MovieCollectionPoster><div class=poster style=background-image:url("+item.poster+"),url('../../../Movie/img/noImage.gif')></div></a></div>"+
	                 		   "<div class =MovieCollection2MovieName></div>"+
	                 		   "</div>");
		                   $('.MovieCollection2Poster').eq(index).attr('href','MovieDetailPro.mo?movieSeq='+item.movieSeq+'&query='+item.title);
		                   $('.MovieCollection2MovieName').eq(index).text(item.title);
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