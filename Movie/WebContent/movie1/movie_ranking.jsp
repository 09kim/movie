<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/default.css" rel="stylesheet" type="text/css">
<link href="css/movieboard.css" rel="stylesheet" type="text/css">
<script src="../../../Movie/js/jquery-3.5.1.js"></script>
<script>

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
                		  result = image[0] +"|"+item2.nation;
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
       var dd = d.getDate() - 1; // 하루 전 날짜 
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
            	   $.each(item.dailyBoxOfficeList, function(idx,item2){
            		   var title = item2.movieNm;
                       var titleNoSpace = title.replace(/ /g, '');
                       var openDt = item2.openDt.replace(/-/g,'');
                       $('.boxOffice').append("<div class=ranking></div>"+
                    		   "<img class=poster_img>"+
                    		   "<div><a class=movieName></a></div>"+
                    		   "<div class=openDate></div><div class=audiAcc></div><div class=nation></div>");
                       $('.movieName').eq(idx).text(item2.movieNm);
                       $('.movieName').eq(idx).attr('href','MovieDetailPro.mo?movieNm='+titleNoSpace+'&openDt='+openDt);
                       result = getNation(openDt,titleNoSpace);
                       result = result.split("|");
                       $('.poster_img').eq(idx).attr("src",result[0]);
             		   $('.nation').eq(idx).text(result[1]);
            	   });
            	   
                   
                });
            }
       });
       
      
       
       
   });
   
   
</script>

</head>
<body>
<jsp:include page="/inc/top.jsp" />
<div class="clear"></div>
<%
%>
    <h1>박스오피스 순위</h1>
    <div class="boxOffice"></div>
<!-- 헤더 -->
<!-- 헤더 -->
</body>
</html>