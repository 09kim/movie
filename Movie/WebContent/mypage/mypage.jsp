<%@page import="member.vo.MemberBean"%> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    MemberBean memberBean = (MemberBean)request.getAttribute("memberBean");
    String nick = (String)session.getAttribute("nick");
	%>
<!DOCTYPE html>
<html>
<head>
<script src="../../../Movie/js/jquery-3.5.1.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var sortData = [];
		var sortData2 = [];
		var nick = $('#nick').val();
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
									$('.genre').append(item.key +" : "+item.value+ "개  " +count.toFixed(1)+"점 <br>");
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
						$('.nation').append(idx2 +" : "+item2.nation+"개 "+ count.toFixed(1) +"점 <br>"); 
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
					
					$('.director').append(item.director);
				});
				
			}
		});
		
	});
</script>
<meta charset="UTF-8">
<title>MyPage - MyPage</title>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/mypageboard.css" rel="stylesheet" type="text/css">
</head>
<body>
<!-- 헤더 -->
<jsp:include page="/inc/top.jsp" />
<div class="clear"></div> 
<!-- 헤더 -->

<section id="main">
	<!-- 왼쪽메뉴 -->
	<div id="sub_menu"> 
		<ul>
			<li><a href="Mypage.mp">마이 페이지</a></li>
			<li><a href="MypageGrade.mp">평가한 영화</a></li>
			<li><a href="MypageWish.mp">좋아요 누른 영화</a></li>
			<li><a href="BoardReviewList.bo">리뷰</a></li>
            
		</ul> 
	</div> 
	
<!-- 	여기부분 자꾸 NullPoniter 뜸 -->
	<div id="myinfo">
		이메일
		<input type="email" id="email" name="email" value="<%=memberBean.getEmail()%>"><br>
		닉네임
		<input type="text" id="nick" name="nick" value="<%=nick%>" ><br>
		소개
		<input type="text" id="infoup" name="info"><br>
		<a href="MypageForm.mp">프로필수정</a>
		<div class="favorite">
		<fieldset>
		<legend>선호 장르</legend>
		<span class="genre"></span>
		</fieldset>
		<fieldset>
		<legend>선호 국가</legend>
		<span class="nation"></span>
		</fieldset>
		<fieldset>
		<legend>선호 감독</legend>
		<span class="director"></span> 
		</fieldset>
		</div>			
	</div>
<%-- <jsp:include page="/mypage/grade_list.jsp"/> --%> 
</section>
</body>
</html>