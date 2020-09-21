<%@page import="board.vo.ReplyBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.vo.ReviewBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
ArrayList<ReviewBean> reviewList = (ArrayList<ReviewBean>)request.getAttribute("reviewList");
ArrayList<ReplyBean> replyList = (ArrayList<ReplyBean>)request.getAttribute("replyList");
String nick = (String)session.getAttribute("nick"); 
int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));

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

   $(document).ready(function(){
	   
	   var movieSeq = $("#movieSeq").val();
       var nick = $('#nick').val()
       var reply = $('#reply').val();
	   
         function selectBtn() { 
             $('#dialog-reply').dialog({
                 modal: true,
                 buttons: {
                     "로그인":function() {location.href="MemberLoginForm.me" },
                     "회원가입":function() {location.href="MemberJoinForm.me" },
                     "취소":function() {$(this).dialog('close'); },
                 }
             
             }); 
            
         }

         
         
         $('.replyWrite').click(function(){
            replyBtn();
         });

        
         var returnReply = $('#returnReply').val();
         function replyBtn() {
//         	 alert("제발");
        	 var $replyWrite = $('.replyWrite').on('click', function() {
                 var idx = $replyWrite.index(this); 
//                  alert("idx : " + idx);
	             $('#dialog-reply').dialog({
	                 modal: true,
	                 buttons: {
	                     "작성":function() { 
	                         var reply = $('#opinion').val();
	                         var nick = $('#nick').val();
	                         var movieSeq = $('#movieSeq').val();
	                         idx = $replyWrite.index(this); 
	//                          alert(reply);
	//                          alert(nick);
	//                          alert(movieSeq);
	                         
	                         $.ajax({
	                            url:"BoardReply.bo",  
	                            method:"get",
	                            data:{reply:reply,
	                                  nick:nick,
	                                  movieSeq:movieSeq,
	                                  },
	                                  success:function(data) {
	                                    $('#reply').eq(idx).append(data);
	                                  }
	                                
	                        });
	                        
	                        $(this).dialog('close');
	                     
	                     },
	                     
	                     "취소":function() {$(this).dialog('close'); },
	                 }
	             
	             }); 
           }); 
             
             
             
            
         }
         
   });
      
</script>
</head>
<jsp:include page="/inc/top.jsp" /><br><br>
<div class="clear"></div>
<body>
    <h2>리뷰내용 상세보기</h2>
<%--         <%=reviewList.get(0).getNick() %> --%>
         <%
            for(int i = 0; i < reviewList.size(); i++) {
            %>
                <div>닉네임 - <%=reviewList.get(i).getNick() %></div>
                <div>별점 - <%=reviewList.get(i).getGrade() %></div>
                <div>내용 - <%=reviewList.get(i).getContent() %></div>
                <hr>
                <div>좋아요 - <%=reviewList.get(i).getLike_count() %></div>
<%--                 <div>댓글수 - <%=replyList.get(i).getReply_count() %></div> --%>
                <hr>
                <div id="reply"></div>
                <hr>
                <input id="like_count" name="like_count" type="button" value="좋아요">
                <input id="replyWrite" name="replyWrite" class="replyWrite" type="button" value="댓글쓰기">
                <hr>
                
            <%
            }
            %>   
    
    <input type="hidden" value="<%=nick %>" id="nick">        
    <input type="hidden" value="<%=movieSeq %>" id="movieSeq">        
    <div id="dialog-reply" title="댓글" style="display:none">
        <textarea id="opinion" name="opinion" cols="30" rows="5"></textarea>
        이 리뷰에 대한 <%=nick %> 님의 댓글을 남겨주세요.
    </div>            
            
            
</body>
</html>