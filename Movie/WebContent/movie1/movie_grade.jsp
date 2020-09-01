<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>

<link href="MovieCss.mo" type="text/css" rel="stylesheet">
<style type="text/css">
button{
   margin: 0;
   padding: 0;
   border:0;
   font-size: 30px;
   background-color: white;
   outline:none;
}</style>
<script src="../../../Movie/js/jquery-3.5.1.js"></script>
<script type="text/javascript">
$(document).ready(function(){
   
   // 랜덤한 영화를 보여주는 Jqeury 문
   $('#categoryMovie').change(function(){
      var type = $('#categoryMovie option:selected').val();
      $("#movieList").empty();
            $.ajax("GradeMoviePro.mo",{
               method:"get",
               dataType :"json",
               data:{type:type},
               success:function(data){
                  
                  $.each(data.Data,function(idx,item){
                     var count = item.TotalCount;
                     var ran = parseInt(Math.random()*count);
                     $.each(item.Result,function(idx,item2){
                        var num = 0;
                        var image = item2.posters.split("|")
                        var title = item2.title
                        var titleNoSpace = title.replace(/ /g, '');
                        var title2 = titleNoSpace.replace(/!HS/g,'')
                        var title3 = title2.replace(/!HE/g,'')
                        var title5 = title3.trim();
                        
                        $('.movieList').append('<div class=thisMovie>'
                        +'<div class=poster>'
                        +'<img class="poster_img">'
                        +'</div>'
                         +'<div class=title>'
                        +'<a class="link"></a>'
                        +'<button class="score1">☆</button><button class="score2">☆</button><button class="score3">☆</button><button class="score4">☆</button><button class="score5">☆</button>'
                        +'<a class="star" href=>별점등록</a>'
                        +'</div>');
                        
//                         $('.poster_img:eq(idx)').attr("src="+image[idx]);
                           $('.link').eq(idx).text(title);
                           $('.link').eq(idx).attr("href",'MovieDetailPro.mo?movieId'+item2.movieId+'&movieSeq='
                                 +item2.movieSeq+'&query='+title5);
                           
                        if(image[0]){
                           
                           $('.poster_img').eq(idx).attr("src",image[0]);
                           
                        }else{
                           $('.poster_img').eq(idx).attr("src",'../../../Movie/img/noImage.gif');
                        }

                        
                        $('.score1').eq(idx).click(function(){
                           alert(title + "1점 등록");
                           $('.score1').eq(idx).text("⭐");
                           $('.score2').eq(idx).text("☆");
                           $('.score3').eq(idx).text("☆");
                           $('.score4').eq(idx).text("☆");
                           $('.score5').eq(idx).text("☆");
                        });
                        $('.score2').eq(idx).click(function(){
                           alert(title + "2점 등록");
                           $('.score1').eq(idx).text("⭐");
                           $('.score2').eq(idx).text("⭐");
                           $('.score3').eq(idx).text("☆");
                           $('.score4').eq(idx).text("☆");
                           $('.score5').eq(idx).text("☆");
                        });
                        $('.score3').eq(idx).click(function(){
                           alert(title + "3점 등록");
                           $('.score1').eq(idx).text("⭐");
                           $('.score2').eq(idx).text("⭐");
                           $('.score3').eq(idx).text("⭐");
                           $('.score4').eq(idx).text("☆");
                           $('.score5').eq(idx).text("☆");
                        });
                        $('.score4').eq(idx).click(function(){
                           alert(title + "4점 등록");
                           $('.score1').eq(idx).text("⭐");
                           $('.score2').eq(idx).text("⭐");
                           $('.score3').eq(idx).text("⭐");
                           $('.score4').eq(idx).text("⭐");
                           $('.score5').eq(idx).text("☆");
                        });
                        $('.score5').eq(idx).click(function(){
                           alert(title + "5점 등록");
                           $('.score1').eq(idx).text("⭐");
                           $('.score2').eq(idx).text("⭐");
                           $('.score3').eq(idx).text("⭐");
                           $('.score4').eq(idx).text("⭐");
                           $('.score5').eq(idx).text("⭐");
                        });
                        
                        
                     });
                  
                     

                  
                  });//each문 끝남
                  
               }
               
            });
   });
   
   
      
      
//       $('#starRating').submit(function(){
//           if($(".star-input>output").val() =="0점"){
//             alert('점수는 최소 1점이상 입력하셔야 합니다.');
//             return false;
//           } else {
//             alert($(".star-input>output").val())
//             return true;
//           }
//       });
});
</script>
</head>
<body>

<select id="categoryMovie">
<option >정렬기준</option>
<option id ="random" value="random">랜덤</option>
<option id ="comedy" value="코메디">코메디</option>
<option id ="nwar" value="느와르">느와르</option>
<option id ="sf" value="sf">SF</option>
<option id ="crime" value="느와르">느와르</option>
<option id ="noir" value="범죄">범죄</option>
<option id ="drama" value="드라마">드라마</option>
<option id ="romance" value="로맨스">로맨스</option>
<option id ="thriller" value="스릴러">스릴러</option>
<option id ="war" value="전쟁">전쟁</option>
<option id ="family" value="가족">가족</option>
<option id ="fantasy" value="판타지">판타지</option>
<option id ="action" value="액션">액션</option>
<option id ="sf" value="SF">SF</option>
<option id ="animation" value="애니메이션">애니메이션</option>
<option id ="character" value="인물">인물</option>
<option id ="horror" value="공포">공포</option>
<option id ="mystery" value="미스터리">미스터리</option>
</select>

<div class="movieList"></div>


</body>
</html>