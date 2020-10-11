<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[갓챠] Email 주소 찾기</title>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<!-- <script src="../../../Movie/js/jquery-3.5.1.js"></script> -->
<script type="text/javascript">
$(document).ready(function(){
	// 핸드폰 인증번호
	$('#phoneNumBtn').click(function() {
		var phone = $("#phoneNum").val();
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
<jsp:include page="/inc/top.jsp" />
<div class="clear"></div>
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