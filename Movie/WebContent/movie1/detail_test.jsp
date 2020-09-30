<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {
  font:14px/1.8 Arial, Helvetica, sans-serif;
}
.frame {
  width: 1000px;
  margin: 0 auto;
  border: 1px solid #aaa;
}
.header {
  padding:40px 10px;
  text-align: center;
  background: #eee;
  margin-bottom: 20px;
}
.logo {
  font-size: 2em;
  font-weight: bold;
  background: #5457de;
  color: #fff;
  display: inline-block;
  padding: 0 8px;
}
#detail {
  overflow: hidden;
}
.poster {
  float: left;
  width: auto;
  height: auto;
/*   background: #333; */
/*   color: #fff; */
  margin-right: 50px;
}
/* .poster-list { */
/*   list-style: none; */
/*   margin: 0; */
/*   padding: 10px 0; */
/* } */
/* .poster-item { */
/*   margin: 4px 0; */
/* } */
/* .poster-link { */
/*   display: block; */
/*   text-decoration: none; */
/*   padding: 4px 10px; */
/*   color: #fff; */
/* } */
/* .poster-link:hover { */
/*   background: #5457de; */
/* } */
.content {
  float: left;
  width: 600px;
}
.footer {
  text-align: center;
  border-top: 1px solid #aaa;
  margin: 20px 20px 0;
  font-size: 12px;
}
#detail {
  display: table;
}
.poster, .content {
  display: table-cell;
}
#detail {
padding: 30px;
/*   background: #333; */
}
.content {
  background: #fff;
}
#detail {
/*   background: url('img/bg.png') repeat-y #fff; */
}
dt {float: left;}
</style>
</head>
<body>
<div class="frame">
  <div id="detail">
    <div class="poster">
					<img src="../../../Movie/img/noImage.gif" alt="[독점] 괜찮아요? 프리랜서" class="image-cover" onError="this.src='../../../Movie/img/noImage.gif'">
	</div>
    <!-- //poster -->
    <div class="content">
     
				<div class="movie-detail__info-description">
					<dl class="info">
						<dt>상영국가</dt>
						<dd>대한민국</dd>
						<dt>감독</dt>
						<dd><a class="under" href="https://www.tving.com/find/main.do?kwd=%EB%82%98%EC%99%80%ED%8F%B0%20%ED%83%90%EB%A1%B1%EB%9D%BC%ED%83%80%EB%9D%BC%EB%8B%9B">나와폰 탐롱라타라닛</a></dd>
						<dt>출연</dt>
						<dd>다비카 후네, 써니 수완메타논트</dd>
					</dl>
					<p class="summary">
						[티빙 익스클루시브] 오직 티빙에서, 티빙 이용권만 있다면!
30세의 프리랜서 그래픽 디자이너 겸 리터쳐 ′윤′
매주 마감 압박에 시달리지만 자신의 일에 만족하며 살아간다.

그러다, 온몸에 이유를 알 수 없는 발진이 일어나고 병원을 찾아간 ′윤′
그곳에서 그는 피부과 의사 ′임′을 만나 사랑에 빠진다.

시간에 쫓기는 업무 압박 속에서
사랑하는 이를 만나기 위해 시간과의 사투를 벌이는 ′윤′

오늘은 그녀를 만날 수 있을까?

열심히 일한 자, 뜨겁게 사랑하라!
					</p>
					<br>
					<dl id="price-info" class="info price"><dt>대여</dt><dd><em class="icon drmInfoLayer" style="cursor:pointer;">DRM</em><span class="info_price"><strong>90,000</strong>원</span> (7일간 시청 가능)</dd></dl>
					<div id="drm-info" class="guide-info price"><a href="javascript:void(0)" class="drminfo"></a><div id="layer-guide" class="layer-wrapper" style="display:none;position:absolute;">    <span class="arrow-left"></span>    <dl><dt>이용정보</dt><dd><strong>DRM</strong>  (저작권보호장치 적용) 기기 등록한 디바이스에서만 이용 가능하며 티빙 플레이어에서만 재생 됩니다.</dd><dt>주의사항</dt><dd>다운로드한 DRM 콘텐츠(ismv 파일)는 설치형 <a href="https://www.tving.com/download/player.do">티빙 플레이어</a>에서만 시청할 수 있습니다.<br>DRM 콘텐츠 이용이 어려우신 경우 <a href="https://www.tving.com/faq/main.do">FAQ</a>를 참고해 주세요.</dd><dt>지원기기</dt><dd>PC, 모바일, 태블릿, 스틱, 크롬캐스트</dd>    </dl></div></div>
				</div>
    </div>
  </div>
  <!-- //detail -->
  <div class="footer">
    <p class="copyright">&copy;copy</p>
  </div>
    <!-- //footer -->
</div>
<!-- //frame -->
</body>
</html>