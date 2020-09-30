<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%String nick = (String)session.getAttribute("nick"); 
String getGrade = (String)request.getAttribute("getGrade"); 
String movieSeq = (String)request.getParameter("movieSeq");
String query = request.getParameter("query");
String returnCmt = (String)request.getAttribute("returnCmt");%>
<%String director=request.getParameter("director"); 
 %>
<meta charset="UTF-8">
<title></title>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/jquery-ui.css" type="text/css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/moviecss/movie.css" type="text/css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/mypagewish.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.min.css">
<script src="../../../Movie/js/jquery-3.5.1.js"></script>
<script src="../../../Movie/js/jquery-ui.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.js"></script>



<script type="text/javascript">
// $(document).keydown(function (e) { // 새로고침 금지
    
//     if (e.which === 116) {
//         if (typeof event == "object") {
//             event.keyCode = 0;
//         }
//         return false;
//     } else if (e.which === 82 && e.ctrlKey) {
//         return false;
//     }
// }); 
   $(document).ready(function(){
      // 영화의 디테일한 내용을 담당하는 Jquery 문
//       $('#btn').click(function(){
         var name = $("#na").val();
         var movieSeq = $("#movieSeq").val();
         var query = $("#query").val();
         var keyword = $("#keyword").val();
         var nick = $('#nick').val()
         var refreshUrl = document.location.href;
        
		 $.ajax('MypageSelectWish.mp',{
			data:{movieSeq:movieSeq},
			async: false,
			success:function(rdata){
				if(rdata=="Y"){
					$('.btn-like').addClass("done")
				} else { // 여기 역시 기본값이 없는 클래스 이기때문에 remove 는 필요없음!
					$('.btn-like').removeClass("done") 
				}
			}
		});
         
         
         function selectBtn() { 
        	 $('#dialog-message').dialog({
        		 modal: true,
        		 buttons: {
        			 "로그인":function() {location.href="MemberLoginForm.me" },
        			 "회원가입":function() {location.href="MemberJoinForm.me" },
        			 "취소":function() {$(this).dialog('close'); },
        		 }
        	 
        	 }); 
        	
         }
         
         
         $('#comment').click(function(){
         	cmtBtn();
         });
         
         
         $.ajax({
            url:"MovieDetail.mo",
            method:"post",
            dataType :"json",
            async: false,
            data:{
               movieSeq:movieSeq,
               query:query,
               keyword:keyword
               },
            success:function(data){
               
               $.each(data.Data,function(idx,item){
                  
                  $.each(item.Result,function(idx,item2){
                     
                     var title = item2.title 
                     var titleNoSpace = title.replace(/ /g, '');
                     var title2 = titleNoSpace.replace(/!HS/g,'')
                     var title3 = title2.replace(/!HE/g,'')
                     var title5 = title3.trim();
                     var image = item2.posters.split("|")
                     var stills = item2.stlls.split("|")
                     var keyword = item2.keywords.split(",")
                     var actors="";
                     
                     
                    
                     $('.btn-like').click(function() {  
                    	 if(nick != 'null'){
                     
            			 $.ajax('MypageChangeWish.mp',{
            					data:{movieSeq:movieSeq,title:title5,poster:image[0]},
            					async: false,
            					success:function(rdata){
            						if(!$('.btn-like').hasClass("done")){
            							$('.btn-like').addClass("done")
            						} else { // 여긴 필요할꺼 같음! if문에 done 이 잇냐 없냐로 체크하기 때문에~
            							$('.btn-like').removeClass("done")
            						}
            					}
            				});
            			} else {selectBtn()}}); 
                     
                     for(var num = 0; num < item2.staff.length ; num++){
                        if(item2.staff.length>11){
                           if(num==11){
                              break;
                           }
                           if(!item2.staff[num].staffRole){
                              actors = actors + item2.staff[num].staffNm + " : "+ item2.staff[num].staffRoleGroup+"<br>";
                           }else{
                           actors = actors + item2.staff[num].staffNm + " : "+ item2.staff[num].staffRole+"<br>";   
                           }
                        }else {
                           if(!item2.staff[num].staffRole){
                              actors = actors + item2.staff[num].staffNm + " : "+ item2.staff[num].staffRoleGroup+"<br>";
                           }else{
                           actors = actors + item2.staff[num].staffNm + " : "+ item2.staff[num].staffRole+"<br>";   
                           }
                        }
                        
                     }
                  
                     
                     
                      
                        function starClick(param,grade,image){
                                  $.ajax("setGrade.mo",{
                                     method:"post",
                                     async: false,
                                     data:{
                                          data:param,
                                          grade:grade,
                                          nick:nick,
                                          image:image
                                          },
                                     success:function(data){
                                    	location.reload();
                                     }
                                  }
                           ) 
                        }   
                     
                     if(nick != 'null') {
                     $.ajax("MovieDetail.mo",{
                        method:"get",
                        dataType :"json",
                        async: false,
                        data:{movieSeq:movieSeq,
                        query:query,
                        keyword:keyword},
                        success:function(data){
                           var grade = 0;
                           $.each(data.Data,function(idx,item){
                              var i =1;
                              var l =1;
                             
                              $.each(item.Result,function(idx,item2){
                                
                                 var num = 0;
                                 var image = item2.posters.split("|")
                                 var title = item2.title
                                 var titleNoSpace = title.replace(/ /g, '');
                                 var title2 = titleNoSpace.replace(/!HS/g,'')
                                 var title3 = title2.replace(/!HE/g,'')
                                 var title5 = title3.trim();
                                 
                                 
                                 
                                 // 10개의 라벨에 각기 다른 값을 부여하기위한 반복문
                                 for(var o=1;o<11;o++){
                                 $('.c'+o).eq(idx).attr("id","p"+i++);
                                 }
                                 // 10개의 라벨에 각기 다른 값을 부여하기위한 반복문
                                 for(var o=1;o<11;o++){
                                 $('.l'+o).eq(idx).attr("for","p"+l++);
                                 }
                                 
                                 var getGrade = $('#getGrade').val()
                                 switch(getGrade){
                                 
                                 case "0.5" :
                                	 $('.l1').focus();
                                	 $('#isGrade').show();
                                	 break;                                 
                                 case "1" :
                                	 $('.l2').focus();
                                	 $('#isGrade').show();
                                	 break;                             
                              	 case "1.5":
                             		 $('.l3').focus();
                             		$('#isGrade').show();
                             	 	 break;
                              	 case "2" :
                              		 $('.l4').focus();
                              		$('#isGrade').show();
                              		 break;
                              	 case "2.5":
                              		 $('.l5').focus();
                              		$('#isGrade').show();
                              		 break;
                              	 case "3" :
                              		 $('.l6').focus();
                              		$('#isGrade').show();
                              		 break;
                              	 case "3.5" :
                              		 $('.l7').focus();
                              		$('#isGrade').show();
                              		 break;
                              	 case "4" :
                              		 $('.l8').focus();
                              		 $('#isGrade').show();
                              		 break;
                              	 case "4.5":
                              		 $('.l9').focus();
                              		 $('#isGrade').show();
                              		 break;
                              	 case "5":
                              		$('.l10').focus();
                              	$('#isGrade').show();
                              	break;
                              	
                              		 }
                              
                             
                                 
                                 var nation = item2.nation.split(",");
                                 $('.c1').eq(idx).val(item2.director[0].directorNm+"/"+nation[0]+"/"+title5+"/"+item2.movieSeq+"/"+item2.runtime+"/"+item2.genre+"/"+item2.prodYear);
                                 var image= image[0];
                                 var garde= 0;
                          		 var movieSeq =""   
                                    $('.c1').eq(idx).click(function(){
                                       var grade=1;
                                       var data = $('.c1').eq(idx).val();
                                       starClick(data,grade,image);
                                      
                                    });
                                    
                                    $('.c2').eq(idx).click(function(){
                                       var grade = 2;
                                       var data = $('.c1').eq(idx).val();
                                       starClick(data,grade,image);
                                      
                                    });
                                    $('.c3').eq(idx).click(function(){
                                       var grade = 3;
                                       var data = $('.c1').eq(idx).val();
                                       starClick(data,grade,image);
                                       
                                    });
                                    
                                    $('.c4').eq(idx).click(function(){
                                       var grade = 4;
                                       var data = $('.c1').eq(idx).val();
                                       starClick(data,grade,image);
                                    });
                                    
                                    $('.c5').eq(idx).click(function(){
                                       var grade = 5;
                                       var data = $('.c1').eq(idx).val();
                                       starClick(data,grade,image); 
                                    });
                                    
                                    $('.c6').eq(idx).click(function(){
                                        var grade = 6;
                                        var data = $('.c1').eq(idx).val();
                                        starClick(data,grade,image);
                                        
                                    });
                                    $('.c7').eq(idx).click(function(){
                                        var grade=7;
                                       var data = $('.c1').eq(idx).val();
                                       starClick(data,grade,image);
                                    });
                                    $('.c8').eq(idx).click(function(){
                                        var grade=8;
                                       var data = $('.c1').eq(idx).val();
                                       starClick(data,grade,image);
                                    });
                                    $('.c9').eq(idx).click(function(){
                                        var grade=9;
                                       var data = $('.c1').eq(idx).val();
                                       starClick(data,grade,image);
                                    });
                                    $('.c10').eq(idx).click(function(){
                                        var grade=10;
                                       var data = $('.c1').eq(idx).val();
                                       starClick(data,grade,image);
                                       
                                    });
                                   
                           
                           });//each문 끝남
                       });
                    }
               })
         } else {  
            $('.l1').click(function(){
            	selectBtn();
            })
            
            $('.l2').click(function(){
               selectBtn();
            	   })
            
            $('.l3').click(function(){
            	selectBtn();  })
            
            $('.l4').click(function(){
            	selectBtn();   })
            
            $('.l5').click(function(){
            	selectBtn();  })
            
            $('.l6').click(function(){
            	selectBtn();   })
            
            $('.l7').click(function(){
            	selectBtn();   })
            
            $('.l8').click(function(){
            	selectBtn();   })
            
            $('.l9').click(function(){
            	selectBtn();  })  
            
            $('.l10').click(function(){
            	selectBtn();  })
             }  
                     director = item2.director[0].directorNm;
                     director = director.replace(/ /g,'');
//                      $('#detail').append('<div class=title>'+title5+'</div>')
                     $('#detail').append('<div class=poster><img style=width:250px;height:350px; src='+image[0]+'></div>');
                     $('#detail').append('<div class=content></div>');
                     $('.content').append('<dl class=info>');
                     $('.content').append('<dt>상영국가</dt>');
                     $('.content').append('<dd>'+item2.nation+'</dd>');
                     $('.content').append('<dt>개봉일</dt>');
                     $('.content').append('<dd>'+item2.repRlsDate+'</dd>');
                     $('.content').append('<dt>상영시간</dt>');
                     $('.content').append('<dd>'+item2.runtime+'</dd>');
                     $('.content').append('<dt>시청 가능 연령</dt>');
                     $('.content').append('<dd>'+item2.rating[0].ratingGrade+'</dd>');
                     $('.content').append('<dt>감독</dt>');
                     $('.content').append('<dd><a href=MovieSearchDirector.mo?director='+director+'>'+item2.director[0].directorNm+'</a></dd>');
                     $('.content').append('<dt>배우</dt>');
                     $('.content').append('<dd>'+actors+'</dd>');
                     $('.content').append('<dt>배급사</dt>');
                     $('.content').append('<dd>'+item2.company+'</dd>');
                     $('.content').append('<dd>'+item2.company+'</dd>');
                    
                     
                     
                     
                     
                     
                     $('#detail').append('<div class=title>'+item2.repRlsDate+'</div>')
                     $('#detail').append('<div class=titleEng>'+item2.titleEng+'</div>')
                     $('#detail').append('<div class=nation>'+item2.nation+'</div>')
                     $('#detail').append('<div class=runtime>'+item2.runtime+'</div>')
                     $('#detail').append('<div class=rating>'+item2.rating[0].ratingGrade+'</div>')
                     $('#detail').append('<div class=runtime>'+item2.genre+'</div>')
                     $('#detail').append('<div class=actors><a href=MovieSearchDirector.mo?director='+director+'>'+item2.director[0].directorNm+'</a></div>')
                     $('#detail').append("<input type='hidden' class ='directorName' value="+ director+ ">")
                     $('#detail').append("<input type='hidden' class ='typeName' value="+ item2.type+ ">")
                     $('#detail').append('<div class=actors>'+actors+'</div>')
                     $('#detail').append('<div class=company>'+item2.company+'</div>')
                     $('#detail').append('<div class=plot>'+item2.plot+'</div>')
                     for(var i in stills){
                     $('#posters').append('<div style=float:left; class=image><img src='+stills[i]+'></div>')
                     }
                        if(keyword[0]!=""||keyword[keyword.length]!=""){
                           
                        for(var i in keyword){
                           
                              $('#keyword').append('<div style=float:left; class=keyword><a href=MovieSearchKeyword.mo?keyword='+keyword[i]+'>#'+keyword[i]+'&nbsp;</div>')
                           }
                           
                        }
                        $('.detailH2').text("영화 "+title5+"의 상세 정보"); 
                        
                        });
               });
            }
            
         });
         
         $.ajax('MovieDirector.mo',{
             method:"post",
             dataType :"json",
             async: false,
             data:{query:director},
             success:function(data){
          	   
                $.each(data.Data,function(idx,item){
                   
                   var count = item.Count
                      
                   $.each(item.Result,function(idx,item2){
                      
                      var title = item2.title
                      var titleNoSpace = title.replace(/ /g, '');
                      var title2 = titleNoSpace.replace(/!HS/g,'')
                      var title3 = title2.replace(/!HE/g,'')
                      var title5 = title3.trim();
                      var actors="";
                      
                      var image = item2.posters.split("|")
                      
                      for(var num = 0; num < item2.actor.length ; num++){
                         actors = actors + item2.actor[num].actorNm + ", ";   
                      }
                      if(image[0]){
                            $('#subInfo').append('<div class=nation>'+item2.nation+'</div>')
                            $('#subInfo').append('<div class=title><a href=MovieDetailPro.mo?movieId'+item2.movieId+'&movieSeq='
                                  +item2.movieSeq+'&query='+title5+'>'+title3+'</div>')
                            $('#subInfo').append('<div class=runtime>'+item2.runtime+'</div>')
                            $('#subInfo').append('<div class=rating>'+item2.rating[0].ratingGrade+'</div>') 
                            $('#subInfo').append('<div class=poster><img src='+image[0]+'></div>')
                            $('.directorH2').text(director+"의 다른 영화들");
                      }
                         
                         });
                });
             }
       }); 
         
         
         
         var returnCmt = $('#returnCmt').val();
         function cmtBtn() {
        	 
        	 var typeName = $('#typeName').val();
        	 
        	 
        	 $('#dialog-comment').dialog({
        		 modal: true,
        		 buttons: {
        			 "작성":function() { 
        				 var review = $('#opinion').val();	
        			 	$.ajax({
        			 		url:"MovieReview.mo",  
        			 	 	method:"get",
        			 	 	async: false,
        			 	 	data:{review:review,
        			 	 		  nick:nick,
        			 	 		  movieSeq:movieSeq,
        			 	 		  typeName:typeName 
        			 	 		  },
        			 	 		  success:function(data) {
        			 	 		  	$('#review').append(data);
        			 	 		    location.reload();
        			 	 		  }
        			 	 		
        			 	});
        			 	
        			 	$(this).dialog('close');
        			 
        			 },
        			 
        			 "취소":function() {$(this).dialog('close'); },
        		 }
        	 
        	 }); 
        	
         }
         
         
         $('#updateCmt').click(function(){var typeName = $('#typeName').val();
         $('#dialog-comment').dialog({
    		 modal: true,
    		 buttons: {
    			 "수정":function() { 
    				 var review = $('#opinion').val();	
    			 	$.ajax({
    			 		url:"MovieReviewUpdate.mo",  
    			 	 	method:"get",
    			 	 	async: false,
    			 	 	data:{review:review,  
    			 	 		  nick:nick,
    			 	 		  movieSeq:movieSeq,
    			 	 		  typeName:typeName 
    			 	 		  },
    			 	 		  success:function(data) {
    			 	 		    location.reload();
    			 	 		  }
    			 	 		
    			 	});
    			 	
    			 	$(this).dialog('close');
    			 
    			 },
    			 
    			 "취소":function() {$(this).dialog('close'); },
    		 }
    	 
    	 }); 
         
         });
         
         $('#deleteCmt').click(function(){var typeName = $('#typeName').val();
             $('#delete-message').dialog({
        		 modal: true,
        		 buttons: {
        			 "삭제":function() { 
        				 var review = $('#opinion').val();	
        			 	$.ajax({
        			 		url:"MovieReviewDelete.mo",  
        			 	 	method:"get",
        			 	 	async: false,
        			 	 	data:{review:review,  
        			 	 		  nick:nick,
        			 	 		  movieSeq:movieSeq,
        			 	 		  typeName:typeName 
        			 	 		  },
        			 	 		  success:function(data) {
        			 	 			location.reload();
        			 	 		  }
        			 	 		
        			 	});
        			 	
        				 	$(this).dialog('close');
        			 
        			 },
        			 
        				 "취소":function() {$(this).dialog('close'); },
        			 }
        	 
        		 }); 
             
             });
   });
</script>
</head>
<body>
<input type="hidden" id="movieSeq" value="<%=movieSeq%>">
<input type="hidden" id="query" value="<%=query%>">
<input type="hidden" id ="nick" class="nick" value=<%=nick %>>
<input type="hidden" id="getGrade" value="<%=getGrade %>">
<input type="hidden" id="returnCmt" value="<%=returnCmt %>">
<jsp:include page="/inc/top.jsp" />
<div class="clear"></div>

<section id="main">
<div id="wish">
   	<button class="btn-like" value="<%=movieSeq%>">❤️</button>
</div>
<div id="dialog-message" title="선택하세요." style="display:none">
   	평가하시려면 로그인이 필요해요. <br>
   	회원가입 또는 로그인하고 별점을 기록해보세요.
   	</div>
   	
   	<div id="dialog-comment" title="코멘트" style="display:none">
   		<textarea id="opinion" name="opinion" cols="30" rows="5"></textarea>
   		이 작품에 대한 <%=nick %> 님의 평가를 글로 남겨보세요.
   	</div>
   	
   	
   	<div id="delete-message" title="코멘트" style="display:none">
   		정말로 삭제 하시겠습니까?
   	</div>
	<div>
   <a href="BoardReviewView.bo?movieSeq=<%=movieSeq %>">모든 리뷰 보러가기</a>
  <span class='star-input'>
                    <span class='input'>
                 <input type="button" class="c1" ><label style= "width: 10px; z-index: 10;" class="l1">1</label>
                 <input type="button" class="c2" ><label style= "width: 20px; z-index: 9;" class="l2">2</label>
                 <input type="button" class="c3" ><label style= "width: 30px; z-index: 8;" class="l3">3</label>
                 <input type="button" class="c4" ><label style= "width: 40px; z-index: 7;" class="l4">4</label>
                 <input type="button" class="c5" ><label style= "width: 50px; z-index: 6;" class="l5">5</label>
                 <input type="button" class="c6" ><label style= "width: 60px; z-index: 5;" class="l6">6</label>
                 <input type="button" class="c7" ><label style= "width: 70px; z-index: 4;" class="l7">7</label>
                 <input type="button" class="c8" ><label style= "width: 80px; z-index: 3;" class="l8" >8</label>
                 <input type="button" class="c9" ><label style= "width: 90px; z-index: 2;" class="l9">9</label>
                 <input type="button" class="c10"><label style= "width: 100px; z-index: 1;" class="l10">10</label>
                 </span></span>
                 
                 <% if(!(getGrade.equals("0"))){ %>
                <div id="isGrade">
        	<%= getGrade %> 점을 입력하셨습니다 
        	<% if(returnCmt.equals("")){ %>
        	<input id="comment" name="comment" type="button" value ="코멘트 남기러 가기">
        	<%}else{ %>
        	<br><%=nick %>님의 코멘트 :  <%=returnCmt %> 
  			    	 
     			     <input type="button" id ="updateCmt" value="수정">
       	             <input type="button" id ="deleteCmt" value="삭제">
                </div>
                	  <%} %>
                	  
		<div id="review"></div>
<%} %> 
	</div>
	
<div class="main">
    <div class=thisMovie>
    <h2 class="detailH2"></h2>
   <div id="detail">
   </div>
   <div id="posters">
   </div>
   <div style=float:left; id="keyword">
   </div>
   </div>
   <div id="subInfo"><h2 class="directorH2"></h2></div>
   </div>
   	
   	</section>
<script type="text/javascript">
$(document).ready(function(){
	$('.main').slick({
		  dots: true,
		  infinite: true,
		  speed: 300,
		  slidesToShow: 1,
		  adaptiveHeight: true
		});	
});
</script>
   	
</body>
</html>