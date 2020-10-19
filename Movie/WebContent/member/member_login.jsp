<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<script type="text/javascript">
	
	$(document).ready(function(){
	   
	   $('#login').submit(function(){
	      if($('#email').val()==""){
	         alert("Email을 입력하세요");
	         $('#email').focus();
	         return false;
	      }
	      
	   });
	    
	    // 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
	    var key = getCookie("key");
	    $("#email").val(key); 
	     
	    if($("#email").val() != ""){ // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
	        $("#emailSaveCheck").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
	    }
	     
	    $("#emailSaveCheck").change(function(){ // 체크박스에 변화가 있다면,
	        if($("#emailSaveCheck").is(":checked")){ // ID 저장하기 체크했을 때,
	            setCookie("key", $("#email").val(), 7); // 7일 동안 쿠키 보관
	        }else{ // ID 저장하기 체크 해제 시,
	            deleteCookie("key");
	        }
	    });
	     
	    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
	    $("#email").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
	        if($("#emailSaveCheck").is(":checked")){ // ID 저장하기를 체크한 상태라면,
	            setCookie("key", $("#email").val(), 7); // 7일 동안 쿠키 보관
	        }
	    });
	});
	 
	function setCookie(cookieName, value, exdays){
	    var exdate = new Date();
	    exdate.setDate(exdate.getDate() + exdays);
	    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
	    document.cookie = cookieName + "=" + cookieValue;
	}
	 
	function deleteCookie(cookieName){
	    var expireDate = new Date();
	    expireDate.setDate(expireDate.getDate() - 1);
	    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
	}
	 
	function getCookie(cookieName) {
	    cookieName = cookieName + '=';
	    var cookieData = document.cookie;
	    var start = cookieData.indexOf(cookieName);
	    var cookieValue = '';
	    if(start != -1){
	        start += cookieName.length;
	        var end = cookieData.indexOf(';', start);
	        if(end == -1)end = cookieData.length;
	        cookieValue = cookieData.substring(start, end);
	    }
	    return unescape(cookieValue);
	}


</script>
</head>
	<!-- 헤더 -->
	<div style="width:100%;position: sticky !important;top:0;z-index: 100;">
		<jsp:include page="/inc/top.jsp"/>
		<div class="clear"></div>
	</div>
	<!-- 헤더 -->
<div id="jb-container">
<!-- <section id="main"> -->
			<form action="MemberLoginPro.me" method="post" id="login">
			<fieldset>
			<legend>Login</legend>
			<fieldset>
			<legend>이메일</legend>
			<div class="inputWithIcon inputIconBg">
<!-- 			  <input type="email" id="email" name="email" placeholder="Email"/> -->
			  <input type="text" id="email" name="email" placeholder="Email"/>
			  <i class="fa fa-envelope fa-lg fa-fw" aria-hidden="true"></i>
			</div>
			</fieldset>
			<input type="checkbox" id="emailSaveCheck">이메일 기억하기 <br>
			
			
			<fieldset>
			<legend>패스워드</legend>
			<div class="inputWithIcon inputIconBg">
			  <input type="password" id="pass" name="pass" placeholder="Password"/>
			  <i class="fas fa-keyboard  fa-lg fa-fw" aria-hidden="true"></i>
			</div>
			</fieldset>
			
			<div class="btnGroup">
			<input type="submit" value="로그인"> 
			<input type="button" value="회원가입" onclick="location.href='MemberJoinForm.me'">
			<input type="button" value="취소" onclick="history.back()">
			</div>
			<div class="forget">
			<a href="ForgetPassword.me">E-Mail로 비밀번호 찾기</a> | 
			<a href="ForgetEmail.me">E-Mail주소 찾기</a>
			</div>
			
			
			</fieldset>
			</form>
<!-- </section> -->
</div>



	<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
	<link href="${pageContext.request.contextPath}/css/member_login.css" rel="stylesheet" type="text/css">
</body>
</html>



