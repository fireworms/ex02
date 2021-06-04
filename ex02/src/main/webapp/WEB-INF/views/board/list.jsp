<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@include file = "../includes/header.jsp" %>

                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">Tables</h1>
                    <p class="mb-4">DataTables is a third party plugin that is used to generate the demo table below.
                        For more information about DataTables, please visit the <a target="_blank"
                            href="https://datatables.net">official DataTables documentation</a>.</p>

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <span>Board List Page</span>
                            <button id='regBtn' class="btn btn-sm btn-primary float-sm-right">Register New Board</button>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
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
                                    			<td><a  class='move' href='<c:out value="${board.bno }" />'><c:out value="${board.title}" /></a></td>
                                    			<td><c:out value="${board.writer}" /></td>
                                    			<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate }" /></td>
                                    			<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}" /></td>
                                    		</tr>
                                    	</c:forEach>
                                    </tbody>
                                </table>
                                <div class='float-sm-right'>
                                <form id='actionForm' action="/board/list" method='get'>
                                	<input type='hidden' name='pageNum' value ='${pageMaker.cri.pageNum }'>
                                	<input type='hidden' name='amount' value ='${pageMaker.cri.amount }'>
                                	<ul class="pagination">
		                                <c:if test="${pageMaker.prev }">
		                                <li class="page-item"><a class="page-link" href="${pageMaker.startPage -1 }">Previous</a>
		                                </li>
		                                </c:if>
		                                
		                                <c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
		                                <li class="page-item ${pageMaker.cri.pageNum == num ? "active" : "" }"><a class="page-link" href="${num }">${num }</a></li>
		                                </c:forEach>
		                                
		                                <c:if test="${pageMaker.next }">
		                                <li class="page-item"><a class="page-link" href="${pageMaker.endPage +1 }">Next</a></li>
		                                </c:if>
                                	</ul>
                                </form>
                                </div>
                                <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                	<div class="modal-dialog">
                                		<div class="modal-content">
                                			<div class="modal-header">
                                				<h4 class="modal-title" id="myModalLabel">Modal title</h4>
                                				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">X</button>
                                			</div>
                                			<div id="aaa" class="registerMessage modal-body">처리가 완료되었습니다</div>
                                			<div class="modal-footer">
                                				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                				<button type="button" class="btn btn-primary">Save changes</button>
                                			</div>
                                		</div>
                                	</div>
                            	</div>
                            	<script type="text/javascript">
                            		$(document).ready(function(){
                            			var result = '<c:out value="${result}"/>';
                            			
                            			checkModal(result);
                            			
                            			history.replaceState("asd", null, null);
                            			
                            			function checkModal(result){
                            				if(result === '' || history.state ){
                            					return;
                            				}
                            				
                            				if(parseInt(result) > 0){
                            					//$(".registerMessage").html("게시글 " + parseInt(result) + " 번이 등록되었습니다");
                            					document.getElementById("aaa").innerText = ("게시글 " + parseInt(result) + " 번이 등록되었습니다");
                            				}
                            				$("#myModal").modal("show");
                            				
                            			}
                            			
                            			$("#regBtn").on("click", function(){
                            				self.location ="/board/register";
                            			});
                            			
                            			var actionForm = $("#actionForm");
                            			
                            			$(".page-item a").on("click", function(e){
                            				e.preventDefault();
                            				console.log('click');
                            				actionForm.find("input[name='pageNum']").val($(this).attr("href"));
                            				actionForm.submit();
                            			});
                            			
                            			$(".move").on("click", function(e){
											e.preventDefault();
											actionForm.append("<input type='hidden' name='bno' value='" + $(this).attr("href") + "'>");
											actionForm.attr("action", "/board/get");
											actionForm.submit();
                            			});
                            		});
                            	</script>
                            </div>
                        </div>
                    </div>

                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->

<%@include file = "../includes/footer.jsp" %>