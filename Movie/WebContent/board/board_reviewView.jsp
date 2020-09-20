<%@page import="java.util.ArrayList"%>
<%@page import="board.vo.ReviewBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
ArrayList<ReviewBean> reviewList = (ArrayList<ReviewBean>)request.getAttribute("reviewList");
String nick = (String)session.getAttribute("nick"); 

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/moviecss/movie.css" rel="stylesheet" type="text/css">
<script src="../../../Movie/js/jquery-3.5.1.js"></script>
<script src="../../../Movie/js/jquery-ui.js"></script>
<script type="text/javascript">

   $(document).ready(function(){

         var name = $("#na").val();
         var movieSeq = $("#movieSeq").val();
         var query = $("#query").val();
         var keyword = $("#keyword").val();
         var nick = $('#nick').val()
         var refreshUrl = document.location.href;       
         
                 
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

         
         $('#reply').click(function(){
            cmtBtn();
         });

        
         var returnCmt = $('#returnCmt').val();
         function cmtBtn() {
             
             var typeName = $('#typeName').val();
             
             
             $('#dialog-comment').dialog({
                 modal: true,
                 buttons: {
                     "작성":function() { 
                         var comment = $('#opinion').val(); 
                        $.ajax({
                            url:"MovieReview.mo",  
                            method:"get",
                            data:{comment:comment,
                                  nick:nick,
                                  movieSeq:movieSeq,
                                  typeName:typeName 
                                  },
                                  success:function(data) {
                                    $('#review').append(data);
                                  }
                                
                        });
                        
                        $(this).dialog('close');
                     
                     },
                     
                     "취소":function() {$(this).dialog('close'); },
                 }
             
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
                <div>좋아요 - <%=reviewList.get(i).getLike_count() %></div>
                <hr>
                <div>좋아요수  댓글수</div>
                <hr>
                <input id="like" name="like" type="button" value="좋아요">
                <input id="reply" name="reply" type="button" value="댓글쓰기">
                <hr>
                
            <%
            }
            %>   
            
    <div id="dialog-reply" title="댓글" style="display:none">
        <textarea id="opinion" name="opinion" cols="30" rows="5"></textarea>
        이 리뷰에 대한 <%=nick %> 님의 댓글을 남겨주세요.
    </div>            
            
            
</body>
</html>