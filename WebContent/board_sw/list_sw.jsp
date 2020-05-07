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
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=no">
<title>list.jsp</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style>
* {
	margin: 0px;
	padding: 0px;
}

td {
	border: 1px solid red;
}

.dataRow {
	cursor: pointer;
}
</style>
<script>
	// 스크립트

	$(function() {
		$(".dataRow").click(function() {

			var no = $(this).find(".no").text();

			location = "view_sw.jsp?no=" + no;

		});
	});
</script>
</head>
<body>
	<!-- 내용 -->

	<h2>게시판 리스트</h2>
	<br>
	<hr>
	<br>

	<%
		System.out.println("---list_sw.jsp");
	%>

	<%
		DBConnBoard tt = new DBConnBoard();
	tt.reload_list();
	System.out.println(tt.list_no.size());
	%>

	<table>
		<tr>
			<th>글번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>

		<%
			for (int i = 0; i < tt.list_no.size(); i++) {

			out.print("<tr class=\"dataRow\">");
			out.print("<td class=\"no\">" + (tt.list_no.get(i) + "") + "</td>");
			out.print("<td class=\"title\">" + tt.list_title.get(i) + "</td>");
			out.print("<td class=\"writer\">" + tt.list_writer.get(i) + "</td>");
			out.print("<td>" + tt.list_writeDate.get(i) + "</td>");
			out.print("	<td>" + tt.list_hit.get(i) + "</td>");
			out.print("	</tr>");

		}
		%>

		<tr>
			<td colspan="5"><a href="writeForm_sw.jsp"><button>글쓰기버튼</button></a></td>
		</tr>

	</table>

</body>

</html>