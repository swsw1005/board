<%@page import="com.webjjang.board.dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 여기는 자바 부분입니다.
System.out.println("------------- updateForm.jsp");
// 글번호에 맞는 데이터를 DB에서 가져온다.
// no 를 받아서  no에 맞는 데이터를 DB에서 가져온다.
int no = Integer.parseInt(request.getParameter("no"));
// DB에서 데이터 가져오기.
BoardDAO dao = new BoardDAO();
request.setAttribute("dto", dao.view(no));

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글수정</title>

<!-- Bootstrap + jQuery 라이브러리 등록 -->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script type="text/javascript">
$(function(){
	//취소버큰 이벤트 처리 -> 이전페이지로 이동
	$(".cancelBtn").click(function(){
		history.back();
	});
});
</script>

</head>
<body>
<div class="container">
<h2>게시판 글수정</h2>
<form action="update.jsp" method="post">
	<!-- 번호입력 -->
	<div class="form-group">
	  <label for="no">글번호</label>
	  <input type="text" class="form-control" id="no" name="no"
	   value="${dto.no }" readonly="readonly">
	</div>

	<!-- 제목입력 -->
	<div class="form-group">
	  <label for="title">제목</label>
	  <input type="text" class="form-control" id="title" name="title"
	   value="${dto.title }" >
	</div>

	<!-- 내용입력 -->
	<div class="form-group">
	  <label for="content">내용</label>
	  <textarea class="form-control" rows="5" id="content" 
	    name="content">${dto.content }</textarea>
	</div> 
	
	<!-- 작성자 입력 -->
	<div class="form-group">
	  <label for="writer">작성자</label>
	  <input type="text" class="form-control" id="writer" name="writer"
	   value="${dto.writer }">
	</div>
	
	<!-- 비밀번호 입력 -->
	<div class="form-group">
	  <label for="pw">비밀번호</label>
	  <input type="password" class="form-control" id="pw" name="pw">
	</div>
	
	<!-- 버튼처리 -->
	<div class="btn-group">
	   <button class="btn btn-default">수정</button>
	   <button type="reset" class="btn btn-default">새로입력</button>
	   <button type="button" class="btn btn-default cancelBtn">취소</button>
	</div> 

</form>
</div>
</body>
</html>