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
		
// 		$('#btn').click(function(){
			var name = $("#na").val();
			var movieSeq = $("#movieSeq").val();
			var query = $("#query").val();
			$.ajax({
				url:"MovieDetail.mo",
				method:"get",
				dataType :"json",
				data:{
					movieSeq:movieSeq,
					query:query
					},
				success:function(data){
					
					$.each(data.Data,function(idx,item){
						
						
						$.each(item.Result,function(idx,item2){
							
							var title = item2.title
							var title2 = title.replace('!HS','')
							var title3 = title2.replace('!HE','')
							var title4 = title3.replace('/ /gi',"")
							var title5 = title4.trim();
							
							$('#idx').text(item2.DOCID);
							$('#id').text(item2.movieId);
							$('#seq').text(item2.movieSeq);
							$('#title').text(title5);
							$('#titleEng').text(item2.titleEng);
							$('#nation').text(item2.nation);
							$('#plot').text(item2.plot);
							$('#runtime').text(item2.runtime);
							$('#rating').text(item2.rating);
							$('#company').text(item2.company);
							
//							alert(item2.length);
// 							for(var num = 0; num<item2.director.length; num++){
// 								<tr><th>감독</th><td>"+item2.director[num].directorNm+"</td></tr>")
// 								<tr><th>감독번호</th><td>"+item2.director[num].directorId+"</td></tr>")
// 							}
							
//								<tr><th>감독</th><td>"+item2.staff[0].staffNm+"</td><td>"+item2.staff[0].staffRoleGroup+"</td><td>"+item2.staff[0].staffRole+"</td></tr>");
								
							var actors="";
							for(var num = 3; num < 13 ; num++){
// 								$('#actors').text("<tr><th>출연</th><td>"+item2.staff[num].staffNm+"</td><td>"+item2.staff[num].staffRoleGroup+"</td><td>"+item2.staff[num].staffRole+"</td></tr>");	
								actors = actors + item2.staff[num].staffNm + ", ";	
							}
							$('#actors').text(actors);	
		                  });
						
// 						$.each(item2.actor[0],function(idx,item3){
// 		                     <tr><th>"+item3[0]+"</th></tr>")
// 							});
						
						
						
// 							<tr><th>"+item.Result[0].actor[0].actorNm+"</th></tr>")	
// 					<tr><th>"+item.Result[0].actor[0].actorNm+"</th><th>"+item.Result[0].director.directorNm+"</th><th>"+item.actorNm+"</th><th>"+item.releaseDate
// 							+"</th><th><img src="+item.Result[0].posters+"></th></tr>")
					});
					
					
				}
				
			});
			
// 		});
	});
</script>
</head>
<body>
<%String movieSeq = request.getParameter("movieSeq");
  String query = request.getParameter("query");%>
	<input type="hidden" id="movieSeq" value="<%=movieSeq%>">
	<input type="hidden" id="query" value="<%=query%>">
	<table id="table" border="1">
		<tr>
			<th>기준키</th>
			<td id="idx"></td>
		</tr>
		<tr>
			<th>등록아이디</th>
			<td id="id"></td>
		</tr>
		<tr>
			<th>등록아이디</th>
			<td id="seq"></td>
		</tr>
		<tr>
			<th>제목</th>
			<td id="title"></td>
		</tr>
		<tr>
			<th>영제목</th>
			<td id="titleEng"></td>
		</tr>
		<tr>
			<th>국가</th>
			<td id="nation"></td>
		</tr>
		<tr>
			<th>줄거리</th>
			<td id="plot"></td>
		</tr>
		<tr>
			<th>런타임</th>
			<td id="runtime"></td>
		</tr>
		<tr>
			<th>관람등급</th>
			<td id="rating"></td>
		</tr>
		<tr>
			<th>제작</th>
			<td id="company"></td>
		</tr>

		<tr>
			<th>출연</th>
			<td id="actors"></td>
		</tr>
	</table>
</body>
</html>

