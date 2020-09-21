<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="${pageContext.request.contextPath}/css/default.css" type="text/css" rel="stylesheet">
<%
request.setCharacterEncoding("UTF-8");
String nick=(String)session.getAttribute("nick");
%>

<header>
<div class="div-top">

	<div id="header-menu">
	   <ul class="ul-top">
	      <li class="top-menu">
	          <a class="a-home" href="Main.me">홈</a>
	      </li>
	      <li class="top-menu">
	          <a class="a-list" href="MovieRanking.mo">박스오피스</a>
	      </li>
	      <li class="top-menu">
	      	  <a class="a-grade" href="GradeMovie.mo">평점</a>
	      </li>
	      <li>
	      	<div id="search_bar">
				<form action="MovieSearch.mo">
					<input type="text" name="query">
					<input type="submit" value="검색">
				</form>
			</div>
	      </li>
	      <li>
			<div id="login">
				<%
				if(nick != null && !(request.getServletPath().equals("/member/member_login.jsp"))){ %>
				<a href="Mypage.mp"><%=nick %> 님 | </a>
				<a href="MemberLogout.me">로그아웃</a>
				<%
				} else{ %>
				<a href="MemberLoginForm.me">로그인</a>
				 | <a href="MemberJoinForm.me">회원가입</a>
				<%
				}
				%>
			</div>
	      </li>
	   </ul>
	</div>

</div>
</header>