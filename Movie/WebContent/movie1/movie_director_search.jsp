<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<script src="../../../Movie/js/jquery-3.5.1.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	// 감독 검색기능의 Jquery 디테일에서 감독 이름 클릭시 결과가 나옴
		var director = $("#director").val();
		director = director.replace(/ /g,'');
		$.ajax('MovieSearchDirectorPro.mo',{
			method:"post",
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
							
						$('#list').append('<div class=nation>'+item2.nation+'</div>')
						$('#list').append('<div class=title><a href=MovieDetailPro.mo?movieId'+item2.movieId+'&movieSeq='
								+item2.movieSeq+'&query='+title5+'>'+title3+'</div>')
						$('#list').append('<div class=runtime>'+item2.runtime+'</div>')
						$('#list').append('<div class=rating>'+item2.rating[0].ratingGrade+'</div>')
						$('#list').append('<div class=poster><img src='+image[0]+'></div>')
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
<%String director=request.getParameter("director"); %>
	<input type="hidden" id="director" name=director value="<%=director%>">
	<section id="list">
	</section>
</body>
</html>
