<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	   var fileTarget = $('.filebox .upload-hidden');

	    fileTarget.on('change', function(){
	        if(window.FileReader){
	            // 파일명 추출
	            var filename = $(this)[0].files[0].name;
	        } 

	        else {
	            // Old IE 파일명 추출
	            var filename = $(this).val().split('/').pop().split('\\').pop();
	        };

	        $(this).siblings('.upload-name').val(filename);
	    });

	    //preview image 
	    var imgTarget = $('.preview-image .upload-hidden');

	    imgTarget.on('change', function(){
	        var parent = $(this).parent();
	        parent.children('.upload-display').remove();

	        if(window.FileReader){
	            //image 파일만
	            if (!$(this)[0].files[0].type.match(/image\//)) return;
	            
	            var reader = new FileReader();
	            reader.onload = function(e){
	                var src = e.target.result;
// 	                parent.prepend('<div class="upload-display"><div class="upload-thumb-wrap"><img src="'+src+'" class="upload-thumb"></div></div>');
// 	                parent.prepend('<div class="upload-display"><div class="upload-thumb-wrap"><img src="'+src+'" class="upload-thumb"></div></div>');
	                $('.profileImage').attr("src",src);
	            }
	            reader.readAsDataURL($(this)[0].files[0]);
	        }

	        else {
	            $(this)[0].select();
	            $(this)[0].blur();
	            var imgSrc = document.selection.createRange().text;
	            parent.prepend('<div class="upload-display"><div class="upload-thumb-wrap"><img class="upload-thumb"></div></div>');

	            var img = $(this).siblings('.upload-display').find('img');
	            img[0].style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enable='true',sizingMethod='scale',src=\""+imgSrc+"\")";        
	        }
	    });
	});
</script>
</head>
<body>
<div class="filebox bs3-primary preview-image">
<!--                             <input class="upload-name" value="파일선택" disabled="disabled" style="width: 200px;"> -->

<!--                             <label for="input_file">업로드</label>  -->
                            <label for="input_file"><img class="profileImage" src="" onerror="this.src='../../../Movie/img/noProfile.png'"></label> 
                          <input type="file" id="input_file" class="upload-hidden"> 
                        </div>
<!--                             <label for="input_file"><img src="../../../Movie/img/noImage.gif"></label>  -->
<!--                           <input type="file" id="input_file" class="upload-hidden">  -->
<!--                         </div> -->

<!-- <a href="http://webdir.tistory.com/435" target="_blank" class="where">posted in webdir</a> -->






<style type="text/css">
body {margin: 10px;}
.where {
  display: block;
  margin: 25px 15px;
  font-size: 11px;
  color: #000;
  text-decoration: none;
  font-family: verdana;
  font-style: italic;
} 

.filebox input[type="file"] {
    position: absolute;
    width: 1px;
    height: 1px;
    padding: 0;
    margin: -1px;
    overflow: hidden;
    clip:rect(0,0,0,0);
    border: 0;
}

.filebox label {
    display: inline-block;
/*     padding: .5em .75em; */
    color: #999;
    font-size: inherit;
    line-height: normal;
    vertical-align: middle;
    background-color: #fdfdfd;
    cursor: pointer;
    overflow: hidden;
  width: 300px;
  height: 300px;
  object-fit: cover;
/*     border: 1px solid #ebebeb; */
/*     border-bottom-color: #e2e2e2; */
/*     border-radius: .25em; */
	border-radius: 70%;
}
.filebox label>img{
width:100%;
height:100%;
  object-fit: cover;}

/* /* named upload */ */
/* .filebox .upload-name { */
/*     display: inline-block; */
/*     padding: .5em .75em; */
/*     font-size: inherit; */
/*     font-family: inherit; */
/*     line-height: normal; */
/*     vertical-align: middle; */
/*     background-color: #f5f5f5; */
/*   border: 1px solid #ebebeb; */
/*   border-bottom-color: #e2e2e2; */
/*   border-radius: .25em; */
/*   -webkit-appearance: none; /* 네이티브 외형 감추기 */ */
/*   -moz-appearance: none; */
/*   appearance: none; */
/* } */

/* imaged preview */
.filebox .upload-display {
    margin-bottom: 5px;
}

@media(min-width: 768px) {
    .filebox .upload-display {
        display: inline-block;
        margin-right: 5px;
        margin-bottom: 0;
    }
}

.filebox .upload-thumb-wrap {
    display: inline-block;
    width: 54px;
    padding: 2px;
    vertical-align: middle;
    border: 1px solid #ddd;
    border-radius: 5px;
    background-color: #fff;
}

.filebox .upload-display img {
    display: block;
    max-width: 100%;
    width: 100% \9;
    height: auto;
}

/* .filebox.bs3-primary label { */
/*   color: #fff; */
/*   background-color: #337ab7; */
/*     border-color: #2e6da4; */
/* } */

/* .filebox input[type="file"] { */
/* position: absolute; */
/* width: 1px; */
/* height: 1px; */
/* padding: 0; */
/* margin: -1px; */
/* overflow: hidden; */
/* clip:rect(0,0,0,0); */
/* border: 0; */
/* } */

</style>
</body>

</body>
</html>