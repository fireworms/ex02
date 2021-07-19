<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp"%>

<!-- Begin Page Content -->
<div class="container-fluid">

	<!-- Page Heading -->
	<h1 class="h3 mb-2 text-gray-800">자유게시판</h1>
	<p class="mb-4">
		자유로운 글과 댓글을 써 보세요
	</p>

	<!-- DataTales Example -->
	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<span>글 목록</span>
		</div>
		<div class="card-body">
			<div class="table-responsive">
				<table class="table table-bordered" id="dataTable" width="100%"
					cellspacing="0">
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>수정일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list }" var="board">
							<tr>
								<td><c:out value="${board.bno}" /></td>
								<td><a class='move' href='<c:out value="${board.bno }" />'><c:out
											value="${board.title}" /> <b>[ <c:out
												value="${board.replyCnt}" /> ]
									</b></a></td>
								<td><c:out value="${board.writer}" /></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd"
										value="${board.regdate }" /></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd"
										value="${board.updateDate}" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class='row'>
					<div class="col-lg-12">
						<form
							class='d-none d-sm-inline-block form-inline mr-auto my-2 my-md-0 mw-100 navbar-search'
							id='searchForm' action="/board/list" method='get'>
							<div class='input-group'>
								<select class='custom-select' name='type'>
									<option value=""
										<c:out value="${pageMaker.cri.type == null?'selected' : '' }"/>>--</option>
									<option value="T"
										<c:out value="${pageMaker.cri.type == 'T'?'selected' : '' }"/>>제목</option>
									<option value="C"
										<c:out value="${pageMaker.cri.type == 'C'?'selected' : '' }"/>>내용</option>
									<option value="W"
										<c:out value="${pageMaker.cri.type == 'W'?'selected' : '' }"/>>작성자</option>
									<option value="TC"
										<c:out value="${pageMaker.cri.type == 'TC'?'selected' : '' }"/>>제목
										or 내용</option>
									<option value="TW"
										<c:out value="${pageMaker.cri.type == 'TW'?'selected' : '' }"/>>제목
										or 작성자</option>
									<option value="TCW"
										<c:out value="${pageMaker.cri.type == 'TCW'?'selected' : '' }"/>>제목
										or 내용 or 작성자</option>
								</select>
								<div class='input-group-append'>
									<input class="form-control bg-light border-0 small" type='text'
										name='keyword'
										value='<c:out value="${pageMaker.cri.keyword }" />'> <input
										type='hidden' name='pageNum'
										value='<c:out value="${pageMaker.cri.pageNum }" />'> <input
										type='hidden' name='amount'
										value='<c:out value="${pageMaker.cri.amount }" />'>
									<button class='btn btn-primary'>
										<i class="fas fa-search fa-sm"></i>
									</button>
								</div>
							</div>
						</form>
						<button id='regBtn' class="btn btn-sm btn-primary float-sm-right">글쓰기</button>
					</div>
				</div>
				<div class='float-sm-right'>
					<form id='actionForm' action="/board/list" method='get'>
						<input type='hidden' name='pageNum'
							value='${pageMaker.cri.pageNum }'> <input type='hidden'
							name='amount' value='${pageMaker.cri.amount }'> <input
							type='hidden' name='type'
							value='<c:out value="${pageMaker.cri.type }" />'> <input
							type='hidden' name='keyword'
							value='<c:out value="${pageMaker.cri.keyword }" />'>
						<ul class="pagination">
							<c:if test="${pageMaker.prev }">
								<li class="page-item"><a class="page-link"
									href="${pageMaker.startPage -1 }">Previous</a></li>
							</c:if>

							<c:forEach var="num" begin="${pageMaker.startPage }"
								end="${pageMaker.endPage }">
								<li class="page-item ${pageMaker.cri.pageNum == num ? "active" : "" }"><a
									class="page-link" href="${num }">${num }</a></li>
							</c:forEach>

							<c:if test="${pageMaker.next }">
								<li class="page-item"><a class="page-link"
									href="${pageMaker.endPage +1 }">Next</a></li>
							</c:if>
						</ul>
					</form>
				</div>
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
					aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h4 class="modal-title" id="myModalLabel">Modal title</h4>
								<button type="button" class="close" data-dismiss="modal"
									aria-hidden="true">X</button>
							</div>
							<div id="aaa" class="registerMessage modal-body">처리가
								완료되었습니다</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-light" data-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>
				<script type="text/javascript">
					$(document).ready(function() {
						
						var result = '<c:out value="${result}"/>';

						checkModal(result);

						history.replaceState("asd", null, null);

						function checkModal(result) {
							if (result === '' || history.state) {
								return;
							}

							if (parseInt(result) > 0) {
								//$(".registerMessage").html("게시글 " + parseInt(result) + " 번이 등록되었습니다");
								document.getElementById("aaa").innerText = ("게시글 "
										+ parseInt(result) + " 번이 등록되었습니다");
							}
							$("#myModal").modal("show");

						}

						$("#regBtn").on("click", function() {
							self.location = "/board/register";
						});

						var actionForm = $("#actionForm");

						$(".page-item a").on("click",function(e) {
							
								e.preventDefault();
								
								actionForm.find("input[name='pageNum']").val($(this).attr("href"));
								actionForm.submit();
							});

						$(".move").on("click",function(e) {
							
							e.preventDefault();
							actionForm.append("<input type='hidden' name='bno' value='" + $(this).attr("href") + "'>");
							actionForm.attr("action", "/board/get");
							actionForm.submit();
							
						});
					});

					var searchForm = $("#searchForm");
					$("#searchForm button").on("click", function(e) {

						if (!searchForm.find("option:selected").val()) {
							alert("검색종류를 선택하세요");
							return false;
						}

						if (!searchForm.find("input[name='keyword']").val()) {
							alert("키워드를 입력하세요");
							return false;
						}

						searchForm.find("input[name='pageNum']").val("1");
						e.preventDefault();

						searchForm.submit();
					});
				</script>
			</div>
		</div>
	</div>

</div>
<!-- /.container-fluid -->

</div>
<!-- End of Main Content -->

<%@include file="../includes/footer.jsp"%>