<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="../../../Movie/js/jquery-3.5.1.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
					
		
		$.urlParam = function(name){
		    var results = new RegExp('[\?&amp;]' + name + '=([^&amp;#]*)').exec(window.location.href);
		    return results[1] || 0;
		}

	
				var movieSeq = $.urlParam('movieSeq');   
				movieSeq = movieSeq.replace(/ /g,'');
				$.ajax('MovieActorRole.mo',{
					method:"get",
					dataType :"json",
					data:{query:movieSeq},
					success:function(data){
						alert("되냐234"); 
						$.each(data.Data,function(idx,item){
							$.each(item.Result,function(idx,item2){
								
								var actors="";
								for(var num = 0; num < item2.staff.length ; num++){
									if(item2.staff.length>11){
										if(num==11){
											break;
										}
										if(!item2.staff[num].staffRole){
											actors = actors + item2.staff[num].staffNm + " : "+ item2.staff[num].staffRoleGroup+"<br>";
										}else{
										actors = actors + item2.staff[num].staffNm + " : "+ item2.staff[num].staffRole+"<br>";	
										}
									}else {
										if(!item2.staff[num].staffRole){
											actors = actors + item2.staff[num].staffNm + " : "+ item2.staff[num].staffRoleGroup+"<br>";
										}else{
										actors = actors + item2.staff[num].staffNm + " : "+ item2.staff[num].staffRole+"<br>";	
										}
									}
									$('#detail').append('<div class=actors>'+actors+'</div>')
								}
								
							
			                  });
						});
					}
			});
				

	});
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
</head>
<body>
<section id="detail">

</section>
</body>
</html>