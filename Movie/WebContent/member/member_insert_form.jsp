<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../../../Movie/js/jquery-3.5.1.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	$('#phoneNumBtn').click(function() {
		var phone = $("#phoneNum").val();
		$.ajax('Message.me',{
			data:{phoneNum:phone},
			success:function(rdata){
				$('#divid').html(rdata);
				$("#phoneNumBtn").attr("disabled","disabled");
			}
		});
	});
	
	$('#certificationBtn').click(function() {
		var cNum = $("#certificationNum").val();
		if(cNum==$('#hiddenCnum').val()){
			$('#divid').html("인증되셨습니다.");
			$("#phoneNum").attr("readonly",true);
			$("#certificationNum").attr("readonly",true);
			$("#certificationBtn").attr("disabled","disabled");
			alert("certificationNum");

		} else {
			$('#divid').html("인증번호가 틀렸습니다.")
		}
	});
});
</script>
</head>
<body>




<form action="MemberWritePro.me">
이메일 : <input type="text" name="email"> &nbsp;&nbsp; <input type="button" value="이메일 중복체크" id="dupEmail"> <br> 
패스워드 : <input type="password" name="pass"> <br> 
닉네임 : <input type="text" name="nick"> &nbsp;&nbsp; <input type="button" value="닉네임 중복체크" id="dupNick"> <br>
연락처 : <input type="text" id="phoneNum" name="phoneNum">  &nbsp;&nbsp; <input type="button" id="phoneNumBtn" value="인증번호" ><br>
			<input type="text" id="certificationNum">  &nbsp;&nbsp;  <input type="button" id="certificationBtn" value="인증">
	 
<div id="divid">d</div>
<input type="submit" value="가입">
</form>
</body>
</html>