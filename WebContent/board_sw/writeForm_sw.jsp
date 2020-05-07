<%@ page import="com.connection.board.Board_one"%>
<%@ page import="com.connection.board.DBConnBoard"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%!//변수 선언%>

<%
	//자바 구문
request.setCharacterEncoding("UTF-8");
System.out.println("---writeForm_sw.jsp");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=no">


<script src="../js/jquery-3.4.1.min.js"></script>
<title>writeForm.jsp</title>
<style>
* {
	margin: 0px;
	padding: 0px;
}

td {
	border: 1px solid red;
}
</style>
<script>
	$(function() {
		$("#cancleBtn").click(function() {
			console.log("cancleBtn click");
			history.back();
		});
	});
</script>
</head>
<body>
	<!-- 내용 -->
	<h2>글 쓰기 폼</h2>
	<br>
	<hr>
	<br>



	<form action="write_sw.jsp" method="post">

		<table>
			<tr>
				<th>제목</th>
				<td><input type="text" name="title"></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea name="content" id="" cols="80" rows="5"></textarea></td>
			</tr>
			<tr>
				<th>글쓴이</th>
				<td><input type="text" name="writer"></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="pw"></td>
			</tr>
		</table>

		<button type="reset">새로입력</button>
		<button>쓰기</button>
		<button type="button" id="cancleBtn">취소</button>

	</form>




</body>

</html>