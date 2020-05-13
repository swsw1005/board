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

<style>
.ani {
	transition: 1s;
}

</style>

<!-- Bootstrap + jQuery 라이브러리 등록 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script>
	// 스크립트
	$(function() {
		// 댓글 로딩
		setTimeout(rep_load,300);
		interval();

		// 댓글등록 버튼 이벤트처리
		$("#replyWriteBtn").click(writeReply);
	});

	function writeReply() {
		// 입력한 데이터를 받아 내자.
		var no_ = $("#no").val();
		console.log("---" + no_ + "---");
		var content_ = $("#content").val();
		var writer_ = $("#writer").val();
		var pw_ = $("#pw").val();

		// JSON 데이터로 만들기
		var reply = {
			// 항목이름 : 값(변수)
			no : $("#no").val(),
			content : $("#content").val(),
			writer : $("#writer").val(),
			pw : $("#pw").val()
		}

		console.log(reply.no);
		//alert(JSON.stringify(reply));
		//var data = JSON.stringify(reply);
		// ajax(비동기 통신)를 통해서 post방식의 입력한 데이터를 서버에 넘기기
		$.ajax({
			type : "post",
			url : "replyWrite.jsp",
			//	dateType : "json",
			//async: true,
			data : reply
			,
			//contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				//alert("성공적으로 댓글 등록이 되었습니다.");
				//console.log(result);
				//console.log(status);
				//console.log(xhr);
				rep_write_true();
			},
			error : function(status) {
				//alert("댓글을 등록하는 중 오류가 발생되었습니다.");
				console.log(status);
				rep_write_false();
			}
		});
		$("#replyModal").modal("hide");
		setTimeout(rep_load(), 300);
	}
	//contentType : "application/json;
	//___ request is sending json data
	//___서버에 데이터를 보낼 때
	// dateType : "json",
	//___ request expects a json response.
	//___서버에서 반환되는 데이터 형식

	function interval() {
		setInterval(rep_load, 3000);
	}

	//댓글 로딩
	function rep_load() {
		var no = $("#board_no").text();
		console.log(no);
		$("#replyList").load("replyList.jsp?no=" + no);
	}

	//ajax 성공시...
	function rep_write_true() {
		console.log("tt");
		modal_del();
		$("#rep_result")
				.html(
						'<span class="alert alert-success ani">성공적으로 댓글을 작성하였을껍니다. 아마도...3초후 폭파</span>');
		setTimeout(rep_write_reset, 3200);
	}

	//ajax 실패시...
	function rep_write_false() {
		console.log("ff");
		$("#rep_result")
				.html(
						'<span class="alert alert-danger ani">댓글 입력에 실패하였습니다. 이유는 모릅니다...3초후 폭파</span>');
		setTimeout(rep_write_reset, 3200);
	}

	//성공,실패 시  
	function rep_write_reset() {
		document.getElementById("rep_result").innerHTML = "";
	}

	function modal_del() {
		$("#content").val('');
		$("#writer").val('');
		$("#pw").val('');
	}
</script>

</head>
<body>
	<div class="container">
		<h2>게시판 글보기</h2>
		<table class="table">
			<tr>
				<th>글번호</th>
				<td id=board_no>${dto.no }</td>
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
						<a href="delete.jsp?no=${param.no }" class="btn btn-default">새로입력</a>
						<a href="list.jsp" class="btn btn-default cancelBtn">취소</a>
					</div>
				</td>
			</tr>
		</table>

		<hr>
		<button onclick="rep_load()">댓글소환</button>
		<div id="rep_result"></div>
		<hr>



		<!-- 댓글 처리 : Ajax 이용. 1. 댓글 리스트 - load(), 2. 쓰기, 수정, 삭제 $.ajxt() -->
		<div class="panel panel-default">
			<div class="panel-heading">
				댓글 <span class="pull-right">
					<button class="btn btn-primary btn-xs" data-toggle="modal"
						data-target="#replyModal">쓰기</button>
				</span>
			</div>
			<div class="panel-body">
				<ul id="replyList" class="list-group">
				
				<li class="list-group-item">데이터를 불러오는 중입니다.</li>
				
				</ul>
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
							<button type="reset" class="btn btn-default">새로입력</button>
							<button type="button" class="btn btn-default"
								data-dismiss="modal">취소</button>
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