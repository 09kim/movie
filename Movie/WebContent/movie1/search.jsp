
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
	
	$('#btn').click(function(){
		var name = $("#na").val();
		$.ajax({
			url:"MovieSearchPro.mo",
			method:"get",
			dataType :"json",
			data:{name:name},
			success:function(data){
				
				$.each(data.Data,function(idx,item){
					
					$.each(item.Result,function(idx,item2){
					
						alert(item2)
						
						var title = item2.title
						
						var title2 = title.replace('!HS','')
						var title3 = title2.replace('!HE','')
						var title4 = title3.replace('/ /gi',"")
						var title5 = title4.trim();
						
						$('table').append("<tr><th>제목</th><td id=title></td></tr><tr><th>국가</th>"+
						"<td id=nation></td></tr><tr><th>런타임</th><td id=runtime></td></tr><tr><th>관람등급</th>"+
						"<td id=rating></td></tr><tr><th>제작</th><td id=company></td></tr><tr><th>출연</th>"+
						"<td id=actors></td></tr>")
						
						
						
						var actors="";
// 						for(var num = 3; num < 13 ; num++){
// 							actors = actors + item2.staff[num].staffNm + ", ";	
// 						}
						$('#title').text(title5);
						$('#actors').text(actors);	
	                  });
						
// 						$('table').append("<tr><th><a href='MovieDetail1.mo?query="+title4+"&movieSeq="+item2.movieSeq+"'>"+title5+"</a></th><th>"+item2.staff[0].staffNm+"</th><th>"+item.actor+"</th><th>"+item.userRating
// 								+"</th><th><img src="+item.image+"></th></tr>")
// 						});
						
					
				});
				
				
			}
			
		});
		
	});
});
</script>
</head>
<body>
	<input type="text" id="na" name="na">
	<input type="button" id="btn" value="버튼" onclick="">
	<table id="table" border="1">

	</table>
</body>
</html>
