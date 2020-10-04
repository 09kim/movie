<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%String nick = (String)session.getAttribute("nick"); %>
<title>Insert title here</title>
<!-- <meta charset="utf-8"> -->
<!-- <meta http-equiv="X-UA-Compatible" content="IE=edge"> -->
<!-- <meta name="viewport" content="width=device-width, initial-scale=1"> -->
<%-- <link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet"> --%>
<!-- <script src="js/bootstrap.min.js"></script> -->
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/movieboard.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.min.css">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	
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
                		  result = image[0] +"|"+item2.nation + "|"+item2.movieSeq;
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
       var dd = d.getDate()  ;
       if(d.getDay()!=1){
    	   dd = dd-d.getDay();
       }
//           alert(dd); // 일요일 구하는 메서드
		if(dd<=0){
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
                       
                       
                       $('.boxOffice').append("<div class=movie><div class=ranking></div>"+
                    		   "<img class=poster_img>"+
                    		   "<div><a class=movieName></a></div>"+
                    		   "<div class=openDate></div><div class=audiAcc></div><div class=nation></div></div>");
                       result = getNation(openDt,titleNoSpace);
                       result = result.split("|");
                       if(result[0]){
                       		$('.poster_img').eq(idx2).attr("src",result[0]);
                       }else{
                    	 	$('.poster_img').eq(idx2).attr("src","../../../Movie/img/noImage.gif");
                       }
             		   $('.nation').eq(idx2).text(result[1]);
                       $('.movieName').eq(idx2).attr('href','MovieDetailPro.mo?query='+titleNoSpace+'&movieSeq='+result[2]);
                       $('.movieName').eq(idx2).text(item2.movieNm);
                       
                      
                       
                       
            	   });
            	  
                   
                });
               $('.boxOffice').slick({
            	   dots: false,
            	   infinite: false,
            	   arrows: true,
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
</head>
<body>
<input type="hidden" value="<%=nick%>">
<%-- <jsp:include page="/inc/top.jsp" /> --%>
    <h1>박스오피스 순위</h1>
    <div class="boxOffice"></div>


</body>
</html>