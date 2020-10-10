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
    String nick = (String)session.getAttribute("nick");
    ArrayList<MypageBean> wishMovie = (ArrayList<MypageBean>)request.getAttribute("wishMovie");
    ArrayList<MypageBean> gradeList = (ArrayList<MypageBean>) request.getAttribute("gradeList");
    int listCount = (int) request.getAttribute("listCount");
    ArrayList<CollectionBean> collection = (ArrayList<CollectionBean>)(request.getAttribute("collection")); 
	%>
	
	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>마이페이지</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="" />
	<meta name="keywords" content="" />
	<meta name="author" content="" />

  <!-- Facebook and Twitter integration -->
	<meta property="og:title" content=""/>
	<meta property="og:image" content=""/>
	<meta property="og:url" content=""/>
	<meta property="og:site_name" content=""/>
	<meta property="og:description" content=""/>
	<meta name="twitter:title" content="" />
	<meta name="twitter:image" content="" />
	<meta name="twitter:url" content="" />
	<meta name="twitter:card" content="" />

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
// 						$('.nation').append(idx2 +" : "+item2.nation+"개 "+ count.toFixed(1) +"점 <br>"); 
// 						$('.nationList').append('<tr><th scope="row">'+idx2+'</th><td><span class="colorlib-counter js-counter" data-from="0" data-to="'+item2.nation+'" data-speed="3000" data-refresh-interval="50"></span></td><td>★'+count.toFixed(1)+'점</td></tr>');
// 						$('#nationList').append('<span class="colorlib-counter js-counter" data-from="0" data-to="'+item2.nation+'" data-speed="5000" data-refresh-interval="50"></span><span class="colorlib-counter-label">'+idx2+'</span><span class="colorlib-counter-label">'+count.toFixed(1)+'</span>');
// 						$('#favoriteNation').append('<div id=nationList style=float:left;margin:auto;padding:auto;><span style=color:#FFFFFF class="colorlib-counter js-counter" data-from="0" data-to="'+item2.nation+'" data-speed="5000" data-refresh-interval="50"></span><span style=color:#FFFFFF class="colorlib-counter-label">'+idx2+'</span><span style=color:#FFFFFF class="colorlib-counter-label">'+count.toFixed(1)+'</span></div>');
						$('.nationList').append('<tr><th scope="row">'+idx2+'</th><td><span class="colorlib-counter js-counter" data-from="0" data-to="'+item2.nation+'" data-speed="3000" data-refresh-interval="50"></span></td><td>★'+count.toFixed(1)+'점</td></tr>');
						// 						<div class="col-md-3 text-center animate-box" id="nationList"></div>
						// 						<div class="col-md-3 text-center animate-box"> -->
						<!-- 							<span class="colorlib-counter js-counter" data-from="0" data-to="309" data-speed="5000" data-refresh-interval="50"></span> -->
						<!-- 							<span class="colorlib-counter-label">Cups of coffee</span> -->
						<!-- 						</div> -->
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
 						$('.director').append('<div class=favoriteDirector>'+img+'<br>'+item2.director+'</div>');
					});
				});
				
			}
		});
		
		
		
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
			
// 		$('#movies').append("<li>" + $('#hiddenTitle').val() +"</li>");
// 		alert($('#hiddenTitle').val());
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
		})
		
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
	
	
		
	});
	
	
</script>
	
	
	
	
<style>
#header{position: sticky;top: 0;z-index: 100;}
.btn-like{float:left;background-color: inherit;border:none;outline:none;}
.btn-like:active{outline:none;}
/* * { font-family: 'D2Coding'; src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_three@1.0/D2Coding.woff') format('woff'); font-weight: normal; font-style: normal; } */
</style>
</head>
<body>
	<div id="header">
		<jsp:include page="/inc/top.jsp" />
		<div class="clear"></div>
	</div>
	<div id="colorlib-page" style="margin-bottom:500px;">
		<div class="container-wrap">
		
		
		
		
		
		<!--       사이드 레프트 [S] -->
      <div id="jb-sidebar-left">
				<aside id="colorlib-aside" role="complementary" class="border js-fullheight">
				<div class="text-center">
					<div class="author-img" style="background-image: url(프로필사진주소), url(img/noProfile.png);"></div>
					<h1 id="colorlib-logo"><a href="index.html"><%=nick %></a></h1>
				</div>
				<nav id="colorlib-main-menu" role="navigation" class="navbar">
					<div id="navbar" class="collapse">
						<ul>
							<li class="active"><a href="Mypage.mp" data-nav-section="about">개인 정보 수정</a></li>
							<li><a href="MypageGrade.mp" data-nav-section="services">선호 장르&국가&감독</a></li>
							<li><a href="MypageWish.mp" data-nav-section="skills">보고싶어요한 영화</a></li>
							<li><a href="BoardReviewList.bo" data-nav-section="education">내가 평가한 영화</a></li>
							<li><a href="MypageCollection.mp" data-nav-section="experience">컬렉션</a></li>
<!-- 							<li><a href="MypageCollection.mp" data-nav-section="experience">Experience</a></li> -->
<!-- 							<li><a href="#" data-nav-section="work">Work</a></li> -->
<!-- 							<li><a href="#" data-nav-section="blog">Blog</a></li> -->
<!-- 							<li><a href="#" data-nav-section="contact">Contact</a></li> -->
						</ul>
					</div>
				</nav>
			</aside>
      </div>
<!--       사이드 레프트[E] -->
		
		
		<!--       사이드 센터[S] -->
      <div id="jb-content">
      		<a href="#" class="js-colorlib-nav-toggle colorlib-nav-toggle" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar"><i></i></a>
			

		<div id="colorlib-main">
			<section class="colorlib-about" data-section="about">
		<div id="myinfo">
			<fieldset>
			<legend>닉네임</legend>
			<div class="inputWithIcon inputIconBg">
			  <input type="text" id="nick" placeholder="Nick Name" value="<%=nick%>" readonly/>
			  <i class="fa fa-user fa-lg fa-fw" aria-hidden="true"></i>
			</div>
			</fieldset>
			
			<fieldset>
			<legend>이메일</legend>
			<div class="inputWithIcon inputIconBg">
			  <input type="email" id="email" placeholder="Email" value="<%=memberBean.getEmail()%>" readonly/>
			  <i class="fa fa-envelope fa-lg fa-fw" aria-hidden="true"></i>
			  <button id="emailBtn" type="button">이메일 변경</button>
			</div>
			</fieldset>
			
			
			<fieldset>
			<legend>이메일 인증</legend>
			<div class="inputWithIcon inputIconBg">
			  <input type="email" id="certificationNum_email" name="certificationNum_email" placeholder="Email Certification Number"/>
			  <i class="fa fa-envelope fa-lg fa-fw" aria-hidden="true"></i>
			  <button id="certification_email_Btn" type="button">인증코드 입력</button>
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
			  <input type="text" id="phoneNum" name="phoneNum" placeholder="Phone Number" value="<%=memberBean.getPhone()%>" readonly/>
			  <i class="fa fa-phone fa-lg fa-fw" aria-hidden="true"></i>
			  <button id="phoneNumBtn" type="button">핸드폰 번호 변경</button>
			</div>
			</fieldset>
			
			<fieldset>
			<legend>핸드폰 인증</legend>
			<div class="inputWithIcon inputIconBg">
			  <input type="text" id="certificationNum" name="certificationNum" placeholder="Certification Number" />
			  <i class="fa fa-phone fa-lg fa-fw" aria-hidden="true"></i>
			  <button id="phoneNumBtn" type="button">인증번호 입력</button>
			</div>
			</fieldset>
			
			<fieldset>
			<legend>자기 소개</legend>
			<div class="inputWithIcon inputIconBg">
			<!--   <input type="text" id="introduce" name="introduce" style="background-color: inherit;border:none;" value="Introduce" readonly/> -->
			  <textarea rows="20" cols="20" id="infoup" placeholder="Introduce"></textarea>
			  <i class="fas fa-address-card fa-lg fa-fw" aria-hidden="true" style="margin-top:12px"></i>
			</div>
			</fieldset>		
					<a href="MypageForm.mp">프로필수정</a>
			</div>	
		</section>
		
		<div id="colorlib-counter" class="colorlib-counters" data-stellar-background-ratio="0.5">
			</div>


			
			<section class="colorlib-services" data-section="services">
				<fieldset id="genre_nation">
					<legend>선호 하는 장르 및 국가</legend>
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

				<fieldset>
				<legend>선호 하는 감독</legend>
				<div class="director"></div> 
				</fieldset>
			</section>
			
<!-- 			<div id="colorlib-counter" class="colorlib-counters" data-stellar-background-ratio="0.5"> -->


<!-- 			</div> -->


			<section class="colorlib-skills" data-section="skills">
			
				<fieldset>
				<legend><%=nick %>님의 보고싶어요 리스트</legend>
					<div id="myinfo" class="myinfo">
						<div id="listForm">
							<% for(MypageBean wishInfo : wishMovie) {%>
							<div class="wishList">
							<%  String a = String.format("%05d" ,wishInfo.getMovieSeq()); %>
	<%-- 									<%if(wishInfo.getPoster()!=null){ %> --%>
	<%-- 									<div class="poster"><a href="MovieDetailPro.mo?movieSeq=<%=a%>&query=<%=wishInfo.getTitle()%>"><img src="<%=wishInfo.getPoster()%>" style="width:250px;height:350px;" onerror="this.src='${pageContext.request.contextPath}/img/noImage.gif'"></a></div><div class="title"><%=wishInfo.getTitle() %></div> --%>
										<%if(wishInfo.getPoster()!=null){ %>
										<div class="poster" style='width:250px;height:350px;background-image: url(<%=wishInfo.getPoster()%>)' onerror="this.src='${pageContext.request.contextPath}/img/noImage.gif'"><a href="MovieDetailPro.mo?movieSeq=<%=a%>&query=<%=wishInfo.getTitle()%>"></a>
										<%if(wishInfo.getWish().equals("Y")){ %>
										<button class="btn-like" value="<%=nick%>,<%=wishInfo.getTitle() %>,<%=wishInfo.getWish() %>,<%=a %>,<%=wishInfo.getIdx()%>">❤️</button>
										<% }%>
										</div>
										<div class="title" style="margin-left:-20px;"><%=wishInfo.getTitle() %></div>
	<%-- 									<%if(wishInfo.getWish().equals("Y")){ %> --%>
	<%-- 									<button class="btn-like" value="<%=nick%>,<%=wishInfo.getTitle() %>,<%=wishInfo.getWish() %>,<%=a %>,<%=wishInfo.getIdx()%>">❤️</button> --%>
	<%-- 									<% }%> --%>
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
				<div id="gradelist">
					<ul> <%  String a = String.format("%05d" ,gradeList.get(i).getMovieSeq()); %>
						<li><div class=poster><img src=<%=gradeList.get(i).getPoster() %>></div>
							<div id="movieInfo">
								<div class="title" style="font-size:2em"><%=gradeList.get(i).getTitle()%></div>
<%-- 								<div class="grade" style="font-size:2em">★ : <%=gradeList.get(i).getGrade()/2.0%>점</div> --%>
<%-- 								<div class="grade" style="font-size:2em;background-image: url('img/grade_img.png');">★ : <%=gradeList.get(i).getGrade()/2.0%>점</div> --%>
<!-- 								<div class="grade" style="font-size:2em"> -->
									<div class="wrap-star" style="float:left;margin-left:-50px;">								
										<div class='star-rating' style="float:left;">
		        						<span style ="width:<%=starRating%>%;"></span>
		    							</div>
		    							<div style="float:right;">
		        						<p style="font-size: 2em;margin-left:-90px;margin-top:14px;"><%=starRating1 %>점</p>
		        						</div>
	    							</div>
<!--     							</div> -->
							 <!-- 2.0으로 나누기 끝자리 0이면 정수로만보여주기 나머지가 0이면 인트 등등방법  -->
							</div></li>
					</ul>
					
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
				
		</section>
									
		
<!-- 		나머지 메뉴 틀 주석 처리 - 낙원 : 1007 [S] -->

			<section class="colorlib-experience" data-section="experience">
			<fieldset>
				<legend><%=nick %> 님의 컬렉션 목록</legend>
			<div>
			
			
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
			<section>
				
				<% for(int i = 0; i < collection.size(); i++) {%>
				<form action="/Movie/MypageCollectionUpdate.mp" method="post">
					<div id="collectionNum" class="collectionNum<%=i%>"><h2>컬렉션 명:<%=collection.get(i).getCollection_name() %></h2><br>
					<h4>컬렉션 내용:<%=collection.get(i).getContent() %></h4>
					<input type="button" class ="delBtn" id="<%=collection.get(i).getIdx()%>" value="삭제">
					<input type="button" class ="modifyBtn" id="<%=collection.get(i).getIdx()%>" value="수정">
					<input type="button" value="작품추가" id ="add<%=i %>"  class="modifyAddMov"><br><br>
					<div class="collectionView">
					<%for(int o = 0; o < collection.get(i).getTitle().split(",").length; o++){%>
						<div class ="eachList<%=o %>" id="eachList">
						<div id="modifyMovies"></div>
						<img src="<%=collection.get(i).getPoster().split(",")[o]%>">
						<br>
						<a href="MovieDetailPro.mo?movieSeq=<%=collection.get(i).getMovieSeq().split(",")[o]%>
						&query=<%=collection.get(i).getTitle().split(",")[o]%>"><%=collection.get(i).getTitle().split(",")[o]%></a>
						
						<input type="button" class ="modifyDelBtn" id="eachList<%=o %>" value="삭제"><br></div>
						
						<input type="hidden" name="movieSeq" value="<%=collection.get(i).getMovieSeq().split(",")[o]%>">
						<input type="hidden" name="title" value="<%=collection.get(i).getTitle().split(",")[o]%>">
						<input type="hidden" name="poster" value="<%=collection.get(i).getPoster().split(",")[o]%>">
						<input type="hidden" name="idx" value="<%=collection.get(i).getIdx()%>">
						
						
					<%} %></div>
					</div>
					<input type="submit" value="수정하기"></form>
			<%}%> 
				
				
			</section>
		</div>
	</div>
		</fieldset>	
	
<!-- 				<div class="colorlib-narrow-content"> -->
<!-- 					<div class="row"> -->
<!-- 						<div class="col-md-6 col-md-offset-3 col-md-pull-3 animate-box" data-animate-effect="fadeInLeft"> -->
<!-- 							<span class="heading-meta">Experience</span> -->
<!-- 							<h2 class="colorlib-heading animate-box">Work Experience</h2> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					<div class="row"> -->
<!-- 						<div class="col-md-12"> -->
<!-- 				         <div class="timeline-centered"> -->
<!-- 					         <article class="timeline-entry animate-box" data-animate-effect="fadeInLeft"> -->
<!-- 					            <div class="timeline-entry-inner"> -->

<!-- 					               <div class="timeline-icon color-1"> -->
<!-- 					                  <i class="icon-pen2"></i> -->
<!-- 					               </div> -->

<!-- 					               <div class="timeline-label"> -->
<!-- 					                  <h2><a href="#">Full Stack Developer</a> <span>2017-2018</span></h2> -->
<!-- 					                  <p>Tolerably earnestly middleton extremely distrusts she boy now not. Add and offered prepare how cordial two promise. Greatly who affixed suppose but enquire compact prepare all put. Added forth chief trees but rooms think may.</p> -->
<!-- 					               </div> -->
<!-- 					            </div> -->
<!-- 					         </article> -->


<!-- 					         <article class="timeline-entry animate-box" data-animate-effect="fadeInRight"> -->
<!-- 					            <div class="timeline-entry-inner"> -->
<!-- 					               <div class="timeline-icon color-2"> -->
<!-- 					                  <i class="icon-pen2"></i> -->
<!-- 					               </div> -->
<!-- 					               <div class="timeline-label"> -->
<!-- 					               	<h2><a href="#">Front End Developer at Google Company</a> <span>2017-2018</span></h2> -->
<!-- 					                  <p>Even the all-powerful Pointing has no control about the blind texts it is an almost unorthographic life One day however a small line of blind text by the name of Lorem Ipsum decided to leave for the far World of Grammar.</p> -->
<!-- 					               </div> -->
<!-- 					            </div> -->
<!-- 					         </article> -->

<!-- 					         <article class="timeline-entry animate-box" data-animate-effect="fadeInLeft"> -->
<!-- 					            <div class="timeline-entry-inner"> -->
<!-- 					               <div class="timeline-icon color-3"> -->
<!-- 					                  <i class="icon-pen2"></i> -->
<!-- 					               </div> -->
<!-- 					               <div class="timeline-label"> -->
<!-- 					               	<h2><a href="#">System Analyst</a> <span>2017-2018</span></h2> -->
<!-- 					                  <p>Even the all-powerful Pointing has no control about the blind texts it is an almost unorthographic life One day however a small line of blind text by the name of Lorem Ipsum decided to leave for the far World of Grammar.</p> -->
<!-- 					               </div> -->
<!-- 					            </div> -->
<!-- 					         </article> -->

<!-- 					         <article class="timeline-entry animate-box" data-animate-effect="fadeInTop"> -->
<!-- 					            <div class="timeline-entry-inner"> -->
<!-- 					               <div class="timeline-icon color-4"> -->
<!-- 					                  <i class="icon-pen2"></i> -->
<!-- 					               </div> -->
<!-- 					               <div class="timeline-label"> -->
<!-- 					               	<h2><a href="#">Creative Designer</a> <span>2017-2018</span></h2> -->
<!-- 					                  <p>Even the all-powerful Pointing has no control about the blind texts it is an almost unorthographic life One day however a small line of blind text by the name of Lorem Ipsum decided to leave for the far World of Grammar.</p> -->
<!-- 					               </div> -->
<!-- 					            </div> -->
<!-- 					         </article> -->

<!-- 					         <article class="timeline-entry animate-box" data-animate-effect="fadeInLeft"> -->
<!-- 					            <div class="timeline-entry-inner"> -->
<!-- 					               <div class="timeline-icon color-5"> -->
<!-- 					                  <i class="icon-pen2"></i> -->
<!-- 					               </div> -->
<!-- 					               <div class="timeline-label"> -->
<!-- 					               	<h2><a href="#">UI/UX Designer at Envato</a> <span>2017-2018</span></h2> -->
<!-- 					                  <p>Even the all-powerful Pointing has no control about the blind texts it is an almost unorthographic life One day however a small line of blind text by the name of Lorem Ipsum decided to leave for the far World of Grammar.</p> -->
<!-- 					               </div> -->
<!-- 					            </div> -->
<!-- 					         </article> -->

<!-- 					         <article class="timeline-entry begin animate-box" data-animate-effect="fadeInBottom"> -->
<!-- 					            <div class="timeline-entry-inner"> -->
<!-- 					               <div class="timeline-icon color-none"> -->
<!-- 					               </div> -->
<!-- 					            </div> -->
<!-- 					         </article> -->
<!-- 					      </div> -->
<!-- 					   </div> -->
<!-- 				   </div> -->
<!-- 				</div> -->
			</section>
      </div>
<!--       사이드 센터[E] -->
		
		
		
		
		
		
		

<!-- 			<section class="colorlib-work" data-section="work"> -->
<!-- 				<div class="colorlib-narrow-content"> -->
<!-- 					<div class="row"> -->
<!-- 						<div class="col-md-6 col-md-offset-3 col-md-pull-3 animate-box" data-animate-effect="fadeInLeft"> -->
<!-- 							<span class="heading-meta">My Work</span> -->
<!-- 							<h2 class="colorlib-heading animate-box">Recent Work</h2> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					<div class="row row-bottom-padded-sm animate-box" data-animate-effect="fadeInLeft"> -->
<!-- 						<div class="col-md-12"> -->
<!-- 							<p class="work-menu"><span><a href="#" class="active">Graphic Design</a></span> <span><a href="#">Web Design</a></span> <span><a href="#">Software</a></span> <span><a href="#">Apps</a></span></p> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					<div class="row"> -->
<!-- 						<div class="col-md-6 animate-box" data-animate-effect="fadeInLeft"> -->
<!-- 							<div class="project" style="background-image: url(images/img-1.jpg);"> -->
<!-- 								<div class="desc"> -->
<!-- 									<div class="con"> -->
<!-- 										<h3><a href="work.html">Work 01</a></h3> -->
<!-- 										<span>Website</span> -->
<!-- 										<p class="icon"> -->
<!-- 											<span><a href="#"><i class="icon-share3"></i></a></span> -->
<!-- 											<span><a href="#"><i class="icon-eye"></i> 100</a></span> -->
<!-- 											<span><a href="#"><i class="icon-heart"></i> 49</a></span> -->
<!-- 										</p> -->
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<div class="col-md-6 animate-box" data-animate-effect="fadeInRight"> -->
<!-- 							<div class="project" style="background-image: url(images/img-2.jpg);"> -->
<!-- 								<div class="desc"> -->
<!-- 									<div class="con"> -->
<!-- 										<h3><a href="work.html">Work 02</a></h3> -->
<!-- 										<span>Animation</span> -->
<!-- 										<p class="icon"> -->
<!-- 											<span><a href="#"><i class="icon-share3"></i></a></span> -->
<!-- 											<span><a href="#"><i class="icon-eye"></i> 100</a></span> -->
<!-- 											<span><a href="#"><i class="icon-heart"></i> 49</a></span> -->
<!-- 										</p> -->
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<div class="col-md-6 animate-box" data-animate-effect="fadeInTop"> -->
<!-- 							<div class="project" style="background-image: url(images/img-3.jpg);"> -->
<!-- 								<div class="desc"> -->
<!-- 									<div class="con"> -->
<!-- 										<h3><a href="work.html">Work 03</a></h3> -->
<!-- 										<span>Illustration</span> -->
<!-- 										<p class="icon"> -->
<!-- 											<span><a href="#"><i class="icon-share3"></i></a></span> -->
<!-- 											<span><a href="#"><i class="icon-eye"></i> 100</a></span> -->
<!-- 											<span><a href="#"><i class="icon-heart"></i> 49</a></span> -->
<!-- 										</p> -->
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<div class="col-md-6 animate-box" data-animate-effect="fadeInBottom"> -->
<!-- 							<div class="project" style="background-image: url(images/img-4.jpg);"> -->
<!-- 								<div class="desc"> -->
<!-- 									<div class="con"> -->
<!-- 										<h3><a href="work.html">Work 04</a></h3> -->
<!-- 										<span>Application</span> -->
<!-- 										<p class="icon"> -->
<!-- 											<span><a href="#"><i class="icon-share3"></i></a></span> -->
<!-- 											<span><a href="#"><i class="icon-eye"></i> 100</a></span> -->
<!-- 											<span><a href="#"><i class="icon-heart"></i> 49</a></span> -->
<!-- 										</p> -->
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<div class="col-md-6 animate-box" data-animate-effect="fadeInLeft"> -->
<!-- 							<div class="project" style="background-image: url(images/img-5.jpg);"> -->
<!-- 								<div class="desc"> -->
<!-- 									<div class="con"> -->
<!-- 										<h3><a href="work.html">Work 05</a></h3> -->
<!-- 										<span>Graphic, Logo</span> -->
<!-- 										<p class="icon"> -->
<!-- 											<span><a href="#"><i class="icon-share3"></i></a></span> -->
<!-- 											<span><a href="#"><i class="icon-eye"></i> 100</a></span> -->
<!-- 											<span><a href="#"><i class="icon-heart"></i> 49</a></span> -->
<!-- 										</p> -->
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<div class="col-md-6 animate-box" data-animate-effect="fadeInRight"> -->
<!-- 							<div class="project" style="background-image: url(images/img-6.jpg);"> -->
<!-- 								<div class="desc"> -->
<!-- 									<div class="con"> -->
<!-- 										<h3><a href="work.html">Work 06</a></h3> -->
<!-- 										<span>Web Design</span> -->
<!-- 										<p class="icon"> -->
<!-- 											<span><a href="#"><i class="icon-share3"></i></a></span> -->
<!-- 											<span><a href="#"><i class="icon-eye"></i> 100</a></span> -->
<!-- 											<span><a href="#"><i class="icon-heart"></i> 49</a></span> -->
<!-- 										</p> -->
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					<div class="row"> -->
<!-- 						<div class="col-md-12 animate-box"> -->
<!-- 							<p><a href="#" class="btn btn-primary btn-lg btn-load-more">Load more <i class="icon-reload"></i></a></p> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</section> -->

<!-- 			<section class="colorlib-blog" data-section="blog"> -->
<!-- 				<div class="colorlib-narrow-content"> -->
<!-- 					<div class="row"> -->
<!-- 						<div class="col-md-6 col-md-offset-3 col-md-pull-3 animate-box" data-animate-effect="fadeInLeft"> -->
<!-- 							<span class="heading-meta">Read</span> -->
<!-- 							<h2 class="colorlib-heading">Recent Blog</h2> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					<div class="row"> -->
<!-- 						<div class="col-md-4 col-sm-6 animate-box" data-animate-effect="fadeInLeft"> -->
<!-- 							<div class="blog-entry"> -->
<!-- 								<a href="blog.html" class="blog-img"><img src="images/blog-1.jpg" class="img-responsive" alt="HTML5 Bootstrap Template by colorlib.com"></a> -->
<!-- 								<div class="desc"> -->
<!-- 									<span><small>April 14, 2018 </small> | <small> Web Design </small> | <small> <i class="icon-bubble3"></i> 4</small></span> -->
<!-- 									<h3><a href="blog.html">Renovating National Gallery</a></h3> -->
<!-- 									<p>Separated they live in Bookmarksgrove right at the coast of the Semantics, a large language ocean.</p> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<div class="col-md-4 col-sm-6 animate-box" data-animate-effect="fadeInRight"> -->
<!-- 							<div class="blog-entry"> -->
<!-- 								<a href="blog.html" class="blog-img"><img src="images/blog-2.jpg" class="img-responsive" alt="HTML5 Bootstrap Template by colorlib.com"></a> -->
<!-- 								<div class="desc"> -->
<!-- 									<span><small>April 14, 2018 </small> | <small> Web Design </small> | <small> <i class="icon-bubble3"></i> 4</small></span> -->
<!-- 									<h3><a href="blog.html">Wordpress for a Beginner</a></h3> -->
<!-- 									<p>Separated they live in Bookmarksgrove right at the coast of the Semantics, a large language ocean.</p> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<div class="col-md-4 col-sm-6 animate-box" data-animate-effect="fadeInLeft"> -->
<!-- 							<div class="blog-entry"> -->
<!-- 								<a href="blog.html" class="blog-img"><img src="images/blog-3.jpg" class="img-responsive" alt="HTML5 Bootstrap Template by colorlib.com"></a> -->
<!-- 								<div class="desc"> -->
<!-- 									<span><small>April 14, 2018 </small> | <small> Inspiration </small> | <small> <i class="icon-bubble3"></i> 4</small></span> -->
<!-- 									<h3><a href="blog.html">Make website from scratch</a></h3> -->
<!-- 									<p>Separated they live in Bookmarksgrove right at the coast of the Semantics, a large language ocean.</p> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					<div class="row"> -->
<!-- 						<div class="col-md-12 animate-box"> -->
<!-- 							<p><a href="#" class="btn btn-primary btn-lg btn-load-more">Load more <i class="icon-reload"></i></a></p> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</section> -->

<!-- 			<section class="colorlib-contact" data-section="contact"> -->
<!-- 				<div class="colorlib-narrow-content"> -->
<!-- 					<div class="row"> -->
<!-- 						<div class="col-md-6 col-md-offset-3 col-md-pull-3 animate-box" data-animate-effect="fadeInLeft"> -->
<!-- 							<span class="heading-meta">Get in Touch</span> -->
<!-- 							<h2 class="colorlib-heading">Contact</h2> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					<div class="row"> -->
<!-- 						<div class="col-md-5"> -->
<!-- 							<div class="colorlib-feature colorlib-feature-sm animate-box" data-animate-effect="fadeInLeft"> -->
<!-- 								<div class="colorlib-icon"> -->
<!-- 									<i class="icon-globe-outline"></i> -->
<!-- 								</div> -->
<!-- 								<div class="colorlib-text"> -->
<!-- 									<p><a href="#">info@domain.com</a></p> -->
<!-- 								</div> -->
<!-- 							</div> -->

<!-- 							<div class="colorlib-feature colorlib-feature-sm animate-box" data-animate-effect="fadeInLeft"> -->
<!-- 								<div class="colorlib-icon"> -->
<!-- 									<i class="icon-map"></i> -->
<!-- 								</div> -->
<!-- 								<div class="colorlib-text"> -->
<!-- 									<p>198 West 21th Street, Suite 721 New York NY 10016</p> -->
<!-- 								</div> -->
<!-- 							</div> -->

<!-- 							<div class="colorlib-feature colorlib-feature-sm animate-box" data-animate-effect="fadeInLeft"> -->
<!-- 								<div class="colorlib-icon"> -->
<!-- 									<i class="icon-phone"></i> -->
<!-- 								</div> -->
<!-- 								<div class="colorlib-text"> -->
<!-- 									<p><a href="tel://">+123 456 7890</a></p> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<div class="col-md-7 col-md-push-1"> -->
<!-- 							<div class="row"> -->
<!-- 								<div class="col-md-10 col-md-offset-1 col-md-pull-1 animate-box" data-animate-effect="fadeInRight"> -->
<!-- 									<form action=""> -->
<!-- 										<div class="form-group"> -->
<!-- 											<input type="text" class="form-control" placeholder="Name"> -->
<!-- 										</div> -->
<!-- 										<div class="form-group"> -->
<!-- 											<input type="text" class="form-control" placeholder="Email"> -->
<!-- 										</div> -->
<!-- 										<div class="form-group"> -->
<!-- 											<input type="text" class="form-control" placeholder="Subject"> -->
<!-- 										</div> -->
<!-- 										<div class="form-group"> -->
<!-- 											<textarea name="" id="message" cols="30" rows="7" class="form-control" placeholder="Message"></textarea> -->
<!-- 										</div> -->
<!-- 										<div class="form-group"> -->
<!-- 											<input type="submit" class="btn btn-primary btn-send-message" value="Send Message"> -->
<!-- 										</div> -->
<!-- 									</form> -->
<!-- 								</div> -->
								
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</section> -->
<!-- 나머지 메뉴 틀 주석 처리 - 낙원 : 1007 [E] -->

		</div><!-- end:colorlib-main -->
	</div><!--  end:container-wrap-->
	</div><!-- end:colorlib-page -->

	<!-- jQuery -->
<script src="js/jquery.min.js"></script>
<!-- jQuery Easing -->
<script src="js/jquery.easing.1.3.js"></script>
<!-- Bootstrap -->
<!-- <script src="js/bootstrap.min.js"></script> -->
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
	 });
	 
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
	 	 });
	
	
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
		 });	
	
	
</script>
<script src="${pageContext.request.contextPath}/css/default.css"></script>
<style>
#myinfo,.favorite{font-size: 2em;padding:20px 20px;margin:0 auto;}
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
#infoup{width:500px;margin-top: 20px;}
li>a{font-size: 1.5em;}
table#favoriteGenre {
    border-collapse: collapse;
    text-align: center;
    line-height: 1.5;
    border: 1px solid #ccc;
    margin: 20px 10px;
}
table#favoriteGenre thead {
    border-right: 1px solid #ccc;
    border-left: 1px solid #ccc;
    background: #e7708d;
}
table#favoriteGenre thead th {
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    color: #fff;
}
table#favoriteGenre tbody th {
    width: 150px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
    background: #fcf1f4;
}
/* table#favoriteGenre td { */
/*     width: 150px; */
/*     padding: 10px; */
/*     vertical-align: top; */
/*     border-bottom: 1px solid #ccc; */
/* } */
table#favoriteNation {
    border-collapse: collapse;
    text-align: center;
    line-height: 1.5;
    border: 1px solid #ccc;
    margin: 20px 10px;
}
table#favoriteNation thead {
    border-right: 1px solid #ccc;
    border-left: 1px solid #ccc;
    background: #e7708d;
}
table#favoriteNation thead th {
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    color: #fff;
}
table#favoriteNation tbody th {
    width: 150px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
    background: #fcf1f4;
}
/* table#favoriteNation td { */
/*     width: 150px; */
/*     padding: 10px; */
/*     vertical-align: top; */
/*     border-bottom: 1px solid #ccc; */
/* } */
fieldset{margin-left:50px;min-width: 1200px;}
#favoriteGenre,#favoriteNation{font-size: 1.5em;padding:20px 20px;margin:0 auto;float:left;}
/* #favoriteNation{margin:0px auto;} */
/* #nationList{float:left;text-align: center;margin:0px auto;padding-right: 25%} */
.director{float:left;}
.favoriteDirector{margin-right:1em;float:left;display: block;text-align: center;}
.poster img{
	width: 250px;
	height:350px;
	text-align: center;
	
}
.poster{
	width: 250px;
	text-align: center;
	background-repeat: no-repeat;
}
.title{
	width: 250px;
	text-overflow: ellipsis;
	white-space: nowrap;
	overflow: hidden;
	text-align: center;
}
.grade{
	width: 250px;
	text-overflow: ellipsis;
	white-space: nowrap;
	overflow: hidden;
	text-align: center;
}
ul {list-style: none;}



.gradeList{height:100%;}
h2 {font-size:15px;}
/* .star-rating {width:304px; } */
.wrap-star{margin-left:-24px;}
.star-rating {width:304px;transform:scale(0.4); }
.star-rating,.star-rating span {display:inline-block; height:55px; overflow:hidden; background:url(img/star.png)no-repeat;}
.star-rating span{background-position:left bottom; line-height:0; vertical-align:top;margin:0 auto;}

#jb-container {
	width: 100%;
	height: 100%;
	margin: 0 auto;
/* 	padding: 20px; */
/* 	border: 1px solid #bcbcbc; */
	background-color: #2E2E2E;
}



#jb-sidebar-left {
	width: 300px;
	height: 100%;
	text-align: center;
/* 	padding: 20px; */
/* 	margin-right: 20px; */
/* 	margin-bottom: 20px; */
	float: left;
/* 	color: #FFFFFF; */
/* 	border: 1px solid #bcbcbc; */
}

#jb-content {
	height: 100%;
	width: 100%-300px;
	padding: 20px;
	margin-bottom: 20px;
	float: left;
/* 	color: #FFFFFF; */
/* 	border: 1px solid #bcbcbc; */
}



</style>
</body>
</html>