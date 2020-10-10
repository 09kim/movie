<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<style>
#jb-container {
	width: 1200px;
	height: 100%;
	margin: 0 auto;
	padding: 20px;
	border: 1px solid #bcbcbc;
	background-color: #2E2E2E;
}



#jb-sidebar-left {
	width: 300px;
	height: 100%;
	text-align: center;
	padding: 20px;
	margin-right: 20px;
	margin-bottom: 20px;
	float: left;
	color: #FFFFFF;
	border: 1px solid #bcbcbc;
}

#jb-content {
	height: 100%;
	width: 100%-300px;
	padding: 20px;
	margin-bottom: 20px;
	float: left;
	color: #FFFFFF;
	border: 1px solid #bcbcbc;
}



</style>
<body>
<div id="jb-container">
      
<!--       사이드 레프트 [S] -->
      <div id="jb-sidebar-left">
				<aside id="colorlib-aside" role="complementary" class="border js-fullheight">
				<div class="text-center">
					<div class="author-img" style="background-image: url(프로필사진주소), url(img/noProfile.png);"></div>
					<h1 id="colorlib-logo"><a href="index.html"><%=nick %></a></h1>
				</div>
				<nav id="colorlib-main-menu" role="navigation" class="navbar">
					<div id="navbar" class="collapse">
						<ul>
							<li class="active"><a href="Mypage.mp" data-nav-section="about">개인 정보 수정</a></li>
							<li><a href="MypageGrade.mp" data-nav-section="services">선호 장르&국가&감독</a></li>
							<li><a href="MypageWish.mp" data-nav-section="skills">보고싶어요한 영화</a></li>
							<li><a href="BoardReviewList.bo" data-nav-section="education">내가 평가한 영화</a></li>
							<li><a href="MypageCollection.mp" data-nav-section="experience">컬렉션</a></li>
<!-- 							<li><a href="MypageCollection.mp" data-nav-section="experience">Experience</a></li> -->
<!-- 							<li><a href="#" data-nav-section="work">Work</a></li> -->
<!-- 							<li><a href="#" data-nav-section="blog">Blog</a></li> -->
<!-- 							<li><a href="#" data-nav-section="contact">Contact</a></li> -->
						</ul>
					</div>
				</nav>
			</aside>
      </div>
<!--       사이드 레프트[E] -->
      
<!--       사이드 센터[S] -->
      <div id="jb-content">
      		<a href="#" class="js-colorlib-nav-toggle colorlib-nav-toggle" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar"><i></i></a>
			

		<div id="colorlib-main">
			<section class="colorlib-about" data-section="about">
		<div id="myinfo">
			<fieldset>
			<legend>닉네임</legend>
			<div class="inputWithIcon inputIconBg">
			  <input type="text" id="nick" placeholder="Nick Name" value="<%=nick%>" readonly/>
			  <i class="fa fa-user fa-lg fa-fw" aria-hidden="true"></i>
			</div>
			</fieldset>
			
			<fieldset>
			<legend>이메일</legend>
			<div class="inputWithIcon inputIconBg">
			  <input type="email" id="email" placeholder="Email" value="<%=memberBean.getEmail()%>" readonly/>
			  <i class="fa fa-envelope fa-lg fa-fw" aria-hidden="true"></i>
			  <button id="emailBtn" type="button">이메일 변경</button>
			</div>
			</fieldset>
			
			
			<fieldset>
			<legend>이메일 인증</legend>
			<div class="inputWithIcon inputIconBg">
			  <input type="email" id="certificationNum_email" name="certificationNum_email" placeholder="Email Certification Number"/>
			  <i class="fa fa-envelope fa-lg fa-fw" aria-hidden="true"></i>
			  <button id="certification_email_Btn" type="button">인증코드 입력</button>
			</div>
			</fieldset>
			
			
			<fieldset>
			<legend>패스워드</legend>
			<div class="inputWithIcon inputIconBg">
			  <input type="password" id="pass" name="pass" placeholder="Password"/>
			  <i class="fas fa-keyboard  fa-lg fa-fw" aria-hidden="true"></i>
			</div>
			  <div id="regPass"></div>
			  <div id="st_msg"></div>
			</fieldset>
			
			
			<fieldset>
			<legend>핸드폰 번호</legend>
			<div class="inputWithIcon inputIconBg">
			  <input type="text" id="phoneNum" name="phoneNum" placeholder="Phone Number" value="<%=memberBean.getPhone()%>" readonly/>
			  <i class="fa fa-phone fa-lg fa-fw" aria-hidden="true"></i>
			  <button id="phoneNumBtn" type="button">핸드폰 번호 변경</button>
			</div>
			</fieldset>
			
			<fieldset>
			<legend>핸드폰 인증</legend>
			<div class="inputWithIcon inputIconBg">
			  <input type="text" id="certificationNum" name="certificationNum" placeholder="Certification Number" />
			  <i class="fa fa-phone fa-lg fa-fw" aria-hidden="true"></i>
			  <button id="phoneNumBtn" type="button">인증번호 입력</button>
			</div>
			</fieldset>
			
			<fieldset>
			<legend>자기 소개</legend>
			<div class="inputWithIcon inputIconBg">
			<!--   <input type="text" id="introduce" name="introduce" style="background-color: inherit;border:none;" value="Introduce" readonly/> -->
			  <textarea rows="20" cols="20" id="infoup" placeholder="Introduce"></textarea>
			  <i class="fas fa-address-card fa-lg fa-fw" aria-hidden="true" style="margin-top:12px"></i>
			</div>
			</fieldset>		
					<a href="MypageForm.mp">프로필수정</a>
			</div>	
		</section>
		
		<div id="colorlib-counter" class="colorlib-counters" data-stellar-background-ratio="0.5">
			</div>


			
			<section class="colorlib-services" data-section="services">
				<fieldset id="genre_nation">
					<legend>선호 하는 장르 및 국가</legend>
					<table id="favoriteGenre">
					    <thead>
					    <tr>
					        <th scope="cols">장르</th>
					        <th scope="cols">평가한 영화 수</th>
					        <th scope="cols">평점</th>
					    </tr>
					    </thead>
					    <tbody class="genreList">
					    </tbody>
					</table>
					<table id="favoriteNation">
					    <thead>
					    <tr>
					        <th scope="cols">국가명</th>
					        <th scope="cols">선호작품수</th>
					        <th scope="cols">평점</th>
					    </tr>
					    </thead>
					    <tbody class="nationList">
					    </tbody>
					</table>
				</fieldset>

				<fieldset>
				<legend>선호 하는 감독</legend>
				<div class="director"></div> 
				</fieldset>
			</section>
			
<!-- 			<div id="colorlib-counter" class="colorlib-counters" data-stellar-background-ratio="0.5"> -->


<!-- 			</div> -->


			<section class="colorlib-skills" data-section="skills">
			
				<fieldset>
				<legend><%=nick %>님의 보고싶어요 리스트</legend>
					<div id="myinfo" class="myinfo">
						<div id="listForm">
							<% for(MypageBean wishInfo : wishMovie) {%>
							<div class="wishList">
							<%  String a = String.format("%05d" ,wishInfo.getMovieSeq()); %>
	<%-- 									<%if(wishInfo.getPoster()!=null){ %> --%>
	<%-- 									<div class="poster"><a href="MovieDetailPro.mo?movieSeq=<%=a%>&query=<%=wishInfo.getTitle()%>"><img src="<%=wishInfo.getPoster()%>" style="width:250px;height:350px;" onerror="this.src='${pageContext.request.contextPath}/img/noImage.gif'"></a></div><div class="title"><%=wishInfo.getTitle() %></div> --%>
										<%if(wishInfo.getPoster()!=null){ %>
										<div class="poster" style='width:250px;height:350px;background-image: url(<%=wishInfo.getPoster()%>)' onerror="this.src='${pageContext.request.contextPath}/img/noImage.gif'"><a href="MovieDetailPro.mo?movieSeq=<%=a%>&query=<%=wishInfo.getTitle()%>"></a>
										<%if(wishInfo.getWish().equals("Y")){ %>
										<button class="btn-like" value="<%=nick%>,<%=wishInfo.getTitle() %>,<%=wishInfo.getWish() %>,<%=a %>,<%=wishInfo.getIdx()%>">❤️</button>
										<% }%>
										</div>
										<div class="title" style="margin-left:-20px;"><%=wishInfo.getTitle() %></div>
	<%-- 									<%if(wishInfo.getWish().equals("Y")){ %> --%>
	<%-- 									<button class="btn-like" value="<%=nick%>,<%=wishInfo.getTitle() %>,<%=wishInfo.getWish() %>,<%=a %>,<%=wishInfo.getIdx()%>">❤️</button> --%>
	<%-- 									<% }%> --%>
										</div>
									<% }%>
								<%}%>
						</div>
					</div>
			</fieldset>
			
			
			</section>

			<section class="colorlib-education" data-section="education">
				<fieldset>
				<legend>내가 평가한 영화 목록 : <%=listCount%>개</legend>
				<div id="myInfo">
				<%
					if (gradeList != null && listCount > 0) {
					for (int i = 0; i < gradeList.size(); i++) {
					int starRating = (int)(gradeList.get(i).getGrade()/2.0*20);						
					double starRating1 = (gradeList.get(i).getGrade()/2.0);						
				%>
				<div id="gradelist">
					<ul> <%  String a = String.format("%05d" ,gradeList.get(i).getMovieSeq()); %>
						<li><div class=poster><img src=<%=gradeList.get(i).getPoster() %>></div>
							<div id="movieInfo">
								<div class="title" style="font-size:2em"><%=gradeList.get(i).getTitle()%></div>
<%-- 								<div class="grade" style="font-size:2em">★ : <%=gradeList.get(i).getGrade()/2.0%>점</div> --%>
<%-- 								<div class="grade" style="font-size:2em;background-image: url('img/grade_img.png');">★ : <%=gradeList.get(i).getGrade()/2.0%>점</div> --%>
<!-- 								<div class="grade" style="font-size:2em"> -->
									<div class="wrap-star" style="float:left;margin-left:-50px;">								
										<div class='star-rating' style="float:left;">
		        						<span style ="width:<%=starRating%>%;"></span>
		    							</div>
		    							<div style="float:right;">
		        						<p style="font-size: 2em;margin-left:-90px;margin-top:14px;"><%=starRating1 %>점</p>
		        						</div>
	    							</div>
<!--     							</div> -->
							 <!-- 2.0으로 나누기 끝자리 0이면 정수로만보여주기 나머지가 0이면 인트 등등방법  -->
							</div></li>
					</ul>
					
				</div>
				<%
					}
				} else {
				%>
				아직 평가한 영화가 없습니다.
				<%
					}
				%>
			</div>
		</fieldset>
				
		</section>
									
		
<!-- 		나머지 메뉴 틀 주석 처리 - 낙원 : 1007 [S] -->

			<section class="colorlib-experience" data-section="experience">
			<fieldset>
				<legend><%=nick %> 님의 컬렉션 목록</legend>
			<div>
			
			
			<div>
			<input type="button" id="showAddCollection" value="컬렉션 추가 하기">
		  	<div id="showDisplay" style= display:none>
				<form action="/Movie/MypageCollectionCreate.mp" method="post">
				<h3>컬렉션 이름</h3><input type="text" name="subject" id="subject"><br>
				<h3>컬렉션 내용</h3><textarea name ="content" id="content"></textarea><br>
				<input type="button" value="작품추가" id="addMov">
				<div id="movies">
				</div>
				<input type="submit" value="생성" id="submit">
	
			</form>
			</div>
			<br>
			<section>
				
				<% for(int i = 0; i < collection.size(); i++) {%>
				<form action="/Movie/MypageCollectionUpdate.mp" method="post">
					<div id="collectionNum" class="collectionNum<%=i%>"><h2>컬렉션 명:<%=collection.get(i).getCollection_name() %></h2><br>
					<h4>컬렉션 내용:<%=collection.get(i).getContent() %></h4>
					<input type="button" class ="delBtn" id="<%=collection.get(i).getIdx()%>" value="삭제">
					<input type="button" class ="modifyBtn" id="<%=collection.get(i).getIdx()%>" value="수정">
					<input type="button" value="작품추가" id ="add<%=i %>"  class="modifyAddMov"><br><br>
					<div class="collectionView">
					<%for(int o = 0; o < collection.get(i).getTitle().split(",").length; o++){%>
						<div class ="eachList<%=o %>" id="eachList">
						<div id="modifyMovies"></div>
						<img src="<%=collection.get(i).getPoster().split(",")[o]%>">
						<br>
						<a href="MovieDetailPro.mo?movieSeq=<%=collection.get(i).getMovieSeq().split(",")[o]%>
						&query=<%=collection.get(i).getTitle().split(",")[o]%>"><%=collection.get(i).getTitle().split(",")[o]%></a>
						
						<input type="button" class ="modifyDelBtn" id="eachList<%=o %>" value="삭제"><br></div>
						
						<input type="hidden" name="movieSeq" value="<%=collection.get(i).getMovieSeq().split(",")[o]%>">
						<input type="hidden" name="title" value="<%=collection.get(i).getTitle().split(",")[o]%>">
						<input type="hidden" name="poster" value="<%=collection.get(i).getPoster().split(",")[o]%>">
						<input type="hidden" name="idx" value="<%=collection.get(i).getIdx()%>">
						
						
					<%} %></div>
					</div>
					<input type="submit" value="수정하기"></form>
			<%}%> 
				
				
			</section>
		</div>
	</div>
		</fieldset>	
	
<!-- 				<div class="colorlib-narrow-content"> -->
<!-- 					<div class="row"> -->
<!-- 						<div class="col-md-6 col-md-offset-3 col-md-pull-3 animate-box" data-animate-effect="fadeInLeft"> -->
<!-- 							<span class="heading-meta">Experience</span> -->
<!-- 							<h2 class="colorlib-heading animate-box">Work Experience</h2> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					<div class="row"> -->
<!-- 						<div class="col-md-12"> -->
<!-- 				         <div class="timeline-centered"> -->
<!-- 					         <article class="timeline-entry animate-box" data-animate-effect="fadeInLeft"> -->
<!-- 					            <div class="timeline-entry-inner"> -->

<!-- 					               <div class="timeline-icon color-1"> -->
<!-- 					                  <i class="icon-pen2"></i> -->
<!-- 					               </div> -->

<!-- 					               <div class="timeline-label"> -->
<!-- 					                  <h2><a href="#">Full Stack Developer</a> <span>2017-2018</span></h2> -->
<!-- 					                  <p>Tolerably earnestly middleton extremely distrusts she boy now not. Add and offered prepare how cordial two promise. Greatly who affixed suppose but enquire compact prepare all put. Added forth chief trees but rooms think may.</p> -->
<!-- 					               </div> -->
<!-- 					            </div> -->
<!-- 					         </article> -->


<!-- 					         <article class="timeline-entry animate-box" data-animate-effect="fadeInRight"> -->
<!-- 					            <div class="timeline-entry-inner"> -->
<!-- 					               <div class="timeline-icon color-2"> -->
<!-- 					                  <i class="icon-pen2"></i> -->
<!-- 					               </div> -->
<!-- 					               <div class="timeline-label"> -->
<!-- 					               	<h2><a href="#">Front End Developer at Google Company</a> <span>2017-2018</span></h2> -->
<!-- 					                  <p>Even the all-powerful Pointing has no control about the blind texts it is an almost unorthographic life One day however a small line of blind text by the name of Lorem Ipsum decided to leave for the far World of Grammar.</p> -->
<!-- 					               </div> -->
<!-- 					            </div> -->
<!-- 					         </article> -->

<!-- 					         <article class="timeline-entry animate-box" data-animate-effect="fadeInLeft"> -->
<!-- 					            <div class="timeline-entry-inner"> -->
<!-- 					               <div class="timeline-icon color-3"> -->
<!-- 					                  <i class="icon-pen2"></i> -->
<!-- 					               </div> -->
<!-- 					               <div class="timeline-label"> -->
<!-- 					               	<h2><a href="#">System Analyst</a> <span>2017-2018</span></h2> -->
<!-- 					                  <p>Even the all-powerful Pointing has no control about the blind texts it is an almost unorthographic life One day however a small line of blind text by the name of Lorem Ipsum decided to leave for the far World of Grammar.</p> -->
<!-- 					               </div> -->
<!-- 					            </div> -->
<!-- 					         </article> -->

<!-- 					         <article class="timeline-entry animate-box" data-animate-effect="fadeInTop"> -->
<!-- 					            <div class="timeline-entry-inner"> -->
<!-- 					               <div class="timeline-icon color-4"> -->
<!-- 					                  <i class="icon-pen2"></i> -->
<!-- 					               </div> -->
<!-- 					               <div class="timeline-label"> -->
<!-- 					               	<h2><a href="#">Creative Designer</a> <span>2017-2018</span></h2> -->
<!-- 					                  <p>Even the all-powerful Pointing has no control about the blind texts it is an almost unorthographic life One day however a small line of blind text by the name of Lorem Ipsum decided to leave for the far World of Grammar.</p> -->
<!-- 					               </div> -->
<!-- 					            </div> -->
<!-- 					         </article> -->

<!-- 					         <article class="timeline-entry animate-box" data-animate-effect="fadeInLeft"> -->
<!-- 					            <div class="timeline-entry-inner"> -->
<!-- 					               <div class="timeline-icon color-5"> -->
<!-- 					                  <i class="icon-pen2"></i> -->
<!-- 					               </div> -->
<!-- 					               <div class="timeline-label"> -->
<!-- 					               	<h2><a href="#">UI/UX Designer at Envato</a> <span>2017-2018</span></h2> -->
<!-- 					                  <p>Even the all-powerful Pointing has no control about the blind texts it is an almost unorthographic life One day however a small line of blind text by the name of Lorem Ipsum decided to leave for the far World of Grammar.</p> -->
<!-- 					               </div> -->
<!-- 					            </div> -->
<!-- 					         </article> -->

<!-- 					         <article class="timeline-entry begin animate-box" data-animate-effect="fadeInBottom"> -->
<!-- 					            <div class="timeline-entry-inner"> -->
<!-- 					               <div class="timeline-icon color-none"> -->
<!-- 					               </div> -->
<!-- 					            </div> -->
<!-- 					         </article> -->
<!-- 					      </div> -->
<!-- 					   </div> -->
<!-- 				   </div> -->
<!-- 				</div> -->
			</section>
      </div>
<!--       사이드 센터[E] -->

<!-- 사이드 라이트[S] -->
<!--       <div id="jb-sidebar-right"> -->
<!--       </div> -->
<!--       사이드 라이트[E] -->


<!-- 푸터(스틸컷)[S] -->
<!--       <div id="jb-footer"> -->
<!--       </div> -->
<!-- 푸터(스틸컷)[E] -->
      
<!-- 푸터(이 감독의 다른 영화)[S] -->      
<!--       <div id="jb-footer2"> -->
<!--       </div> -->
<!-- 푸터(이 감독의 다른 영화)[E] -->       
    
    
    
    
    </div>
<!-- #jb-container[E] -->
</body>
</html>