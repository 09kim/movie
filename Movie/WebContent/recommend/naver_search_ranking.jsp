<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
	$(document).ready(function() {
		var nick = $('#nick').val();
		$.ajax('MovieNaver.mo',{
			method : "get",
			dataType : "json",
			async: false,
			success : function(data) {
				for(var i = 0; i<data.length;i++){
					$('.rank').append('<div class='+i+'></div>')
					$('.'+i).append(data[i]);
				}
				
			}
		});
		
	});
</script>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<div class="rank">
	
</div>
</body>
</html>