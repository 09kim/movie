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
   
	function starClick(param,grade){

		  	  $.ajax("setGrade.mo",{
		  		  method:"post",
		          data:{
		         	   data:param,
		         	   grade:grade
		         	   },
		          success:function(data){
		          	  alert("평가 됨.");
		            }
		  	  }
		)
	}
	
	 function starClick(data,grade){
		 
	  	  $.ajax("setGrade.mo",{
	  		  method:"post",
	          data:{
	         	   data:data,
	         	   grade:grade
	         	   },
	          success:function(data){
	          	  alert("평가 됨.");
	            }
	  	  });
	}
   // 랜덤한 영화를 보여주는 Jqeury 문
   $('#categoryMovie').change(function(){
      var type = $('#categoryMovie option:selected').val();
      $("#movieList").empty();
            $.ajax("GradeMoviePro.mo",{
               method:"get",
               dataType :"json",
               data:{type:type},
               success:function(data){
            	   var grade = 0;
                  $.each(data.Data,function(idx,item){
                     var i =1;
                     var l =1;
                     
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
                        +'<input type="button" class="c1" ><label style= "width: 10px; z-index: 10;" class="l1">1</label>'
                        +'<input type="button" class="c2" ><label style= "width: 20px; z-index: 9;" class="l2">2</label>'
                        +'<input type="button" class="c3" ><label style= "width: 30px; z-index: 8;" class="l3">3</label>'
                        +'<input type="button" class="c4" ><label style= "width: 40px; z-index: 7;" class="l4">4</label>'
                        +'<input type="button" class="c5" ><label style= "width: 50px; z-index: 6;" class="l5">5</label>'
                        +'<input type="button" class="c6" ><label style= "width: 60px; z-index: 5;" class="l6">6</label>'
                        +'<input type="button" class="c7" ><label style= "width: 70px; z-index: 4;" class="l7">7</label>'
                        +'<input type="button" class="c8" ><label style= "width: 80px; z-index: 3;" class="l8" >8</label>'
                        +'<input type="button" class="c9" ><label style= "width: 90px; z-index: 2;" class="l9">9</label>'
                        +'<input type="button" class="c10"><label style= "width: 100px; z-index: 1;" class="l10">10</label>'
                        + '</span></span>' );
                        
//                         $('.poster_img:eq(idx)').attr("src="+image[idx]);
                           
                           $('.link').eq(idx).text(title);
                           $('.link').eq(idx).attr("href",'MovieDetailPro.mo?movieId'+item2.movieId+'&movieSeq='
                                 +item2.movieSeq+'&query='+title5);
                           $('.c1').eq(idx).val(title5+"/"+item2.movieSeq+"/"+item2.runtime+"/"+item2.genre+"/"+item2.prodYear);
                           
                        if(image[0]){
                           
                           $('.poster_img').eq(idx).attr("src",image[0]);
                           
                        }else{
                           $('.poster_img').eq(idx).attr("src",'../../../Movie/img/noImage.gif');
                        }
                        
                        // 10개의 라벨에 각기 다른 값을 부여하기위한 반복문
                        for(var o=1;o<11;o++){
                        $('.c'+o).eq(idx).attr("id","p"+i++);
                        }
                    	 // 10개의 라벨에 각기 다른 값을 부여하기위한 반복문
                        for(var o=1;o<11;o++){
                        $('.l'+o).eq(idx).attr("for","p"+l++);
                        }
                        
                        var garde= 0;
						var movieSeq =""	
	                        $('.c1').eq(idx).click(function(){
	                           alert(title + " | " + "0.5점 등록");
	                           var grade=1;
	                           var data = $('.c1').eq(idx).val();
	                           starClick(data,grade);
	                           var param = $('.param').val(data);
	                            starClick(data,grade);
	                        });
	                        
	                        $('.c2').eq(idx).click(function(){
	                        	var grade = 2;
	                           alert(title +  " | " + "1점 등록");
	                           var grade=2;
	                           var data = $('.c1').eq(idx).val();
	                           starClick(data,grade);
	                            $('.param').val(data); 
	                            starClick(data,grade);
	                          
	                        });
	                        $('.c3').eq(idx).click(function(){
	                           alert(title +  " | " +  "1.5점 등록");
	                           var grade=3;
	                           var grade = 3;
	                           $('.grade').val(3);
	                           var data = $('.c1').eq(idx).val();
	                           starClick(data,grade);
	                           
	                            $('.param').val(data); 
	                            starClick(data,grade);
	                        });
	                        
	                        $('.c4').eq(idx).click(function(){
	                           alert(title +  " | " +  "2점 등록");
	                           var grade=4;
	                           var grade = 4;
	                           $('.grade').val(4);
	                           var data = $('.c1').eq(idx).val();
	                           starClick(data,grade);
	                            $('.param').val(data); 
	                            starClick(data,grade);
	                           
	                        });
	                        
	                        $('.c5').eq(idx).click(function(){
	                           alert(title +  " | " +  "2.5점 등록");
	                           var grade=5;
	                           var grade = 5;
	                           $('.grade').val(5);
	                           var data = $('.c1').eq(idx).val();
	                           starClick(data,grade); 
	                            $('.param').val(data); 
	                            starClick(data,grade);
	                        });
	                        
	                        $('.c6').eq(idx).click(function(){
	                            alert(title +  " | " +  "3점 등록");
	                            var grade=6;
	                            var grade = 6;
	                            $('.grade').val(6);
	                            var data = $('.c1').eq(idx).val();
	                            $('.param').val(data); 
	                            starClick(data,grade);
	                            
	                        });
	                        $('.c7').eq(idx).click(function(){
	                            alert(title +  " | " +  "3.5점 등록");
	                            var grade=7;
		                        var data = $('.c1').eq(idx).val();
		                        starClick(data,grade);
	                            var grade = 7;
	                            $('.grade').val(7); 
	                            var data = $('.c1').eq(idx).val();
	                            $('.param').val(data); 
	                            starClick(data,grade);
	                            
	                        });
	                        $('.c8').eq(idx).click(function(){
	                            alert(title +  " | " +  "4점 등록");
	                            var grade=8;
		                        var data = $('.c1').eq(idx).val();
		                        starClick(padataram,grade);
	                            var grade = 8;
	                            $('.grade').val(8);
	                            var data = $('.c1').eq(idx).val();
	                            $('.param').val(data);
	                            starClick(data,grade);
	                            
	                        });
	                        $('.c9').eq(idx).click(function(){
	                            alert(title +  " | " +  "4.5점 등록");
	                            var grade=9;
		                        var data = $('.c1').eq(idx).val();
		                        starClick(data,grade);
	                            var grade = 9;
	                            $('.grade').val(9);
	                            var data = $('.c1').eq(idx).val();
	                            $('.param').val(data); 
	                            starClick(data,grade);
	                            
	                        });
	                        $('.c10').eq(idx).click(function(){
	                            alert(title +  " | " +  "5점 등록");
	                            var grade=10;
		                        var data = $('.c1').eq(idx).val();
		                        starClick(data,grade);
	                            var grade = 10;
	                            $('.grade').val(10);
	                            var data = $('.c1').eq(idx).val();
	                            $('.param').val(data); 
	                            starClick(data,grade);
	                            
	                            
	                        });
	              	  	 
	                        
                  
                  });//each문 끝남
              });
           }
               
               
               
        });
   });
   
  
  
   
});
</script>
</head>
<body>
<input type="hidden" class="nick">
<select id="categoryMovie">
<option >정렬기준</option>
<option id ="random" value="random">랜덤</option>
<option id ="comedy" value="코메디">코메디</option>
<option id ="nwar" value="느와르">느와르</option>
<option id ="crime" value="범죄">범죄</option>
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