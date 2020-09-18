<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<!-- <script src="../../../Movie/js/jquery-3.5.1.js"></script> -->
<script type="text/javascript">
$(document).ready(function(){
	// 핸드폰 인증번호
	$('#phoneNumBtn').click(function() {
		var phone = $("#phoneNum").val();
		$.ajax('ForgetEmailPro.me',{
			data:{phone:phone},
			success:function(rdata){
				$('#divPhone').html(rdata);
				if(rdata!="존재하지 않는 핸드폰 번호"){
				$("#phoneNumBtn").attr("disabled",true);
				$("#phone").attr("readonly",true);
				alert("E-Mail주소를 SMS로 전송했습니다.");
				}else{
					alert("존재하지 않는 핸드폰 번호입니다.");
				}
			}
		});
	});
	
		
});
</script>

</head>
<body>
<jsp:include page="/inc/top.jsp" />
<div class="clear"></div>
<!-- 헤더 -->

<section id="main">
<h2>비밀번호 찾기</h2>
<hr>
<h4>회원가입시 사용한 핸드폰 번호를 입력해주세요.</h4>
<fieldset>
<legend>Phone Number</legend>
<input type="text" id="phoneNum" name="phoneNum">  &nbsp;&nbsp; <input type="button" id="phoneNumBtn" value="인증 번호 받기" ><br>
<div id="divPhone"></div>
</fieldset>
</section>

</body>
</html>