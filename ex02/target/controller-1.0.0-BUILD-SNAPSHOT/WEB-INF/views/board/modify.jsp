<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<%@include file="../includes/header.jsp"%>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Modify Page</h1>
	</div>
</div>

<div class="row">
	<div class="col-lg-12">
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-primary">Board Modify Page</h6>
			</div>
			<div class="card-body">
				<form role="form" action="/board/modify" method="post">
					<input type='hidden' name="${_csrf.parameterName }" value="${_csrf.token }" />
					<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }" />'>
					<input type='hidden' name='amount' value='<c:out value="${cri.amount }" />'>
					<input type='hidden' name='type' value='<c:out value="${cri.type }" />'>
					<input type='hidden' name='keyword' value='<c:out value="${cri.keyword }" />'>
						<input type='hidden' class="form-control" name='bno' value='<c:out value="${board.bno }"/>' readonly="readonly">
					<div class="form-group">
						<label>Title</label> <input class="form-control" name='title' value='<c:out value="${board.title }" />'>
					</div>
					<div class="form-group">
						<label>Text area</label>
						<textarea class="form-control" rows="3" name='content'><c:out value="${board.content}" /></textarea>
					</div>
					<div class="form-group">
						<label>Writer</label> <input class="form-control" name='writer' value='<c:out value="${board.writer }" />' readonly="readonly">
					</div>
					<div class="form-group" style="display : none">
						<label>RegDate</label> <input class="form-control" name='regDate' value='<fmt:formatDate pattern = "yyyy/MM/dd" value = "${board.regdate }" />' readonly="readonly">
					</div>
					<div class="form-group" style="display : none">
						<label>Update Date</label> <input class="form-control" name='updateDate' value='<fmt:formatDate pattern = "yyyy/MM/dd" value = "${board.updateDate }" />' readonly="readonly">
					</div>
						<button type="submit" data-oper='modify' class="btn btn-light d-none d-user">Modify</button>
						<button type="submit" data-oper='remove' class="btn btn-danger d-none d-user">Remove</button>
					<button type="submit" data-oper='list' class="btn btn-info">List</button>
				</form>
			</div>
		</div>
	</div>
</div>

<sec:authorize access="isAuthenticated()">
	<c:if test="${pinfo.username eq board.writer }">
		<script>
			$(".d-user").removeClass("d-none");
		</script>
	</c:if>
</sec:authorize>				
<sec:authorize access="hasRole('ROLE_ADMIN')">
	<script>
		$(".d-none").removeClass("d-none");
	</script>
</sec:authorize>

<div class='bigPictureWrapper'>
	<div class='bigPicture'>
	</div>
</div>

<style>
	.uploadResult{
		width:100%;
		background-color : gray;
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
		position: absolute;
		display: none;
		justify-content: center;
		align-items:center;
		top:0%;
		width:100%;
		height:100%;
		background-color:gray;
		z-index:100;
		background:rgba(255,255,255,0.5);
	}
	
	.bigPicture{
		position:relative;
		display:flex;
		justify-content:center;
		align-items:center;
	}
	
	.bigPicture img{
		width:600px;
	}
	
</style>

<div class="row">
	<div class="col-lg-12">
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<i class="fa fa-comments fa-fw"></i><span class="m-0 font-weight-bold text-primary"> Files</span>
			</div>
			<div class="card-body">
				<div class="form-group uploadDiv">
					<input type="file" name='uploadFile' multiple="multiple">
				</div>
				<div class='uploadResult'>
					<ul>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">

function showUploadResult(uploadResultArr){
	
	if(!uploadResultArr || uploadResultArr.length == 0){ return;}
	
	var uploadUL = $(".uploadResult ul");
	
	var str = "";
	
	$(uploadResultArr).each(function(i, obj){
		
		if(obj.image){
			
			var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
			
			str += "<li data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.image + "'>";
			str += "<div>";
			str += "<span> " + obj.fileName + "</span>";
			str += "<button type = 'button' class = 'btn btn-warning btn-circle' data-file=\'" + fileCallPath + "\' data-type='image'><i class = 'fa fa-times'></i></button><br>";
			str += "<img src = '/display?fileName=" + fileCallPath + "'>";
			str += "</div></li>";
			
		}else{
			
			var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
			
			var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
			
			str += "<li data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.image + "'>";
			str += "<div>";
			str += "<span> " + obj.fileName + "</span>";
			str += "<button type = 'button' class = 'btn btn-warning btn-circle' data-file=\'" + fileCallPath + "\' data-type='file'><i class = 'fa fa-times'></i></button><br>";
			str += "<img src = '/resources/img/attach.png'>";
			str += "</div></li>";
			
		}
	});
	
	uploadUL.append(str);
	
}

	$(document).ready(function(){
		
		(function(){
			
			var bno = '<c:out value="${board.bno}"/>';
			
			$.getJSON("/board/getAttachList", {bno: bno}, function(arr){
				
				var str = "";
				
				$(arr).each(function(i, attach){
					
					if(attach.fileType){
						
						var fileCallPath = encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName);
						
						str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'>";
						str += "<div>";
						str += "<span> "+ attach.fileName + "</span>";
						str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
						str += "<img src='/display?fileName="+fileCallPath+"'>";
						str += "</div>";
						str += "</li>";
					}else{
						
						str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'>";
						str += "<div>";
						str += "<span> "+ attach.fileName + "</span>";
						str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
						str += "<img src='/resources/img/attach.png'>";
						str += "</div>";
						str += "</li>";
					}
				});
				
				$(".uploadResult ul").html(str);
			});
		})();
		
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
		
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		
		$("input[type='file']").change(function(e){
			
			var formData = new FormData();
			
			var inputFile = $("input[name='uploadFile']");
			
			var files = inputFile[0].files;
			
			for(var i = 0; i < files.length; i++){
				
				if(!checkExtension(files[i].name, files[i].size)){
					return false;
				}
				formData.append("uploadFile", files[i]);
			}
			
			$.ajax({
				url: "/uploadAjaxAction",
		        type: "POST",
		        dataType: 'json',
		        data: formData,
		        contentType: false,
		        processData: false,
		        cache: false,
		        beforeSend: function(xhr){
		        	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		        },
				success: function(result){
					showUploadResult(result);
				}
			});
		});
		
		var formObj = $("form");
		
		$('button').on("click", function(e){
			
			e.preventDefault();
			
			var operation = $(this).data("oper");
			
			if(operation === 'remove'){
				
				formObj.attr("action", "/board/remove");
				
			}else if(operation === 'list'){
				
				//move to list
				formObj.attr("action", "/board/list").attr("method", "get");
				var pageNumTag = $("input[name='pageNum']").clone();
				var amountTag = $("input[name='amount']").clone();
				var typeTag = $("input[name='type']").clone();
				var keywordTag = $("input[name='keyword']").clone();
				
				formObj.empty();
				
				formObj.append(pageNumTag);
				formObj.append(amountTag);
				formObj.append(typeTag);
				formObj.append(keywordTag);
				
			}else if(operation === 'modify'){
				
				var str = "";
				
				$(".uploadResult ul li").each(function(i, obj){
					
					var jobj = $(obj);
					console.dir(jobj);
					
					str += "<input type='hidden' name='attachList[" + i + "].fileName' value='" + jobj.data('filename') + "'>";
					str += "<input type='hidden' name='attachList[" + i + "].uuid' value='" + jobj.data('uuid') + "'>";
					str += "<input type='hidden' name='attachList[" + i + "].uploadPath' value='" + jobj.data('path') + "'>";
					str += "<input type='hidden' name='attachList[" + i + "].fileType' value='" + jobj.data('type') + "'>";
				});
				
				formObj.append(str).submit();
			}
			formObj.submit();
		});
	});
	
	$(".uploadResult").on("click", "button", function(e){
		
		if(confirm("Remove this file? " )){
			
			var targetLi = $(this).closest("li");
			targetLi.remove();
		}
	});
</script>

<%@include file="../includes/footer.jsp"%>