<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="${pageContext.request.contextPath}/css/memberjoin.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>




<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

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
			        $('#regPass').html('비밀번호는 8~15자이며,\n숫자/대문자/소문자/특수문자(!,@)를 포함해야 합니다.');
			        $('.confirm').eq(1).val("N");
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
		
		
	
}); //ready();
</script>
<style>
body{
    display: table-cell;
    vertical-align: middle;
    background-color: #e0f2f1 !important;
}

html {
    display: table;
    margin: auto;
}

html, body {
    height: 100%;
}

.medium-small {
    font-size: 0.9rem;
    margin: 0;
    padding: 0;
}

.login-form {
/*     width: 280px; */
    width: 500px;
    height: auto;
}

.login-form-text {
    text-transform: uppercase;
    letter-spacing: 2px;
    font-size: 0.8rem;
}

.login-text {
    margin-top: -6px;
    margin-left: -6px !important;
}

.margin {
    margin: 0 !important;
}

.pointer-events {
    pointer-events: auto !important;
}

.input-field >.material-icons  {
    padding-top:10px;
}

.input-field div.error{
    position: relative;
    top: -1rem;
    left: 3rem;
    font-size: 0.8rem;
    color:#FF4081;
    -webkit-transform: translateY(0%);
    -ms-transform: translateY(0%);
    -o-transform: translateY(0%);
    transform: translateY(0%);
}
</style>
</head>
<body>
<jsp:include page="/inc/top.jsp" />
<div class="clear"></div>
<!-- 헤더 -->
<!-- <form class="join_fr" action="MemberJoinPro.me" method="get"> -->
<section id="main">
<div id="login-page" class="row">
  <div class="col s12 z-depth-4 card-panel">
    <form class="join_fr" action="MemberJoinPro.me" method="get">
<!--     <form class="login-form" action="MemberJoinPro.me" method="get"> -->
      <div class="row">
        <div class="input-field col s12 center">
          <h4>Join</h4>
          <p class="center">Join to our community now !</p>
        </div>
      </div>

      <div class="row margin">
        <div class="input-field col s12">
          <!-- <i class="mdi-social-person-outline prefix"></i> -->
          <i class="material-icons prefix">account_circle</i>
          <input id="nick" name="nick" type="text" placeholder="Nickname"/>
        </div>
        <div class="input-field">
          <button class="btn btn-default my-2 my-sm-0 bg-green" id="dupNick" type="button">닉네임 중복체크</button>
          <div id="divNick"></div>
        </div>
      </div>

      <div class="row margin">
        <div class="input-field col s12">
          <!-- <i class="mdi-social-person-outline prefix"></i> -->
          <i class="material-icons prefix">email</i>
          <input id="email" name="email" type="text" placeholder="Email" style="cursor: auto;" />
        </div>
         <div class="input-field">
          <button class="btn btn-default my-2 my-sm-0 bg-green" id="emailBtn" type="button">이메일 인증</button>
          <div id="divEmail"></div>
        </div>
      </div>

      <div class="row margin">
       <div class="input-field col s12">
        <i class="material-icons prefix">email</i>
        <input id="certificationNum_email" name="certificationNum_email" type="text" placeholder="Certification Code" style="cursor: auto;" />
        </div>
         <div class="input-field">
          <button class="btn btn-default my-2 my-sm-0 bg-green" id="certification_email_Btn" type="button">인증코드 입력</button>
        </div>
      </div>

      <div class="row margin">
        <div class="input-field col s12">
          <!-- <i class="mdi-action-lock-outline prefix"></i> -->
          <i class="material-icons prefix">vpn_key</i>
          <input id="pass" name="pass" placeholder="Password" type="password" />
          <div id="regPass"></div>
		  <div id="st_msg"></div>
        </div>
      </div>

<!--       <div class="row margin"> -->
<!--         <div class="input-field col s12"> -->
<!--           <i class="mdi-action-lock-outline prefix"></i> -->
<!--           <i class="material-icons prefix">vpn_key</i> -->
<!--           <input id="pass_r" name="pass_r" placeholder="Retyping Password" type="password" /> -->
<!--         </div> -->
<!--       </div> -->
      
      <div class="row margin">
        <div class="input-field col s12">
          <!-- <i class="mdi-social-person-outline prefix"></i> -->
          <i class="material-icons prefix">phone</i>
          <input id="phoneNum" name="phoneNum" placeholder="Phone Number" type="text" style="cursor: auto;" />
        </div>
        <div class="input-field">
          <button class="btn btn-primary my-2 my-sm-0 bg-green" id="phoneNumBtn" type="button">핸드폰 인증</button>
          <div id="divPhone"></div>
        </div>
      </div>

      <div class="row margin">
        <div class="input-field col s12">
          <!-- <i class="mdi-social-person-outline prefix"></i> -->
          <i class="material-icons prefix">phone</i>
          <input id="certificationNum" name="certificationNum" type="text" placeholder="Certification Number" style="cursor: auto;" />
        </div>
        <div class="input-field">
          <button class="btn btn-primary my-2 my-sm-0 bg-green" id="certificationBtn" type="button">인증번호 입력</button>
        </div>
      </div>

      <div class="row">
        <div class="input-field col s12">
          <button type="submit" class="btn waves-effect waves-light col s12">REGISTER NOW</button>
          
        </div>
        <div class="input-field col s12">
          <p class="margin center medium-small sign-up">Already have an account? <a href="./login">Login</a></p>
        </div>
      </div>


<!--     </form> -->
  </div>
</div>



<input type="hidden" class="confirm">
<input type="hidden" class="confirm">
<input type="hidden" class="confirm">
<input type="hidden" class="confirm">
</section>
</body>
</html>