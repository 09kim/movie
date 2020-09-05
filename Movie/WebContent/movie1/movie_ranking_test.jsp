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
       
       $.ajax({
            url: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key="
                  + serviceKey + "&targetDt=" + today + "&itemPerPage=10",
                    // &itemPerPage: 1-10위 까지의 데이터가 출력되도록 설정(최대 10)
            type:"get",       
            dataType: "json",
            success: function(data) {
//             alert('성공');
               $.each(data, function(idx, item) {
            	   
                   for(var i = 0; i < 10; i++){
//                 	    $('#test').html(item.dailyBoxOfficeList[i].movieNm);
//                 	    $('#test1').html(item.dailyBoxOfficeList[i].openDt);
                	    console.log(item.dailyBoxOfficeList[i].movieNm);
                	    console.log(item.dailyBoxOfficeList[i].movieCd);
                	    console.log(item.dailyBoxOfficeList[i].openDt);
                	    console.log(item.dailyBoxOfficeList[i].audiAcc);
                        
                   }
                   
                });

            }
         
       });
      
   });
   
   
</script>
</head>
<body>
    <h1>박스오피스 순위</h1>
    <div id="test"></div>
    <div id="test1"></div>
</body>
</html>