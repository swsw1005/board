<%@page import="net.webjjang.util.PageObject"%>
<%@page import="com.webjjang.board.dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 태그를 이용해서 제어문 처리하도록 하는 설정 -->
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="customtag" tagdir="/WEB-INF/tags"%>

<%
	// 여기 부분은 자바 입니다. -> Controller(jsp) - Service(x) - Dao(Mapper)
System.out.println("------------ list.jsp");

// 넘어오는 데이터 받기
String pageStr = request.getParameter("page");
if (pageStr == null || pageStr.equals(""))
	pageStr = "1";
int cpage = Integer.parseInt(pageStr);
String perPageNumStr = request.getParameter("perPageNum");
if (perPageNumStr == null || perPageNumStr.equals(""))
	perPageNumStr = "10";
int perPageNum = Integer.parseInt(perPageNumStr);

PageObject pageObject = new PageObject(cpage, perPageNum);

// DB에서 데이터를 가져오는 프로그램 작성 -> List<BoardDTO> -> 차후
// DB 처리하는 객체를 생성하고 메서드 호출
BoardDAO dao = new BoardDAO();
//JSP에서 페이지네이션을 위해 계산 -> 전체 데이터 갯수 필요.
pageObject.setTotalRow(dao.getTotalRow());

//*** 한블럭방 몇페이지?
pageObject.setPerGroupPageNum(15);
pageObject.setPerPageNum(20);

request.setAttribute("pageObject", pageObject);
// request객체에 담기
request.setAttribute("list", dao.list(pageObject));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 리스트</title>

<!-- Bootstrap + jQuery 라이브러리 등록 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- CDN - W3CSS -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">


<style type="text/css">
.dataRow:hover {
	cursor: pointer;
}
</style>

<script>
	$(function() {
		// 게시글 한줄을 클릭하면 글보기로 이동시킨다.
		$(".dataRow").click(function() {
			// view.jsp?no=15
			var no = $(this).find(".no").text();
			// location 객체에 url을 저장하는 속성 : href -> location.href
			location = "view.jsp?no=" + no + "&inc=t";
		});
	});
</script>

</head>
<body>
	<div class="w3-container w3-margin">
		<h2>게시판 리스트</h2>
		<table class="w3-table">
			<tr>
				<th>글번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
			<!-- 반복의 시작 -->
			<c:forEach items="${list }" var="dto">
				<tr class="dataRow">
					<td class="no">${dto.no }</td>
					<td>${dto.title }</td>
					<td>${dto.writer }</td>
					<td>${dto.writeDate }</td>
					<td>${dto.hit }</td>
				</tr>
			</c:forEach>
			<!-- 반복의 끝 -->
			<!-- 버튼 처리 -->
			<%-- <tr>
				<td colspan="5"><customtag:pageNav
						endPage="${pageObject.endPage }"
						totalPage="${pageObject.totalPage }"
						startPage="${pageObject.startPage }" page="${pageObject.page }" />
				</td>
			</tr> --%>
			<tr>
				<td colspan="5" class="w3-center">
				<customtag:pageNavW3
						endPage="${pageObject.endPage }"
						totalPage="${pageObject.totalPage }"
						startPage="${pageObject.startPage }"
						 page="${pageObject.page }" 
						 />
				</td>
			</tr>
			<tr>
				<td colspan="5"><a href="writeForm.jsp" class="w3-button">글쓰기</a>
				</td>
			</tr>
		</table>
	</div>

</body>
</html>


