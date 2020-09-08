<%@page import="mypage.vo.MypageBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String nick = (String)session.getAttribute("nick"); 
ArrayList<MypageBean> gradeList = (ArrayList<MypageBean>)request.getAttribute("gradeList");
int listCount = (int)request.getAttribute("listCount");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyPage - GradeList</title>
</head>
<body>
<jsp:include page="/inc/top.jsp" />
<br><br><br><br>

내가 평가한 영화 목록 
<%
if(gradeList != null && listCount > 0){
	for(int i=0; i < gradeList.size(); i++){
%>
<span><%=listCount %></span>
<div id="gradelist">
	<ul>
		<li>
			<a>Poster</a>
			<div id="movieInfo">
				<div><%=gradeList.get(i).getTitle() %></div>
				<div><%=gradeList.get(i).getGrade() %></div>
			</div>
			
		</li>
	</ul>

</div>
<%
	}
} else {
%>
평가한 영화 목록이 비어있습니다.
<%
}
%>
</body>
</html>