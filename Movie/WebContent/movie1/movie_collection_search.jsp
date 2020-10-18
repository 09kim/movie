<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/movieboard.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.min.css">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.js"></script>
<script type="text/javascript">
// 기본검색기능을 담당하는 뷰페이지


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
   
      var query = $("#query").val();
      var nick = $("#nick").val();
      query = query.replace(/ /g,'');
      $.ajax('MovieSearchPro.mo',{
         method:"post",
         dataType :"json",
         data:{query:query},
         success:function(data){
            // 처음 결과 4개의 배열구조
            $.each(data.Data,function(idx,item){
               // 4번째 오브젝드 Data 안에 것을 가져옴
               var count = item.Count
                  
               $.each(item.Result,function(idx,item2){
                  // 가져오너 Data 안에 Result 데이터를가져옴( 우리가원하는 값들이 여기 모두 들어있음)
                  var title = item2.title // 타이블을 변수 지정
                  var titleNoSpace = title.replace(/ /g, ''); // 타이틀 공백제거
                  var title2 = titleNoSpace.replace(/!HS/g,'') // 검색어는 !HS , !HE 로 둘러 싸여있어서 제거해줌
                  var title3 = title2.replace(/!HE/g,'')
                  var title5 = title3.trim(); // 양쪽끝에 공백을 제거해줌
                  var title6 =  encodeURIComponent(title5);
                  var actors="";
                  
                  var image = item2.posters.split("|") // 포스터 데이터는 | 로 구분되어있어서 스플리 처리함 ( 여러개 있음 )
                  var nation = item2.nation
                  if(nation == "대한민국"){ // 국내 국외 영화구분을 위한 제어문
                     
                     for(var num = 0; num < item2.actor.length ; num++){
                        actors = actors + item2.actor[num].actorNm + ", ";   
                     }
                        
                     if(image[0]){
                        $('#koreaList').append("<div class=koreaMovie>"+
                              '<div class=poster><a href=MovieDetailBySearch.mo?movieId='+item2.movieId+'&movieSeq='+item2.movieSeq+'&query='+title6+'&image='+image[0]+'&temp='+temp+'&weather='+weather+'><img style=width:250px;height:350px;padding-right:20px; src='+image[0]+'></a></div>'+
                              '<div class=nation>'+item2.nation+'</div>'+
                              '<div class=rating>'+item2.rating[0].ratingGrade+'</div>'+
                              '<div class=title>'+title5+'</div>' +
                              "<input type='button' value='담기' style=margin-left:-50px; id='" + item2.movieSeq + "'</div>");
                     }
                     $('#koreaList').on('click', '#'+item2.movieSeq, function() {
//                     	 $("#movies", opener.document).text("<li>"+item2.movieSeq+"</li>");

						 var movieSeq = item2.movieSeq;
						 var poster = image[0];
                    	 $.ajax('CollectionMovieAdd.mp',{
     	   					data:{nick:nick,movieSeq:movieSeq,title:title5,poster:poster},
     	   					success:function(rdata){
//      	   							$("#movies", parent.opener.document).val();
//      	  			 				opener.location.reload();
									
									var dupCheck="";

									// #movies객체가 존재 하지 않을경우(null)을 판별. 객체가 없는 상태이므로 객체를 추가하는 구문을 추가함 - 낙원 : 1011[S]
									if($("#movies", opener.document).find('.title').length==0){
										dupCheck="Y";
// 										alert("판별결과 널 : " + dupCheck)
										 // 슬라이드에 객체 추가하는 구문 - 낙원 : 1011
										 // 포스터랑 타이틀 나오는 부분 디자인 수정때문에 코드 변경 & 슬라이드 추가구문 추가  - 낙원 : 1011[S]
					     	   	            $("#movies", opener.document).slick('slickAdd',"<div class=collectionList>"+ 
				 	  			      			    '<div class=poster style="background-image: url('+image[0]+')"></div>'+ 
				 	  			      				'<div class=title>'+title5+
				 	  			      				"</div>" +
				 	  			      				"<input type='hidden' value='"+ movieSeq + "'name = 'movieSeq' id='movieSeq'>" +
				 	  			      				"<input type='hidden' value='"+ poster + "'name = 'poster'>" +
				 	  			      				"<input type='hidden' value='"+ title5 + "'name = 'title'></div>")
			
											 // 포스터랑 타이틀 나오는 부분 디자인 수정때문에 코드 변경 & 슬라이드 추가구문 추가  - 낙원 : 1011[E]
										return false;
									}else{ // #movies가 존재하는 경우
										// each문으로 mypage의 #movies에 있는 title값을 가져와서 비교 - 낙원 : 1011
										$("#movies", opener.document).find('.title').each(function(idx) {
											dupCheck="";
											var title = $("#movies", opener.document).find('.title').eq(idx).text();
											// 중복되는 것이 없는 경우 Y
											if(title!=title5){
												dupCheck="Y";
// 													alert("판별결과 : " + dupCheck)
											} else {
												// 하나라도 중복되는경우 값은N으로 변경 후 리턴으로 반복문 종료 - 낙원 : 1011
												dupCheck="N";
// 													alert("판별결과 : " + dupCheck)
													return false;
											}
											
										});
										
										
										// 판별결과 Y인 경우 #movies에 슬라이드 추가 - 낙원 : 1011
										if(dupCheck=="Y"){
											 // 포스터랑 타이틀 나오는 부분 디자인 수정때문에 코드 변경 & 슬라이드 추가구문 추가  - 낙원 : 1011[S]
					     	   	            $("#movies", opener.document).slick('slickAdd',"<div class=collectionList>"+ 
				 	  			      			    '<div class=poster style="background-image: url('+image[0]+')"></div>'+ 
				 	  			      				'<div class=title>'+title5+
				 	  			      				"</div>" +
				 	  			      				"<input type='hidden' value='"+ movieSeq + "'name = 'movieSeq' id='movieSeq'>" +
				 	  			      				"<input type='hidden' value='"+ poster + "'name = 'poster'>" +
				 	  			      				"<input type='hidden' value='"+ title5 + "'name = 'title'></div>")
			
											 // 포스터랑 타이틀 나오는 부분 디자인 수정때문에 코드 변경 & 슬라이드 추가구문 추가  - 낙원 : 1011[E]
										} else { // N인경우 중복이므로 중복된 영화라고 알림창 출력 - 낙원 : 1011
											alert("같은 영화를 중복으로 추가하실 수 없습니다.")
										}
										
									}
									// #movies객체가 존재 하지 않을경우(null)을 판별. 객체가 없는 상태이므로 객체를 추가하는 구문을 추가함 - 낙원 : 1011[E]


     	   						}
     	 					});
                    	});
//                      else{
//                         $('#koreaList').append('<div class=poster><img src=../../../Movie/img/noImage.gif></div>');
//                      }
                  }
                  else {
                     
                     for(var num = 0; num < item2.actor.length ; num++){
                        actors = actors + item2.actor[num].actorNm + ", ";   
                     }
                        
                     if(image[0]){
                        $('#foreignList').append("<div class=foreignMovie>"+
                              '<div class=poster><a href=MovieDetailBySearch.mo?movieId='+item2.movieId+'&movieSeq='+item2.movieSeq+'&query='+title6+'&image='+image[0]+'&temp='+temp+'&weather='+weather+'><img style=width:250px;height:350px;padding-right:20px; src='+image[0]+'></a></div>'+
                              '<div class=nation>'+item2.nation+'</div>'+
                              '<div class=rating>'+item2.rating[0].ratingGrade+'</div>'+
                              '<div class=title>'+title5+'</div>' +
                              "<input type='button' value='담기' style=margin-left:-50px; id='" + item2.movieSeq + "'</div>");
                     } 
                     $('#foreignList').on('click', '#'+item2.movieSeq, function() {
//                     	 $("#movies", opener.document).text("<li>"+item2.movieSeq+"</li>");

						 var movieSeq = item2.movieSeq;
						 var poster = image[0];
                    	 $.ajax('CollectionMovieAdd.mp',{
     	   					data:{nick:nick,movieSeq:movieSeq,title:title5,poster:poster},
     	   					success:function(rdata){
//      	   							$("#movies", parent.opener.document).val();
//      	  			 				opener.location.reload();
     	   					var dupCheck="";

							// #movies객체가 존재 하지 않을경우(null)을 판별. 객체가 없는 상태이므로 객체를 추가하는 구문을 추가함 - 낙원 : 1011[S]
							if($("#movies", opener.document).find('.title').length==0){
								dupCheck="Y";
//									alert("판별결과 널 : " + dupCheck)
								 // 슬라이드에 객체 추가하는 구문 - 낙원 : 1011
								 // 포스터랑 타이틀 나오는 부분 디자인 수정때문에 코드 변경 & 슬라이드 추가구문 추가  - 낙원 : 1011[S]
			     	   	            $("#movies", opener.document).slick('slickAdd',"<div class=collectionList>"+ 
		 	  			      			    '<div class=poster style="background-image: url('+image[0]+')"></div>'+ 
		 	  			      				'<div class=title>'+title5+
		 	  			      				"</div>" +
		 	  			      				"<input type='hidden' value='"+ movieSeq + "'name = 'movieSeq' id='movieSeq'>" +
		 	  			      				"<input type='hidden' value='"+ poster + "'name = 'poster'>" +
		 	  			      				"<input type='hidden' value='"+ title5 + "'name = 'title'></div>")
	
									 // 포스터랑 타이틀 나오는 부분 디자인 수정때문에 코드 변경 & 슬라이드 추가구문 추가  - 낙원 : 1011[E]
								return false;
							}else{ // #movies가 존재하는 경우
								// each문으로 mypage의 #movies에 있는 title값을 가져와서 비교 - 낙원 : 1011
								$("#movies", opener.document).find('.title').each(function(idx) {
									dupCheck="";
									var title = $("#movies", opener.document).find('.title').eq(idx).text();
									// 중복되는 것이 없는 경우 Y
									if(title!=title5){
										dupCheck="Y";
// 											alert("판별결과 : " + dupCheck)
									} else {
										// 하나라도 중복되는경우 값은N으로 변경 후 리턴으로 반복문 종료 - 낙원 : 1011
										dupCheck="N";
// 											alert("판별결과 : " + dupCheck)
											return false;
									}
									
								});
								
								
								// 판별결과 Y인 경우 #movies에 슬라이드 추가 - 낙원 : 1011
								if(dupCheck=="Y"){
									 // 포스터랑 타이틀 나오는 부분 디자인 수정때문에 코드 변경 & 슬라이드 추가구문 추가  - 낙원 : 1011[S]
			     	   	            $("#movies", opener.document).slick('slickAdd',"<div class=collectionList>"+ 
		 	  			      			    '<div class=poster style="background-image: url('+image[0]+')"></div>'+ 
		 	  			      				'<div class=title>'+title5+
		 	  			      				"</div>" +
		 	  			      				"<input type='hidden' value='"+ movieSeq + "'name = 'movieSeq' id='movieSeq'>" +
		 	  			      				"<input type='hidden' value='"+ poster + "'name = 'poster'>" +
		 	  			      				"<input type='hidden' value='"+ title5 + "'name = 'title'></div>")
	
									 // 포스터랑 타이틀 나오는 부분 디자인 수정때문에 코드 변경 & 슬라이드 추가구문 추가  - 낙원 : 1011[E]
								} else { // N인경우 중복이므로 중복된 영화라고 알림창 출력 - 낙원 : 1011
									alert("같은 영화를 중복으로 추가하실 수 없습니다.")
								}
								
							}
							// #movies객체가 존재 하지 않을경우(null)을 판별. 객체가 없는 상태이므로 객체를 추가하는 구문을 추가함 - 낙원 : 1011[E]

     	   						}
     	 					});
                    	});


//                      else{ 포스터 없는거는 거의 대부분 안유명한거라 뺌
//                         $('#foreignList').append('<div class=poster><img src=../../../Movie/img/noImage.gif></div>');
//                      }
                  
                  }
                  
               
                  
                     });
            });
            
            $('#koreaList').slick({
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
                   }); // slick(koreaList)끝
                   
                   $('#foreignList').slick({
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
                     }); // slick(foreignList)끝
                     
         }
   });
      // 배우 검색 기능을 담당하는 Jquery문
      $.ajax('MovieSearchActorPro.mo',{
         method:"post",
         dataType :"json",
         data:{query:query},
         success:function(data){
            $.each(data.Data,function(idx,item){
               
               var count = item.Count
                  
               $.each(item.Result,function(idx,item2){
                  
                  var title = item2.title
                  var titleNoSpace = title.replace(/ /g, '');
                  var title2 = titleNoSpace.replace(/!HS/g,'')
                  var title3 = title2.replace(/!HE/g,'');
                  var title5 = title3.trim();
                  var title6 =  encodeURIComponent(title5);
                  var actors="";
                  var image = item2.posters.split("|")
                  
                  for(var num = 0; num < item2.actor.length ; num++){
                     actors = actors + item2.actor[num].actorNm + ", ";   
                  }
                     
                  if(image[0]){
                     $('#actorList').append("<div class=koreaMovie>"+
                           '<div class=poster><a href=MovieDetailBySearch.mo?movieId='+item2.movieId+'&movieSeq='+item2.movieSeq+'&query='+title6+'&image='+image[0]+'&temp='+temp+'&weather='+weather+'><img style=width:250px;height:350px;padding-right:20px; src='+image[0]+'></a></div>'+
                           '<div class=nation>'+item2.nation+'</div>'+
                           '<div class=rating>'+item2.rating[0].ratingGrade+'</div>'+
                           '<div class=title>'+title5+'</div>' +
                           "<input type='button' value='담기' style=margin-left:-50px; id='" + item2.movieSeq + "'</div>");
                  }
                  $('#actorList').on('click', '#'+item2.movieSeq, function() {
//                  	 $("#movies", opener.document).text("<li>"+item2.movieSeq+"</li>");

						 var movieSeq = item2.movieSeq;
						 var poster = image[0];
                 	 $.ajax('CollectionMovieAdd.mp',{
  	   					data:{nick:nick,movieSeq:movieSeq,title:title5,poster:poster},
  	   					success:function(rdata){
//   	   							$("#movies", parent.opener.document).val();
//   	  			 				opener.location.reload();
  	   					var dupCheck="";

						// #movies객체가 존재 하지 않을경우(null)을 판별. 객체가 없는 상태이므로 객체를 추가하는 구문을 추가함 - 낙원 : 1011[S]
						if($("#movies", opener.document).find('.title').length==0){
							dupCheck="Y";
//								alert("판별결과 널 : " + dupCheck)
							 // 슬라이드에 객체 추가하는 구문 - 낙원 : 1011
							 // 포스터랑 타이틀 나오는 부분 디자인 수정때문에 코드 변경 & 슬라이드 추가구문 추가  - 낙원 : 1011[S]
		     	   	            $("#movies", opener.document).slick('slickAdd',"<div class=collectionList>"+ 
	 	  			      			    '<div class=poster style="background-image: url('+image[0]+')"></div>'+ 
	 	  			      				'<div class=title>'+title5+
	 	  			      				"</div>" +
	 	  			      				"<input type='hidden' value='"+ movieSeq + "'name = 'movieSeq' id='movieSeq'>" +
	 	  			      				"<input type='hidden' value='"+ poster + "'name = 'poster'>" +
	 	  			      				"<input type='hidden' value='"+ title5 + "'name = 'title'></div>")

								 // 포스터랑 타이틀 나오는 부분 디자인 수정때문에 코드 변경 & 슬라이드 추가구문 추가  - 낙원 : 1011[E]
							return false;
						}else{ // #movies가 존재하는 경우
							// each문으로 mypage의 #movies에 있는 title값을 가져와서 비교 - 낙원 : 1011
							$("#movies", opener.document).find('.title').each(function(idx) {
								dupCheck="";
								var title = $("#movies", opener.document).find('.title').eq(idx).text();
								// 중복되는 것이 없는 경우 Y
								if(title!=title5){
									dupCheck="Y";
// 										alert("판별결과 : " + dupCheck)
								} else {
									// 하나라도 중복되는경우 값은N으로 변경 후 리턴으로 반복문 종료 - 낙원 : 1011
									dupCheck="N";
// 										alert("판별결과 : " + dupCheck)
										return false;
								}
								
							});
							
							
							// 판별결과 Y인 경우 #movies에 슬라이드 추가 - 낙원 : 1011
							if(dupCheck=="Y"){
								 // 포스터랑 타이틀 나오는 부분 디자인 수정때문에 코드 변경 & 슬라이드 추가구문 추가  - 낙원 : 1011[S]
		     	   	            $("#movies", opener.document).slick('slickAdd',"<div class=collectionList>"+ 
	 	  			      			    '<div class=poster style="background-image: url('+image[0]+')"></div>'+ 
	 	  			      				'<div class=title>'+title5+
	 	  			      				"</div>" +
	 	  			      				"<input type='hidden' value='"+ movieSeq + "'name = 'movieSeq' id='movieSeq'>" +
	 	  			      				"<input type='hidden' value='"+ poster + "'name = 'poster'>" +
	 	  			      				"<input type='hidden' value='"+ title5 + "'name = 'title'></div>")

								 // 포스터랑 타이틀 나오는 부분 디자인 수정때문에 코드 변경 & 슬라이드 추가구문 추가  - 낙원 : 1011[E]
							} else { // N인경우 중복이므로 중복된 영화라고 알림창 출력 - 낙원 : 1011
								alert("같은 영화를 중복으로 추가하실 수 없습니다.")
							}
							
						}
						// #movies객체가 존재 하지 않을경우(null)을 판별. 객체가 없는 상태이므로 객체를 추가하는 구문을 추가함 - 낙원 : 1011[E]
	     	   				

  	   						}
  	 					});
                 	});
//                   else{
//                      $('#actorList').append('<div class=poster><img src=../../../Movie/img/noImage.gif></div>');
//                   }
                     });
            });
            
            $('#actorList').slick({
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
              }); // slick(actorList)끝
            
            
            
         }
   });
      // 감독검색을 담당하는 Jquery문
      $.ajax('MovieSearchDirectorPro.mo',{
         method:"post",
         dataType :"json",
         data:{query:query},
         success:function(data){
            
            $.each(data.Data,function(idx,item){
               
               var count = item.Count
                  
               $.each(item.Result,function(idx,item2){
                  
                  var title = item2.title
                  var titleNoSpace = title.replace(/ /g, '');
                  var title2 = titleNoSpace.replace(/!HS/g,'');
                  var title3 = title2.replace(/!HE/g,'');
                  var title5 = title3.trim();
                  var title6 =  encodeURIComponent(title5);
                  var actors="";
                  
                  var image = item2.posters.split("|")
                  
                  for(var num = 0; num < item2.actor.length ; num++){
                     actors = actors + item2.actor[num].actorNm + ", ";   
                  }
                     
                  if(image[0]){
                     $('#directorList').append("<div class=koreaMovie>"+
                           '<div class=poster><a href=MovieDetailBySearch.mo?movieId='+item2.movieId+'&movieSeq='+item2.movieSeq+'&query='+title6+'&image='+image[0]+'&temp='+temp+'&weather='+weather+'><img style=width:250px;height:350px;padding-right:20px; src='+image[0]+'></a></div>'+
                           '<div class=nation>'+item2.nation+'</div>'+
                           '<div class=rating>'+item2.rating[0].ratingGrade+'</div>'+
                           '<div class=title>'+title5+'</div>' +
                           "<input type='button' value='담기' style=margin-left:-50px; id='" + item2.movieSeq + "'</div>");
                  } 
                  $('#directorList').on('click', '#'+item2.movieSeq, function() {
//               	 $("#movies", opener.document).text("<li>"+item2.movieSeq+"</li>");

						 var movieSeq = item2.movieSeq;
						 var poster = image[0];
              	 $.ajax('CollectionMovieAdd.mp',{
	   					data:{nick:nick,movieSeq:movieSeq,title:title5,poster:poster},
	   					success:function(rdata){
//	   							$("#movies", parent.opener.document).val();
//	  			 				opener.location.reload();


	   						var dupCheck="";

								// #movies객체가 존재 하지 않을경우(null)을 판별. 객체가 없는 상태이므로 객체를 추가하는 구문을 추가함 - 낙원 : 1011[S]
								if($("#movies", opener.document).find('.title').length==0){
									dupCheck="Y";
	//									alert("판별결과 널 : " + dupCheck)
									 // 슬라이드에 객체 추가하는 구문 - 낙원 : 1011
									 // 포스터랑 타이틀 나오는 부분 디자인 수정때문에 코드 변경 & 슬라이드 추가구문 추가  - 낙원 : 1011[S]
				     	   	            $("#movies", opener.document).slick('slickAdd',"<div class=collectionList>"+ 
			 	  			      			    '<div class=poster style="background-image: url('+image[0]+')"></div>'+ 
			 	  			      				'<div class=title>'+title5+
			 	  			      				"</div>" +
			 	  			      				"<input type='hidden' value='"+ movieSeq + "'name = 'movieSeq' id='movieSeq'>" +
			 	  			      				"<input type='hidden' value='"+ poster + "'name = 'poster'>" +
			 	  			      				"<input type='hidden' value='"+ title5 + "'name = 'title'></div>")
		
										 // 포스터랑 타이틀 나오는 부분 디자인 수정때문에 코드 변경 & 슬라이드 추가구문 추가  - 낙원 : 1011[E]
									return false;
								}else{ // #movies가 존재하는 경우
									// each문으로 mypage의 #movies에 있는 title값을 가져와서 비교 - 낙원 : 1011
									$("#movies", opener.document).find('.title').each(function(idx) {
										dupCheck="";
										var title = $("#movies", opener.document).find('.title').eq(idx).text();
										// 중복되는 것이 없는 경우 Y
										if(title!=title5){
											dupCheck="Y";
	// 											alert("판별결과 : " + dupCheck)
										} else {
											// 하나라도 중복되는경우 값은N으로 변경 후 리턴으로 반복문 종료 - 낙원 : 1011
											dupCheck="N";
	// 											alert("판별결과 : " + dupCheck)
												return false;
										}
										
									});
									
									
									// 판별결과 Y인 경우 #movies에 슬라이드 추가 - 낙원 : 1011
									if(dupCheck=="Y"){
										 // 포스터랑 타이틀 나오는 부분 디자인 수정때문에 코드 변경 & 슬라이드 추가구문 추가  - 낙원 : 1011[S]
				     	   	            $("#movies", opener.document).slick('slickAdd',"<div class=collectionList>"+ 
			 	  			      			    '<div class=poster style="background-image: url('+image[0]+')"></div>'+ 
			 	  			      				'<div class=title>'+title5+
			 	  			      				"</div>" +
			 	  			      				"<input type='hidden' value='"+ movieSeq + "'name = 'movieSeq' id='movieSeq'>" +
			 	  			      				"<input type='hidden' value='"+ poster + "'name = 'poster'>" +
			 	  			      				"<input type='hidden' value='"+ title5 + "'name = 'title'></div>")
		
										 // 포스터랑 타이틀 나오는 부분 디자인 수정때문에 코드 변경 & 슬라이드 추가구문 추가  - 낙원 : 1011[E]
									} else { // N인경우 중복이므로 중복된 영화라고 알림창 출력 - 낙원 : 1011
										alert("같은 영화를 중복으로 추가하실 수 없습니다.")
									}
									
								}
								// #movies객체가 존재 하지 않을경우(null)을 판별. 객체가 없는 상태이므로 객체를 추가하는 구문을 추가함 - 낙원 : 1011[E]
	   						}
	 					});
              	});
//                   else{
//                      $('#directorList').append('<div class=poster><img src=../../../Movie/img/noImage.gif></div>');
//                   }
                     });
            });
            
            
            $('#directorList').slick({
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
              }); // slick(directorList)끝
              
              
            
         }
   });
      
      
      
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
</head>
<body>
<section id="main">
<jsp:include page="/inc/collectionTop.jsp" />
<div class="clear"></div>
<%String query=request.getParameter("query"); %>
<%String nick = (String)session.getAttribute("nick"); %>
   <input type="hidden" id="query" name=query value="<%=query%>">
   <input type="hidden" id="nick" name=nick value="<%=nick%>">
   <input type="hidden" id="temp">
   <input type="hidden" id="weather">
<div class="content">   
<h1>국내영화</h1>
   <section id="koreaList">
   </section>
</div>
<div class="content">   
<h1>국외영화</h1>
   <section id="foreignList">
   </section>
</div>
<div class="content">   
<h1>영화인 검색 결과</h1>
   <section id="actorList"></section>
</div>
<div class="content">   
<h1>감독 검색 결과</h1>
   <section id="directorList"></section>
</div>
</section>
<div class="moveTop" style="cursor:pointer;">TOP</div>

<style type="text/css">
.title{width: 250px;text-align: center;text-overflow: ellipsis;white-space: nowrap;overflow: hidden;}
.nation{width: 250px;text-align: center;text-overflow: ellipsis;white-space: nowrap;overflow: hidden;}
.rating{width: 250px;text-align: center;text-overflow: ellipsis;white-space: nowrap;overflow: hidden;}
.koreaMovie {text-align: center;width: 250px;height:400px;margin-right: 20px;}
.foreignMovie {text-align: center;width: 250px;height:400px;margin-right: 20px;}
.actorMovie {text-align: center;width: 250px;height:400px;margin-right: 20px;}
.directorMovie {text-align: center;width: 250px;height:400px;margin-right: 20px;}
/* .foreignMovie.poster{text-align: center;} */
/* .foreignMovie>.title{text-align: center;text-overflow: ellipsis;white-space: nowrap;} */
/* .actorMovie {text-align: center;width: 250px;height:350px;} */
/* .actorMovie.poster{text-align: center;} */
/* .actorMovie>.title{text-align: center;text-overflow: ellipsis;white-space: nowrap;} */
/* .directorMovie {text-align: center;width: 250px;height:350px;} */
/* .directorMovie.poster{text-align: center;} */
/* .directorMovie>.title{text-align: center;text-overflow: ellipsis;white-space: nowrap;} */
.poster{width:250px;height:350px;background-size: 100%;margin-right:20px;margin-top:20px;margin-left:10px;}
.content{border:1px solid black;margin:20px auto;padding:20px 0px;background-color: rgba(240,255,255,0.1);border-radius: 10px 10px 10px 10px;}
.slick-track{background-color: #000000;border-radius: 10px 10px;}
.title,.nation,.rating{
	overflow:hidden;
	width:250px;
	text-align: center;
	text-overflow: ellipsis;
	white-space: nowrap;
	color:#FFFFFF;
}
h1,h2,h3,h4,h5,h6 {
font-family: -apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,"Noto Sans",sans-serif,"Apple Color Emoji","Segoe UI Emoji","Segoe UI Symbol","Noto Color Emoji";
color: #FFFFFF;
}
body{background-color: #14141f;}
</style>
</body>
</html>