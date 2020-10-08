<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String nick=(String)session.getAttribute("nick");
%>
<%-- <script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script> --%>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>

<header>

<nav class="navbar navbar-expand-lg navbar-light bg-dark">
<!--   <a class="navbar-brand" href="#">Navbar</a> -->
<!--   <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"> -->
<!--     <span class="navbar-toggler-icon"></span> -->
<!--   </button> -->

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
<!--   <div class="collapse navbar-collapse" id="navbarSupportedContent"> -->
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link text-white" href="Main.me">Home<span class="sr-only">(current)</span></a>
      </li>
<!--       <li class="nav-item"> -->
<!--         <a class="nav-link text-white" href="MovieRanking.mo">BoxOffice</a> -->
<!--       </li> -->
      <li class="nav-item">
        <a class="nav-link text-white" href="GradeMovie.mo">Grade</a>
      </li>
<!--       <li class="nav-item dropdown"> -->
<!--         <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> -->
<!--           Dropdown -->
<!--         </a> -->
<!--         <div class="dropdown-menu" aria-labelledby="navbarDropdown"> -->
<!--           <a class="dropdown-item" href="#">Action</a> -->
<!--           <a class="dropdown-item" href="#">Another action</a> -->
<!--           <div class="dropdown-divider"></div> -->
<!--           <a class="dropdown-item" href="#">Something else here</a> -->
<!--         </div> -->
<!--       </li> -->
<!--       <li class="nav-item"> -->
<!--         <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a> -->
<!--       </li> -->
    </ul>
<!--     <form class="form-inline my-2 my-lg-0"> -->
    <form class="form-inline my-2 my-lg-0 mr-5" action="MovieSearch.mo">
<!--       <input class="form-control mr-sm-2" name="query" type="search" placeholder="Search" aria-label="Search"> -->
      <input class="form-control" name="query" type="search" placeholder="Search" aria-label="Search">
<!--       <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button> -->
<!--       <button class="btn btn-primary my-2 my-sm-0 bg-green" type="submit">Search</button> -->
      <button class="btn btn-primary bg-green" type="submit">Search</button>
    </form>
<!--      <ul class="navbar-nav mr-auto"> -->
     <ul class="navbar-nav">
     <%
		if(nick != null && !(request.getServletPath().equals("/member/member_login.jsp"))){ %>
      <li class="nav-item-inline">
      	<a class="nav-link-outline text-white" href="Mypage.mp"><img src="${pageContext.request.contextPath}/img/noProfile.png" class="rounded-circle no-gutters" style="width:20%"></a>
        <a class="nav-link-outline text-white" href="Mypage.mp"><%=nick %> 님</a>
      </li>
      <li class="nav-item">
        <a class="nav-link text-white" href="MemberLogout.me" style="margin-left:-100px">로그아웃</a>
      </li>
      <%
		} else{ %>
		<li class="nav-item">
        <a class="nav-link text-white" href="MemberLoginForm.me">로그인</a>
      </li>
      <li class="nav-item">
        <a class="nav-link text-white" href="MemberJoinForm.me">회원가입</a>
      </li>
      <%
		}
		%>
      </ul>
  </div>
</nav>

</header>