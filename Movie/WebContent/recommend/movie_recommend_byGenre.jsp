<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%String nick = (String)session.getAttribute("nick"); %>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript">
	$(document).ready(function() {
		$.ajax('MovieGetGenre.mo',{
			method : "post",
			dataType : "json",
			async: false,
			success : function(data){
				$.each(data,function(index,item){
					alert(item.movieTitle);
				});
			}
			
		});
	});
</script>
</head>
<body>
	<h1><%=nick %> 님이 좋아하는 장르의 영화!</h1>
	
</body>
</html>