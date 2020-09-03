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
	
	// 핸드폰 인증번호
	$('#phoneNumBtn').click(function() {
		var phone = $("#phone").val();
		alert(phone)
		$.ajax('Message.me',{
			data:{phone:phone},
			success:function(rdata){
				$('#divPhone').html(rdata);
<<<<<<< HEAD
				$("#phoneNumBtn").attr("disabled","disabled");
			}
		});
	});
	
	$('#certificationBtn').click(function() {
		var cNum = $("#certificationNum").val();
		if(cNum==$('#hiddenCnum').val()){
			$('#divid').html("인증되셨습니다.");
			$("#phone").attr("readonly",true);
			$("#certificationNum").attr("readonly",true);
			$("#certificationBtn").attr("disabled","disabled");
			alert("certificationNum");
		} else {
			$('#divid').html("인증번호가 틀렸습니다.")
		}
	});
	
	// 닉네임 중복체크
	$('#dupNick').click(function() {
		var nick = $('#nick').val();	
		$.ajax('dupNick.me',{
			data: {nick:nick},
			success: function(rdata){
				$('#divNick').html(rdata);
			}
		});
	});
	
	// 비밀번호 일치/불일치
	$('#againPass').keyup(function() {
		var pw1 = $('#pass').val();
		var pw2 = $('#againPass').val();
		
        if(pw1 == pw2) {
            $('#checkPass').html('비밀번호가 일치합니다');
            return false;
        } else {
            $('#checkPass').html('비밀번호가 일치하지 않습니다');
        }
        		
	});
	
    // 비밀번호 정규식	
	$('#pass').keyup(function() {
		var pw = $('#pass').val();
			
//      var reg = /^(?=.*?^[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@]).{8,15}$/;
        var reg = /^[a-zA-Z0-9!@].{8,15}$/;
		var regLow = /[a-z]/;
		var regUpper = /[A-Z]/;
        var regNum = /[0-9]/;
        var regSpec = /[!@]/;        
        
        if(pw.search(/\s/) != -1) {
            $('#regPass').html('비밀번호는 공백 없이 입력해주세요.');
            return false;
        }  else if(/(\w)\1\1\1/.test(pw)){
            $('#regPass').html('같은 문자를 4번 이상 사용할 수 없습니다.');
            return false;
        } else if(pw == "") {
            $('#regPass').html('비밀번호는 8~15자이며, 대문자(영문자)/소문자(영문자)/숫자/특수문자(!,@)를 포함해야 합니다.');
            return false;
        } else if(false == regLow.test(pw)) {
        	$('#regPass').html('소문자(영문자)를 포함해야 합니다.');
            return false;
        } else if(false == regUpper.test(pw)) {
            $('#regPass').html('대문자(영문자)를 포함해야 합니다.');
            return false;
        } else if(false == regNum.test(pw)) {
            $('#regPass').html('숫자를 포함해야 합니다.');
            return false;
        } else if(false == regSpec.test(pw)) {
            $('#regPass').html('특수문자(!,@)를 포함해야 합니다.');
            return false;
	    } else if(false == reg.test(pw)) {
            $('#regPass').html('비밀번호는 8~15자이며, 대문자(영문자)/소문자(영문자)/숫자/특수문자(!,@)를 포함해야 합니다.');
            return false;
        } else {
            $('#regPass').html('사용 가능')
        }
		  
	});
	
    // 비밀번호 강도 표시
    $('#pass').keyup(function() {
		$('#divPass').html(checkStrength($('#pass').val()))
    });	
   
	function checkStrength(pass) {
		var strength = 0;
		
        if(pass.length < 8) {
            $('#divPass').removeClass()
            $('#divPass').addClass.html('비밀번호 짧음');
            return false;
        }
        
        if(pass.length >= 8) strength += 1
        if(pass.match(/([a-z].*[A-Z])|([A-Z].*[a-z]))/)) strength += 1
        if(pass.match(/([a-zA-Z])/) && pass.match(/([0-9])/)) strength += 1
        if(pass.match(/([!,@])/)) strength += 1
        
        if(strength < 2) {
            $('#divPass').removeClass()
            $('#divPass').addClass('약함')
            return false;
            
        } else if(strength == 2) {
            $('#divPass').removeClass()
            $('#divPass').addClass('중간')
            return false;
            
        } else {
            $('#divPass').removeClass()
            $('#divPass').addClass('강함')
            return false;
        }                  
	}
		
   	
		
	/// 이메일 체크
	$( function(){
		$( '#email' ).on("blur keyup", function() {
			$(this).val( $(this).val().replace( /[^0-9a-zA-Z-_\\@.]/g, '' ) );
		});
	})
	
	$('#emailBtn').click(function() {
		// 이메일 인증 번호받기 재시도시 기존에 인증받아서 잠겼던 버튼과 코드입력창의 상태를 원상복구
		$("#certificationNum_email").attr("readonly",false);
		$("#certification_email_Btn").attr("disabled",false);
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
               
               if ((ch < "0" || ch > "9") && (ch < "A" || ch > "Z") && ((code > 255) || (code < 0))){
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
					$('#divemail').html(rdata);
				}
			});
		}
           
       });
});

=======
				$("#phoneNumBtn").attr("disabled",true);
			}
		});
	});
	
	
	
	
	
	
	$('#certificationBtn').click(function() {
		var cNum = $("#certificationNum").val();
		if(cNum==$('#hiddenCnum').val()){
			// 낙원(0902:divid => divPhone으로 변경)
			$('#divphone').html("인증되셨습니다.");
			$("#phone").attr("readonly",true);
			$("#certificationNum").attr("readonly",true);
			$("#certificationBtn").attr("disabled",true);3
			alert("인증되었습니다.");
		} else {
			// 낙원(0902:divid => divPhone으로 변경)
			$('#divPhone').html("인증번호가 틀렸습니다.")
		}
	});
	
	$('#dupNick').click(function(){
		var nick = $('#nick').val();		
		$.ajax("dupNick.me",{
			data:{nick:nick},
			success:function(data){
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
>>>>>>> refs/heads/낙원
</script>
</head>
<body>
<<<<<<< HEAD



<!-- 0829 이메일 인증번호 체크 구현해야함 -->
<form action="MemberJoinPro.me" method="get">
이메일 : <input type="text" id="email" name="email">  &nbsp;&nbsp; <input type="button" id="emailBtn" value="인증 번호 받기" ><br>
<input type="text" id="certificationNum_email">  &nbsp;&nbsp;  <input type="button" id="certification_email_Btn" value="인증 번호 입력">
<div id="divemail"></div>
비밀번호 : <input type="password" id="pass" name="pass"><span id="regPass"></span><br>
<div id="divPass"></div>
비밀번호 확인 : <input type="password" id="againPass" name="againPass">
<span id="checkPass"></span><br>
닉네임 : <input type="text" id="nick" name="nick" required="required"> &nbsp;&nbsp; <input type="button" id="dupNick" value="닉네임 중복체크" ><br>
<div id="divNick"></div>
연락처 : <input type="text" id="phone" name="phone">  &nbsp;&nbsp; <input type="button" id="phoneNumBtn" value="인증번호" ><br>
<input type="text" id="certificationNum">  &nbsp;&nbsp;  <input type="button" id="certificationBtn" value="인증">
<div id="divPhone"></div>

=======
<!-- 낙원(0902:헤더 추가) -->
<jsp:include page="/inc/top.jsp" />
<div class="clear"></div>
<!-- /낙원(0902:헤더 추가) -->


<form action="MemberJoinPro.me" method="get">
<fieldset>
<legend>Nick Name</legend>
<input type="text" name="nick" id="nick"> &nbsp;&nbsp; <input type="button" value="닉네임 중복체크" id="dupNick"> <br>
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
>>>>>>> refs/heads/낙원
<input type="submit" value="가입">
</form>







<!-- 0829 이메일 인증번호 체크 구현해야함 -->
<!-- <form action="MemberJoinPro.me" method="get"> -->
<!-- 이메일 : <input type="text" id="email" name="email">  &nbsp;&nbsp; <input type="button" id="emailBtn" value="인증 번호 받기" ><br> -->
<!-- <input type="text" id="certificationNum_email">  &nbsp;&nbsp;  <input type="button" id="certification_email_Btn" value="인증 번호 입력"> -->
<!-- <div id="divEmail"></div> -->
<!-- 패스워드 : pass <input type="password" id="pass" name="pass"><span id="regPass"></span> -->
<!-- <span id="st_msg"></span><br> -->
<!--  again pass <input type="password" id="againPass"><br> -->
<!-- 닉네임 : <input type="text" id="nick" name="nick" required="required"> &nbsp;&nbsp; <input type="button" value="닉네임 중복체크" id="dupNick"> <br> -->
<!-- <div id="divNick"></div> -->
<!-- 연락처 : <input type="text" id="phone" name="phone">  &nbsp;&nbsp; <input type="button" id="phoneNumBtn" value="인증번호" ><br> -->
<!-- <input type="text" id="certificationNum">  &nbsp;&nbsp;  <input type="button" id="certificationBtn" value="인증"> -->
<!-- <div id="divPhone"></div> -->

<!-- <input type="submit" value="가입"> -->
</form>
</body>
</html>