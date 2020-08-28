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
	
// 	$('#btn').click(function(){
		var query = $("#query").val();
		$.ajax({
			url:"MovieSearchPro.mo",
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
						
						for(var num = 0; num < item2.actor.length ; num++){
							actors = actors + item2.actor[num].actorNm + ", ";	
						}
						$('#list').append('<div class=nation>'+item2.nation+'</div>')
						$('#list').append('<div class=title><a href=MovieDetailPro.mo?movieSeq='+item2.movieSeq+'&query='+title5+'>'+title3+'</div>')
						$('#list').append('<div class=runtime>'+item2.runtime+'</div>')
						$('#list').append('<div class=rating>'+item2.rating[0].ratingGrade+'</div>')
						$('#list').append('<div class=poster><img src='+image[0]+'></div>')
							
						
	                  });
						
// 						$('table').append("<tr><th><a href='MovieDetail1.mo?query="+title4+"&movieSeq="+item2.movieSeq+"'>"+title5+"</a></th><th>"+item2.staff[0].staffNm+"</th><th>"+item.actor+"</th><th>"+item.userRating
// 								+"</th><th><img src="+item.image+"></th></tr>")
// 						});
						
					
				});
				
				
			}
			
// 		});
		
	});
});
</script>
</head>
<body>
<%String query=request.getParameter("query"); %>
	<input type="hidden" id="query" name=query value="<%=query%>">
	<section id="list">
	</section>
</body>
</html>
