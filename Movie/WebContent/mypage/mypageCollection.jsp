<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    String nick = (String)session.getAttribute("nick");

	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/jquery-ui.css" type="text/css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/mypageboard.css" rel="stylesheet" type="text/css">
<script src="../../../Movie/js/jquery-3.5.1.js"></script>
<script src="../../../Movie/js/jquery-ui.js"></script>
<script type="text/javascript">
  
  $(document).ready(function() {
	  
	  $('#addCollectionBtn').click(function(){
		  $('#search').dialog({
			  modal:true,
			  buttons {
				  검색
			  $('#searchBtn').click(function(){
		  		$.ajax({
		  				url:MovieDetail.mo
		  				
		  			});
		  		});
			  }
		  }); 
	  });
	  
	  
  });

</script>
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
			<li><a href="MypageForm.mp">마이 페이지</a></li> 
			<li><a href="MypageGrade.mp">평가한 영화</a></li>
			<li><a href="MypageWish.mp">좋아요 누른 영화</a></li>
			<li><a href="BoardReviewList.bo">리뷰</a></li>
			<li><a href="MypageCollection.mp">컬렉션</a></li>
		</ul> 
	</div> 
	<!-- 왼쪽메뉴 -->
	<input type="button" id="addCollectionBtn" value="컬렉션 추가하기">
	
	<div id="search" style="display:none">
			<input type="text" name="query" id="query">
			<input type="submit" value="검색" id="searchBtn">
	</div>
	
		
	</section>
</body>
</html>