<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<script src="../../../Movie/js/jquery-3.5.1.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	// 핸드폰 인증번호
	$('#phoneNumBtn').click(function() {
		var phone = $("#phoneNum").val();
		alert(phone)
		$.ajax('Message.me',{
			data:{phone:phone},
			success:function(rdata){
				$('#divPhone').html(rdata);
				$("#phoneNumBtn").attr("disabled",true);
			}
		});
	});
	
	$('#certificationBtn').click(function() {
		var cNum = $("#certificationNum").val();
		if(cNum==$('#hiddenCnum').val()){
			$('#divPhone').html("인증되셨습니다.");
			$("#phone").attr("readonly",true);
			$("#certificationNum").attr("readonly",true);
			$("#certificationBtn").attr("disabled",true);
			alert("인증 되셨습니다.");
		} else {
			$('#divPhone').html("인증번호가 틀렸습니다.")
		}
	});
	
	$('#certification_email_Btn').click(function() {
		var cNum = $("#certificationNum_email").val();
		if(cNum==$('#hiddenCnum_email').val()){
			$('#divEmail').html("인증되셨습니다.");
			$("#email").attr("readonly",true);
			$("#certificationNum_email").attr("readonly",true);
			$("#certification_email_Btn").attr("disabled",true);
			alert("이메일 인증 완료!");

		} else {
			$('#divEmail').html("인증번호가 틀렸습니다.")
		}
	});
	
	$('#dupNick').click(function(){
		var nick = $('#nick').val();		
		$.ajax("dupNick.me",{
			data:{nick:nick},
			success:function(data){
				alert(data)
				$('#divNick').html(data);
			}
		});
	});
	
	var pw = $('#pass').val(); 
// 	var reg = /^[a-zA-Z0-9!@]{8,15}$/;
	var reg = /^(?=.*?^[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@]).{8,15}$/;
	
	// 패스워드 정규식
	$('#pass').keyup(function() {
			
	if(false == reg.test(pw)) {
			$('#regPass').html('비밀번호는 8~15자이며,\n숫자/대문자/소문자/특수문자(!,@)를 포함해야 합니다.');
				return false;
	//			/^[가-힣a-zA-z]{3.10}$/
			}else {
				$('#regPass').html('사용 가능')
			}
		
			if(/(\w)\1\1\1/.test(pw)) {
				$('#regPass').html('같은 문자를 4번 이상 사용할 수 없습니다.');
				return false;
			
				}
			if(pw.search(/\s/) != -1) {
				$('#regPass').html('비밀번호는 공백 없이 입력해주세요.');
				return false;
				
				}
			});
		
		
		$('#pass').keyup(function() {
			$('#st_msg').html(checkStrength($('#pass').val()))
		});
		
		function checkStrength(pass) {
			var strength = 0;
			if(pass.length < 8) {
				$('#st_msg').removeClass()
				$('#st_msg').addClass('짧음')
			}
			
			if(pass.length >= 8) strength += 1
			if(pass.match(/([a-z].*[A-Z])|([A-Z].*[a-z]))/)) strength += 1
			if(pass.match(/([a-zA-Z])/) && pass.match(/([0-9])/)) strength += 1
			if(pass.match(/([!,@])/)) strength += 1
			
			if(strength < 2) {
				$('#st_msg').removeClass()
				$('#st_msg').addClass('약함')
                return '약함'
                
			} else if(strength == 2) {
				$('#st_msg').removeClass()
                $('#st_msg').addClass('중간')
                return '중간'
                
			} else {
				$('#st_msg').removeClass()
                $('#st_msg').addClass('강함')
                return '강함'
			}                                
		}
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
				$.ajax('Email.me',{
					data:{email:$('#email').val()},
					success:function(rdata){
						$("#emailBtn").attr("disabled",true);
						$('#divEmail').html(rdata);
					}
				});
			}
            
        });
		
		
});
</script>

</head>
<body>
<jsp:include page="/inc/top.jsp" />
<div class="clear"></div>
<br><br><br><br><br>
<form class="join_fr" action="MemberJoinPro.me" method="get">

<fieldset>
<legend>Nick Name</legend>
<input type="text" name="nick" id="nick"> &nbsp;&nbsp; <input type="button" value="닉네임 중복체크" id="dupNick"> <br>
<div id="divNick"></div>
</fieldset>

<fieldset>
<legend>Password</legend>
<input type="password" name="pass" id="pass"> <br>
</fieldset>

<fieldset>
<legend>Phone Number</legend>
<input type="text" id="phoneNum" name="phoneNum">  &nbsp;&nbsp; <input type="button" id="phoneNumBtn" value="인증 번호 받기" ><br>
<input type="text" id="certificationNum">  &nbsp;&nbsp;  <input type="button" id="certificationBtn" value="인증 번호 입력">
<div id="divPhone"></div>
</fieldset>

<fieldset>
<legend>E-Mail</legend>
<input type="text" id="email" name="email">  &nbsp;&nbsp; <input type="button" id="emailBtn" value="인증 번호 받기" ><br>
<input type="text" id="certificationNum_email">  &nbsp;&nbsp;  <input type="button" id="certification_email_Btn" value="인증 번호 입력">
<div id="divEmail"></div>
</fieldset>
</form>


</body>
</html>