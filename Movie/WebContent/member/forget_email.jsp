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
	$('#divPass').children().hide();
	$('#certification_email_Btn').click(function() {
		var cNum = $("#certificationNum_email").val();
		if(cNum==$('#hiddenCnum_email').val()){
			$('#divEmail').html("인증되셨습니다.");
			$("#email").attr("readonly",true);
			$("#certificationNum_email").attr("readonly",true);
			$("#certification_email_Btn").attr("disabled",true);
			alert("이메일 인증 완료!");
			$('#divPass').children().show();
		} else {
			$('#divEmail').html("인증번호가 틀렸습니다.");
		}
	});
	
	
		/// 이메일 체크
		$( function(){
			$( '#email' ).on("blur keyup", function() {
				$(this).val( $(this).val().replace( /[^0-9a-zA-Z-_\\@.]/g, '' ) );
			});
		})
		
		$('#emailBtn').click(function() {
			// 정규식 판별 변수
			var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.([a-zA-Z]){2,3}$/i;
			var checkResult = regExp.test( $("#email").val() );
            
            // 정규식에 위배되는 경우
            if (!checkResult){
				alert('이메일 양식을 확인해주세요.');
			}
            // 바이트 수를 초과하지 않고 정규식에 위배 되지 않는 경우
			if(checkResult==true){
				$.ajax('ForgetPasswordPro.me',{
					data:{email:$('#email').val()},
					success:function(rdata){
						$('#divEmail').html(rdata);
					}
				});
			}
            
        });
		
		// 회원가입 버튼 동작
		$('.update_fr').submit(function(){
			if($('#pass').val()==""){
				alert("비밀번호를 입력하세요");
				$('#pass').focus();
				return false;
			}
			if($('#email').val()==""){
				alert("이메일을 입력하세요");
				$('#email').focus();
				return false;
			}
			if($('#certificationNum_email').val()==""){
				alert("이메일 인증코드를 입력하세요");
				$('#certificationNum_email').focus();
				return false;
			}
			
			
			
		});
		
		
});
</script>

</head>
<body>
<jsp:include page="/inc/top.jsp" />
<div class="clear"></div>
<!-- 헤더 -->

<section id="main">
<form class="update_fr" action="MemberUpdatePasswordPro.me" method="get">

<div id="divPass">
<fieldset>
<legend>Password</legend>
<input type="password" name="pass" id="pass"> <br>
</fieldset>
</div>

<fieldset>
<legend>E-Mail</legend>
<input type="text" id="email" name="email">  &nbsp;&nbsp; <input type="button" id="emailBtn" value="인증 번호 받기" ><br>
<input type="text" id="certificationNum_email">  &nbsp;&nbsp;  <input type="button" id="certification_email_Btn" value="인증 번호 입력">
<div id="divEmail"></div>
</fieldset>
<input type="submit" value="Submit" class="submit">
<input type="reset" value="Cancel" class="cancel">
</form>
</section>

</body>
</html>