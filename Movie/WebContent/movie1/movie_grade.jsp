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
	
	// 랜덤한 영화를 보여주는 Jqeury 문
	$('#categoryMovie').change(function(){
		var type = $('#categoryMovie option:selected').val();
		$("#movieList").empty();
// 		if(random=='random'){
// 		for(var i =0 ; i <11 ; i++){
				$.ajax("GradeMoviePro.mo",{
					method:"get",
					dataType :"json",
					data:{type:type},
					success:function(data){
						
						$.each(data.Data,function(idx,item){
							var count = item.TotalCount;
							var ran = parseInt(Math.random()*count);
							$.each(item.Result,function(idx,item2){
								var num = 0;
								var image = item2.posters.split("|")
								var title = item2.title
								var titleNoSpace = title.replace(/ /g, '');
								var title2 = titleNoSpace.replace(/!HS/g,'')
								var title3 = title2.replace(/!HE/g,'')
								var title5 = title3.trim();
								
								if(image[0]){
								$('#movieList').append('<div class=poster><img src='+image[0]+'></div><div class=title><a href=MovieDetailPro.mo?movieId'+item2.movieId+'&movieSeq='
										+item2.movieSeq+'&query='+title5+'>'+title3+'</div>')
								}else {
								$('#movieList').append('<div class=poster><img src=../../../Movie/img/noImage.gif></div><div class=title><a href=MovieDetailPro.mo?movieId'+item2.movieId+'&movieSeq='
										+item2.movieSeq+'&query='+title5+'>'+title3+'</div>')
								}
							});
						
						});
						
					}
					
				});
// 			}
// 		}
	});
});
</script>
</head>
<body>
<select id="categoryMovie">
<option >정렬기준</option>
<option id ="random" value="random">랜덤</option>
<option id ="comedy" value="코메디">코메디</option>
<option id ="crime" value="느와르">느와르</option>
<option id ="noir" value="범죄">범죄</option>
<option id ="drama" value="드라마">드라마</option>
<option id ="romance" value="로맨스">로맨스</option>
<option id ="thriller" value="스릴러">스릴러</option>
<option id ="war" value="전쟁">전쟁</option>
<option id ="family" value="가족">가족</option>
<option id ="fantasy" value="판타지">판타지</option>
<option id ="action" value="액션">액션</option>
<option id ="sf" value="SF">SF</option>
<option id ="animation" value="애니메이션">애니메이션</option>
<option id ="character" value="인물">인물</option>
<option id ="horror" value="공포">공포</option>
<option id ="mystery" value="미스테리">미스테리</option>
</select>
<section id="movieList">
</section>
</body>
</html>