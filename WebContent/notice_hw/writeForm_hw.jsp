<%@ page import="com.connection.notice.Notice_one"%>
<%@ page import="com.connection.notice.DBConnNotice"%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%!//변수 선언%>

<%
	//자바 구문
request.setCharacterEncoding("UTF-8");
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

	<%
		System.out.println("---writeForm_hw.jsp");
	%>


	<form action="write_hw.jsp" method="post">

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
				<th>공지시작일</th>
				<td><input type="text" name="startDate"></td>
			</tr>
			<tr>
				<th>공지종료일</th>
				<td><input type="text" name="endDate"></td>
			</tr>
			<tr>
				<th>주의!!</th>
				<td>날짜입력 양식 <strong> ex) 2020-03-03</strong></td>
			</tr>
		</table>

		<button type="reset">새로입력</button>
		<button>쓰기</button>
		<button type="button" id="cancleBtn">취소</button>

	</form>




</body>

</html>