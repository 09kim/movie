<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%String nick = (String)session.getAttribute("nick"); 
String getGrade = (String)request.getAttribute("getGrade"); 
String movieSeq = (String)request.getParameter("movieSeq");
String query = request.getParameter("query");
String returnCmt = (String)request.getAttribute("returnCmt");
String poster = (String)request.getParameter("image");
String director=request.getParameter("director");%>
<title>[갓챠] - 영화 <%=query %>의 상세정보</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/movie_detail.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/jquery-ui.css" type="text/css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/moviecss/movie.css" type="text/css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/mypagewish.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.min.css">

<link href="${pageContext.request.contextPath}/css/toggle.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.3/jquery.min.js"></script>

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
	   
	   var latitude, longitude;
	   var API_KEY = '19eab104c69d6fa4c412bfe0078fdd0d';
	   var temp = '0';
	   var weather = 'no';
	   
	   function getLocation(){
	      window.navigator.geolocation.getCurrentPosition(current_position);
	   }
	   
	   function current_position(position){
	      latitude = position.coords.latitude;
	      longitude = position.coords.longitude;
	      $.ajax("https://api.openweathermap.org/data/2.5/weather?lat="+latitude
	            +"&lon="+longitude+"&appid="+API_KEY+"&units=metric&lang=kr",{
	         dataType:"json",
	         async:false,
	         success:function(data){
	            $('#temp').val(data.main.temp);
	            $('#weather').val(data.weather[0].main);
	            temp = $('#temp').val();
	            weather = $('#weather').val();
	         }
	      });
	   }
	      
	   window.addEventListener("load",getLocation);
	   
	   
	   
	   
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
                  
                     
                     var link = document.location.href; 
                      
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
                                 var image = item2.posters.split("|");
                                 var title = item2.title;
                                 var titleNoSpace = title.replace(/ /g, '');
                                 var title2 = titleNoSpace.replace(/!HS/g,'');
                                 var title3 = title2.replace(/!HE/g,'');
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
                     
                     var age = item2.rating[0].ratingGrade.split("||")[0]
                     $('.caption_top').append(query); // 상단 제목줄 큰 제목 - 낙원 : 1002
                     $('.caption_bottom').append('<span class="repRlsDate">'+item2.repRlsDate+'</span>&nbsp'); // 상단 제목줄 밑 개요 표시줄 개봉일 표시 - 낙원 : 1002
                     $('.caption_bottom').append('<span class="age">'+age+'</span>'); // 상단 제목줄 밑 개요 표시줄 개봉일 표시 - 낙원 : 1002
//                      $('.poster').append('<img style=width:250px;height:350px; src='+image[0]+' onerror=this.src="../../../Movie/img/noImage.gif">'); // 상단 제목줄 밑 개요 표시줄 시청가능연령 표시 - 낙원 : 1002
//                      $('.poster').append('<img style=width:250px;height:350px; src="'+image[0]+'" onerror=this.src="${pageContext.request.contextPath}/img/noImage.gif">'); // 상단 제목줄 밑 개요 표시줄 시청가능연령 표시 - 낙원 : 1002
                     $('.poster').append('<img style=width:250px;height:350px; src="'+image[0]+'" onerror=this.src="${pageContext.request.contextPath}/img/noImage.gif">'); // 상단 제목줄 밑 개요 표시줄 시청가능연령 표시 - 낙원 : 1002
                     $('.info').append('<dt>개요</dt>'); // 개요
                     $('.info').append('<dd id=summaryInfo><span class=age>'+age+'</span><span style="padding-left:5px;" id="playTime">'+item2.runtime+'분</span>'); // 개요
                     $('.info').append('<dt>상영국가</dt>'); // 상영국가
                     $('.info').append('<dd><span class=nation>'+item2.nation+'</span></dd>'); // 상영국가
                     $('.info').append('<dt>감독</dt>'); // 감독
                     $('.info').append('<dd><span class=director><a href=MovieSearchDirector.mo?director='+director+'>'+item2.director[0].directorNm+'</a></span></dd>'); // 감독
                     $('.info').append('<dt>배급사</dt>'); // 배급사
                     $('.info').append('<dd><span class=company>'+item2.company+'</span></dd>'); // 배급사
                     $('.info').append('<dt>줄거리</dt>'); // 줄거리
                     $('.info').append('<dd><span class=plot>'+item2.plot+'</span></dd>'); // 줄거리
                     
					 var staffList = actors.split("<br>")
					 
					 for(var i in staffList){
		                 if(!staffList[i].includes("감독")&&!staffList[i].includes("각본")){ // 배역(배우목록)에서 감독이나 각본등은 제외 - 낙원 : 1002
						 $('.staff').append('<dd>'+staffList[i]+'</dd>') // 배역 표시
		                 }
					 }
                     
                     
                    	 for(var i in stills){
							if(stills[i]){                    		 
                          $('.posters').append('<div class=stillCut style="background-image: url('+stills[i]+');"></div>')
//                           $('.posters').append('<div class=stillCut><img style="height:150px;" src='+stills[i]+' onerror=this.src=../../../Movie/img/noImage.gif></div>')
							}else{
								$('.posters').append('<div class=stillCut style="background-image: url(${pageContext.request.contextPath}/img/noImage.gif;")></div>')
							}
						}
                     
                        if(keyword[0]!=""||keyword[keyword.length]!=""){
                           
                        for(var i in keyword){
                           
                              $('#keyword').append('<div style=float:left; class=keyword><a href=MovieSearchKeyword.mo?keyword='+keyword[i]+'>#'+keyword[i]+'&nbsp;</div>')
                           }
                           
                        }
                        $('.detailH2').text("영화 "+title5+"의 상세 정보"); 
                        
                        // 트레일러 영상 추가
                        // 낙원 키
                        var key = "AIzaSyAFCuBm8gWBOlb7U7BsVmPYB9QTfdCxUf0";
                        // 영운 키
//                         var key = "AIzaSyAVNyht3Y8C6lrx4Eiha9l3MsE7EItlHjI";
                        var url = "https://www.googleapis.com/youtube/v3/search?key=" + key + "&q=영화" +title3+ "예고편&part=id&type=video";
                        
                        $.ajax({
                            type : "GET",
                            dataType : "JSON",
                            url : url,
                            contentType : "application/json",
                            success : function(jsonData) {
                            
                               var link = jsonData.items[0].id.videoId;
                               // 유튜브 영상 자동재생 + 음소거 모드 추가 - 낙원 :1003
                               $('#trailer').append('<iframe width=700 height=500 src=https://www.youtube.com/embed/'+link+'?autoplay=1&mute=1 frameborder=0 allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen=""></iframe>');
//                                $('#trailer').append("<iframe src='https://www.youtube.com/embed/"+link + "' width='700' height='500'>" )
                               },
                            error : function(xhr, status, error) {
                            console.log("유튜브 요청 에러: "+error);
                            }
                            });
                        
                        
                        
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
                	if(!item.Result){
                       	 $('.directorH2').text('결과가 없습니다.');
                	}
                   var count = item.Count
                   $.each(item.Result,function(idx,item2){
                      var title = item2.title
                      var titleNoSpace = title.replace(/ /g, '');
                      var title2 = titleNoSpace.replace(/!HS/g,'')
                      var title3 = title2.replace(/!HE/g,'')
                      var title5 = title3.trim();
                      var title6 =  encodeURIComponent(title5);
                      var actors="";
                      
                      
                      
                      var image = item2.posters.split("|")
                      for(var num = 0; num < item2.actor.length ; num++){
                         actors = actors + item2.actor[num].actorNm + ", ";   
                      }
                      
                      if(image[0]){
                    	  $('.directorsMovie').append("<div class=directorsMovieList>"+
//                      			 '<div class=poster><a href=MovieDetailBySearch.mo?movieId='+item2.movieId+'&movieSeq='+item2.movieSeq+'&query='+title6+'&image='+image[0]+'&temp='+temp+'&weather='+weather+'><img style=width:250px;height:350px;margin-right:20px; src='+image[0]+'></a></div>'+
								 '<a href=MovieDetailBySearch.mo?movieId='+item2.movieId+'&movieSeq='+item2.movieSeq+'&query='+title6+'&image='+image[0]+'&temp='+temp+'&weather='+weather+'><div class=poster style="background-image: url('+image[0]+'),url(${pageContext.request.contextPath}/img/noImage.gif;"></div></a>'+
                     			 '<div class=nation>'+item2.nation+'</div>'+
                     			 '<div class=rating>'+item2.rating[0].ratingGrade+'</div>'+
                     			 '<div class=title>'+title5+'</div></div>');
                            $('.directorP').text(director+"감독의 다른 영화들");	
                      }
                         
                     });
                });
                
                
             }
             
       }); 
         
         
         // 리뷰 
         
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
        			 	 			
        			 	 			// 스포일러 체크  
        			 	 			if($('#spoilerCheck').is(":checked") == true) {
        			                    $('#review').text("스포일러가 포함된 리뷰입니다."); 
        			                    $('#review').append(data);
        			                    location.reload();
        			                    
        			                 } else {
	        			 	 		  	$('#review').append(data);
	        			 	 		    location.reload();
        			                     
        			                 }
        			 	 			  
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
         
         
         
         // 현재 스크롤바의 좌표 받기 - 낙원 : 1003
         $(window).scroll(function () {
     		height = $(document).scrollTop();
     	});   
         
         // 아래로 이동 버튼 클릭시 - 낙원:1003
         $('.down').click(function() {
        	   var height = $(document).scrollTop();
        	   height = Math.floor(height);
//         	   alert("현재 높이 : " + height)
        	   var list = ["#main","#jb-content","#jb-footer","#jb-footer2"];
        	   var position = [];
        	   var offset = 0;
        	   var test ="";
        	   var height1 = "";
        	   for(var i = 0 ; i<list.length; i++){
        			test = $(list[i]);
        			height1 = test.offset().top;
        			height1 = Math.floor(height1);
//         			alert("리스트별 높이"+height1)
        		    position.push(height1);
        	   }
        	   
        	   for(var i = 0; i<position.length;i++){
        		   if(height<position[i]){
//         			  alert("이동할 포지션 " + position[i]) 
        			   var offset = $(list[i]).offset();
        			    $('html, body').animate({scrollTop : offset.top}, 400);
        			    return false;
        		   }
        	   }
        	});
         
         // 위로 이동 버튼 클릭시 - 낙원 : 1003
         $('.up').click(function() {
        	   var height = $(document).scrollTop();
        	   height = Math.floor(height);
//         	   alert("현재 높이 : " + height)
        	   var list = ["#main","#jb-content","#jb-footer","#jb-footer2"];
        	   var position = [];
        	   var offset = 0;
        	   var test ="";
        	   var height1 = "";
        	   for(var i = 0 ; i<list.length; i++){
        			test = $(list[i]);
        			height1 = test.offset().top;
        			height1 = Math.floor(height1);
        		    position.push(height1);
        	   }
        	   
        	   for(var i = (list.length-1); i>=0;i--){
        		   if(height>position[i]){
//         			  alert("이동할 포지션 " + position[i]) 
        			   var offset = $(list[i]).offset();
        			    $('html, body').animate({scrollTop : offset.top}, 400);
        			    return false;
        		   }
        	   }
        	});
         
         
         
         
   });
    
</script>

</head>
<body>
<jsp:include page="/inc/top.jsp" />
<div class="clear"></div>
    
<!-- main[S] -->
<section id="main">

<!-- jbMenu[S] -->
<div class="jbMenu">
<div class="clear"></div>

<div id="Box">
<!-- 	<div id="head"> -->
<!-- 	<div id="trailer"></div> -->
<!-- 	</div> -->
	<div id="body">
	<button class="up">▲</button>
	<button class="down">▼</button>
	</div>
	</div>
</div>
<!-- jbMenu[E] -->
    

    
    
    
<!--     jb-container[S] -->
<div id="jb-container">

<!-- jbMenu[S] -->
<div class="jbMenu1">
<div class="clear"></div>

<div id="Box">
	<div id="head">
	<div id="trailer"></div>
	</div>
<!-- 	<div id="body"> -->
<!-- 	<button class="up">▲</button> -->
<!-- 	<button class="down">▼</button> -->
<!-- 	</div> -->
	</div>
</div>
<!-- jbMenu[E] -->





<input type="hidden" id="hashIndex" value="0">

<!--     헤더 [S] -->
      <div id="jb-header">
        <div class="title-left">
        <h3 class="caption_top"></h3>
			<div class="caption_bottom"></div>
		</div>
        <div class="title-right">
				<button class="btn-like" value="<%=movieSeq%>">❤️<br>좋아요</button>
		</div>
    </div>
<!--       헤더 [E] -->
      
<!--       사이드 레프트 [S] -->
      <div id="jb-sidebar-left">
				<div class="poster"></div>
				
	<div id="dialog-message" title="선택하세요." style="display:none">
	   	평가하시려면 로그인이 필요해요. <br>
	   	회원가입 또는 로그인하고 별점을 기록해보세요.
   	</div>
   	
   	<div id="dialog-comment" title="리뷰" style="display:none">
   	    <input type="checkbox" id="spoilerCheck" value="스포일러"> 스포일러
   		<textarea id="opinion" name="opinion" cols="30" rows="5"></textarea>
   		이 작품에 대한 <%=nick %> 님의 평가를 글로 남겨보세요.
   	</div>
   	
   	
   	<div id="delete-message" title="리뷰" style="display:none">
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
        	<%= getGrade %> 점을 입력하셨습니다 <br>
        	<% if(returnCmt.equals("")){ %>
	        	<input id="comment" name="comment" type="button" value ="리뷰 남기러 가기">
        	<%}else{ %>
        	<div id="review">
        	<br><%=nick %>님의 코멘트 : <%=returnCmt %> </div>
  			    	 
     			     <input type="button" id ="updateCmt" value="수정">
       	             <input type="button" id ="deleteCmt" value="삭제">
                	  <%} %>
                </div>
                	  
		
<%} %> 
	</div>				
				
				
      </div>
<!--       사이드 레프트[E] -->
      
<!--       사이드 센터[S] -->
      <div id="jb-content">
		<dl class="info"></dl>
      </div>
<!--       사이드 센터[E] -->

<!-- 사이드 라이트[S] -->
      <div id="jb-sidebar-right">
      	<p><b>배역</b></p>
        <dl class="staff">
		</dl>
      </div>
<!--       사이드 라이트[E] -->


<!-- 푸터(스틸컷)[S] -->
      <div id="jb-footer">
      <p>스틸컷</p>
        <div class="posters"></div>
      </div>
<!-- 푸터(스틸컷)[E] -->
      
<!-- 푸터(이 감독의 다른 영화)[S] -->      
      <div id="jb-footer2">
      <p class="directorP"></p>
        <div class="directorsMovie"></div>
      </div>
<!-- 푸터(이 감독의 다른 영화)[E] -->       
    
    
<input type="hidden" id="movieSeq" value="<%=movieSeq%>">
<input type="hidden" id="query" value="<%=query%>">
<input type="hidden" id ="nick" class="nick" value=<%=nick %>>
<input type="hidden" id="getGrade" value="<%=getGrade %>">
<input type="hidden" id="returnCmt" value="<%=returnCmt %>">
    

    </div>
<!-- #jb-container[E] -->
</section>
<!-- main[E] -->

<div class="moveTop" style="cursor:pointer;">TOP</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	$('.posters').slick({
        dots: false,
        infinite: false,
        arrows: true,
        variableWidth:true,
        speed: 300,
        slidesToShow: 4,
        slidesToScroll: 3,
        responsive: [
          {
            breakpoint: 1024,
            settings: {
              slidesToShow: 3,
              slidesToScroll: 3,
              infinite: true,
              dots: true
            }
          },
          {
            breakpoint: 600,
            settings: {
              slidesToShow: 2,
              slidesToScroll: 2
            }
          },
          {
            breakpoint: 480,
            settings: {
              slidesToShow: 1,
              slidesToScroll: 1
            }
          }
          // You can unslick at a given breakpoint now by adding:
          // settings: "unslick"
          // instead of a settings object
        ]
      }); // slick(.posters)끝
      
      
      $('.directorsMovie').slick({
    	  dots: false,
          infinite: false,
//           infinite: true,
          arrows: true,
          variableWidth:true,
          speed: 300,
//           autoplay:true,
//           autoplaySpeed:3000,
          slidesToShow: 4,
          slidesToScroll: 3,
          responsive: [
            {
              breakpoint: 1024,
              settings: {
                slidesToShow: 3,
                slidesToScroll: 3,
                infinite: true,
                dots: true
              }
            },
            {
              breakpoint: 600,
              settings: {
                slidesToShow: 2,
                slidesToScroll: 2
              }
            },
            {
              breakpoint: 480,
              settings: {
                slidesToShow: 1,
                slidesToScroll: 1
              }
            }
            // You can unslick at a given breakpoint now by adding:
            // settings: "unslick"
            // instead of a settings object
          ]
        }); // slick(.directorsMovieList)끝
        
        
        
     // 상단 이동 버튼 기능 추가 - 낙원 : 1016[S]
        $( '.moveTop' ).hide(); // 시작시에 hide로 안보이게 함(밑에 함수는 스크롤동작을했을때만 동작하므로)
  	    $( window ).scroll( function() {
            if ( $( this ).scrollTop() > 200 ) {
              $( '.moveTop' ).fadeIn();
            } else {
              $( '.moveTop' ).fadeOut();
            }
          } );
          $( '.moveTop' ).click( function() {
            $( 'html, body' ).animate( { scrollTop : 0 }, 400 );
            return false;
          } );
        // 상단 이동 버튼 기능 추가 - 낙원 : 1016[E]
        
        
        
        
        
        
      
});
</script>

      
</body>
</html>