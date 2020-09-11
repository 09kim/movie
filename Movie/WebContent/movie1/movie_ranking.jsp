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

    var serviceKey = "4d549b0bc63467abbc7ffe4a1169333a"; // 박스오피스 발급키
        
    $(document).ready(function () {
        document.getElementById("today").valueAsDate = new Date(); // 날짜
    
        $("#ok").click(function () {
            $("#list").empty();
            $("#memo").empty();
    
            var url = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.xml?key=" + serviceKey + "&targetDt=";
            
            date_list = $('#today').val().split('-');
            url = url + date_list[0] + date_list[1] + date_list[2];
    
            $.ajax({
                url: url,
                type: "GET",
                dataType: "xml",
                success: function (mydata) {
                    var str = "";
    
                    if ($(mydata).find("dailyBoxOffice").text() == "") {
                        $("#list").append("자료가 없습니다.");
                        return;
                    }
                    
                    $(mydata).find("dailyBoxOffice").each(function () {
                        str = str + $(this).find("rank").text() + "위 "
    
                        str = str + "<a href='#' onclick='javascript:movie(" + $(this).find("movieCd").text() + ")'>";
                        str = str + $(this).find("movieNm").text() + "</a>";
    
                        str = str + " (전일대비 ";
                        rankInten = eval($(this).find("rankInten").text());
                        if (rankInten > 0) {
                            str = str + "+" + rankInten + ", "
                        } else if (rankInten < 0) {
                            str = str + "-" + Math.abs(rankInten) + ", "
                        } else {
                            str = str + rankInten + ", "
                        }
    
                        str = str + "누적관객수 " + $(this).find("audiAcc").text() + "명)<br>";
                    });
                    
                    $("#list").append(str);
                },
                
                error: function () {
                    $("#list").append("Error...");
                }
                
            });
        });
    });
    
   
    
</script>

</head>
<body>
<!-- 헤더 -->
<jsp:include page="/inc/top.jsp" />
<div class="clear"></div>
<!-- 헤더 -->

<section id="main">
    <div id="boxoffice">
	    <div id="boxoffice-head">
		    <header>
	    		<h1>박스오피스 순위</h1>
		    </header>
		    <div id="choice">
		    	<b>일별 박스오피스</b>
		        <input type="date" id="today">
		        <button id="ok">확인</button>
		    </div>
	    </div>
<!-- 	    <div id="title"><b>일별 박스오피스</b></div> -->
		<div class="clear"></div>
	    <hr>
	    <div id="list"></div>
	    <hr>
	    <div id="memo"></div>
    </div>
</section>
</body>
</html>