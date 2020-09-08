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
                        + "<span class='star-input'>"
                        +   "<span class='input'>"
                        +'<input type="radio" name="star-input"id="p1" value="1"><label for="p1">1</label>'
                        +'<input type="radio" name="star-input" id="p2" value="2"><label for="p2">2</label>'
                        +'<input type="radio" name="star-input" id="p3" value="3"><label for="p3">3</label>'
                        +'<input type="radio" name="star-input" id="p4" value="4"><label for="p4">4</label>'
                        +'<input type="radio" name="star-input" id="p5" value="5"><label for="p5">5</label>'
                        +'<input type="radio" name="star-input" id="p6" value="6"><label for="p6">6</label>'
                        +'<input type="radio" name="star-input" id="p7" value="7"><label for="p7">7</label>'
                        +'<input type="radio" name="star-input" id="p8" value="8"><label for="p8">8</label>'
                        +'<input type="radio" name="star-input" id="p9" value="9"><label for="p9">9</label>'
                        +'<input type="radio" name="star-input" id="p10" value="10"><label for="p10">10</label>'
                        + '</span>'
                        +'</span>'
                        +'<a class="star" href=>별점등록</a>'
                        +'</div>'
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
						
                       

                        $('#p1').eq(idx).click(function(){
                           alert(title + " | " + "0.5점 등록");
                           
                           
                        });
                        $('#p2').eq(idx).click(function(){
                           alert(title +  " | " + "1점 등록");
                          
                        });
                        $('#p3').eq(idx).click(function(){
                           alert(title +  " | " +  "1.5점 등록");
                           
                        });
                        $('#p4').eq(idx).click(function(){
                           alert(title +  " | " +  "2점 등록");
                           
                        });
                        $('#p5').eq(idx).click(function(){
                           alert(title +  " | " +  "2.5점 등록");
                           
                        });
                        $('#p6').eq(idx).click(function(){
                            alert(title +  " | " +  "3점 등록");
                            
                         });
                         $('#p7').eq(idx).click(function(){
                            alert(title +  " | " +  "3.5점 등록");
                            
                         });
                         $('#p8').eq(idx).click(function(){
                            alert(title +  " | " +  "4점 등록");
                            
                         });
                         $('#p9').eq(idx).click(function(){
                            alert(title +  " | " +  "4.5점 등록");
                            
                         });
                         $('#p10').eq(idx).click(function(){
                            alert(title +  " | " +  "5점 등록");
                            
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