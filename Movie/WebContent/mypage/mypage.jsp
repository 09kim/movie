<%@page import="mypage.vo.ProfileBean"%>
<%@page import="mypage.vo.CollectionBean"%>
<%@page import="mypage.vo.MypageBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="member.vo.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%
    MemberBean memberBean = (MemberBean)request.getAttribute("memberBean");
//     ProfileBean profileBean = (ProfileBean)request.getAttribute("profileBean"); // 프로필 사진 받는 객체 - 낙원 : 1015
	ProfileBean profileBean=(ProfileBean)session.getAttribute("profileBean");
    String nick = (String)session.getAttribute("nick");
    ArrayList<MypageBean> wishMovie = (ArrayList<MypageBean>)request.getAttribute("wishMovie");
    ArrayList<MypageBean> gradeList = (ArrayList<MypageBean>) request.getAttribute("gradeList");
    int listCount = (int) request.getAttribute("listCount");
    ArrayList<CollectionBean> collection = (ArrayList<CollectionBean>)(request.getAttribute("collection")); 
    
    String savePath = profileBean.getSavePath();
	String uploadFileName = profileBean.getUploadFileName();
	String realProfilePath = savePath + "\\" + uploadFileName;
	%>
	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>마이페이지</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="" />
	<meta name="keywords" content="" />
	<meta name="author" content="" />


	<!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
	<link rel="shortcut icon" href="favicon.ico">

	<link href="https://fonts.googleapis.com/css?family=Quicksand:300,400,500,700" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css?family=Playfair+Display:400,400i,700" rel="stylesheet">
	
	<!-- Animate.css -->
	<link rel="stylesheet" href="css/animate.css">
	<!-- Icomoon Icon Fonts-->
	<link rel="stylesheet" href="css/icomoon.css">
	<!-- Bootstrap  -->
<!-- 	<link rel="stylesheet" href="css/bootstrap.css"> -->
	<!-- Flexslider  -->
	<link rel="stylesheet" href="css/flexslider.css">
	<!-- Flaticons  -->
	<link rel="stylesheet" href="fonts/flaticon/font/flaticon.css">
	<!-- Owl Carousel -->
	<link rel="stylesheet" href="css/owl.carousel.min.css">
	<link rel="stylesheet" href="css/owl.theme.default.min.css">
	<!-- Theme style  -->
	<link rel="stylesheet" href="css/style.css">

	<!-- Modernizr JS -->
	<script src="js/modernizr-2.6.2.min.js"></script>
	<!-- FOR IE9 below -->
	<!--[if lt IE 9]>
	<script src="js/respond.min.js"></script>
	<![endif]-->

<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.min.css">

<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<script type="text/javascript">


function a() {
	window.open("CollectionModifySearch.mo",
				"open the window",
			"toolbar=no, width=1000, height=850, top=150, left=150");
}






	$(document).ready(function() {
		var sortData = [];
		var sortData2 = [];
		var nick = $('#nick').val();
		var img;
		function getSrc(director){
			$.ajax('MypageDirectorSrc.mp',{
				method : "post",
				data : {director:director},
				async: false,
				success : function(data){
					img = data; // 리턴을 안하고 여기서하면 왜 순차적으로 안들고 오는것인가!!!!
				}
			});	
			return img;
		}
		$.ajax('MypageGener.mp', {
			method : "post",
			dataType : "json",
			data : {
				nick : nick
			},
			success : function(data) {
				$.each(data[0],function(idx,item){
					sortData.push({key:idx,value:item});
					sortData.sort(function(a,b){
						return(a.value>b.value)?-1:(a.value<b.value)?1:0;
					});
				});
				
				$.each(data[1],function(idx,item){
					sortData2.push({key:idx,value:item});
					sortData2.sort(function(a,b){
						return(a.value>b.value)?-1:(a.value<b.value)?1:0;
					});
				});
				
				$.each(sortData,function(idx,item){
					if(item.value!=0){
						$.each(sortData2,function(idx2,item2){
							if(item2.value!=0){
								if(item.key==item2.key){
									var count = item2.value/2/item.value;
// 									$('.genre').append(item.key +" : "+item.value+ "개  " +count.toFixed(1)+"점 <br>");
// 									$('#genreList').append('<tr><th scope="row">'+item.key+'</th><td>'+item.value+'개</td><td>★'+count.toFixed(1)+'점</td></tr>');
									$('.genreList').append('<tr><th scope="row">'+item.key+'</th><td><span class="colorlib-counter js-counter" data-from="0" data-to="'+item.value+'" data-speed="1000" data-refresh-interval="50"></span></td><td>★'+count.toFixed(1)+'점</td></tr>');
								}
							}
						});
						
					}
				});
				
			}
		});
		
		$.ajax('MypageNation.mp',{
			method : "post",
			dataType : "json",
			data : {
				nick : nick
			},
			success : function(data) {
				$.each(data,function(idx,item){
					$.each(item,function(idx2,item2){
						var count = item2.avgGrade/2/item2.nation;
						$('.nationList').append('<tr><th scope="row">'+idx2+'</th><td><span class="colorlib-counter js-counter" data-from="0" data-to="'+item2.nation+'" data-speed="1000" data-refresh-interval="50"></span></td><td>★'+count.toFixed(1)+'점</td></tr>');
					});
				});
				
			}
		});
		
		$.ajax('MypageDirector.mp',{
			method : "post",
			dataType : "json",
			data : {
				nick : nick
			},
			success : function(data) {
				$.each(data,function(idx,item){
					$.each(item,function(idx2,item2){
 						var img = getSrc(item2.director);
 						var imgSrc = img.split("\"")[1]
 						
 						$('.director').append('<div class=favoriteDirector>'+
 								'<div class=poster style="background-image: url('+imgSrc+'),url(${pageContext.request.contextPath}/img/noImage.gif"></div>'+
 								'<div class="directorName">'+item2.director+'</div></div>');
					});
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
	
	
	// 좋아요 페이지 버튼 동작 자바스크립트 추가 - 낙원 : 1006[S]
	
	$('.btn-like').each(function() {
		var wishInfo = $(this).val().split(",");
		var wish = wishInfo[2];
		if (wish == "Y") {
			$(this).addClass("done");
		} else { // 기본이 없는 클래스라 remove가 필요없음
			$(this).removeClass("done");
		}
	});
	$('.btn-like').click(function() {
			var wishInfo = $(this).val().split(",");
			var nick = wishInfo[0];
			var title = wishInfo[1];
			var wish = wishInfo[2];
			var movieSeq = wishInfo[3];
			var idx = wishInfo[4];
			if (confirm(title + "을(를) 보고싶어요 리스트에서 제외 하시겠습니까?")) {
   			 $.ajax('MypageChangeWish.mp',{
   					data:{nick:nick,movieSeq:movieSeq,title:title},
   					success:function(rdata){
  			 				if(rdata=="Y"){
  			 					location.reload();
	   							}
   						}
 					});
 			} else {
 				alert("취소 하셨습니다.");
 			}
	});
	
	// 좋아요 페이지 버튼 동작 자바스크립트 추가 - 낙원 : 1006[E]
	
	
	
	// 영운 컬렉션 코드 마이페이지에 추가 - 낙원 : 1007 [S]
	$('#addMov').click(function(){
			
			window.open("CollectionSearch.mo",
					"open the window",
					"toolbar=no, width=1000, height=850, top=150, left=150");
		});	
	
	
	
	
	






		$('.modifyCollection').click(function(){
			
			
			$.ajax('MypageCollectionUpdate.mp',{
					data:{nick:nick,movieSeq:movieSeq,title:title,idx:idx},
					success:function(rdata){
			 				if(rdata=="Y"){
			 					location.reload();
 							}
						}
					});	
			
		
			
		})


		// 최초 화면 로딩 시 작품추가/수정/삭제 버튼 숨기기 - 낙원 : 1013 [S]
		$('.modifyAdd').hide();			
       	$('.modifyDel').hide();			
        $('.collectionModify').hide();		
     // 최초 화면 로딩 시 작품추가/수정/삭제 버튼 숨기기 - 낙원 : 1013 [E]
            
        // 수정 버튼 클릭 시 작품추가/수정/삭제 버튼 표시 - 낙원 : 1013 [S]    
		$('.modifyBtn').click(function(){
            $('.modifyAdd').toggle();			
            $('.modifyDel').toggle();			
            $('.collectionModify').toggle();			
		});
		// 수정 버튼 클릭 시 작품추가/수정/삭제 버튼 표시 - 낙원 : 1013 [E]
		
		$('.modifyAddMov').click(function(){
			var index = $('.modifyAddMov').index();
			var addId = $(this).attr('id');
		    window.open("CollectionModifySearch.mo?addId=" + addId,
 					"open the window",
					"toolbar=no, width=1000, height=850, top=150, left=150");
			
		});
		
		
		
		$('#showAddCollection').click(function(){
			if($('#showDisplay').css('display') == "none"){
				$('#showDisplay').show();
				$('#showAddCollection').val('컬렉션 추가창 닫기');
			} else {
				$('#showDisplay').hide();
				$('#showAddCollection').val("컬렉션 추가");
			}
		})
			
		$('#submit').click(function(){
			if($('#subject').val() == ''){
				alert("제목을 입력하세요")
				return false;
			}
			if($('#content').val() == ''){
				alert("내용을 입력하세요")
				return false;
			}
			if($('#movieSeq').length < 1){
				alert("영화를 선택하세요");
				return false;
			} 
			location.reload();
		})
		
		
		$(document).on('click', '.modifyDel .modifyDeleteBtn', function() {
						var index = $('.modifyDel .modifyDeleteBtn').index(this);	
// 				alert(index);
						$('.eachList').eq(index).remove();
		});
		
		
		

		
		
		
		
		
		$('.modifyDelBtn').click(function(){
			var eachList = $(this).attr('id');	
			var collectionNum = $(this).closest('#collectionNum').attr('class')
			$('.' + collectionNum).find('.'+eachList).remove();
		});
		
				
		
		$('.delBtn').click(function(){
			var idx = $(this).attr('id')
			$.ajax('CollectionDelete.mp',{
				
				data:{idx:idx},
				success:function(rdata){
					  alert("삭제 되었습니다");
		      		  location.reload();
					}
				});
		});	
	
	// 영운 컬렉션 코드 마이페이지에 추가 - 낙원 : 1007 [E]
		
		// 회원 정보 수정 스크립트 추가 - 낙원 : 1011[S]
		// 회원정보 수정 버튼 동작
		$('.update_fr').submit(function(){
			if($('#phoneNumBtn').val()!="1"){
				$('.confirm').eq(2).val("Y");
			}
			if($('#emailBtn').val()!="1"){
				$('.confirm').eq(3).val("Y");
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
			if($('#email').val()==""){
				alert("이메일을 입력하세요");
				$('#email').focus();
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

	
	
		$('#phoneNumBtn').click(function() {
			$('#phoneNumBtn').val("1"); // 핸드폰 번호 변경 버튼을 한번이라도 누르면 1값으로 밸류값을 변경 추후 버튼 클릭 유무와 인증 판별을 위해서 밸류를 넣어둠 - 낙원 : 1012
			var btnName=$('#phoneNumBtn').html();
			var phone = $("#phoneNum").val();
			if(phone==""){
				alert("핸드폰 번호를 입력하세요");
				$('#phoneNum').focus();
				return false;
			}
			if(btnName=="핸드폰 번호 변경"){
				// 핸드폰 번호 변경 버튼 클릭시 핸드폰 번호값이 바뀌므로 버튼 이름을 핸드폰 번호 인증으로 변경하고 readonly옵션을 false로 변경 - 낙원 : 1012
				$('#phoneNumBtn').html("핸드폰 번호 인증");
				$("#phoneNum").attr("readonly",false);
				$('.confirm').eq(2).val("N");
				// 핸드폰 번호 변경시 기존에 인증한 내용을 초기화
				$("#certificationBtn").val("");
				$("#certificationBtn").html("인증번호 입력");
				$("#certificationNum").attr("readonly",false);
				$("#certificationNum").val("");
				$("#divPhone").html("");
				$("#certificationBtn").attr("disabled",false);
				$(".phoneConfirm").hide();
				
			} else {
				$(".phoneConfirm").hide();

					$.ajax('MessageUpdate.me',{
						data:{phone:phone},
						success:function(rdata){
							$('#divPhone').html(rdata);
								alert("인증번호를 전송했습니다.")
								$(".phoneConfirm").show();
								$('#divPhone').html(rdata);
								$('#phoneNumBtn').html("핸드폰 번호 변경");
								$("#phoneNum").attr("readonly",true);
// 							}
						}
					});
			
				}
	        });
	
	

		
		
		
		
		$('#certificationBtn').click(function() {
				var cNum = $("#certificationNum").val();
				var oriCnum = $('#hiddenCnum').val();
				if(cNum==oriCnum){
// 				if(cNum==$('#hiddenCnum_email').val()){
				$("#certificationBtn").val("1");
					$('#divPhone').html("인증되셨습니다.");
					$("#phoneNum").attr("readonly",true);
					$("#certificationNum").attr("readonly",true);
					$("#certificationBtn").attr("disabled",true);
					$("#certificationBtn").html("인증 완료");
					alert("핸드폰 인증 완료!");
					$('.confirm').eq(2).val("Y");
				} else {
					alert("잘못된 인증번호입니다.")
					$('.confirm').eq(2).val("N");
					$('#divPhone').html("인증번호가 틀렸습니다.");
					$('#divPhone').append("<input type='text' id='hiddenCnum' value=" + oriCnum + ">"); // 잘못 입력해서 실패했을시에 인증번호 없어지는부분 수정 - 낙원 : 1012
				}
		});
		
		
		
		
		
		$('#certification_email_Btn').click(function() {
				var cNum = $("#certificationNum_email").val();
				var oriCnum = $('#hiddenCnum_email').val();
				if(cNum==$('#hiddenCnum_email').val()){
				$("#certification_email_Btn").val("1");
					$('#divEmail').html("인증되셨습니다.");
					$("#email").attr("readonly",true);
					$("#certificationNum_email").attr("readonly",true);
					$("#certification_email_Btn").attr("disabled",true);
					$("#certification_email_Btn").html("인증 완료");
					alert("이메일 인증 완료!");
					$('.confirm').eq(3).val("Y");
				} else {
					alert("잘못된 인증코드입니다.")
					$('.confirm').eq(3).val("N");
					$('#divEmail').html("인증코드가 틀렸습니다.");
					$('#divEmail').append("<input type='text' id='hiddenCnum_email' value=" + oriCnum + ">"); // 잘못 입력해서 실패했을시에 인증번호 없어지는부분 수정 - 낙원 : 1012
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
//	 			        $('.confirm').eq(1).val("N");
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
				$('#emailBtn').val("1"); // 이메일 변경 버튼을 한번이라도 누르면 1값으로 밸류값을 변경 추후 버튼 클릭 유무와 인증 판별을 위해서 밸류를 넣어둠 - 낙원 : 1012
				var btnName=$('#emailBtn').html();
				if(btnName=="이메일 변경"){
					// 이메일 변경 버튼 클릭시 이메일값이 바뀌므로 버튼 이름을 이메일 인증으로 변경하고 readonly옵션을 false로 변경 - 낙원 : 1012
					$('#emailBtn').html("이메일 인증");
					$("#email").attr("readonly",false);
					$('.confirm').eq(3).val("N");
					// 이메일 변경시 기존에 인증한 내용을 초기화
					$("#certification_email_Btn").val("");
					$("#certification_email_Btn").html("인증코드 입력");
					$("#certificationNum_email").attr("readonly",false);
					$("#certificationNum_email").val("");
					$("#divEmail").html("");
					$("#certification_email_Btn").attr("disabled",false);
					$(".emailConfirm").hide();
					
				} else {
					$(".emailConfirm").hide();
//	 				$("#certification_email_Btn").attr("disabled",true);
//	 				$('#emailBtn').attr("readonly",false);
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
								if(rdata.includes("중복된 E-Mail입니다.")){
									alert("중복된 E-Mail입니다.");
								} else {
									$(".emailConfirm").show();
									$('#divEmail').html(rdata);
									$('#emailBtn').html("이메일 변경");
									$("#email").attr("readonly",true);
								}
							}
						});
					}
				}
		        });
			
			
				
			// 이메일 인증 번호 입력란 표시를 최초에 숨김 - 낙원 : 1012
			$(".emailConfirm").hide();
			$(".phoneConfirm").hide();

			// 회원 정보 수정 스크립트 추가 - 낙원 : 1011[E]
			
			
			
			
			// 프로필 사진 수정 스크립트 - 낙원 1015[S]
			 var fileTarget = $('.filebox .upload-hidden');

			    fileTarget.on('change', function(){
			        if(window.FileReader){
			            // 파일명 추출
			            var filename = $(this)[0].files[0].name;
			        } 

			        else {
			            // Old IE 파일명 추출
			            var filename = $(this).val().split('/').pop().split('\\').pop();
			        };

			        $(this).siblings('.upload-name').val(filename);
			    });

			    //preview image 
			    var imgTarget = $('.preview-image .upload-hidden');

			    imgTarget.on('change', function(){
			        var parent = $(this).parent();
			        parent.children('.upload-display').remove();

			        if(window.FileReader){
			            //image 파일만
			            if (!$(this)[0].files[0].type.match(/image\//)) return;
			            
			            var reader = new FileReader();
			            reader.onload = function(e){
			                var src = e.target.result;
//		 	                parent.prepend('<div class="upload-display"><div class="upload-thumb-wrap"><img src="'+src+'" class="upload-thumb"></div></div>');
//		 	                parent.prepend('<div class="upload-display"><div class="upload-thumb-wrap"><img src="'+src+'" class="upload-thumb"></div></div>');
			                $('.profileImage').attr("src",src);
			                $('.filebox').append('<input type=hidden id=profile_src value='+src+'>');
// 			                alert($('.change_photo').length);
			                if($('.change_photo').length==0){ // 버튼 중복 생성을 막기위해서 객체가 없을때 length==0일때는 버튼생성 - 낙원 : 1015
			                	 $('.filebox').append('<div class=change_photo><Button type=submit>적용</Button></div>');
			                }
			               
			            }
			            reader.readAsDataURL($(this)[0].files[0]);
			        }

			        else {
			            $(this)[0].select();
			            $(this)[0].blur();
			            var imgSrc = document.selection.createRange().text;
			            parent.prepend('<div class="upload-display"><div class="upload-thumb-wrap"><img class="upload-thumb"></div></div>');

			            var img = $(this).siblings('.upload-display').find('img');
			            img[0].style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enable='true',sizingMethod='scale',src=\""+imgSrc+"\")";        
			        }
			    });
			
			
			
			
			
			
			
			
			    $('#update_profile').submit(function(){
					alert("적용하기")
					return true;
			    });
			
			 // 프로필 사진 수정 스크립트 - 낙원 1015[E]
			    
			    
			    // 상단 이동 버튼 기능 추가 - 낙원 : 1016[S]
			      $( '.moveTop' ).hide(); // 시작시에 hide로 안보이게 함(밑에 함수는 스크롤동작을했을때만 동작하므로)
				    $( window ).scroll( function() {
			          if ( $( this ).scrollTop() > 200 ) {
			            $( '.moveTop' ).fadeIn();
			          } else {
			            $( '.moveTop' ).fadeOut();
			          }
			        } );
			        $( '.moveTop' ).click( function() {
			          $( 'html, body' ).animate( { scrollTop : 0 }, 400 );
			          return false;
			        } );
			      // 상단 이동 버튼 기능 추가 - 낙원 : 1016[E]
			    
			
			
	
		
	});
	
	
</script>

	</head>
	<body>
	<div style="width:100%;position: sticky !important;top:0;z-index: 100;">
	<jsp:include page="/inc/top.jsp"/>
	<div class="clear"></div>
	</div>
	
	
	<!--       사이드 레프트 [S] -->
      <div id="jb-sidebar-left">
				<aside id="colorlib-aside" role="complementary" class="border js-fullheight">
			<div class="text-center">
<!-- 				<div class="author-img" style="background-image: url(프로필사진주소), url(img/noProfile.png);"></div> -->
			<form action="MypageUpdateProfile.mp" id="update_profile" method="post" enctype="multipart/form-data">
					<div class="filebox bs3-primary preview-image">
<%--                           <label for="input_file"><img class="profileImage" src="<%=realProfilePath %>" onerror="this.src='../../../Movie/img/noProfile.png'"></label>  --%>
<%--                           <label for="input_file"><img class="profileImage" src="<%="../../../Movie/upload/"+uploadFileName %>"></label>  --%>
							<%if(profileBean !=null){ %>
                          <label for="input_file"><img class="profileImage" src="${pageContext.request.contextPath}/upload/<%=uploadFileName%>" onerror="this.src='${pageContext.request.contextPath}/img/noProfile.png'"></label> 
                         <%} %>
                          <input type="file" id="input_file" name="input_file" class="upload-hidden"> 
                    </div>
			</form>



				<div id="colorlib-logo"><a href="Mypage.mp"><%=nick %></a></div>
<%-- 				<h1 id="colorlib-logo"><a href="index.html"><%=nick %></a></h1> --%>
			</div>
			<nav id="colorlib-main-menu" role="navigation" class="navbar">
				<div id="navbar" class="collapse">
					<ul>
<!-- 						<li class="active"><a href="#" data-nav-section="home">개인정보수정</a></li> -->
						<li class="active"><a href="#" data-nav-section="about">개인정보수정</a></li>
<!-- 						<li><a href="#" data-nav-section="about">About</a></li> -->
						<li><a href="MypageGrade.mp" data-nav-section="services">선호 장르&국가&감독</a></li>
						<li><a href="MypageWish.mp" data-nav-section="skills">보고싶어요한 영화</a></li>
						<li><a href="BoardReviewList.bo" data-nav-section="education">내가 평가한 영화</a></li>
						<li><a href="MypageCollection.mp" data-nav-section="experience">컬렉션</a></li>
<!-- 						<li><a href="#" data-nav-section="work">Work</a></li> -->
<!-- 						<li><a href="#" data-nav-section="blog">Blog</a></li> -->
<!-- 						<li><a href="#" data-nav-section="contact">Contact</a></li> -->
					</ul>
				</div>
			</nav>


		</aside>
      </div>
<!--       사이드 레프트[E] -->
      
<!--       사이드 센터[S] -->
      <div id="jb-content">
      		<div id="colorlib-page">
		<div class="container-wrap">
		<a href="#" class="js-colorlib-nav-toggle colorlib-nav-toggle" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar"><i></i></a>

<!-- 		<div id="colorlib-main"> -->
<!-- 			<section id="colorlib-hero" class="js-fullheight" data-section="home"> -->
			
<!-- 			</section> -->
<!-- 			</div> -->

			<section class="colorlib-about" data-section="about">
			<fieldset>
			<legend>회원 정보 수정</legend>
			<form action="MemberUpdatePro.me" method="post" id="update_fr" class="update_fr">
				<fieldset>
				<legend>닉네임</legend>
				<div class="inputWithIcon inputIconBg">
				  <input type="text" id="nick" name="nick" placeholder="Nick Name" value="<%=nick%>" readonly/>
				  <i class="fa fa-user fa-lg fa-fw" aria-hidden="true"></i>
				</div>
				</fieldset>
				
				<fieldset>
				<legend>이메일</legend>
				<div class="inputWithIcon inputIconBg">
				  <input type="email" id="email" name="email" placeholder="Email" value="<%=memberBean.getEmail()%>" readonly/>
				  <i class="fa fa-envelope fa-lg fa-fw" aria-hidden="true"></i>
				  <button class="btn-style" id="emailBtn" type="button">이메일 변경</button>
				</div>
				<div id="divEmail"></div>
				</fieldset>
				
				<div class="emailConfirm">
				<fieldset>
				<legend>이메일 인증</legend>
				<div class="inputWithIcon inputIconBg">
				  <input type="text" id="certificationNum_email" name="certificationNum_email" placeholder="Email Certification Number"/>
				  <i class="fa fa-envelope fa-lg fa-fw" aria-hidden="true"></i>
				  <button class="btn-style" id="certification_email_Btn" type="button">인증코드 입력</button>
				</div>
				</fieldset>
				</div>
				
				<fieldset>
				<legend>패스워드</legend>
				<div class="inputWithIcon inputIconBg">
				  <input type="password" id="pass" name="pass" placeholder="Password" maxlength="15"/>
				  <i class="fas fa-keyboard  fa-lg fa-fw" aria-hidden="true"></i>
				</div>
				  <div id="regPass"></div>
				  <div id="st_msg"></div>
				</fieldset>
				
				
				<fieldset>
				<legend>핸드폰 번호</legend>
				<div class="inputWithIcon inputIconBg">
				  <input type="text" id="phoneNum" name="phoneNum" placeholder="Phone Number" value="<%=memberBean.getPhone()%>" maxlength="13" readonly/>
				  <i class="fa fa-phone fa-lg fa-fw" aria-hidden="true"></i>
				  <button class="btn-style" id="phoneNumBtn" type="button">핸드폰 번호 변경</button>
				</div>
				<div id="divPhone"></div>
				</fieldset>
				
				<div class="phoneConfirm">
				<fieldset>
				<legend>핸드폰 인증</legend>
				<div class="inputWithIcon inputIconBg">
				  <input type="text" id="certificationNum" name="certificationNum" placeholder="Certification Number" />
				  <i class="fa fa-phone fa-lg fa-fw" aria-hidden="true"></i>
				  <button class="btn-style" id="certificationBtn" type="button">인증번호 입력</button>
				</div>
				</fieldset>
				</div>
				
				<fieldset>
				<legend>자기 소개</legend>
				<div class="inputWithIcon inputIconBg">
				<!--   <input type="text" id="introduce" name="introduce" style="background-color: inherit;border:none;" value="Introduce" readonly/> -->
				  <textarea rows="20" cols="20" id="introduce" name="introduce" placeholder="Introduce"></textarea>
				  <i class="fas fa-address-card fa-lg fa-fw" aria-hidden="true"></i>
				</div>
				</fieldset>	
				
				<button type="submit" class="btn-style">회원 정보 수정</button>
				<button type="reset" class="btn-style">취소</button>
					
<!-- 				<div class="btn-style"><a style="color:#FFFFFF" href="MypageForm.mp">프로필수정</a></div> -->
				</form>
				<input type="hidden" class="confirm">
				<input type="hidden" class="confirm">
				<input type="hidden" class="confirm">
				<input type="hidden" class="confirm">
			</fieldset>
			
			
			
			
			
			
			
			
		</section>


			
			<section class="colorlib-services" data-section="services">
				<div id="colorlib-counter" class="colorlib-counters" style="background-image: url(images/cover_bg_1.jpg);" data-stellar-background-ratio="0.5"></div>
			
			
		<div class="table_form" style="display: flex;width:inherit;">
<!-- 			<div class="table_left" style="flex:0.5"> -->
			<div class="table_left">
			
			<fieldset id="genre_nation" style="text-align: center;width:100%;">
					<legend>선호 하는 장르</legend>
					<table id="favoriteGenre">
					    <thead>
					    <tr>
					        <th scope="cols">장르</th>
					        <th scope="cols">평가한 영화 수</th>
					        <th scope="cols">평점</th>
					    </tr>
					    </thead>
					    <tbody class="genreList">
					    </tbody>
					</table>
					
				</fieldset>
				</div>


<!-- 			<div class="table_right" style="flex:0.3;"> -->
			<div class="table_right">
				<fieldset id="genre_nation" style="text-align: center;width:100%;">
					<legend>선호 하는 국가</legend>
					<table id="favoriteNation">
						    <thead>
						    <tr>
						        <th scope="cols">국가명</th>
						        <th scope="cols">선호작품수</th>
						        <th scope="cols">평점</th>
						    </tr>
						    </thead>
						    <tbody class="nationList">
						    </tbody>
						</table>
				</fieldset>
			</div>
			
		</div>
			<div class="table_bottom" style="display: flex;">
			<fieldset>
				<legend>선호 하는 감독</legend>
				<div class="director"></div> 
			</fieldset>
			</div>
			
			
			
			
			
			</section>
			
			

			<section class="colorlib-skills" data-section="skills">
				<fieldset>
				<legend><%=nick %>님의 보고싶어요 리스트</legend>
					<div id="myinfo" class="myinfo">
						<div id="listForm">
							<% for(MypageBean wishInfo : wishMovie) {%>
							<div class="wishList">
							<%  String a = String.format("%05d" ,wishInfo.getMovieSeq()); %>
										<%if(wishInfo.getPoster()!=null){ %>
										<div class="poster" style='background-image: url(<%=wishInfo.getPoster()%>),url(${pageContext.request.contextPath}/img/noImage.gif'><a href="MovieDetailPro.mo?movieSeq=<%=a%>&query=<%=wishInfo.getTitle()%>"></a>
										<%if(wishInfo.getWish().equals("Y")){ %>
										<button class="btn-like" value="<%=nick%>,<%=wishInfo.getTitle() %>,<%=wishInfo.getWish() %>,<%=a %>,<%=wishInfo.getIdx()%>">❤️</button>
										<% }%>
										</div>
										<div class="title"><%=wishInfo.getTitle() %></div>
										</div>
									<% }%>
								<%}%>
						</div>
					</div>
			</fieldset>
			
			</section>

			<section class="colorlib-education" data-section="education">
				<fieldset>
				<legend>내가 평가한 영화 목록 : <%=listCount%>개</legend>
				<div id="myInfo">
				<%
					if (gradeList != null && listCount > 0) {
					for (int i = 0; i < gradeList.size(); i++) {
					int starRating = (int)(gradeList.get(i).getGrade()/2.0*20);						
					double starRating1 = (gradeList.get(i).getGrade()/2.0);						
				%>
				<div id="gradeList">
					<%  String a = String.format("%05d" ,gradeList.get(i).getMovieSeq()); %>

										<div class="poster" style='background-image: url(<%=gradeList.get(i).getPoster()%>),url(${pageContext.request.contextPath}/img/noImage.gif'></div>
										<div class="title"><%=gradeList.get(i).getTitle() %></div>
										<div class="wrap-star" style="float:left;margin-left:-50px;">								
										<div class='star-rating' style="float:left;">
		        						<span style ="width:<%=starRating%>%;"></span>
		    							</div>
		    							<div style="float:right;">
		        						<p style="margin-left:-90px;margin-top:16px;"><%=starRating1 %>점</p>
		        						</div>
	    								</div>
				
			</div>
				<%
					}
				} else {
				%>
				아직 평가한 영화가 없습니다.
				<%
					}
				%>
			</div>
		</fieldset>
			
<!-- 				<div class="colorlib-narrow-content"> -->
<!-- 					<div class="row"> -->
<!-- 						<div class="col-md-6 col-md-offset-3 col-md-pull-3 animate-box" data-animate-effect="fadeInLeft"> -->
<!-- 							<span class="heading-meta">Education</span> -->
<!-- 							<h2 class="colorlib-heading animate-box">Education</h2> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					<div class="row"> -->
<!-- 						<div class="col-md-12 animate-box" data-animate-effect="fadeInLeft"> -->
<!-- 							<div class="fancy-collapse-panel"> -->
<!-- 								<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true"> -->
<!-- 									<div class="panel panel-default"> -->
<!-- 									    <div class="panel-heading" role="tab" id="headingOne"> -->
<!-- 									        <h4 class="panel-title"> -->
<!-- 									            <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">Master Degree Graphic Design -->
<!-- 									            </a> -->
<!-- 									        </h4> -->
<!-- 									    </div> -->
<!-- 									    <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne"> -->
<!-- 									         <div class="panel-body"> -->
<!-- 									            <div class="row"> -->
<!-- 										      		<div class="col-md-6"> -->
<!-- 										      			<p>Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts. </p> -->
<!-- 										      		</div> -->
<!-- 										      		<div class="col-md-6"> -->
<!-- 										      			<p>Separated they live in Bookmarksgrove right at the coast of the Semantics, a large language ocean.</p> -->
<!-- 										      		</div> -->
<!-- 										      	</div> -->
<!-- 									         </div> -->
<!-- 									    </div> -->
<!-- 									</div> -->
<!-- 									<div class="panel panel-default"> -->
<!-- 									    <div class="panel-heading" role="tab" id="headingTwo"> -->
<!-- 									        <h4 class="panel-title"> -->
<!-- 									            <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">Bachelor Degree of Computer Science -->
<!-- 									            </a> -->
<!-- 									        </h4> -->
<!-- 									    </div> -->
<!-- 									    <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo"> -->
<!-- 									        <div class="panel-body"> -->
<!-- 									            <p>Far far away, behind the word <strong>mountains</strong>, far from the countries Vokalia and Consonantia, there live the blind texts. Separated they live in Bookmarksgrove right at the coast of the Semantics, a large language ocean.</p> -->
<!-- 													<ul> -->
<!-- 														<li>Separated they live in Bookmarksgrove right</li> -->
<!-- 														<li>Separated they live in Bookmarksgrove right</li> -->
<!-- 													</ul> -->
<!-- 									        </div> -->
<!-- 									    </div> -->
<!-- 									</div> -->
<!-- 									<div class="panel panel-default"> -->
<!-- 									    <div class="panel-heading" role="tab" id="headingThree"> -->
<!-- 									        <h4 class="panel-title"> -->
<!-- 									            <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">Diploma in Information Technology -->
<!-- 									            </a> -->
<!-- 									        </h4> -->
<!-- 									    </div> -->
<!-- 									    <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree"> -->
<!-- 									        <div class="panel-body"> -->
<!-- 									            <p>Far far away, behind the word <strong>mountains</strong>, far from the countries Vokalia and Consonantia, there live the blind texts. Separated they live in Bookmarksgrove right at the coast of the Semantics, a large language ocean.</p>	 -->
<!-- 									        </div> -->
<!-- 									    </div> -->
<!-- 									</div> -->

<!-- 									<div class="panel panel-default"> -->
<!-- 									    <div class="panel-heading" role="tab" id="headingFour"> -->
<!-- 									        <h4 class="panel-title"> -->
<!-- 									            <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseFour" aria-expanded="false" aria-controls="collapseFour">Diploma in Information Technology -->
<!-- 									            </a> -->
<!-- 									        </h4> -->
<!-- 									    </div> -->
<!-- 									    <div id="collapseFour" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFour"> -->
<!-- 									        <div class="panel-body"> -->
<!-- 									            <p>Far far away, behind the word <strong>mountains</strong>, far from the countries Vokalia and Consonantia, there live the blind texts. Separated they live in Bookmarksgrove right at the coast of the Semantics, a large language ocean.</p>	 -->
<!-- 									        </div> -->
<!-- 									    </div> -->
<!-- 									</div> -->

<!-- 									<div class="panel panel-default"> -->
<!-- 									    <div class="panel-heading" role="tab" id="headingFive"> -->
<!-- 									        <h4 class="panel-title"> -->
<!-- 									            <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseFive" aria-expanded="false" aria-controls="collapseFive">High School Secondary Education -->
<!-- 									            </a> -->
<!-- 									        </h4> -->
<!-- 									    </div> -->
<!-- 									    <div id="collapseFive" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFive"> -->
<!-- 									        <div class="panel-body"> -->
<!-- 									            <p>Far far away, behind the word <strong>mountains</strong>, far from the countries Vokalia and Consonantia, there live the blind texts. Separated they live in Bookmarksgrove right at the coast of the Semantics, a large language ocean.</p>	 -->
<!-- 									        </div> -->
<!-- 									    </div> -->
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
			</section>
			
			
			
			
			
			<section class="colorlib-education" data-section="experience">
			<h2>컬렉션 페이지</h2>
		<div>
			<input type="button" id="showAddCollection" value="컬렉션 추가 하기">
		  <div id="showDisplay" style= display:none>
				<form action="/Movie/MypageCollectionCreate.mp" method="post">
				<h3>컬렉션 이름</h3><input type="text" name="subject" id="subject"><br>
				<h3>컬렉션 내용</h3><textarea name ="content" id="content"></textarea><br>
				<input type="button" value="작품추가" id="addMov">
				<div id="movies">
				</div>
				<input type="submit" value="생성" id="submit">
	
			</form>
			</div>
			<br>
			<h1><%=nick %> 님의 컬렉션 목록</h1> <br>
				
				<% for(int i = 0; i < collection.size(); i++) {%>
				<form action="/Movie/MypageCollectionUpdate.mp" method="post">
					<div id="collectionNum" class="collectionNum<%=i%>">
					<div class="collections">
					<h2>컬렉션 명:<%=collection.get(i).getCollection_name() %></h2><br>
					<h4>컬렉션 내용:<%=collection.get(i).getContent() %></h4>
					<input type="button" class ="delBtn" id="<%=collection.get(i).getIdx()%>" value="삭제">
					<input type="button" class ="modifyBtn" id="<%=collection.get(i).getIdx()%>" value="수정">
					<div class="modifyAdd">
					<input type="button" value="작품추가" id ="add<%=i %>"  class="modifyAddMov"><br><br>
					</div>
					<div class="collectionView">
					<%for(int o = 0; o < collection.get(i).getTitle().split(",").length; o++){%>
						<div class ="eachList<%=o %>" id="eachList">
						<div id="modifyMovies"></div>
						<a href="MovieDetailPro.mo?movieSeq=<%=collection.get(i).getMovieSeq().split(",")[o]%>&query=<%=collection.get(i).getTitle().split(",")[o]%>">
						</a>
						<div class="poster" style="background-image: url('<%=collection.get(i).getPoster().split(",")[o]%>'),url(${pageContext.request.contextPath}/img/noImage.gif;"></div>
						<div class="title"><%=collection.get(i).getTitle().split(",")[o]%></div>

						<div class="modifyDel">
						<input type="button" class ="modifyDelBtn" id="eachList<%=o %>" value="삭제"><br>
						</div>
						
						<input type="hidden" name="movieSeq" value="<%=collection.get(i).getMovieSeq().split(",")[o]%>">
						<input type="hidden" name="title" value="<%=collection.get(i).getTitle().split(",")[o]%>">
						<input type="hidden" name="poster" value="<%=collection.get(i).getPoster().split(",")[o]%>">
						<input type="hidden" name="idx" value="<%=collection.get(i).getIdx()%>">
						</div>
						
					<%} %>
					</div>
					<div class="collectionModify">
					<Button class="modifyCollection" type="submit">수정하기</Button>
					</div>
					</div>
					</div>
					</form>
			<%}%> 
					</div>
				
			</section>
		</div>
	</div>
			
			</section>


		</div><!-- end:colorlib-main -->
	</div><!-- end:container-wrap -->
	</div><!-- end:colorlib-page -->
      
      
      </div>
<!--       사이드 센터[E] -->

<!-- 상단 이동 버튼 [S] -->
<div class="moveTop" style="cursor:pointer;">TOP</div>
<!-- 상단 이동 버튼 [E] -->	
	
	

<!-- jQuery -->
<script src="js/jquery.min.js"></script>
<!-- jQuery Easing -->
<script src="js/jquery.easing.1.3.js"></script>
<!-- Bootstrap -->
<!-- 	<script src="js/bootstrap.min.js"></script> -->
<!-- Waypoints -->
<script src="js/jquery.waypoints.min.js"></script>
<!-- Flexslider -->
<script src="js/jquery.flexslider-min.js"></script>
<!-- Owl carousel -->
<script src="js/owl.carousel.min.js"></script>
<!-- Counters -->
<script src="js/jquery.countTo.js"></script>


<!-- MAIN JS -->
<script src="js/main.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.js"></script>
<script type="text/javascript">
$('#listForm').slick({
	   dots: false,
     infinite: false,
     arrows: true,
     variableWidth:true,
     speed: 300,
     slidesToShow: 4,
     slidesToScroll: 3,
	   responsive: [
	     {
	       breakpoint: 1024,
	       settings: {
	         slidesToShow: 3,
	         slidesToScroll: 3,
	         infinite: false,
	         dots: false
	       }
	     },
	     {
	       breakpoint: 600,
	       settings: {
	         slidesToShow: 2,
	         slidesToScroll: 2
	       }
	     },
	     {
	       breakpoint: 480,
	       settings: {
	         slidesToShow: 1,
	         slidesToScroll: 1
	       }
	     }
	   ]
	 }); //$('#listForm').slick() 끝
	 
	$('#myInfo').slick({
	 	   dots: false,
	        infinite: false,
	        arrows: true,
	        variableWidth:true,
	        speed: 300,
	        slidesToShow: 4,
	        slidesToScroll: 3,
	 	   responsive: [
	 	     {
	 	       breakpoint: 1024,
	 	       settings: {
	 	         slidesToShow: 3,
	 	         slidesToScroll: 3,
	 	         infinite: false,
	 	         dots: false
	 	       }
	 	     },
	 	     {
	 	       breakpoint: 600,
	 	       settings: {
	 	         slidesToShow: 2,
	 	         slidesToScroll: 2
	 	       }
	 	     },
	 	     {
	 	       breakpoint: 480,
	 	       settings: {
	 	         slidesToShow: 1,
	 	         slidesToScroll: 1
	 	       }
	 	     }
	 	   ]
	 	 }); //$('#myInfo').slick() 끝
	
	
	$('.collectionView').slick({
		   dots: false,
	     infinite: false,
	     arrows: true,
	     variableWidth:true,
	     speed: 300,
	     slidesToShow: 4,
	     slidesToScroll: 3,
		   responsive: [
		     {
		       breakpoint: 1024,
		       settings: {
		         slidesToShow: 3,
		         slidesToScroll: 3,
		         infinite: false,
		         dots: false
		       }
		     },
		     {
		       breakpoint: 600,
		       settings: {
		         slidesToShow: 2,
		         slidesToScroll: 2
		       }
		     },
		     {
		       breakpoint: 480,
		       settings: {
		         slidesToShow: 1,
		         slidesToScroll: 1
		       }
		     }
		   ]
		 });	//$('.collectionView').slick() 끝
	
	
	$('.director').slick({
		   dots: false,
	     infinite: false,
	     arrows: true,
	     variableWidth:true,
	     speed: 300,
	     slidesToShow: 4,
	     slidesToScroll: 3,
		   responsive: [
		     {
		       breakpoint: 1024,
		       settings: {
		         slidesToShow: 3,
		         slidesToScroll: 3,
		         infinite: false,
		         dots: false
		       }
		     },
		     {
		       breakpoint: 600,
		       settings: {
		         slidesToShow: 2,
		         slidesToScroll: 2
		       }
		     },
		     {
		       breakpoint: 480,
		       settings: {
		         slidesToShow: 1,
		         slidesToScroll: 1
		       }
		     }
		   ]
		 }); //$('.director').slick() 끝
	
	
	$('#movies').slick({
		   dots: false,
	     infinite: false,
	     arrows: true,
	     variableWidth:true,
	     speed: 300,
	     slidesToShow: 4,
	     slidesToScroll: 3,
		   responsive: [
		     {
		       breakpoint: 1024,
		       settings: {
		         slidesToShow: 3,
		         slidesToScroll: 3,
		         infinite: false,
		         dots: false
		       }
		     },
		     {
		       breakpoint: 600,
		       settings: {
		         slidesToShow: 2,
		         slidesToScroll: 2
		       }
		     },
		     {
		       breakpoint: 480,
		       settings: {
		         slidesToShow: 1,
		         slidesToScroll: 1
		       }
		     }
		   ]
		 }); //$('#movies').slick() 끝
	
	
</script>


	<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/css/mypage.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/css/memberjoin.css" rel="stylesheet" type="text/css">
</body>
</html>