<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
    
    function movie(movieCd) {
        $("#memo").empty();
        
        var url = "http://ync.jupiterflow.com/jquery/searchMovieInfo?key=" + serviceKey + "&movieCd=";
        url = url + movieCd;
    
        $.ajax({
            url: url,
            type: "GET",
            dataType: "xml",
            success: function (movie_data) {
                console.log(movie_data);
                
                var str = "";
                str = str + "<img src='" + $(movie_data).find("imgSrc").text() + "'><a href=''></a>";
                str = str + "<a href='" + $(movie_data).find("naverMovieSrc").text() + "'>네이버바로가기</a>" ;
                str = str + "<div>" + $(movie_data).find("movieNm").text() + "(";
                str = str + $(movie_data).find("movieNmEn").text() + ")</div>";
    
                str = str + "<div>" + $(movie_data).find("nationNm").text() + ", " + $(movie_data).find("openDt").text() + "개봉, " + $(movie_data).find("showTm").text() + "분</div>";
    
                str = str + "<ul>";
               
                $(movie_data).find("actor").each(function () {
                    str = str + "<li>" + $(this).find("peopleNm").text() + "</li>";
                });
                
                str = str + "</ul>";
                $("#memo").append(str);
            },
            
            error: function () {
                alert("Error...");
            }
            
        });
    }
    
</script>
</head>
<body>
    <h1>박스오피스 순위</h1>
    <div id="choice">
        <input type="date" id="today">
        <button id="ok">확인</button>
    </div><br>
    <div id="title"><b>일별 박스오피스</b></div>
    <hr>
    <div id="list"></div>
    <hr>
    <div id="memo"></div>
</body>
</html>