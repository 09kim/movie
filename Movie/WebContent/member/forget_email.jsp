<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<link href="${pageContext.request.contextPath}/css/memberjoin.css" rel="stylesheet" type="text/css">
<!-- <script src="../../../Movie/js/jquery-3.5.1.js"></script> -->
<script type="text/javascript">
$(document).ready(function(){
	$('#divPass').children().hide();
	
	// 패스워드 정규식 & 보안강도 표시 (낙원:0919)
	$('#pass').keyup(function() {
			var pw = $('#pass').val(); 
			
			var lengthReg = /(?=.{8,15})/;
			var upperReg = /[A-Z]/;
			var lowerReg = /[a-z]/;
			var numReg = /[0-9]/;
			var specialReg = /[!@]/;
			
			var length = lengthReg.test(pw);
			var lower = null;
			var upper = null;
			var num = null;
			var special = null;
			
			if(length){
				lower = lowerReg.test(pw);
				upper = upperReg.test(pw);
				num = numReg.test(pw);
				special = specialReg.test(pw);
				if(lower&&upper&&num&&special){ // 강함(영어 대문자+소문자+숫자+특수문자)
		            $('#st_msg').removeClass();
			        $('#st_msg').addClass('강함');
			        $('#st_msg').html("<div id='box1'></div><div id='box2'></div><div id='box3'></div><div id='box4'></div> 강함");
			        $('#regPass').html('사용 가능');
    				$('.confirm').eq(1).val("Y");
				} 
				else if((lower||upper)&&(num||special)){ // 중간(영어 대/소문자 + 숫자(또는 특수문자))
				    $('#st_msg').removeClass();
			        $('#st_msg').addClass('중간');
			        $('#st_msg').html("<div id='box1'></div><div id='box2'></div><div id='box3'></div><div id='box4'></div> 중간");
			        $('#regPass').html('비밀번호는 8~15자이며,\n숫자/대문자/소문자/특수문자(!,@)를 포함해야 합니다.');
// 			        $('.confirm').eq(1).val("N");
			        $('.confirm').eq(1).val("Y"); // 패스워드 2단계(실질적으로 3단계)에서 회원가입 가능하도록 코드 수정 - 낙원:1011
				} else { // 한가지 조합으로만 8글자 입력했을 경우
					$('#st_msg').removeClass();
					$('#st_msg').addClass('약함');
					$('#st_msg').html("<div id='box1'></div><div id='box2'></div><div id='box3'></div><div id='box4'></div> 약함");
					$('#regPass').html('비밀번호는 8~15자이며,\n숫자/대문자/소문자/특수문자(!,@)를 포함해야 합니다.');
					 $('.confirm').eq(1).val("N");
				}
				
			} else {
	        	$('#st_msg').removeClass();
	        	$('#st_msg').addClass('짧음');
		        $('#st_msg').html("<div id='box1'></div><div id='box2'></div><div id='box3'></div><div id='box4'></div> 짧음");
		        $('#regPass').html('비밀번호는 8~15자이며,\n숫자/대문자/소문자/특수문자(!,@)를 포함해야 합니다.');
		        $('.confirm').eq(1).val("N");
				if (pw.length==0) {
						$('#st_msg').hide();
		        } else {
		        	$('#st_msg').show();
		        }
			}
	        
			if(/(\w)\1\1\1/.test(pw)) {
				$('#regPass').html('같은 문자를 4번 이상 사용할 수 없습니다.');
				 $('.confirm').eq(1).val("N");
			}
			if(pw.search(/\s/) != -1) {
				$('#regPass').html('비밀번호는 공백 없이 입력해주세요.');
				$('.confirm').eq(1).val("N");
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
			$('#divPass').children().show();
			$('.confirm').eq(0).val("Y");
		} else {
			$('#divEmail').html("인증번호가 틀렸습니다.");
			$('.confirm').eq(0).val("N");
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
				$('.confirm').eq(0).val("N");
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
		
		
		// 패스워드 변경 버튼 동작 (낙원:0919)
		$('.update_fr').submit(function(){
			
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
			if($('.confirm').eq(0).val()=="Y"==false){
				alert("이메일 인증에 문제가 있습니다.");
				return false;
			}
			if($('#pass').val()==""){
				alert("비밀번호를 입력하세요");
				$('#pass').focus();
				return false;
			}
			if($('.confirm').eq(1).val()=="Y"==false){
				alert("패스워드 설정에 문제가 있습니다.");
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

<div id="jb-container">
<!-- <section id="main"> -->
			<form class="update_fr" action="MemberUpdatePasswordPro.me" method="get" id="forgetPass">
			<h2>이메일로 패스워드 찾기</h2>
			
			<div id="divPass">
				<fieldset>
				<legend>패스워드 설정</legend>
					<div class="inputWithIcon inputIconBg">
					  <input type="password" id="pass" name="pass" placeholder="Password"/>
					  <i class="fas fa-keyboard  fa-lg fa-fw" aria-hidden="true"></i>
					</div>
					<div id="regPass"></div>
					<div id="st_msg"></div>
				</fieldset>
			</div>
			
			
			
			
			
			<fieldset>
				<legend>이메일</legend>
				<div class="inputWithIcon inputIconBg">
				  <input type="email" id="email" name="email" placeholder="Email">
				  <i class="fa fa-envelope fa-lg fa-fw" aria-hidden="true"></i>
				  <button class="btn-style" id="emailBtn" type="button">이메일 인증</button>
				</div>
				<div id="divEmail"></div>
				</fieldset>
				
				
				<fieldset>
				<legend>이메일 인증</legend>
				<div class="inputWithIcon inputIconBg">
				  <input type="text" id="certificationNum_email" name="certificationNum_email" placeholder="Email Certification Number"/>
				  <i class="fa fa-envelope fa-lg fa-fw" aria-hidden="true"></i>
				  <button class="btn-style" id="certification_email_Btn" type="button">인증코드 입력</button>
				</div>
				</fieldset>
			
			
			
				<input type="hidden" class="confirm">
				<input type="hidden" class="confirm">
				<input type="submit" value="Submit" class="submit">
				<input type="reset" value="Cancel" class="cancel">
			
			
			
			</form>
<!-- </section> -->
</div>





<style type="text/css">
/* body{background-image: url("${pageContext.request.contextPath}/img/background/join_background.jpg");} */
/* body{background-image: url("${pageContext.request.contextPath}/img/background/login_background.jpg");background-repeat: no-repeat;background-size: 100%;} */
#jb-container {
    z-index : 100;
	width:800px;
	margin:150px auto;
	padding: 100px;
	height: 100%;
/* 	margin: 0 auto; */
	border: 1px solid #bcbcbc;
	
}
#forgetPass {width:700px;margin:auto;}


input[type="text"],input[type="email"],input[type="password"] {
  width: 500px;
  border: 2px solid #aaa;
  border-radius: 4px;
  margin: 8px 0;
  outline: none;
/*   padding: 8px; */
  box-sizing: border-box;
  transition: 0.3s;
  padding-bottom:4px;
}
input[type="text"]:focus,input[type="email"]:focus,input[type="password"]:focus {
  border-color: dodgerBlue;
  box-shadow: 0 0 8px 0 dodgerBlue;
}
.inputWithIcon input[type="text"],input[type="email"],input[type="password"] {
  padding-left: 50px; /* 아이콘 과 텍스트 간격 */
}
.inputWithIcon {
  position: relative;
}
.inputWithIcon i {
	width:1.5em;/* 아이콘 폭 */
  position: absolute;
  left: 0;
  top: 8px;
  padding: 9px 8px;
  color: #aaa;
  transition: 0.3s;
}
.inputWithIcon input[type="text"]:focus + i,input[type="email"]:focus + i,,input[type="password"]:focus + i {
  color: dodgerBlue;
}
.inputWithIcon.inputIconBg i {
  background-color: #aaa;
  color: #fff;
  padding: 9px 4px;
  border-radius: 4px 0 0 4px;
}
.inputWithIcon.inputIconBg input[type="text"]:focus + i,input[type="email"]:focus + i,input[type="password"]:focus + i {
  color: #fff;
  background-color: dodgerBlue;
}

.btn-style {
    width:auto;
    height:31px;
    
	background-color: dodgerBlue;
    border: solid 2px dodgerBlue;
    color:#FFFFFF;
	padding: auto 0;
    text-align: center;
    text-decoration: none;
    display: inline-block;
/*     font-size: 15px; */
/*     margin: 4px; */
    cursor: pointer;
    border-radius:2px;
}
.btn-style:hover {
  background-color: dodgerBlue;
  background-color: blue;
  border: solid 2px blue;
/*   box-shadow: 0 0 8px 0 dodgerBlue; */
}
</style>

</body>
</html>