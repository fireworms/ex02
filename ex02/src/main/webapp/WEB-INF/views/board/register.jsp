<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp"%>
<style>
	.uploadResult{
		width:100%;
		background-color:gray;
	}
	.uploadResult ul{
		display:flex;
		flex-flow:row;
		justify-content:center;
		align-items:center;
	}
	
	.uploadResult ul li{
		list-style:none;
		padding:10px;
		align-content:center;
		text-align:center;
	}
	
	.uploadResult ul li img{
		width:100px;
	}
	
	.uploadResult ul li span{
		color:white;
	}
	
	.bigPictureWrapper{
		position : absolute;
		display : none;
		justify-content : center;
		align-items : center;
		top:0%;
		width:100%;
		height:100%;
		background-color:gray;
		z-index:100;
		background:rgba(255, 255, 255, 0.5);
	}
	
	.bigPicture{
		position: relative;
		display:flex;
		justify-content: center;
		align-items: center;
	}
	
	.bigPicture img{
		width:600px;
	}
</style>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Register</h1>
	</div>
</div>

<div class="row">
	<div class="col-lg-12">
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-primary">Board Register</h6>
			</div>
			<div class="card-body">
				<form role="form" action="/board/register" method="post">
					<div class="form-group">
						<label>Title</label> <input class="form-control" name='title'>
					</div>
					<div class="form-group">
						<label>Text area</label>
						<textarea class="form-control" rows="3" name='content'></textarea>
					</div>
					<div class="form-group">
						<label>Writer</label> <input class="form-control" name='writer'>
					</div>
					<button type="submit" class="btn btn-Primary">Submit
						Button</button>
					<button type="reset" class="btn btn-Light">Reset Button</button>
				</form>
			</div>
		</div>
	</div>
</div>

<div class="row">
	<div class="col-lg-12">
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-primary">File Attach</h6>
			</div>
			<div class="card-body">
				<div class="form-group uploadDiv">
					<input type='file' name='uploadFile' multiple>
				</div>
				
				<div class='uploadResult'>
					<ul>
					
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	
	function showUploadResult(uploadResultArr){
		
		if(!uploadResultArr || uploadResultArr.length == 0){ return;}
		
		var uploadUL = $(".uploadResult ul");
		
		var str = "";
		
		$(uploadResultArr).each(function(i, obj){
			
			if(obj.image){
				
				var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
				
				str += "<li><div>";
				str += "<span> " + obj.fileName + "</span>";
				str += "<button type = 'button' class = 'btn btn-warning btn-circle' data-file=\'" + fileCallPath + "\' data-type='image'><i class = 'fa fa-times'></i></button><br>";
				str += "<img src = '/display?fileName=" + fileCallPath + "'>";
				str += "</div></li>";
				
			}else{
				
				var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
				
				var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
				
				str += "<li><div>";
				str += "<span> " + obj.fileName + "</span>";
				str += "<button type = 'button' class = 'btn btn-warning btn-circle' data-file=\'" + fileCallPath + "\' data-type='file'><i class = 'fa fa-times'></i></button><br>";
				str += "<img src = '/resources/img/attach.png'></a>";
				str += "</div></li>";
				
			}
		});
		
		uploadUL.append(str);
		
	}
	
	$(document).ready(function(e){
		
		var formObj = $("form[role='form']");
		
		$("button[type='submit']").on("click", function(e){
			
			e.preventDefault();
			
			console.log("submit clicked");
		});
		
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		
		var maxSize = 5242880;
		
		function checkExtension(fileName, fileSize){
			
			if(fileSize >= maxSize){
				alert("파일 사이즈 초과");
				return false;
			}
			
			if(regex.test(fileName)){
				alert("해당 종류의 파일은 업로드할 수 없습니다");
				return false;
			}
			return true;
		}
		
		$("input[type='file']").change(function(e){
			
			var formData = new FormData();
			
			var inputFile = $("input[name='uploadFile']");
			
			var files = inputFile[0].files;
			
			console.log(files);
			
			for(var i = 0; i < files.length; i++){
				
				if(!checkExtension(files[i].name, files[i].size)){
					return false;
				}
				formData.append("uploadFile", files[i]);
			}
			
			console.log(formData);
			
			$.ajax({
				url: "/uploadAjaxAction",
		        type: "POST",
		        dataType: 'json',
		        data: formData,
		        contentType: false,
		        processData: false,
		        cache: false,
				success: function(result){
					console.log(result);
					showUploadResult(result);
				}
			});
		});
	});
	
	$(".uploadResult").on("click", "button", function(e){
		
		console.log("delete file");
		
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		
		var targetLi = $(this).closest("li");
		
		$.ajax({
			url: '/deleteFile',
			data: {fileName: targetFile, type:type},
			dataType: 'text',
			type: 'POST',
			success: function(result){
				alert(result);
				targetLi.remove();
			}
		})
		
	});
</script>

<%@include file="../includes/footer.jsp"%>
