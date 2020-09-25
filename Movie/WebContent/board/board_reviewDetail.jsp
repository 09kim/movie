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
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/mypagewish.css" rel="stylesheet" type="text/css">
<script src="../../../Movie/js/jquery-3.5.1.js"></script>
<script src="../../../Movie/js/jquery-ui.js"></script>
<script type="text/javascript">

$(document).ready(function() {
	
	var nick = $('#nick').val()
    var movieSeq = $("#movieSeq").val();
    var idx = $('#idx').val();
    var returnReply = $('#returnReply').val();
    
    $("#replyBtn").on("click", function() {
			
        var reply = $('#replyContent').val();
					
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
				alert("댓글 작성 완료");
				
//              location.href="BoardReviewDetail.bo?movieSeq=" + $('#movieSeq').val() + "&idx=" + $('#idx').val();
	
				location.reload();
				
			}
			
		});
	});
	
});



</script>
</head>
<body>
<input type="hidden" id="idx" value="<%=reviewBean.getIdx() %>">
<input type="hidden" id="movieSeq" value="<%=reviewBean.getMovieSeq() %>">
<input type="hidden" id="nick" value="<%=nick %>">

<jsp:include page="/inc/top.jsp" />
<div class="clear"></div>

   
    <h1>댓글</h1>
<div>No. - <%=reviewBean.getIdx() %></div>
<div>영화제목 - <%=reviewBean.getTitle() %></div>
<div>별점 - <%=reviewBean.getGrade() %></div>
<div>영화번호 - <%=reviewBean.getMovieSeq() %></div>
<div>리뷰내용 - <%=reviewBean.getContent() %></div>


    <div>
        <textarea rows="5" cols="30" id="replyContent"></textarea>
        <input type="button" value="댓글쓰기" id="replyBtn" >
    
		<input type="button" id ="updateReply" value="수정">
	    <input type="button" id ="deleteReply" value="삭제">
    </div>
<hr>
<div id="replyShow"></div>


<h3><%=reviewBean.getTitle() %> 리뷰의 댓글</h3>

<%if(replyList!=null){ %>

	<%for(ReplyBean rb : replyList) { %>
	    <div>닉네임 - <%=rb.getNick() %></div>
	    <div>댓글 - <%=rb.getReply() %></div>
	    <div>날짜 - <%=rb.getDate() %></div>
	    <hr>
    <%} %>
<%} %>

</body>
</html>