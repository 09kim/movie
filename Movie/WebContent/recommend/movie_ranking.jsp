<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%String nick = (String)session.getAttribute("nick"); %>
<title></title>
<script type="text/javascript">
$(document).ready(function() {
	
	// 태윤's 장소 확인 및 날씨 정보 기능 ranking에도 추가함 - 낙원
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
	
	
	
	
	
	
	
       var result;
       function getNation(openDt,title){
    	   $.ajax("BoxOfficeNation.mo",{
               method: "get",
               dataType: "json",
               async: false, // ajax 방식일때 리턴값만 비동기로 바꿔주는 부분
               data : {
            	   openDt:openDt,
            	   title:title
            	   	},
               success: function(data) { 
                   $.each(data.Data, function(idx, item) {
                	  $.each(item.Result,function(idx2,item2){
                		  var image = item2.posters.split("|");
//                 		  result = image[0] +"|"+item2.nation + "|"+item2.movieSeq;
                		  result = image[0] +"|"+item2.nation + "|"+item2.movieSeq +"|"+item2.movieId +"|"+item2.rating[0].ratingGrade; // 밑에 영화포스터 링크(a 태그)안에 movieId,ratingGrade 포함해야해서 추가함 - 낙원
                	  });
                   });
                   
               }
      	  });
    	   return result;
    	   
       }
   
       // 하루 전 날짜 구하기
       var d = new Date();
       var yy = d.getFullYear();
       var mm = d.getMonth() + 1; // 리턴값: (0~11) +1 => 1월~12월
       var dd = d.getDate();
       
       if(d.getDay()!=0){
    	   dd = dd-d.getDay();
       }else{
    	   dd = -7; 
       }
		if(dd<=0){ // 마지막 일요일이 지난달일경우 계산하는 계산 식
			var lastDay = new Date(yy,mm-1,0).getDate();
			dd = lastDay - Math.abs(dd);
			mm = mm-1;
		}
		
		 if(mm < 10){
             mm = "0" + mm; 
          }
          if(dd < 10){
             dd = "0" + dd;
          }
		
       var today = yy + "" + mm + "" + dd; // 박스오피스에서 정해준 날짜 형식(yyyymmdd)으로 변환
       $.ajax({
            url: "BoxOffice.mo",
                    // &itemPerPage: 1-10위 까지의 데이터가 출력되도록 설정(최대 10)
            method:"get",       
            dataType: "json",
            data: {
            	targetDt:today,
            },
            success: function(data) {
               $.each(data, function(idx, item) {
            	   $.each(item.weeklyBoxOfficeList, function(idx2,item2){
            		   var title = item2.movieNm;
                       var titleNoSpace = title.replace(/ /g, '');
                       var openDt = item2.openDt.replace(/-/g,'');
                       var num =0;
                       
                       // 기존 movie_ranking 양식에 맞춰서 만든것 - 낙원:0930
                       $('.boxOffice').append("<div class=movie><div class=ranking></div>"+
                    		   "<div><a class=poster><img class=poster_img></a></div>"+ // title 대신에 포스터클릭하면 넘어가게끔 변경 - 낙원:0930
//                     		   "<div><a class=movieName></a></div>"+
                    		   "<div class =movieName></div>"+
                    		   "<div class=openDate></div><div class=audiAcc></div><div class=nation></div><div class=rating></div></div>"); // rating 추가 - 낙원 : 0930
                       result = getNation(openDt,titleNoSpace);
                       result = result.split("|");
                       
                       temp = $('#temp').val();
      	               weather = $('#weather').val();
                       if(result[0]){
                       		$('.poster_img').eq(idx2).css("width","250px").css("height","350px");
                       		$('.poster_img').eq(idx2).attr("src",result[0]);
                       }else{
                    	   $('.poster_img').eq(idx2).css("width","250px").css("height","350px");
                    	 	$('.poster_img').eq(idx2).attr("src","../../../Movie/img/noImage.gif");
                       }
             		   $('.nation').eq(idx2).text(result[1]);
             		   $('.rating').eq(idx2).text(result[4]);
                       $('.poster').eq(idx2).attr('href','MovieDetailBySearch.mo?movieId='+result[3]+'&movieSeq='+result[2]+'&query='+titleNoSpace+'&image='+result[0]);
                       $('.movieName').eq(idx2).html(item2.movieNm);
                       
                      
                       
                       
            	   });
            	  
                   
                });
               $('.boxOffice').slick({
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
            	 });
               
            }
       });
       
       
       
   });
   
   
</script>
<style>
.rating{width:250px;text-overflow: ellipsis;white-space: nowrap;overflow: hidden;text-align: center;}
.poster{width:250px;text-overflow: ellipsis;white-space: nowrap;overflow: hidden;text-align: center;}
.nation{width:250px;text-overflow: ellipsis;white-space: nowrap;overflow: hidden;text-align: center;}
.movieName{width:250px;text-overflow: ellipsis;white-space: nowrap;overflow: hidden;text-align: center;}
.movie {width: 250px;height:400px;margin-right: 20px;padding:0;}
</style>
</head>
<body>
<input type="hidden" value="<%=nick%>">
    <h1>박스오피스 순위</h1>
    <div class="boxOffice"></div>


</body>
</html>