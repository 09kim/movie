<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<script src="../../../Movie/js/jquery-3.5.1.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		// 영화의 디테일한 내용을 담당하는 Jquery 문
// 		$('#btn').click(function(){
			var name = $("#na").val();
			var movieSeq = $("#movieSeq").val();
			var query = $("#query").val();
			var keyword = $("#keyword").val();
			$.ajax({
				url:"MovieDetail.mo",
				method:"post",
				dataType :"json",
				data:{
					movieSeq:movieSeq,
					query:query,
					keyword:keyword
					},
				success:function(data){
					
					$.each(data.Data,function(idx,item){
						
						
						$.each(item.Result,function(idx,item2){
							
							var title = item2.title
							var titleNoSpace = title.replace(/ /g, '');
							var title2 = titleNoSpace.replace(/!HS/g,'')
							var title3 = title2.replace(/!HE/g,'')
							var title5 = title3.trim();
							
							var stlls = item2.stlls.split("|")
							var keyword = item2.keywords.split(",")
							var actors="";
							for(var num = 0; num < item2.staff.length ; num++){
								if(item2.staff.length>11){
									if(num==11){
										break;
									}
									if(!item2.staff[num].staffRole){
										actors = actors + item2.staff[num].staffNm + " : "+ item2.staff[num].staffRoleGroup+"<br>";
									}else{
									actors = actors + item2.staff[num].staffNm + " : "+ item2.staff[num].staffRole+"<br>";	
									}
								}else {
									if(!item2.staff[num].staffRole){
										actors = actors + item2.staff[num].staffNm + " : "+ item2.staff[num].staffRoleGroup+"<br>";
									}else{
									actors = actors + item2.staff[num].staffNm + " : "+ item2.staff[num].staffRole+"<br>";	
									}
								}
								
							}
							
							$('#detail').append('<div class=title>'+title5+'</div>')
							$('#detail').append('<div class=title>'+item2.repRlsDate+'</div>')
							$('#detail').append('<div class=titleEng>'+item2.titleEng+'</div>')
							$('#detail').append('<div class=nation>'+item2.nation+'</div>')
							$('#detail').append('<div class=runtime>'+item2.runtime+'</div>')
							$('#detail').append('<div class=rating>'+item2.rating[0].ratingGrade+'</div>')
							$('#detail').append('<div class=runtime>'+item2.genre+'</div>')
							$('#detail').append('<div class=actors><a href=MovieSearchDirector.mo?director='+item2.director[0].directorNm+'>'+item2.director[0].directorNm+'</a></div>')
							$('#detail').append("<input type='hidden' id ='directorName' value="+ item2.director[0].directorNm+ ">")
							$('#detail').append('<div class=actors>'+actors+'</div>')
							$('#detail').append('<div class=company>'+item2.company+'</div>')
							$('#detail').append('<div class=plot>'+item2.plot+'</div>')
							for(var i in stlls){
							$('#posters').append('<div style=float:left; class=image><img src='+stlls[i]+'></div>')
							}
								if(keyword[0]!=""||keyword[keyword.length]!=""){
									
								for(var i in keyword){
									
										$('#keyword').append('<div style=float:left; class=keyword><a href=MovieSearchKeyword.mo?keyword='+keyword[i]+'>#'+keyword[i]+'&nbsp;</div>')
									}
									
								}
		                  });
					});
				}
				
			});
			
			
			
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
			                  });
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
	<a href="#" id="directorMovies">이 감독의 다른 영화</a>
			<br>
		<div id="subInfo"></div>
		
	<section id="list">
	</section>
	</section>
</body>
</html>