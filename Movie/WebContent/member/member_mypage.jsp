<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="../../../Movie/js/jquery-3.5.1.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var sortData = [];
		var nick = $('#nick').val();
		alert('ㅇㅇㅇ');
		$.ajax('MypageGener.me', {
			method : "get",
			dataType : "json",
			data : {
				nick : nick
			},
			success : function(data) {
				$.each(data,function(idx,item){
					sortData.push({key:idx,value:item});
					sortData.sort(function(a,b){
						return(a.value>b.value)?-1:(a.value<b.value)?1:0;
						
					});
				});
				
				$.each(sortData,function(idx,item){
					if(item.value!=0){
							$('body').append(item.key +" : "+item.value+"<br>");
					}
				});
			}
		});
		
// 		$.ajax('MypageTitle.me',{
// 			method : "get",
// 			dataType : "json",
// 			data : {
// 				nick : nick
// 			},
// 			success : function(data) {
// 				goPython(data);
// 				$.each(data.Movie,function(idx,item){
					
// // 						$.each(item,function(idx2,item2){
// // 							$('body').append(idx2+" : "+item2/2+"점 <br>");
// // 						});
// 					});
				
// 			}
// 		});
		
	});
</script>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<input type="hidden" id="nick" value="<%=request.getParameter("nick") %>">
</body>
</html>