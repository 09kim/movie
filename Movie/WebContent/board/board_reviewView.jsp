<%@page import="board.vo.ReplyBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.vo.ReviewBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
// ReviewBean reviewBean = (ReviewBean)request.getAttribute("reviewBean");
ReplyBean replyBean = (ReplyBean)request.getAttribute("replyBean");
ArrayList<ReviewBean> reviewList = (ArrayList<ReviewBean>)request.getAttribute("reviewList");
String nick = (String)session.getAttribute("nick"); 
int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/mypagewish.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/jquery-ui.css" type="text/css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/moviecss/movie.css" type="text/css" rel="stylesheet">
<script src="../../../Movie/js/jquery-3.5.1.js"></script>
<script src="../../../Movie/js/jquery-ui.js"></script>

</head>
<jsp:include page="/inc/top.jsp" /><br><br>
<div class="clear"></div>
<body>
    <h2>리뷰내용 상세보기</h2>
        
	<%for(ReviewBean rl : reviewList) { %>
	
	   <div>닉네임 - <%=rl.getNick() %></div>
	   <div>별점 - <%=rl.getGrade() %></div>
	   <div>내용 - <%=rl.getContent() %></div>
	   <div id="libk_count">좋아요 - <%=rl.getLike_count() %></div>
	   <div id="report">신고 - <%=rl.getReport()%></div>
	   <hr>
	   <input type="button" id="likeBtn_<%=rl.getIdx() %>" value="좋아요">
	   <input type="button" id="reportBtn_<%=rl.getIdx() %>" value="신고하기">
	   <a href="BoardReviewDetail.bo?movieSeq=<%=rl.getMovieSeq() %>&idx=<%=rl.getIdx() %>">댓글</a>
	   <hr>
	   
	   <script type="text/javascript">
	   
	   $(document).ready(function() {
		
		   function selectBtn() { 
		        
		        $('#dialog-message').dialog({
		            modal: true,
		            buttons: {
		                "로그인": function() {
		                    location.href="MemberLoginForm.me"
		                    },
		                "회원가입": function() {
		                    location.href="MemberJoinForm.me"
		                    },
		                "취소": function() {
		                    $(this).dialog('close');
		                    },
		            }
		        
		        }); 
		       
		    }
		   
	        // 리뷰 좋아요 버튼
	        $('#likeBtn_<%=rl.getIdx() %>').click(function() {
	        	
	            $('#like-message').dialog({
	                modal: true,
	                buttons: {
	                    "좋아요": function() {
	                        
	                        var nick = $('#nick').val()
	                        var movieSeq = $("#movieSeq").val();
	                        var idx = $('#idx').val();
	                        var like_count = $('#like_count').val();
	                        
	                        $.ajax({
	                              url: "BoardReviewLike.bo?idx=<%=rl.getIdx() %>",
		                          method: "get",
		                          data: {
		                              idx:idx,
		                              movieSeq:movieSeq,
		                              nick:nick,
		                              like_count:like_count
		                          },
		                          success: function(data) {
		                        	  location.reload();
		                              var out = "<%=session.getAttribute("out") %>";
		                              
		                              if(out == "out") {
		                                  alert("좋아요 누르셨습니다");
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
	        
	     // 리뷰 신고하기 버튼
            $('#reportBtn_<%=rl.getIdx() %>').click(function() {
                   
                $('#report-message').dialog({
                    modal: true,
                    buttons: {
                        "신고": function() {
                            
                            var nick = $('#nick').val()
                            var movieSeq = $("#movieSeq").val();
                            var idx = $('#idx').val();
                            var report = $('#report').val();
                            
                            $.ajax({
                                  url: "BoardReviewReport.bo?idx=<%=rl.getIdx() %>",
                                  method: "get",
                                  data: {
                                      idx:idx,
                                      movieSeq:movieSeq,
                                      nick:nick,
                                      report:report,
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
        
	   });
        
        </script>
	   
    <%} %>
 
<input type="hidden" id="movieSeq" value="<%=movieSeq %>">
<input type="hidden" id="nick" value="<%=nick %>">

 
<div id="like-message" title="좋아요" style="display:none">
    이 댓글을 좋아요 하시겠습니까?
</div>

<div id="report-message" title="신고" style="display:none">
    이 댓글을 신고 하시겠습니까?
</div>
              
</body>
</html>