<%@page import="com.connection.notice.Notice_one"%>
<%@page import="com.connection.notice.DBConnNotice"%>
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
<title>updateForm.jsp</title>
<%
	System.out.println("---updateForm_hw.jsp");
%>
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

DBConnNotice tt = new DBConnNotice();
tt.reload_one(no_);

%>




	<form action="update_hw.jsp" method="post">
		<table>
			<tr>
				<th>글번호</th>
				<td><input name="no" value=<%=no_ %> readonly="readonly"></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input name="title" value=<%= tt.notice_title%>></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea rows="5" cols="80" name="content"><%= tt.notice_content%></textarea></td>
			</tr>
			<tr>
				<th>공지시작일</th>
				<td><input type="text" name="startDate" value=<%= tt.notice_startDate%>></td>
			</tr>
			<tr>
				<th>공지종료일</th>
				<td><input type="text" name="endDate" value=<%= tt.notice_endDate%>></td>
			</tr>
			<tr>
				<th>주의!!</th>
				<td>날짜입력 양식 <strong> ex) 2020-03-03</strong></td>
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