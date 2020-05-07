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
System.out.println("---updateForm.jsp");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=no">
<title>updateForm.jsp</title>
<style>
* {
	margin: 0px;
	padding: 0px;
}
td {
	border: 1px solid red;
}
</style>
<script src="../js/jquery-3.4.1.min.js"></script>
<script>
	// 스크립트
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

	<h2>글 수정 폼</h2>
	<br>
	<hr>
	<br>
<%
int no_= Integer.parseInt(request.getParameter("no"));
DBConnBoard tt = new DBConnBoard();
tt.reload_one(no_);
%>




	<form action="update_sw.jsp" method="post">
		<table>
			<tr>
				<th>글번호</th>
				<td><input name="no" value=<%=no_ %> readonly="readonly"></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input name="title" value=<%= tt.board_title%>></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea rows="5" cols="80" name="content"><%= tt.board_content%></textarea></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><input name="writer" value=<%= tt.board_writer%>></td>
			</tr>
			<tr>
				<td colspan="2">
					<button>수정</button>
					<button type="reset">새로입력</button>
					<button type="button" id="cancleBtn">취소</button>
				</td>
			</tr>
		</table>

	</form>

</body>

</html>