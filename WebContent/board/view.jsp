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
						<a href="delete.jsp?no=${param.no }" class="btn btn-default">새로입력</a>
						<a href="list.jsp" class="btn btn-default cancelBtn">취소</a>
					</div>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>