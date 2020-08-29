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
			$.ajax("GradeMoviePro.mo"),{
				method:"post",
				dataType :"json",
				success:function(data){
					$.each(data,function(data,item){
						$('table').append("<tr><th>"+item.title+"</th></tr>")	
					});
				}
				
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
</select>
</body>
</html>