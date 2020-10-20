<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.rank {
	position: fixed;
	right: 50%;
	top: 180px;
	margin-right: -990px;
	text-align: left;
	width: 300px;
	color: #FFFFFF
}
</style>

<script type="text/javascript">
function auto_reload(){  
    setTimeout('location.reload()',1000); 
}	
	$(document).ready(function() {
		var nick = $('#nick').val();
		
		$.ajax('MovieNaver.mo',{
			method : "get",
			dataType : "json",
			async: false,
			success : function(data) {
					$('.rank').prepend('<h6><b>네이버 영화종합 일간검색어</b></h6>')
				for(var i = 0; i<data.length;i++){
					$('.rank').append('<div class='+i+'></div>');
					data[i] = data[i].replace('상승','<span style=color:red>&uarr;</span>');
					data[i] = data[i].replace('하락','<span style=color:cyan>&darr;</span>');
					data[i] = data[i].replace('동일0','<span style=color:#FFFFFF; >─</span>');
					$('.'+i).append(data[i]);
					 
				}
				
			}
		});
		
		
	});
</script>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet">
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<div class="rank"></div>
</body>
</html>