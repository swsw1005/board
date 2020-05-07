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
System.out.println("------view.jsp");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=no">
<title>view.jsp</title>
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
</style>
<script>
	// 스크립트
</script>
</head>
<body>
	<!-- 내용 -->
	<%
		//자바 구문
		
		DBConnBoard tt = new DBConnBoard();
	
	int j = Integer.parseInt(request.getParameter("no"));
	
	tt.reload_one(j);
	
	String temp_title = tt.board_title;
	String temp_content= tt.board_content;
	String temp_writer= tt.board_writer;
	String temp_writeDate= tt.board_writeDate;
	int temp_hit= tt.board_hit;
	%>
	<table>
		<tr>
			<th>글번호</th>
			<td><%=j %></td>
		</tr>
		<tr>
			<th>제목</th>
			<td><%=temp_title%></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><pre><%=temp_content%></pre></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td><%=temp_writer %></td>
		</tr>
		<tr>
			<th>작성일</th>
			<td><%=temp_writeDate %></td>
		</tr>
		<tr>
			<th>조회수</th>
			<td><%= temp_hit %></td>
		</tr>
		<tr>
			<td colspan="2"><a href="updateForm_sw.jsp?no=${param.no }">
					<button>수정</button>
			</a> <a href="delete_sw.jsp?no=${param.no }">
					<button>삭제</button>
			</a> <a href="list_sw.jsp">
					<button>리스트</button>
			</a></td>
		</tr>
	</table>

</body>

</html>