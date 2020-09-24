<%@page import="java.util.ArrayList"%>
<%@page import="board.vo.ReplyBean"%>
<%@page import="board.vo.ReviewBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
ReviewBean reviewBean = (ReviewBean)request.getAttribute("reviewBean");
ArrayList<ReplyBean> replyList = (ArrayList<ReplyBean>)request.getAttribute("replyList");
String nick = (String)session.getAttribute("nick");

%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../../../Movie/js/jquery-3.5.1.js"></script>
<script src="../../../Movie/js/jquery-ui.js"></script>
<script type="text/javascript">

$(document).ready(function() {
	
	$(function() {
		$("#replyBtn").on("click", function() {
			
	        var reply = $('#replyContent').val();
	        var nick = $('#nick').val()
			var movieSeq = $("#movieSeq").val();
	        var idx = $('#idx').val();
// 					$('#replyShow').append(nick);
					$('#replyShow').append(reply);
					
			$.ajax({
				url: "BoardReplyPro.bo",
				method: "get",
				data: {
					idx:idx,
					movieSeq:movieSeq,
					nick:nick,
					reply:reply
				},
				success: function(data) {
					$('#replyShow').append(data);
					
					location.href="BoardReviewDetail.bo?movieSeq=" + $('#movieSeq').val() + "&idx=" + $('#idx').val();
// 					location.reload();
					
				}
				
			});
		});
	});
	
	
});



</script>
</head>
<body>
    <h1>댓글</h1>
<div>No. - <%=reviewBean.getIdx() %></div>
<div>영화제목 - <%=reviewBean.getTitle() %></div>
<div>별점 - <%=reviewBean.getGrade() %></div>
<div>영화번호 - <%=reviewBean.getMovieSeq() %></div>
<div>리뷰내용 - <%=reviewBean.getContent() %></div>


<div>
    <textarea rows="5" cols="30" id="replyContent"></textarea>
    <input type="button" value="댓글쓰기" id="replyBtn" >
</div>
<input type="hidden" id="idx" value="<%=reviewBean.getIdx() %>">
<input type="hidden" id="movieSeq" value="<%=reviewBean.getMovieSeq() %>">
<input type="hidden" id="nick" value="<%=nick%>">
<hr>
<div id="replyShow"></div>
<h3><%=reviewBean.getTitle() %> 리뷰의 댓글</h3>
<%for(int i = 0; i < replyList.size(); i++) { %>
    <div>닉네임 - <%=replyList.get(i).getNick() %></div>
    <div>댓글 - <%=replyList.get(i).getReply() %></div>
    <div>날짜 - <%=replyList.get(i).getDate() %></div>
    <hr>
<%} %>


</body>
</html>