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
		$.ajax('MovieGetTemp.mo',{
			method : "post",
			dataType : "json",
			data : {
				temp:temp,
				weather:weather
			},
			async : false,
			success : function(data){
				
			}
		
			
		});
	});
	
	
</script>
</head>
<body>
	<div class="nationMovie">
	<div class="MovieNation"></div>
	</div>
</body>
</html>