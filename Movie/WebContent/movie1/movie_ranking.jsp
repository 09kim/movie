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
      
       var serviceKey = "4d549b0bc63467abbc7ffe4a1169333a"; // 박스오피스 발급키
   
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
       
       var movieNm = $("movieNm").val();
       var openDt = $("#openDt").val();
       $.ajax({
            url: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key="
                  + serviceKey + "&targetDt=" + today + "&itemPerPage=10",
                    // &itemPerPage: 1-10위 까지의 데이터가 출력되도록 설정(최대 10)
            method:"get",       
            dataType: "json",
            data: {
                openDt:openDt,
                movieNm:movieNm
            },
            success: function(data) {
//             alert('성공');
                
               $.each(data, function(idx, item) {
                  
                   for(var i = 0; i < 10; i++){ // 영화 10개까지 받아오기
                       var title = item.dailyBoxOfficeList[i].movieNm;
                       var titleNoSpace = title.replace(/ /g, '');
                       
                       $('#ranking').append('<td>' + (i+1) + '</td>'); // 순위
//                        $('#poster').append('<td>' + item.dailyBoxOfficeList[i].movieNm + '</td>'); // 포스터
                       $('#movieName').append('<td><a href=MovieDetailPro.mo?movieNm='+titleNoSpace+'&openDt='+item.dailyBoxOfficeList[i].openDt+'> '+item.dailyBoxOfficeList[i].movieNm + '</a></td>'); // 영화명
                       $('#openDate').append('<td>' + item.dailyBoxOfficeList[i].openDt + '</td>'); // 개봉일
                       $('#audiAcc').append('<td>' + item.dailyBoxOfficeList[i].audiAcc + '</td>'); // 누적관객수
                   }
                });
            }
       });
       
       $.ajax({
          url: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.json?key=" + serviceKey + "&itemPerPage=10",
          method: "get",
          dataType: "json",
          data: {
              openDt:openDt
          },
          success: function(data) {
//           alert('성공');
              $.each(data, function(idx, item) {
              
                  for(var i = 0; i < 10; i++){
                  
                      $('#nation').append('<td>' + item.movieList[i].repNationNm + '</td>'); // 제작 국가
                      $('#code').append('<td>' + item.movieList[i].movieCd + '</td>'); // 영화 코드
//                      console.log(item.movieList.directors[i].peopleNm);
                  }
              });
          }
       });
   });
   
   
</script>
</head>
<body>
<%
String openDt = request.getParameter("openDt");
String movieNm = request.getParameter("movieNm");
%>
    <h1>박스오피스 순위</h1>
    <input type="hidden" id="openDt" value="<%=openDt %>">
    <input type="hidden" id="movieNm" value="<%=movieNm %>">
    <table border="1">
       <tr><th>순위</th><td id="ranking"></td></tr>
       <tr><th>포스터</th><td id="poster"></td></tr>
       <tr><th>영화명</th><td id="movieName"></td></tr>
       <tr><th>개봉일</th><td id="openDate"></td></tr>
       <tr><th>제작국가</th><td id="nation"></td></tr>
       <tr><th>영화코드</th><td id="code"></td></tr>
       <tr><th>누적관객수</th><td id="audiAcc"></td></tr>
    </table>
</body>
</html>