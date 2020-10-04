<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<%-- <link href="${pageContext.request.contextPath}/css/movieboard.css" rel="stylesheet" type="text/css"> --%>
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
   
      
    var director = $("#director").val();
	director = director.replace(/ /g,'');
      // 감독검색을 담당하는 Jquery문
      $.ajax('MovieSearchDirectorPro.mo',{
         method:"post",
         dataType :"json",
         data:{query:director},
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
                 			 '<div class=poster><a href=MovieDetailBySearch.mo?movieId='+item2.movieId+'&movieSeq='+item2.movieSeq+'&query='+title6+'&image='+image[0]+'&temp='+temp+'&weather='+weather+'><img style=width:250px;height:350px; src='+image[0]+'></a></div>'+
                 			 '<div class=nation>'+item2.nation+'</div>'+
                 			 '<div class=rating>'+item2.rating[0].ratingGrade+'</div>'+
                 			 '<div class=title>'+title5+'</div></div>');
                  }
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
      
   
      
}); // ready()끝;
      
</script>
<style>
.title{width: 250px;text-align: center;text-overflow: ellipsis;white-space: nowrap;overflow: hidden;}
.nation{width: 250px;text-align: center;text-overflow: ellipsis;white-space: nowrap;overflow: hidden;}
.rating{width: 250px;text-align: center;text-overflow: ellipsis;white-space: nowrap;overflow: hidden;}
.koreaMovie {text-align: center;width: 250px;height:400px;margin-right: 20px;}
.foreignMovie {text-align: center;width: 250px;height:400px;margin-right: 20px;}
.actorMovie {text-align: center;width: 250px;height:400px;margin-right: 20px;}
.directorMovie {text-align: center;width: 250px;height:400px;margin-right: 20px;}
</style>
</head>
<body>
<section id="main">
<jsp:include page="/inc/top.jsp" />
<div class="clear"></div>
<%String director=request.getParameter("director"); %>
<%String nick = (String)session.getAttribute("nick"); %>
<input type="hidden" id="director" name=director value="<%=director%>">
<input type="hidden" id="temp">
<input type="hidden" id="weather">


<h1>감독 검색 결과</h1>
   <section id="directorList"></section>
</section>

</body>
</html>