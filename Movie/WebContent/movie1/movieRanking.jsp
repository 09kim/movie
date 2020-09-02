<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>박스오피스 영화 순위</title>
<script src="../../../Movie/js/jquery-3.5.1.js"></script>
<script type="text/javascript">

	//var xhr = new XMLHttpRequest();
	//xhr.open('GET', "   http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=4d549b0bc63467abbc7ffe4a1169333a&targetDt=" + today);
	// xhr.send();
	
	// // 하루 전 날짜 구하기
	// var d = new Date();
	// var yy = d.getFullYear();
	// var mm = d.getMonth() + 1; // 리턴값: (0~11) +1 => 1월~12월
	// var dd = d.getDate() - 1; // 하루 전 날짜 
	// var todqy = '${yy}${mm}${dd}';
	
	// $.ajax({
	//     type: 'get',
	//     url: 'http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.json?key=4d549b0bc63467abbc7ffe4a1169333a&movieNm=' + 영화이름 + '&directorNm=' + 감독이름,
	//     success: function (data) {
	//         var movieData = data.movieListResult;
	        
	//         for (var i = 0; i < movieData.movieList.length; i++) {
	//             var movieCode = movieData.movieList[i].movieCd;
	//             var Opendate = movieData.movieList[i].openDt; 
	//             var movieName = movieData.movieList[i].movieNm; 
	//             var movieGenre = movieData.movieList[i].genreAlt; 
	//             var movieNation = movieData.movieList[i].nationAlt; 
	//             var movieDirectors = movieData.movieList[i].directors;
	//         }
	//     }
	// });
	


	// 조회할 날짜 계산
	var dt = new Date();
	
	var m = dt.getMonth() +1;
	
	if(m < 10) {
		var month = "0" + m;
	} else {
		var month = m + "";
	}
	
	var d = dt.getDate() -1;
	
	if(d < 10) {
		var day = "0" + d;
	} else {
		var day = d + "";
	}
	
	var y = dt.getFullYear();
	var year = y + "";
	
	var result = year + month + day;
	
	$(function() {
		$.ajax({
			url: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.xml?key=4d549b0bc63467abbc7ffe4a1169333a&targetDt="
					+ result + "&itemPerPage=10",
					// &itemPerPage: 1-10위 까지의 데이터가 출력되도록 설정
			dataType: "xml",
			success: function(data) {
				var $data = $(data).find("boxOfficeResult>dailyBoxOfficeList>dailyBoxOffice");
				
				// 데이터를 테이블 구조에 저장. html의 table태그, class는 table로 하여 부트스트랩 적용
				if($data.length > 0) {
					var table = $("<table/>").attr("class", "table");
					
					// <table>안에 테이블의 컬럼 타이틀 부분인 thead 태그
					var thead = $("<thead/>").append($("<tr/>")).append(
							// 추출하고자 하는 컬럼들의 타이틀 정의
							$("<th/>").html("순위"),
							$("<th/>").html("영화 제목"),
							$("<th/>").html("개봉일"),
							$("<th/>").html("누적 관객수"));
					
					var tbody = $("<tbody/>");
					$.each($data, function(i, o) {
						
						// 오픈 API에 정의된 변수와 내가 정의한 변수 데이터 파싱
						var $rank = $(o).find("rank").text(); // 순위
						var $movieName = $(o).find("movieName").text(); // 영화 제목
						var $relDate = $(o).find("relDate").text(); // 개봉일
						var $accAudi = $(o).find("accAudi").text(); // 누적 관객수
						
						// <tbody><tr><td>태그안에 파싱하여 추출된 데이터 넣기
						var row = $("<tr/>").append(
								$("<td/>").text($rank),
								$("<td/>").text($movieName),
								$("<td/>").text($relDate),
								$("<td/>").text($accAudi));
						
						tbody.append(row);
						
					});
					
					table.append(thead);
					table.append(tbody);
                    $(".wrap").append(table);
				}
			},
			
			// 에러 발생시 "실시간 박스오피스 로딩중..." 메시지 출력
			error: function() {
				alert("실시간 박스오피스 로딩중...");
			}
			
		});
	});
	
</script>
<style type="text/css">
tbody>tr>td:hover {
	background: #ccc;
}
</style>
</head>
<body>
    <h1>실시간 박스오피스</h1>
    <div class="wrap">
        <table>
            <tr>
                <th></th><td></td>
                <th></th><td></td>
                <th></th><td></td>
                <th></th><td></td>
            </tr>       
        </table>
    </div>
</body>
</html>