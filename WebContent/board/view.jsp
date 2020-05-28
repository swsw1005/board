<%@page import="com.webjjang.board.dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// 여기는 자바 입니다.
System.out.println("----------- view.jsp");
// no 를 받아서  no에 맞는 데이터를 DB에서 가져온다.
int no = Integer.parseInt(request.getParameter("no"));
String inc = request.getParameter("inc");
// DB에서 데이터 가져오기.
BoardDAO dao = new BoardDAO();
// inc가 "t"면 조회수 1증가
if (inc.equals("t"))
	dao.increase(no);
// 데이터 가져오기
request.setAttribute("dto", dao.view(no));
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글보기</title>

<!-- Bootstrap + jQuery 라이브러리 등록 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>


<script>
	$(function() {

		function reload() {
			$("#replyList").load("replyList.jsp?no=" + "${dto.no}");
		}
		function reload_auto() {
			reload();
			setInterval(reload, 2000);
		}

		reload_auto();

		// 모달 창의 댓글등록 버튼 이벤트처리
		$("#replyWriteBtn").click(function() {
			console.log('댓글입력 버튼 클릭');
			update("write");
		});

		// 모달 창의 댓글수정 버튼 이벤트처리
		$("#replyUpdateBtn").click(function() {
			console.log('댓글수정버튼 클릭');
			update("update");
		});

		// 데이터를 변경하는 함수 - update
		function update(action) {
			if (action == "write")
				console.log("댓글 등록 클릭");
			else
				console.log("댓글 수정 클릭")
				// 입력한 데이터를 받아 내자.
			var no = $("#no").val();
			var rno = $("#rno").val();
			var content = $("#content").val();
			var writer = $("#writer").val();
			var pw = $("#pw").val();
			// JSON 데이터로 만들기
			var reply = {
				// 항목이름 : 값(변수)
				// no : no,
				content : content,
				writer : writer,
				pw : pw
			}
			var url = "";
			// 만약에 write면 no를 포함 시킨다.
			if (action == "write") {
				reply.no = no;
				url = "replyWrite.jsp";
			}
			// 수정이면 rno를 포함시킨다.
			else {
				reply.rno = rno;
				url = "replyUpdate.jsp";
			}

			// ajax(비동기 통신)를 통해서 post방식의 입력한 데이터를 서버에 넘기기
			$.ajax({
				type : "post",
				url : url,
				data : reply,
				// 리턴 되어 돌려 받는 데이터의 타입
				dataType : "text",
				// 기본값이므로 삭제 가능
				//contentType : "application/x-www-form-urlencoded; charset=utf-8",
				success : function(result, status, xhr) {
					if (action == "write") {
						replyWriteResultAlertTrue();
					} else {
						if (result =="111") {
						replyUpdateResultAlertTrue();
						} else {
						replyUpdateResultPWError();
						}
					}
					console.log("result " + result);
					// 댓글 리스트를 가져와서 뿌려주자.
					$("#replyList").load("replyList.jsp?no=" + "${dto.no}");
				},
				error : function(xhr, status, error) {
					if (action == "write") {
						replyWriteResultAlertFalse();
					} else {
						replyUpdateResultAlertFalse();
					}
					// alert(xhr + "/" + status + "/" + error);
				} // error의 끝
			}); // ajax의 끝

			// 모달 창의 입력한 데이터 지우기
			clear();

			$("#replyModal").modal("hide");
		}
		// update 함수의 끝 -------------------------------------

		// 새로 입력 버튼 이벤트
		$("#replyResetBtn").click(function() {
			clear();
		});

		function clear() {
			$("#content").val("");
			$("#writer").val("");
			$("#pw").val("");
		}

		// 댓글 수정 이벤트
		// 이벤트의 전달 - ajax에 의해서 표시된 데이터를 호출 당해서 처리가 될때 이벤터 처리를 하게된다.
		$("#replyList").on("click", ".replyUpdateBtn", function() {
			console.log("댓글 리스트 div의 댓글 수정 버튼 클릭");
			// 모달창 - 댓글번호, 내용, 작성자
			var item = $(this).closest(".dataRow");
			var rno = item.find(".rno").text();
			var content = item.find(".content").text();
			var writer = item.find(".writer").text();
			// 데이터 확인
			console.log(rno + "/" + content + "/" + writer);
			// 데이터를 모달창에 셋팅
			$("#rno").val(rno);
			$("#content").val(content);
			$("#writer").val(writer);
			// 쓰기 버튼은 감춘다.
			$("#replyWriteBtn").hide();
			$("#replyUpdateBtn").show();

			// 비밀번호 입력 타입을 password로 만들어서 입력하는 글자를 안보이게 처리한다.
			$("#pw").attr("type", "password");

			// 모달창을 보여준다.
			$("#replyModal").modal("show");
		});

		// 댓글 삭제 이벤트
	// 이벤트의 전달
	$("#replyList").on("click", ".replyDeleteBtn", function(){
		// alert("댓글 삭제 클릭");
		// 모달창 - 댓글번호
		var item = $(this).closest(".dataRow");
		var rno = item.find(".rno").text();
		$("#deleteRno").val(rno);
		// 비밀번호 지우기
		$("#deletePw").val("");
		// 모달창을 보이기
		$("#replyDeleteModal").modal("show");
	});
	
	// 삭제 처리하는 이벤트
	$("#replyDeleteBtn").click(function(){
		var reply = {
				rno : $("#deleteRno").val(),
				pw : $("#deletePw").val()
		};
		$.ajax({
			type : "post",
			url : "replyDelete.jsp",
			data : reply,
			dataType : "text",
			success : function(result, status, xhr){
				// 결과가 1이면 성공적으로 댓글삭제, 결과가 0이면 비밀번호 확인
if (result =="111") {
				replyDeleteResultAlertTrue();
} else {
	replyDeleteResultAlertPWError();
}

			},
			error : function(xhr, status, error){
				replyDeleteResultAlertFalse();
			}
		});
		
		$("#replyDeleteModal").modal("hide");
		
		$("#replyList").load("replyList.jsp?no=" + ${dto.no});
		
	});

		// 댓글 제목 오른쪽에 댓글 등록 버튼을 누르면 
		// 모달 창의 수정버튼은 안보이게 , 쓰기 버튼은 보이게 처리한다.
		$("#addReplyBtn").click(function() {
			console.log("#addReplyBtn 클릭");
			// 비밀번호 입력 시 비밀번호가 보이게 처리한다. - type을 text로 변환해 준다.
			$("#pw").attr("type", "text");
			$("#pw").val("");

			$("#replyWriteBtn").show();
			$("#replyUpdateBtn").hide();
		});

		// 댓글 등록 성공 함수 --------------------------------------------------------------
		function replyWriteResultAlertTrue() {
			console.log("---성공적으로 댓글 등록이 되었습니다.");
			const tt = "<div class=\"alert alert-success\"><strong>Reply Write Success!</strong> 댓글 쓰기 성공 </div>";
			document.getElementById("replyWriteResultAlert").innerHTML = tt;
			replyResultAlertClear();
		}
		// 댓글 등록 실패 함수 --------------------------------------------------------------
		function replyWriteResultAlertFalse() {
			console.log("---댓글 등록 실패");
			const tt = "<div class=\"alert alert-danger\"><strong>Reply Write Fail!</strong> 댓글 쓰기 실패 </div>";
			document.getElementById("replyWriteResultAlert").innerHTML = tt;
			replyResultAlertClear();
		}
		// 댓글 수정 성공 함수 --------------------------------------------------------------
		function replyUpdateResultAlertTrue() {
			console.log("---성공적으로 댓글 수정이 되었습니다.");
			const tt = "<div class=\"alert alert-success\"><strong>Reply Update Success!</strong> 댓글 수정 성공 </div>";
			document.getElementById("replyWriteResultAlert").innerHTML = tt;
			replyResultAlertClear();
		}
		// 댓글 수정 비번오류 --------------------------------------------------------------
		function replyUpdateResultPWError() {
			console.log("---댓글 수정   비번 오류");
			const tt = "<div class=\"alert alert-warning\"><strong>Reply Update fail!</strong> 비밀번호를 확인하세요 </div>";
			document.getElementById("replyWriteResultAlert").innerHTML = tt;
			replyResultAlertClear();
		}
		// 댓글 수정 실패 함수 --------------------------------------------------------------
		function replyUpdateResultAlertFalse() {
			console.log("---댓글 수정 실패");
			const tt = "<div class=\"alert alert-danger\"><strong>Reply Update Fail!</strong> 댓글 수정 실패 </div>";
			document.getElementById("replyWriteResultAlert").innerHTML = tt;
			replyResultAlertClear();
		}
		// 댓글 삭제 성공 함수 --------------------------------------------------------------
		function replyDeleteResultAlertTrue() {
			console.log("---성공적으로 댓글 삭제 되었습니다.");
			const tt = "<div class=\"alert alert-success\"><strong>Reply Update Success!</strong> 댓글 삭제 성공 </div>";
			document.getElementById("replyWriteResultAlert").innerHTML = tt;
			replyResultAlertClear();
		}
		// 댓글 삭제 비번오류 함수 --------------------------------------------------------------
		function replyDeleteResultAlertPWError() {
			console.log("---댓글삭제 : 비밀번호 오류");
			const tt = "<div class=\"alert alert-warning\"><strong>Reply Delete Fail!</strong>  비밀번호를 확인하세요</div>";
			document.getElementById("replyWriteResultAlert").innerHTML = tt;
			replyResultAlertClear();
		}
		// 댓글 삭제 실패 함수 --------------------------------------------------------------
		function replyDeleteResultAlertFalse() {
			console.log("---댓글 삭제 실패");
			const tt = "<div class=\"alert alert-danger\"><strong>Reply Update Fail!</strong> 댓글 삭제 실패 </div>";
			document.getElementById("replyWriteResultAlert").innerHTML = tt;
			replyResultAlertClear();
		}
		// 비우기 함수 --------------------------------------------------------------
		function replyResultAlertClear() {
			// 3초뒤 댓글 알림 off
			setInterval(() => {
				console.log("댓글 알림 OFF");
				document.getElementById("replyWriteResultAlert").innerHTML ="";
			},3000 );
		}

	});
</script>

</head>
<body>


	<div class="container">
		<h2>게시판 글보기</h2>

		<table class="table">
			<tr>
				<th>글번호</th>
				<td>${dto.no }</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>${dto.title }</td>
			</tr>
			<tr>
				<th>내용</th>
				<td><pre style="background: #fff; border: #fff">${dto.content }</pre></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>${dto.writer }</td>
			</tr>
			<tr>
				<th>작성일</th>
				<td>${dto.writeDate }</td>
			</tr>
			<tr>
				<th>조회수</th>
				<td>${dto.hit }</td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="btn-group">
						<a href="updateForm.jsp?no=${param.no }" class="btn btn-default">수정</a>
						<a href="delete.jsp?no=${param.no }" class="btn btn-default">삭제</a>
						<a href="list.jsp" class="btn btn-default">리스트</a>
					</div>
				</td>
			</tr>


		</table>
	</div>


	<!-- 댓글 성공 / 실패 alert------------------------------------------------------>
	<div id="replyWriteResultAlert" class="container">
		<!-- ----------------------------------------------- -->
		<%-- <div class="alert alert-success">
			<strong>Success!</strong> Indicates a successful or positive action.
		</div> --%>
		<!-- ----------------------------------------------- -->
		<%-- <div class="alert alert-danger">
			<strong>Danger!</strong> Indicates a dangerous or potentially
			negative action.
		</div> --%>
		<!-- ----------------------------------------------- -->
	</div>
	<!-- 댓글 성공 / 실패 alert------------------------------------------------------>


	<!-- 댓글 처리 : Ajax 이용. 1. 댓글 리스트 - load(), 2. 쓰기, 수정, 삭제 $.ajxt() -->

	<div class="container">
		<div class="panel panel-default">
			<div class="panel-heading">
				댓글 <span class="pull-right">
					<button class="btn btn-primary btn-xs" id="addReplyBtn"
						data-toggle="modal" data-target="#replyModal">쓰기</button>
				</span>
			</div>
			<div class="panel-body">
				<ul class="list-group" id="replyList">
					<li class="list-group-item">데이터를 불러오는 중입니다.</li>
				</ul>
			</div>
		</div>
	</div>

	<!-- Modal 시작 -->
	<div class="modal fade" id="replyModal" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h3 class="modal-title">댓글 작성</h3>
				</div>
				<div class="modal-body">
					<form id="replyWriteForm">
						<!-- 글번호 입력 -->
						<input type="hidden" id="no" name="no" value="${dto.no }" />
						<!-- 댓글번호 입력 -->
						<input type="hidden" id="rno" name="rno" />
						<!-- 내용입력 -->
						<div class="form-group">
							<label for="content">내용</label>
							<textarea class="form-control" rows="3" id="content"
								name="content" required="required"></textarea>
						</div>
						<!-- 작성자 입력 -->
						<div class="form-group">
							<label for="writer">작성자</label> <input type="text"
								class="form-control" id="writer" name="writer"
								required="required">
						</div>
						<!-- 비밀번호 입력 -->
						<div class="form-group">
							<label for="pw">비밀번호</label> <input type="text"
								class="form-control" id="pw" name="pw" required="required">
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<div class="btn-group">
						<button class="btn btn-default" id="replyWriteBtn">쓰기</button>
						<button class="btn btn-default" id="replyUpdateBtn">수정</button>
						<button type="reset" class="btn btn-default" id="replyResetBtn">새로입력</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
					</div>
				</div>
			</div>
			<!-- Modal content 끝-->

		</div>
	</div>
	<!-- Modal 끝 -->

	<!-- 삭제 Modal 시작 -->
	<div class="modal fade" id="replyDeleteModal" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h3 class="modal-title">댓글 삭제</h3>
				</div>
				<div class="modal-body">
					<form id="replyDeleteForm">
						<!-- 댓글번호 입력 -->
						<input type="hidden" id="deleteRno" name="rno" />
						<!-- 비밀번호 입력 -->
						<div class="form-group">
							<label for="deletePw">비밀번호</label> <input type="password"
								class="form-control" id="deletePw" name="pw" required="required">
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<div class="btn-group">
						<button class="btn btn-default" id="replyDeleteBtn">삭제</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
					</div>
				</div>
			</div>
			<!-- Modal content 끝-->

		</div>
	</div>
	<!-- Modal 끝 -->



	</div>
</body>
</html>