<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[갓챠] Email 주소 찾기</title>
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<!-- <script src="../../../Movie/js/jquery-3.5.1.js"></script> -->
<script type="text/javascript">
$(document).ready(function(){
	// 핸드폰 인증번호
	$('#phoneNumBtn').click(function() {
		var phone = $("#phoneNum").val();
		if(phone==""){
			alert("핸드폰 번호를 입력하세요");
			$('#phoneNum').focus();
			return false;
		}
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
	
		
});
</script>

</head>
<body>
	<!-- 헤더 -->
	<div style="width:100%;position: sticky !important;top:0;z-index: 100;">
		<jsp:include page="/inc/top.jsp"/>
		<div class="clear"></div>
	</div>
	<!-- 헤더 -->


<div id="jb-container">
<!-- <section id="main"> -->
			<form class="update_fr" action="MemberUpdatePasswordPro.me" method="get" id="forgetPass">
			<h2>핸드폰 번호를 입력해주세요.</h2>
			
			<fieldset>
				<legend>핸드폰 번호</legend>
				<div class="inputWithIcon inputIconBg">
				  <input type="text" id="phoneNum" name="phoneNum" placeholder="Phone Number" maxlength="13">
				  <i class="fa fa-phone fa-lg fa-fw" aria-hidden="true"></i>
				  <button class="btn-style" id="phoneNumBtn" type="button">핸드폰 인증</button>
				</div>
				<div id="divPhone"></div>
				</fieldset>
			</form>
<!-- </section> -->
</div>






<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/member_forget.css" rel="stylesheet" type="text/css">

</body>
</html>