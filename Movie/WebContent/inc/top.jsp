<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header>
<script src="../../../Movie/js/jquery-3.5.1.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	
});
</script>
<style>
nav#top_menu{width: 6200px; margin: 30px 0px;
float: left;}
/*너비 600px 밖여백 50px 20px 0 0 정렬 오른쪽*/
nav#top_menu ul{list-style:none;
font-family: verdana,Geneba,sans-serif;
font-size: 13px;font-weight: 100;color: #333}
/*스타일없음 글자체 verdana,Geneba,sans-serif 
글자크기 13px 글자굵기 100 글자색 #333*/
nav#top_menu li{float: left;margin: 0 5px;}
/*정렬 왼쪽 밖여잭 0 5px*/
nav#top_menu a{display: block; height: 20px;
padding: 10px; text-decoration: none;color: #333}
/*block 높이 20px 안여백 10px 밑줄 없음 글자색 #333*/
nav#top_menu a:hover{
/* background-image:url("../images/blue.gif"); */
background-color: skyblue;
background-repeat: repeat-x;
background-position: bottom;}

#login{float: right;margin: 20px 64px 0 0;
font-family: Arial,Helvetica,sans-serif;
font-size: 12px;word-spacing: 5px}
/*정렬 오른쪽 밖여백 20 64 0 0  
글자체 Arial,Helvetica,sans-serif 크기 12px 
단어간격 5px*/
#login a{text-decoration: none; color: #333}
/* 하이퍼링크 밑줄 없음 글자색 #333*/
#login a:hover{color: #F90}
.clear{clear: both;}
div#search_bar{float: left;}
</style>
<%
String email=(String)session.getAttribute("email");
if(email == null && !(request.getServletPath().equals("/member/member_login.jsp"))){
	%>
	<div id="login"><input type="button" value="로그인" onclick="location.href='MemberLoginForm.me'"></div>
	<div class="clear"></div>
	<%
}else if(email != null && !(request.getServletPath().equals("/member/member_login.jsp"))){
	%>
	<div id="login"><a href="MemberModifyForm.me"><%=email %>님</a>  |
			<input type="button" value="로그아웃" onclick="location.href='MemberLogout.me'"></div>
			<div class="clear"></div>
	<%
}
%>
<div id="search_bar">
<form action="MovieSearch.mo">
<input type="text" name="query">
<input type="submit" value="검색">
</form>
</div>
<div class="clear"></div>
<nav id="top_menu">
<ul>
	<li><a href="Main.me">홈</a></li>
<%
if(email==null){%>
	<li><a href="MemberJoinForm.me">회원가입</a></li>
<%	
}
%>
<!-- 	<li><a href="MemberLoginForm.me">LOGIN</a></li> -->
<%
if(email!=null){%>
			<li><a href="GradeMovie.mo">평점</a></li>
			<%
	if(email.equals("admin")){%>
			<li><a href="MemberList.me">회원목록</a></li>
		<%
		}
}
%>
			
</ul>
</nav>
<div class="clear"></div>

</header>