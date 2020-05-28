<%@page import="com.webjjang.board.dao.BoardReplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%  // 자바입니다.
int no = Integer.parseInt(request.getParameter("no"));
// DB에서 no에 맞는 댓글리스트를 가져온다.
BoardReplyDAO dao = new BoardReplyDAO();
request.setAttribute("list", dao.list(no));
%>
<c:forEach items="${list }" var="vo">
	<li class="list-group-item dataRow">
		<div style="border-bottom : 1px solid #ddd;">
			<span class="rno">${vo.rno }</span>. 
			<span class="content">${vo.content }</span>
		</div>
		<div><span class="writer">${vo.writer }</span>(${vo.writeDate })
			<span class="pull-right">
				<button class="replyUpdateBtn btn btn-default btn-xs">수정</button>
				<button class="replyDeleteBtn btn btn-default btn-xs">삭제</button>
			</span>
		</div>
	</li>
</c:forEach>