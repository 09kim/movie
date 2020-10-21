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

<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-ui.js"></script>

</head>
<body>
	<!-- 헤더 -->
	<div style="width:100%;position: sticky !important;top:0;z-index: 100;">
		<jsp:include page="/inc/top.jsp"/>
		<div class="clear"></div>
	</div>
	<!-- 헤더 -->
	
    <h2 class="stick-h2">리뷰 상세보기</h2>
    <%for(ReviewBean rl : reviewList) { %>
    <h3 class="stick-h3"> <a href="javascript:history.back()">◀ </a><%=rl.getTitle() %> </h3>
    <%} %>
        
	<%for(ReviewBean rl : reviewList) { %>
	
	   <!-- 신고자 10명 넘으면 글 안보임 -->
       <%if(rl.getReport() < 10) { %>
	       <nav class="veiw" style="background-color: #e2e2e2; margin: 20px auto; width: 40%; border-radius: 10px;">
	           <br>
			   <div class="reviewNick"><%=rl.getNick() %></div>
			   <hr>  
			   <div class="reviewStar">★ <%=rl.getGrade() / 2.0  %></div>
			   <div class="reviewContent"><%=rl.getContent() %></div>
			   <hr>
			   <div class="reviewReport">좋아요 <%=rl.getLike_count() %>  신고 <%=rl.getReport()%>
			    <input class="reviewBtn1" type="button" id="likeBtn_<%=rl.getIdx() %>" value="좋아요">
                <input class="reviewBtn2" type="button" id="reportBtn_<%=rl.getIdx() %>" value="신고하기">
			   </div>
			   <hr>
			   <div class="replyForward">
<%-- 			     <a href="BoardReviewDetail.bo?movieSeq=<%=rl.getMovieSeq() %>&idx=<%=rl.getIdx() %>" id="replyLogin_<%=rl.getIdx() %>"> 댓글</a> --%>
			     <a href="javascript:void(0)" id="replyLogin_<%=rl.getIdx() %>">
			         <input type="hidden" id="replyHref_<%=rl.getIdx() %>" value="BoardReviewDetail.bo?movieSeq=<%=rl.getMovieSeq() %>&idx=<%=rl.getIdx() %>"> 댓글</a>
			         <br><br>
			   </div>
		   </nav>
		   
		   <script type="text/javascript">
		   
		   $(document).ready(function() {
			   
			   var nick = $('#nick').val();
			
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
			                    }
			            }
			        
			        }); 
			       
			    }
			   
			   // 댓글 클릭했을 때
               $('#replyLogin_<%=rl.getIdx() %>').click(function() {
                   
            	   var href = $('#replyHref_<%=rl.getIdx() %>').val();
                   
                   if(nick == 'null'){
                       selectBtn();
                       
                   } else {
                	   location.href=href;
                   }
               });
			   
		        // 리뷰 좋아요 버튼
		        $('#likeBtn_<%=rl.getIdx() %>').click(function() {
		        	
		        	if(nick != 'null'){
		        	
			            $('#like-message').dialog({
			                modal: true,
			                buttons: {
			                    "좋아요": function() {
			                        
			                        var movieSeq = $("#movieSeq").val();
			                        var idx = $('#idx').val();
			                        
			                        $.ajax({
			                              url: "BoardReviewLike.bo?idx=<%=rl.getIdx() %>",
				                          method: "get",
				                          data: {
				                              idx:idx,
				                              movieSeq:movieSeq,
				                              nick:nick,
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
			            
		        	} else { 
		        		selectBtn();
		        	}   
		        });
		        
		        
		     // 리뷰 신고하기 버튼
	            $('#reportBtn_<%=rl.getIdx() %>').click(function() {
	            	
                    if(nick != 'null'){
	                   
		                $('#report-message').dialog({
		                    modal: true,
		                    buttons: {
		                        "신고": function() {
		                            
		                            var movieSeq = $("#movieSeq").val();
		                            var idx = $('#idx').val();
		                            
		                            $.ajax({
		                                  url: "BoardReviewReport.bo?idx=<%=rl.getIdx() %>",
		                                  method: "get",
		                                  data: {
		                                      idx:idx,
		                                      movieSeq:movieSeq,
		                                      nick:nick,
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
		                
                    } else {
                    	selectBtn();
                    }
	            });
	        
		   });
	        
        </script>
        
        <%} %>
	   
    <%} %>
 
<input type="hidden" id="movieSeq" value="<%=movieSeq %>">
<input type="hidden" id="nick" value="<%=nick %>">

<div id="dialog-message" title="선택하세요." style="display:none">
    로그인이 필요해요. <br>
    회원가입 또는 로그인 해주세요.
</div>
 
<div id="like-message" title="좋아요" style="color:#000000 !important; display:none">
    이 댓글을 좋아요 하시겠습니까?
</div>

<div id="report-message" title="신고" style="color:#000000 !important; display:none">
    이 댓글을 신고 하시겠습니까?
</div>



<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/mypagewish.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/jquery-ui.css" type="text/css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/moviecss/movie.css" type="text/css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/reviewView.css" type="text/css" rel="stylesheet">           
<link href="${pageContext.request.contextPath}/css/movie_detail.css" type="text/css" rel="stylesheet">           
</body>
</html>