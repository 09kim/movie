<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/memberjoin.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>



<script type="text/javascript">

$(document).ready(function(){
	// 회원 가입 버튼 동작 (NEW)
// 	$(".join_fr").validate({
// 		  rules: {
// 		    username: {
// 		      required: true,
// 		      minlength: 4
// 		    },     
// 		    email: {
// 		      required: true,
// 		      email:true
// 		    },
// 		    password: {
// 		      required: true,
// 		      minlength: 5
// 		    },
// 		    cpassword: {
// 		      required: true,
// 		      minlength: 5,
// 		      equalTo: "#password"
// 		    }
// 		  },
// 		  //For custom messages
// 		  messages: {
// 		    username:{
// 		      required: "Enter a username",
// 		      minlength: "Enter at least 4 characters"
// 		    }
// 		  },
// 		  errorElement : 'div',
// 		  errorPlacement: function(error, element) {
// 		    var placement = $(element).data('error');
// 		    if (placement) {
// 		      $(placement).append(error)
// 		    } else {
// 		      error.insertAfter(element);
// 		    }
// 		  }
// 		});
	
	
	
	// 회원가입 버튼 동작
	$('.join_fr').submit(function(){
		if($('#nick').val()==""){
			alert("닉네임을 입력하세요");
			$('#nick').focus();
			return false;
		}
		if($('#pass').val()==""){
			alert("비밀번호를 입력하세요");
			$('#pass').focus();
			return false;
		}
		if($('#phoneNum').val()==""){
			alert("핸드폰 번호를 입력하세요");
			$('#phoneNum').focus();
			return false;
		}
		if($('#certificationNum').val()==""){
			alert("핸드폰 인증코드를 입력하세요");
			$('#certificationNum').focus();
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
		
		if($('.confirm').eq(0).val()=="Y"==false){
			alert("닉네임 설정에 문제가 있습니다.");
			$('#nick').focus();
			return false;
		}
		if($('.confirm').eq(1).val()=="Y"==false){
			alert("패스워드 설정에 문제가 있습니다.");
			$('#pass').focus();
			return false;
		}
		if($('.confirm').eq(2).val()=="Y"==false){
			alert("핸드폰 인증에 문제가 있습니다.");
			$('#certificationNum').focus();
			return false;
		}
		if($('.confirm').eq(3).val()=="Y"==false){
			alert("이메일 인증에 문제가 있습니다.");
			$('#certificationNum_email').focus();
			return false;
		}
	});		



	// 핸드폰 인증번호
	$('#phoneNumBtn').click(function() {
		var phone = $("#phoneNum").val();
		if(phone==""){
			alert("핸드폰 번호를 입력하세요");
			$('#phoneNum').focus();
			return false;
		}
		alert(phone)
		$.ajax('Message.me',{
			data:{phone:phone},
			success:function(rdata){
				$('#divPhone').html(rdata);
				if(rdata!="중복된 번호"){
				$("#phoneNumBtn").attr("disabled",true);
				$("#phone").attr("readonly",true);
				alert("인증번호를 전송했습니다.");
				}else{
					alert("중복된 번호입니다.");
				}
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
			$('.confirm').eq(2).val("Y");
		} else {
			$('#divPhone').html("인증번호가 틀렸습니다.");
			$('.confirm').eq(2).val("N");
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
			$('.confirm').eq(3).val("Y");

		} else {
			$('#divEmail').html("인증번호가 틀렸습니다.");
			$('.confirm').eq(3).val("N");
		}
	});
	
	$('#dupNick').click(function(){
		var nick = $('#nick').val();
		if(nick==""){
			alert("닉네임을 입력해주세요.");
			return false;
		} else {
			$.ajax("dupNick.me",{
				data:{nick:nick},
				success:function(rdata){
					if(rdata=="닉네임 중복"){
						$('.confirm').eq(0).val("N");
					} 
					if(rdata=="사용가능 닉네임") {
						$('.confirm').eq(0).val("Y");
					}
					$('#divNick').html(rdata);
				}
			});
		}
	});
	
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
			        $('#regPass').html('사용 가능');
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
						$('#regPass').hide();
		        } else {
		        	$('#st_msg').show();
		        	$('#regPass').show();
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
				$('.confirm').eq(3).val("N");
			} else { // 정규식에 위배되지 않는 경우
				$.ajax('Email.me',{
					data:{email:$('#email').val()},
					success:function(rdata){
						$('#divEmail').html(rdata);
					}
				});
			}
        });
		
		
		// 핸드폰번호 자동 하이픈 추가 - 낙원 : 1011[S]
		function autoHypenPhone(str){
	        str = str.replace(/[^0-9]/g, '');
	        var tmp = '';
	        if( str.length < 4){
	            return str;
	        }else if(str.length < 7){
	            tmp += str.substr(0, 3);
	            tmp += '-';
	            tmp += str.substr(3);
	            return tmp;
	        }else if(str.length < 11){
	            tmp += str.substr(0, 3);
	            tmp += '-';
	            tmp += str.substr(3, 3);
	            tmp += '-';
	            tmp += str.substr(6);
	            return tmp;
	        }else{              
	            tmp += str.substr(0, 3);
	            tmp += '-';
	            tmp += str.substr(3, 4);
	            tmp += '-';
	            tmp += str.substr(7);
	            return tmp;
	        }
	        return str;
	    }
	var cellPhone = document.getElementById('phoneNum');
	cellPhone.onkeyup = function(event){
	    event = event || window.event;
	    var _val = this.value.trim();
	    this.value = autoHypenPhone(_val) ;
	}
	// 핸드폰번호 자동 하이픈 추가 - 낙원 : 1011[E]
		
		
	
}); //ready();
</script>

<style type="text/css">


.content {
  top:0px;
  position: fixed;
/*   bottom: 0; */
  background: rgba(0, 0, 0, 0.5);
  color: #f1f1f1;
  width: 100%;
  padding: 20px;
  height: 100%;
  margin-top: 55px;
/*   margin-bottom:-50px; */
}


/* body{background-image: url("${pageContext.request.contextPath}/img/background/avengers.jpg");background-repeat: no-repeat;background-size: 100%;} */
/* body{background-image: url("${pageContext.request.contextPath}/img/background/avengers.jpg");background-repeat: no-repeat;background-size: 100% 100%;} */

/* body{background-image: url("${pageContext.request.contextPath}/img/background/join_background.jpg");} */
/* body{background-image: url("${pageContext.request.contextPath}/img/background/login_background.jpg");background-repeat: no-repeat;background-size: 100%;} */
#jb-container {
	top:0px;
    z-index : 100;
	width:800px;
	margin:0 auto;
/* 	padding: 100px; */
    padding: 20px 100px 20px 100px;
	height: 90%;
/* 	margin: 0 auto; */
	border: 1px solid #bcbcbc;
/* 	background: rgba(0, 0, 0, 0.5); */
    background: rgba(255, 255, 255, 0.5);
    overflow:scroll
}
/* #join {width:500px;margin:auto;color:#FFFFFF;} */
/* a{color:#FFFFFF;} */
/* a:hover{color:orange;} */
#join {width:700px;margin:auto;}

textarea {
  width: 500px;
  border: 2px solid #aaa;
  border-radius: 4px;
  margin: 8px 0;
  outline: none;
/*   padding: 8px; */
  box-sizing: border-box;
  transition: 0.3s;
}
textarea:focus {
  border-color: dodgerBlue;
  box-shadow: 0 0 8px 0 dodgerBlue;
}
.inputWithIcon textarea {
  margin-top:7px;
  padding-left: 50px; /* 아이콘 과 텍스트 간격 */
}
.inputWithIcon textarea:focus +i {
  color: dodgerBlue;
}
.inputWithIcon.inputIconBg i {
  background-color: #aaa;
  color: #fff;
  padding: 9px 4px;
  border-radius: 4px 0 0 4px;
}
.inputWithIcon.inputIconBg textarea:focus + i {
  color: #fff;
  background-color: dodgerBlue;
}





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
.btn-style:disabled {
	background-color: #AAAAAA;
    border: solid 2px #AAAAAA;
    color:#FFFFFF;
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



#my_video {
/* top: 55px; */
position: fixed;
top:0;
right: 0;
bottom: 0;
/*   position:sticky; */
  min-width: 100%;
  min-height: 100%;
}
header{
  z-index:100;
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
}
</style>
</head>
<body>
<header>
<jsp:include page="/inc/top.jsp" />
<div class="clear"></div>
<!-- 헤더 -->
</header>
<!-- 영상 배경 화면 추가 - 낙원 : 1013[S] -->
<video muted autoplay loop id="my_video">
<!--     <source src="videos/Network.mp4" type="video/mp4"> -->
    <source src="videos/kings.mp4" type="video/mp4">
</video>
<!-- 	영상 배경 화면 추가 - 낙원 : 1013[E]   -->
	  
	  
<div class="content">
<div id="jb-container">
<!-- <section id="main"> -->

			<form action="MemberJoinPro.me" method="post" id="join" class="join_fr">
			<fieldset>
			<legend>회원 가입</legend>
				<fieldset>
				<legend>닉네임</legend>
				<div class="inputWithIcon inputIconBg">
				  <input type="text" id="nick" name="nick" placeholder="Nick Name">
				  <i class="fa fa-user fa-lg fa-fw" aria-hidden="true"></i>
				  <button class="btn-style" id="dupNick" type="button">닉네임 중복체크</button>
				</div>
				<div id="divNick"></div>
				</fieldset>
				
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
				
				
				<fieldset>
				<legend>패스워드</legend>
				<div class="inputWithIcon inputIconBg">
				  <input type="password" id="pass" name="pass" placeholder="Password"/>
				  <i class="fas fa-keyboard  fa-lg fa-fw" aria-hidden="true"></i>
				</div>
				  <div id="regPass"></div>
				  <div id="st_msg"></div>
				</fieldset>
				
				
				<fieldset>
				<legend>핸드폰 번호</legend>
				<div class="inputWithIcon inputIconBg">
				  <input type="text" id="phoneNum" name="phoneNum" placeholder="Phone Number" maxlength="13">
				  <i class="fa fa-phone fa-lg fa-fw" aria-hidden="true"></i>
				  <button class="btn-style" id="phoneNumBtn" type="button">핸드폰 인증</button>
				</div>
				<div id="divPhone"></div>
				</fieldset>
				
				<fieldset>
				<legend>핸드폰 인증</legend>
				<div class="inputWithIcon inputIconBg">
				  <input type="text" id="certificationNum" name="certificationNum" placeholder="Certification Number" />
				  <i class="fa fa-phone fa-lg fa-fw" aria-hidden="true"></i>
				  <button class="btn-style" id="certificationBtn" type="button">인증번호 입력</button>
				</div>
				</fieldset>
				
<!-- 				<fieldset> -->
<!-- 				<legend>자기 소개</legend> -->
<!-- 				<div class="inputWithIcon inputIconBg"> -->
<!-- 				  <input type="text" id="introduce" name="introduce" style="background-color: inherit;border:none;" value="Introduce" readonly/> -->
<!-- 				  <textarea rows="20" cols="20" id="infoup" placeholder="Introduce"></textarea> -->
<!-- 				  <i class="fas fa-address-card fa-lg fa-fw" aria-hidden="true"></i> -->
<!-- 				</div> -->
<!-- 				</fieldset>		 -->
				<button type="submit" class="btn-style">회원 가입</button>
				<button type="reset" class="btn-style">취소</button>
			</fieldset>
			</form>
<!-- </section> -->
</div>



<input type="hidden" class="confirm">
<input type="hidden" class="confirm">
<input type="hidden" class="confirm">
<input type="hidden" class="confirm">
</div>
</body>
</html>