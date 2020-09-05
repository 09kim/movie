<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header>
<script src="../../../Movie/js/jquery-3.5.1.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	
});
</script>
<style>
.clear{clear: both;} /*영역구분*/

.div-top {
  height: 30px;
  width: 100%;
  padding: 1rem;
  background: snow;
  position:fixed;
  display: flex;
  align-items: center;
  margin: 0 0 20px 0;
}

.div-top li {
    margin: 0 10px 0 0;
    padding: 0 0 0 0;
    border : 0;
    float: left;
}

.div-top ul {
    list-style:none;
    margin:0;
    padding:0;
}

#search_bar {
	position: absolute; 
	right: 0;
	padding : 0 13rem 0 0;
}

#login {
	position: absolute; 
	right: 0;
	padding : 0 4rem 0 0;
}

#login a{
	text-decoration: none; 
	color: #333;
}

</style>

<%
request.setCharacterEncoding("UTF-8");
String nick=(String)session.getAttribute("nick");
%>

<div class="div-top">
   <ul class="ul-top">
      <li>
          <a class="a-home" href="Main.me">홈</a>
      </li>
      <li>
          <a class="a-list" href="MovieRanking.mo">박스오피스</a>
      </li>
      <li>
      	  <a class="a-grade" href="GradeMovie.mo">평점</a>
      </li>
   </ul>


	<div id="search_bar">
		<form action="MovieSearch.mo">
			<input type="text" name="query">
			<input type="submit" value="검색">
		</form>
	</div>
	<div class="clear"></div>
	
	<div id="login">
		<%
		if(nick != null && !(request.getServletPath().equals("/member/member_login.jsp"))){ %>
		<a href="../member/info.jsp"><%=nick %> 님 | </a>
		<a href="MemberLogout.me">로그아웃</a>
		<%
		} else{ %>
		<a href="MemberLoginForm.me">로그인</a>
		 | <a href="MemberJoinForm.me">회원가입</a>
		<%
		}
		%>
	</div>
</div>
</header>