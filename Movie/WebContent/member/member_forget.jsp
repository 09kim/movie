<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<<<<<<< HEAD
</head>
<body>
	<form action="ForgetPro.me" method="POST">
		<h2>비밀번호 찾기</h2>
		<hr>
		<h4>비밀번호를 찾고자 하는 아이디(이메일)를 입력해주세요.</h4>
		이메일 : <input type="text" name="email" required="required"><br>
		<input type="submit" value="다음">
	</form>
=======
<script src="../../../Movie/js/jquery-3.5.1.js"></script>
<script type="text/javascript">
$(document).ready(function(){
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
			// 바이트수 판별 변수
			var limit = 50; // DB의 email 컬럼의 데이터 길이값에 해당
			var str = $("#email").val();
			var strLength = 0;
			var strTitle = "";
            var strPiece = "";
            var check = false;
            
            for (i = 0; i < str.length; i++){
                var code = str.charCodeAt(i);
                var ch = str.substr(i,1).toUpperCase();
                //체크 하는 문자를 저장
                strPiece = str.substr(i,1)
                
                code = parseInt(code);
                
                if ((ch < "0" || ch > "9") && (ch < "A" || ch > "Z") && (code > 255 || code < 0)){
                    strLength = strLength + 3; //UTF-8 3byte 로 계산
                }else{
                    strLength = strLength + 1;
                }
                
                if(strLength>limit){ //제한 길이 확인
                    check = true;
                }else{
                    strTitle = strTitle+strPiece; //제한길이 보다 작으면 자른 문자를 붙여준다.
                }
                
            }
            // 바이트수가 초과한 경우
            if(check){
                alert(limit+"byte를 초과했습니다.");
            }
            $("#email").val(strTitle);
            // 정규식에 위배되는 경우
            if (!checkResult){
				alert('이메일 양식을 확인해주세요.');
			}
            // 바이트 수를 초과하지 않고 정규식에 위배 되지 않는 경우
			if(checkResult==true && check==false){
				$.ajax('ForgetPro.me',{
					data:{email:$('#email').val()},
					success:function(rdata){
						$('#divEmail').html(rdata);
					}
				});
			}
            
        });
		
		// 낙원(0902: 이메일 인증코드 확인 버튼 기능 누락되있던거 추가함)
		// 이메일 인증코드 확인 버튼 동작
		$('#certification_email_Btn').click(function() {
			var cNum = $("#certificationNum_email").val();
			if(cNum==$('#hiddenCnum_email').val()){
				$('#divEmail').html("인증되셨습니다.");
				$("#email").attr("readonly",true);
				$("#certificationNum_email").attr("readonly",true);
				$("#certification_email_Btn").attr("disabled","disabled");
				alert("이메일 인증 완료!");

			} else {
				$('#divEmail').html("인증번호가 틀렸습니다.")
			}
		});
});
</script>
</head>
<body>
<!-- 낙원(0902:헤더 추가) -->
<jsp:include page="/inc/top.jsp" />
<div class="clear"></div>
<!-- /낙원(0902:헤더 추가) -->

<form action="ForgetPro.me" method="get">
<h2>비밀번호 찾기</h2>
<hr>
<h4>비밀번호를 찾고자 하는 아이디(이메일)를 입력해주세요.</h4>
<fieldset>
<legend>E-Mail</legend>
<input type="text" id="email" name="email">  &nbsp;&nbsp; <input type="button" id="emailBtn" value="인증 번호 받기" ><br>
<input type="text" id="certificationNum_email">  &nbsp;&nbsp;  <input type="button" id="certification_email_Btn" value="인증 번호 입력">
<div id="divEmail"></div>
</fieldset>
<input type="submit" value="가입">
</form>  

>>>>>>> refs/heads/낙원
</body>
</html>