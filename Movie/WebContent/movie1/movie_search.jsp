<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../../../Movie/js/jquery-3.5.1.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
		var query = $("#query").val();
		query = query.replace(/ /g,'');
		$.ajax('MovieSearchPro.mo',{
			method:"get",
			dataType :"json",
			data:{query:query},
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
						var nation = item2.nation
						
						if(nation == "대한민국"){
							
							for(var num = 0; num < item2.actor.length ; num++){
								actors = actors + item2.actor[num].actorNm + ", ";	
							}
								
							$('#koreaList').append('<div class=nation>'+item2.nation+'</div>')
							$('#koreaList').append('<div class=title><a href=MovieDetailPro.mo?movieId='+item2.movieId+'&movieSeq='
									+item2.movieSeq+'&query='+title5+'>'+title3+'</div>')
							$('#koreaList').append('<div class=runtime>'+item2.runtime+'</div>')
							$('#koreaList').append('<div class=rating>'+item2.rating[0].ratingGrade+'</div>')
							$('#koreaList').append('<div class=poster><img src='+image[0]+'></div>')
						}
						else {
							
							for(var num = 0; num < item2.actor.length ; num++){
								actors = actors + item2.actor[num].actorNm + ", ";	
							}
								
							$('#foreignList').append('<div class=nation>'+item2.nation+'</div>')
							$('#foreignList').append('<div class=title><a href=MovieDetailPro.mo?movieId='+item2.movieId+'&movieSeq='
									+item2.movieSeq+'&query='+title5+'>'+title3+'</div>')
							$('#foreignList').append('<div class=runtime>'+item2.runtime+'</div>')
							$('#foreignList').append('<div class=rating>'+item2.rating[0].ratingGrade+'</div>')
							$('#foreignList').append('<div class=poster><img src='+image[0]+'></div>')
						
						}
						
					
						
	                  });
				});
			}
	});
		
});
</script>
</head>
<body>
<form action="MovieSearch.mo">
<input type="text" name="query">
<input type="submit" value="검색">
</form>
<%String query=request.getParameter("query"); %>
	<input type="hidden" id="query" name=query value="<%=query%>">
<h1>국내영화</h1>
	<section id="koreaList">
	</section>
	
<h1>국외영화</h1>
	<section id="foreignList">
	
	</section>
</body>
</html>
