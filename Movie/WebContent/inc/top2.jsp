<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header>
<style>
nav#top_menu{width: 600px; margin: 50px 20px 0 0;
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
background-image:url("../images/blue.gif");
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
</style>
<%
String nick=(String)session.getAttribute("nick");
if(nick == null && !(request.getServletPath().equals("/member/member_login.jsp"))){
	%>
	<div id="login"><input type="button" value="로그인" onclick="location.href='MemberLoginForm.me'"></div>
	<%
}else if(nick != null && !(request.getServletPath().equals("/member/member_login.jsp"))){
	%>
	<div id="login"><a href="MemberModifyForm.me"><%=nick %>님</a>  |
			<input type="button" value="로그아웃" onclick="location.href='MemberLogout.me'">
	<%
}
%>
<div class="clear"></div>
<!-- 로고들어가는 곳 -->
<!-- 로고들어가는 곳 -->
<nav id="top_menu">
<ul>
	<li><a href="Main.me">MAIN</a></li>
<%
if(nick==null){%>
	<li><a href="MemberJoinForm.me">JOIN</a></li>
<%	
}
%>
<!-- 	<li><a href="MemberLoginForm.me">LOGIN</a></li> -->
<%
if(nick!=null){
	if(nick.equals("admin")){%>
			<li><a href="MemberList.me">MEMBERLIST</a></li>
		<%
		}
}
%>
</ul>
</nav>
</header>