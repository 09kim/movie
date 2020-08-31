<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="../../../Movie/js/jquery-3.5.1.js"></script>
<script type="text/javascript">
	$(document).ready(function(){

			
			$('#directorMovies').click(function(){
				
				var director = $("#directorName").val();
				director = director.replace(/ /g,'');
				$.ajax('MovieDirector.mo',{
					method:"get",
					dataType :"json",
					data:{query:director},
					success:function(data){
						
						
						
						$.each(data.Data,function(idx,item){
							
							var count = item.Count
								
							$.each(item.Result,function(idx,item2){
								
								var title = item2.title
								var titleNoSpace = title.replace(/ /g, '');
								var title2 = titleNoSpace.replace(/!HS/g,'')
								var title3 = title2.replace(/!HE/g,'')
								var title5 = title3.trim();
								var actors="";
								
								var image = item2.posters.split("|")
								
								for(var num = 0; num < item2.actor.length ; num++){
									actors = actors + item2.actor[num].actorNm + ", ";	
								}
									
								$('#subInfo').append('<div class=nation>'+item2.nation+'</div>')
								$('#subInfo').append('<div class=title><a href=MovieDetailPro.mo?movieId'+item2.movieId+'&movieSeq='
										+item2.movieSeq+'&query='+title5+'>'+title3+'</div>')
								$('#subInfo').append('<div class=runtime>'+item2.runtime+'</div>')
								$('#subInfo').append('<div class=rating>'+item2.rating[0].ratingGrade+'</div>')
								$('#subInfo').append('<div class=poster><img src='+image[0]+'></div>')
			                  });dd
						});
					}
			});
				
			});
			
			
			
	});
</script>
</head>
<body>
<form action="MovieSearch.mo">
<input type="text" name="query">
<input type="submit" value="검색">
</form>
<%String movieSeq = request.getParameter("movieSeq");
  String query = request.getParameter("query");%>
	<input type="hidden" id="movieSeq" value="<%=movieSeq%>">
	<input type="hidden" id="query" value="<%=query%>">
	<section id="detail">
	</section>
	<section id="posters">
	</section>
	<section style=float:left; id="keyword">
	</section>
	<br><br><br><br><br><br>
	<%String director=request.getParameter("director"); %>
	<input type="hidden" id="director" name=director value="<%=director%>">
	<section>
		<input type="button" id="directorMovies" value="이 감독의 다른 영화">
		<br>
		<div id="subInfo">d</div>
		
	<section id="list">
	</section>
	</section>
</body>
</html>

