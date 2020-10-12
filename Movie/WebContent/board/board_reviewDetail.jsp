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
<link href="${pageContext.request.contextPath}/css/jquery-ui.css" type="text/css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/moviecss/movie.css" type="text/css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/mypagewish.css" rel="stylesheet" type="text/css">
<script src="../../../Movie/js/jquery-3.5.1.js"></script>
<script src="../../../Movie/js/jquery-ui.js"></script>
<script type="text/javascript">

$(document).ready(function() {
	
	var nick = $('#nick').val()
    var movieSeq = $("#movieSeq").val();
    var idx = $('#idx').val();
    
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
//              location.href="BoardReviewDetail.bo?movieSeq=" + $('#movieSeq').val() + "&idx=" + $('#idx').val();
				location.reload();
				
<%-- 				var out = "<%=session.getAttribute("out") %>"; --%>
//                 if(out == "out") {
//                     alert("댓글을 등록하세요");
//                 }
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
<br>

    <div>
        <textarea rows="5" cols="30" id="replyContent"></textarea>
        <input type="button" value="댓글쓰기" id="replyBtn" >
    </div>
<br>
<div id="replyShow"></div>


<h3><%=reviewBean.getTitle() %> 리뷰의 댓글</h3>
<br>

<%if(replyList != null){ %>

	<%for(ReplyBean rb : replyList) { %>
	
	   <!-- 신고자 10명 넘으면 글 안보임 -->
	   <%if(rb.getReport() < 10) { %>
	   
	   
		    <div><%=rb.getNick() %>님의 댓글 : <%=rb.getReply() %> (<%=rb.getDate() %>)
		    
		    <%if(nick.equals(rb.getNick())) { %>
				&nbsp; <input type="button" id="updateReply_<%=rb.getIdx() %>" value="수정">
			    <input type="button" id="deleteReply_<%=rb.getIdx() %>" value="삭제">
		    
	        </div>
	        <hr>  
	        
		    <script type="text/javascript">
		    
		    // 댓글 수정
	        $('#updateReply_<%=rb.getIdx() %>').click(function() {
	            
	            $('#update-message').dialog({
	                modal: true,
	                buttons: {
	                    "수정": function() {
	                        
	                        var nick = $('#nick').val()
	                        var movieSeq = $("#movieSeq").val();
	                        var idx = $('#idx').val();
	                        var reply = $('#replyUpdate').val();
	                        
	                        $.ajax({
	                            url: "BoardReplyUpdate.bo?idx=<%=rb.getIdx() %>",
	                            method: "get",
	                            data: {
	                                idx:idx,
	                                movieSeq:movieSeq,
	                                nick:nick,
	                                reply:reply
	                            },
	                            success: function(data) {
	                            	console.log(reply);
	                            	$('#replyShow').append(reply);
	                                location.reload();
	                            }
	                        });
	                        
	                        $(this).dialog('close');
	                    },
	                    
	                    "취소": function() {
	                        $(this).dialog('close');
	                    }
	                }
	                
	            });
	            
	        });
		    
		    
		    // 댓글 삭제
		    $('#deleteReply_<%=rb.getIdx() %>').click(function() {
		        
		        $('#delete-message').dialog({
		            modal: true,
		            buttons: {
		                "삭제": function() {
		                    
		                	var nick = $('#nick').val()
		                    var movieSeq = $("#movieSeq").val();
		                    var idx = $('#idx').val();
		                    var reply = $('#replyContent').val();
		                    
		                    $.ajax({
		                        url: "BoardReplyDelete.bo?idx=<%=rb.getIdx() %>",
		                        method: "get",
		                        data: {
		                            idx:idx,
		                            movieSeq:movieSeq,
		                            nick:nick,
		                            reply:reply
		                        },
		                        success: function(data) {
		                            location.reload();
		                        }
		                    });
		                    
		                    $(this).dialog('close');
		                },
		                
		                "취소": function() {
		                    $(this).dialog('close');
		                }
		            }
		            
		        });
		        
		    });
		    
	
		    </script>
		    
		    <%} else {%>
	            &emsp;&emsp; <input type="button" id="reportReply_<%=rb.getIdx() %>" value="댓글신고">
	            <hr>
	           
	           <script type="text/javascript">
	
	           // 댓글 신고버튼
	           $('#reportReply_<%=rb.getIdx() %>').click(function() {
	        	   
	//         	   var report = $('#report').val();
	               
	               $('#report-message').dialog({
	                   modal: true,
	                   buttons: {
	                       "댓글 신고": function() {
	                           
	                           var nick = $('#nick').val()
	                           var movieSeq = $("#movieSeq").val();
	                           var idx = $('#idx').val();
	                           var reply = $('#replyContent').val();
	                           
	                           $.ajax({
	                               url: "BoardReplyReport.bo?idx=<%=rb.getIdx() %>",
	                               method: "get",
	                               data: {
	                                   idx:idx,
	                                   movieSeq:movieSeq,
	                                   nick:nick,
	                                   reply:reply
	                               },
	                               success: function(data) {
	                                   location.reload();
	                                   
	                                   var out = "<%=session.getAttribute("out") %>";
	                                   
	                                   if(out == "out") {
	                                	   alert("신고 하셨습니다");
	                                	   location.reload();
	                                   }
	                               }
	                           });
	                           
	                           $(this).dialog('close');
	                       },
	                       
	                       "취소": function() {
	                           $(this).dialog('close');
	                       }
	                   }
	                   
	               });
	               
	           });
	           
	           </script>
		    
		    <%} %>
		    
		<%} %>    
	    
    <%} %>
    
<%} %>

<div id="dialog-message" title="선택하세요" style="display:none">
    댓글을 남기시려면 로그인이 필요해요. <br>
    회원가입 또는 로그인하고 댓글을 남겨보세요.
</div>

<div id="update-message" title="댓글 수정" style="display:none">
    <textarea id="replyUpdate" name="replyUpdate" cols="30" rows="5"></textarea>
     댓글을 수정해주세요.
</div>

<div id="delete-message" title="댓글 삭제" style="display:none">
    삭제 하시겠습니까?
</div>

<div id="report-message" title="댓글 신고" style="display:none">
    이 댓글을 신고 하시겠습니까?
</div>

</body>
</html>