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
System.out.println("---list.jsp");
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
	margin: 2px;
	padding: 2px;
}

td {
	border: 1px solid red;
}

.dataRow {
	cursor: pointer;
}

ul {
	list-style: none;
	padding: 0px;
	margin: 0px;
	cursor: pointer;
	/* dev option */
}

.li {
	padding: 0px;
	display: grid;
	grid-template-columns: 70px 250px 100px 100px;
	border: 1px solid red;
	/* grid-gap: 10px; */
	/* dev option */
	/* background: yellow; */
}
</style>
<script>
	// 스크립트

	$(function() {
		$(".dataRow").click(function() {
			var no = $(this).find(".no").text();
			location = "view_hw.jsp?no=" + no;
		});

		$(".li").click(function() {
			var a1 = this;
			var a2 = a1.childNodes[1];
			var no = a2.innerText;
			location = "view_hw.jsp?no=" + no;
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
		DBConnNotice tt = new DBConnNotice();
	tt.reload_list();
	System.out.println(tt.list_no.size());
	%>

	<%-- <table>
		<tr>
			<th>글번호</th>
			<th>제목</th>
			<th>공지시작일</th>
			<th>공지종료일</th>
		</tr>

		<%
			for (int i = 0; i < tt.list_no.size(); i++) {
			out.print("<tr class=\"dataRow\">");

			out.print("<td class=\"no\">" + (tt.list_no.get(i) + "") + "</td>");
			out.print("<td class=\"title\">" + tt.list_title.get(i) + "</td>");
			out.print("<td>" + tt.list_startDate.get(i) + "</td>");
			out.print("<td>" + tt.list_endDate.get(i) + "</td>");

			out.print("</tr>");
		}
		%>
		<tr>
			<td colspan="5"><a href="writeForm_hw.jsp"><button>글쓰기버튼</button></a></td>
		</tr>
	</table> --%>

	<!-- 헤더 -->
	<div class="ul">
		<div class="li">
			<div class="no">글번호</div>
			<div class="title">제목</div>
			<div class="date">공지시작일</div>
			<div class="date">공지종료일</div>
		</div>
		<!-- ... -->
	</div>
	<!-- 헤더 end -->

	<ul class="ul">
		<!-- ............. -->
		<%-- <li class="li">
      <div class="no">5</div>
      <div class="title">공지사항 샘플</div>
      <div class="date">2020-04-02</div>
      <div class="date">2020-05-05</div>
    </li>
    <li class="li"></li> --%>
		<!-- ///////// -->
		<!-- ............. -->

		<%
			for (int i = 0; i < tt.list_no.size(); i++) {

			out.print("<li class=\"li\">");
			out.print(" <div class=\"no\">" + (tt.list_no.get(i) + "") + "</div>");
			out.print(" <div class=\"title\">" + tt.list_title.get(i) + "</div>");
			out.print(" <div class=\"date\">" + tt.list_startDate.get(i) + "</div>");
			out.print(" <div class=\"date\">" + tt.list_endDate.get(i) + "</div>");
			out.print("</li>");
		}
		%>

		<!-- ///////// -->
	</ul>
	<a href="writeForm_hw.jsp"><button>글쓰기버튼</button></a>






</body>

</html>