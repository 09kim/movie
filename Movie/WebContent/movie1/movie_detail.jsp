<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%String nick = (String)session.getAttribute("nick"); 
String getGrade = (String)request.getAttribute("getGrade"); 
String movieSeq = request.getParameter("movieSeq");
String query = request.getParameter("query");%>
<%String director=request.getParameter("director"); %>
<meta charset="UTF-8">
<title></title>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/jquery-ui.css" type="text/css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/moviecss/movie.css" type="text/css" rel="stylesheet">
<script src="../../../Movie/js/jquery-3.5.1.js"></script>
<script src="../../../Movie/js/jquery-ui.js"></script>
<script type="text/javascript">

   $(document).ready(function(){
      // 영화의 디테일한 내용을 담당하는 Jquery 문
//       $('#btn').click(function(){
         var name = $("#na").val();
         var movieSeq = $("#movieSeq").val();
         var query = $("#query").val();
         var keyword = $("#keyword").val();
         
         
         
         
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
         
         function cmtBtn() {
        	 $('#dialog-comment').dialog({
        		 modal: true,
        		 buttons: {
        			 "작성":function() {location.href="MemberLoginForm.me" },
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
                     
                     var stlls = item2.stlls.split("|")
                     var keyword = item2.keywords.split(",")
                     var actors="";
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
                  
                     
                     var nick = $('#nick').val()
                      
                        function starClick(param,grade){
                                  $.ajax("setGrade.mo",{
                                     method:"post",
                                     data:{
                                          data:param,
                                          grade:grade,
                                          nick:nick
                                          },
                                     success:function(data){
                                    	
                                     }
                                  }
                           ) 
                        }   
                     
                     if(nick != 'null') {
                     $.ajax("MovieDetail.mo",{
                        method:"get",
                        dataType :"json",
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
                                	 break;                                 
                                 case "1" :
                                	 $('.l2').focus();
                                	 break;                             
                              	 case "1.5":
                             		 $('.l3').focus();
                             	 	 break;
                              	 case "2" :
                              		 $('.l4').focus();
                              		 break;
                              	 case "2.5":
                              		 $('.l5').focus();
                              		 break;
                              	 case "3" :
                              		 $('.l6').focus();
                              		 break;
                              	 case "3.5" :
                              		 $('.l7').focus();
                              		 break;
                              	 case "4" :
                              		 $('.l8').focus()
                              		 break;
                              	 case "4.5":
                              		 $('.l9').focus()
                              		 break;
                              	default:
                              		$('.l10').focus();
                              	
                              		 }
                              
                             
                                 
                                 
                                 $('.c1').eq(idx).val(item2.director[0].directorNm+"/"+item2.nation+"/"+title5+"/"+item2.movieSeq+"/"+item2.runtime+"/"+item2.genre+"/"+item2.prodYear);
                                 var garde= 0;
                          		 var movieSeq =""   
                                    $('.c1').eq(idx).click(function(){
                                       alert(title + " | " + "0.5점 등록");
                                       var grade=1;
                                       var data = $('.c1').eq(idx).val();
                                       starClick(data,grade);
                                      
                                    });
                                    
                                    $('.c2').eq(idx).click(function(){
                                       alert(title +  " | " + "1점 등록");
                                       var grade = 2;
                                       var data = $('.c1').eq(idx).val();
                                       starClick(data,grade);
                                      
                                    });
                                    $('.c3').eq(idx).click(function(){
                                       alert(title +  " | " +  "1.5점 등록");
                                       var grade = 3;
                                       var data = $('.c1').eq(idx).val();
                                       starClick(data,grade);
                                       
                                    });
                                    
                                    $('.c4').eq(idx).click(function(){
                                       alert(title +  " | " +  "2점 등록");
                                       var grade = 4;
                                       var data = $('.c1').eq(idx).val();
                                       starClick(data,grade);
                                    });
                                    
                                    $('.c5').eq(idx).click(function(){
                                       alert(title +  " | " +  "2.5점 등록");
                                       var grade = 5;
                                       var data = $('.c1').eq(idx).val();
                                       starClick(data,grade); 
                                    });
                                    
                                    $('.c6').eq(idx).click(function(){
                                        alert(title +  " | " +  "3점 등록");
                                        var grade = 6;
                                        var data = $('.c1').eq(idx).val();
                                        starClick(data,grade);
                                        
                                    });
                                    $('.c7').eq(idx).click(function(){
                                        alert(title +  " | " +  "3.5점 등록");
                                        var grade=7;
                                       var data = $('.c1').eq(idx).val();
                                       starClick(data,grade);
                                    });
                                    $('.c8').eq(idx).click(function(){
                                        alert(title +  " | " +  "4점 등록");
                                        var grade=8;
                                       var data = $('.c1').eq(idx).val();
                                       starClick(data,grade);
                                       $('.thisMovie').eq(idx).hide();
                                    });
                                    $('.c9').eq(idx).click(function(){
                                        alert(title +  " | " +  "4.5점 등록");
                                        var grade=9;
                                       var data = $('.c1').eq(idx).val();
                                       starClick(data,grade);
                                    });
                                    $('.c10').eq(idx).click(function(){
                                        alert(title +  " | " +  "5점 등록");
                                        var grade=10;
                                       var data = $('.c1').eq(idx).val();
                                       starClick(data,grade);
                                       
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
                     

                     $('#detail').append('<div class=title>'+title5+'</div>')
                     $('#detail').append('<div class=title>'+item2.repRlsDate+'</div>')
                     $('#detail').append('<div class=titleEng>'+item2.titleEng+'</div>')
                     $('#detail').append('<div class=nation>'+item2.nation+'</div>')
                     $('#detail').append('<div class=runtime>'+item2.runtime+'</div>')
                     $('#detail').append('<div class=rating>'+item2.rating[0].ratingGrade+'</div>')
                     $('#detail').append('<div class=runtime>'+item2.genre+'</div>')
                     $('#detail').append('<div class=actors><a href=MovieSearchDirector.mo?director='+item2.director[0].directorNm+'>'+item2.director[0].directorNm+'</a></div>')
                     $('#detail').append("<input type='hidden' id ='directorName' value="+ item2.director[0].directorNm+ ">")
                     $('#detail').append('<div class=actors>'+actors+'</div>')
                     $('#detail').append('<div class=company>'+item2.company+'</div>')
                     $('#detail').append('<div class=plot>'+item2.plot+'</div>')
                     for(var i in stlls){
                     $('#posters').append('<div style=float:left; class=image><img src='+stlls[i]+'></div>')
                     }
                        if(keyword[0]!=""||keyword[keyword.length]!=""){
                           
                        for(var i in keyword){
                           
                              $('#keyword').append('<div style=float:left; class=keyword><a href=MovieSearchKeyword.mo?keyword='+keyword[i]+'>#'+keyword[i]+'&nbsp;</div>')
                           }
                           
                        }
                        });
               });
            }
            
         });
         
         
         
      

         
         
         $('#directorMovies').click(function(){
            
            var director = $("#directorName").val();
            director = director.replace(/ /g,'');
            $.ajax('MovieDirector.mo',{
               method:"get",
               dataType :"json",
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
                           
                        $('#subInfo').append('<div class=nation>'+item2.nation+'</div>')
                        $('#subInfo').append('<div class=title><a href=MovieDetailPro.mo?movieId'+item2.movieId+'&movieSeq='
                              +item2.movieSeq+'&query='+title5+'>'+title3+'</div>')
                        $('#subInfo').append('<div class=runtime>'+item2.runtime+'</div>')
                        $('#subInfo').append('<div class=rating>'+item2.rating[0].ratingGrade+'</div>') 
                        $('#subInfo').append('<div class=poster><img src='+image[0]+'></div>')
                           });
                  });
               }
         });
            $('.thisMovie').hide();
         });
         
         
         
   });
</script>
</head>
<body>
<input type="hidden" id="movieSeq" value="<%=movieSeq%>">
<input type="hidden" id="query" value="<%=query%>">
<input type="hidden" id="director" name=director value="<%=director%>">
<input type="hidden" id ="nick" class="nick" value=<%=nick %>>
<input type="hidden" id="getGrade" value="<%=getGrade %>">
<jsp:include page="/inc/top.jsp" />
<div class="clear"></div>

<section id="main">

<section>
   <a href="#" id="directorMovies">이 감독의 다른 영화</a>
   <br>
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
              
        	<%= getGrade %> 점을 입력하셨습니다. 코멘트를 남겨보세요!
  		    <input id="comment" name="comment" type="button" value ="코멘트 남기러 가기">
      	<%} %>  


   <div id="subInfo"></div>
   <section id="list">
   </section>
    <div class=thisMovie>
   <section id="detail">
   </section>
   <section id="posters">
   </section>
   <section style=float:left; id="keyword">
   </section>
   </div>
   </section>
   <div id="dialog-message" title="선택하세요." style="display:none">
   	평가하시려면 로그인이 필요해요. <br>
   	회원가입 또는 로그인하고 별점을 기록해보세요.
   	</div>
   	
   	<div id="dialog-comment" title="코멘트" style="display:none">
   		<textarea id="opinion" name="opinion" cols="30" rows="5"></textarea>
   		이 작품에 대한 <%=nick %> 님의 평가를 글로 남겨보세요.
   	</div>
   	</section>
</body>
</html>