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
    
    $(function() {
    	
    	$("#replyContent").on('keyup', function() {
    		var able = true;
    		able = $(this).val().length > 0 ? false : true;
    		
    		$("replyBtn").attr("disabled", able);
			
		});
		
	});
    
    // 댓글 쓰기
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
    
    // 댓글 수정
    $("#updateReply").on("click", function() {
    	
    	var reply = $('#replyContent').val();
    	
    	$.ajax({
            url: "BoardReplyUpdate.bo",
            method: "get",
            data: {
                idx:idx,
                movieSeq:movieSeq,
                nick:nick,
                reply:reply
            },
            success: function(data) {
                
                $('#replyShow').append(data);
                alert("댓글 수정 완료");
                
                location.reload();
            }
            
        });
		
	});
    
    // 댓글 삭제
//     $('#deleteReply').click(function() {
		
//     	$('#delete-message').dialog({
//     		modal: true,
//     		buttons: {
//     			"삭제": function() {
    				
// 					var reply = $('#replyContent').val();
					
// 					$.ajax({
// 			            url: "BoardReplyDelete.bo",
// 			            method: "get",
// 			            data: {
// 			                idx:idx,
// 			                movieSeq:movieSeq,
// 			                nick:nick,
// 			                reply:reply
// 			            },
// 			            success: function(data) {
// 			                location.reload();
// 			            }
// 			        });
					
// 					$(this).dialog('close');
// 				},
				
// 				"취소": function() {
// 					$(this).dialog('close');
// 				}
//     		}
    		
//     	});
    	
// 	});

	
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
<br>

    <div>
        <textarea rows="5" cols="30" id="replyContent"></textarea>
<!--         <input type="text" size="60" id="replyContent" > -->
        <input type="button" value="댓글쓰기" id="replyBtn" >
<!--         <button type="submit" id="replyBtn" disabled="disabled">댓글쓰기</button> -->
    </div>
<hr>
<div id="replyShow"></div>


<h3><%=reviewBean.getTitle() %> 리뷰의 댓글</h3>

<%if(replyList != null){ %>

	<%for(ReplyBean rb : replyList) { %>
	    <div><%=rb.getNick() %>님의 댓글 : <%=rb.getReply() %> (<%=rb.getDate() %>)
	    
	    <%if(nick.equals(rb.getNick())) { %>
			<input type="button" id="updateReply_<%=rb.getRe_ref() %>" value="수정">
		    <input type="button" id="deleteReply_<%=rb.getRe_ref() %>" value="삭제">
	    <%} %>
        </div>
        <hr>  
        
	    <script type="text/javascript">
	    
	    // 댓글 삭제
	    $("#deleteReply_<%=rb.getRe_ref() %>").click(function() {
	        
	      var reply = $('#replyContent').val();
	        
	        $.ajax({
	            url: "BoardReplyDelete.bo",
	            method: "get",
	            data: {
	                idx:idx,
	                movieSeq:movieSeq,
	                nick:nick,
	                reply:reply
	            },
	            success: function(data) {
	                
	                 $('#replyShow').append(data);
	                alert("댓글 삭제 완료");
	                
	                location.reload();
	            },
	            error: function(data) {
	            	console("에러");
				}
	            
	        });
	        
	    });
	    
	    </script>
	    
    <%} %>
    
<%} %>


<div id="delete-message" title="댓글" style="display:none">
    삭제 하시겠습니까?
</div>

</body>
</html>