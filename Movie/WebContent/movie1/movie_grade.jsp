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
	
	
	$('#categoryMovie').change(function(){
		var random = $('#categoryMovie option:selected').val();
		if(random=='random'){
		for(var i =0 ; i <11 ; i++){
				$.ajax("GradeMoviePro.mo",{
					method:"get",
					dataType :"json",
					success:function(data){
						$.each(data.Data,function(idx,item){
							var count = item.TotalCount;
							var ran = parseInt(Math.random()*count);
							$.each(item.Result,function(idx,item2){
								var num = 0;
								
								var title = item2.title
								var titleNoSpace = title.replace(/ /g, '');
								var title2 = titleNoSpace.replace(/!HS/g,'')
								var title3 = title2.replace(/!HE/g,'')
								var title5 = title3.trim();
								
								$('#movieList').append('<div class=title><a href=MovieDetailPro.mo?movieId'+item2.movieId+'&movieSeq='
										+item2.movieSeq+'&query='+title5+'>'+title3+'</div>')
							});
						});
						
						
					}
					
				});
			}
		} else if(random=='sf'){
			for(var i =0 ; i <11 ; i++){
				$.ajax("GradeMoviePro.mo",{
					method:"get",
					dataType :"json",
					success:function(data){
						$.each(data.Data,function(idx,item){
							var count = item.TotalCount;
							var ran = parseInt(Math.random()*count);
							$.each(item.Result,function(idx,item2){
								var num = 0;
								
								var title = item2.title
								var titleNoSpace = title.replace(/ /g, '');
								var title2 = titleNoSpace.replace(/!HS/g,'')
								var title3 = title2.replace(/!HE/g,'')
								var title5 = title3.trim();
								alert(title,title2,title3,title5);
								
								$('#movieList').append('<div class=title><a href=MovieDetailPro.mo?movieId'+item2.movieId+'&movieSeq='
										+item2.movieSeq+'&query='+title5+'>'+title3+'</div>')
							});
						});
						
						
					}
					
				});
			}
		}
	});
});
</script>
</head>
<body>
<select id="categoryMovie">
<option >정렬기준</option>
<option id ="random" value="random">랜덤</option>
<option id ="sf" value="sf">SF</option>
</select>

<section id="movieList">
</section>
</body>
</html>