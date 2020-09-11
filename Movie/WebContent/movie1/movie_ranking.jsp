<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../../../Movie/js/jquery-3.5.1.js"></script>
<script>

   $(document).ready(function() {
      
       
//        function getNation(movieCd){
//     	   $.ajax("BoxOfficeNation.mo",{
//                method: "get",
//                dataType: "json",
//                data : {
//             	   movieCd:movieCd
//             	   	},
//                success: function(data) { 
//                    $.each(data, function(idx, item) {
//                 	  $.each(item.movieInfo,function(idx2,item2){
//                 			 alert(item2[3] );
//                 	  });
//                    });
//                }
//      	  });
//        }
   
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
//        alert(today);
       
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
                       $('.boxOffice').append("<div class=ranking></div>"+
                    		   "<div><a class=movieName></a></div>"+
                    		   "<div class=openDate></div><div class=audiAcc></div><div class=nation></div>");
                       $('.movieName').eq(idx).text(item2.movieNm);
                       $('.movieName').eq(idx).attr('href','MovieDetailPro.mo?movieNm='+titleNoSpace+'&openDt='+item2.openDt);
//                        var nation = getNation(item2.movieCd);
//                        $('.nation').eq(idx).text(nation);
            	   });
            	   
//                     for(var i = 0; i < 10; i++){ // 영화 10개까지 받아오기
                       
//                        $('#ranking').append('<td>' + (i+1) + '</td>'); // 순위
//                        $('#poster').append('<td>' + item.dailyBoxOfficeList[i].movieNm + '</td>'); // 포스터
//                        $('#movieName').append('<td><a href=MovieDetailPro.mo?movieNm='+titleNoSpace+'&openDt='+item.dailyBoxOfficeList[i].openDt+'> '+item.dailyBoxOfficeList[i].movieNm + '</a></td>'); // 영화명
//                        $('#openDate').append('<td>' + item.dailyBoxOfficeList[i].openDt + '</td>'); // 개봉일
//                        $('#audiAcc').append('<td>' + item.dailyBoxOfficeList[i].audiAcc + '</td>'); // 누적관객수
                       
//                    }
                   
                });
            }
       });
       
      
       
       
   });
   
   
</script>
</head>
<body>
<%
%>
    <h1>박스오피스 순위</h1>
    
    <div class="boxOffice"></div>
</body>
</html>