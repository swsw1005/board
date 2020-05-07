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
System.out.println("------view_hw.jsp");
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
	DBConnNotice tt = new DBConnNotice();
	
	int j=Integer.parseInt(request.getParameter("no"));
	tt.reload_one(j);

	String temp_title = tt.notice_title;
	String temp_content = tt.notice_content;
	String temp_startDate = tt.notice_startDate;
	String temp_endDate = tt.notice_endDate;
	String temp_updateDate = tt.notice_updateDate;
	%>
	<table>
		<tr>
			<th>글번호</th>
			<td><%=request.getParameter("no")%></td>
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
			<th>공지시작일</th>
			<td><%=temp_startDate%></td>
		</tr>
		<tr>
			<th>공지종료일</th>
			<td><%=temp_endDate%></td>
		</tr>
		<tr>
			<th>최종수정일</th>
			<td><%=temp_updateDate%></td>
		</tr>
		<tr>
			<td colspan="2"><a href="updateForm_hw.jsp?no=${param.no }">
					<button>수정</button>
			</a> <a href="delete_hw.jsp?no=${param.no }">
					<button>삭제</button>
			</a> <a href="list_hw.jsp">
					<button>리스트</button>
			</a></td>
		</tr>
	</table>

</body>

</html>