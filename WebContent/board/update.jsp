<%@page import="com.webjjang.board.dao.BoardDAO"%>
<%@page import="com.webjjang.board.dto.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
// 여기가 자바 부분입니다.
System.out.println("-------- update.jsp");
// 한글 처리
request.setCharacterEncoding("utf-8");

//DB에 받아온 데이터를 update 처리한다.
// 1. 넘어오는 데이터를 받는다.
int no = Integer.parseInt(request.getParameter("no"));
String title = request.getParameter("title");
String content = request.getParameter("content");
String writer = request.getParameter("writer");
String pw = request.getParameter("pw");

// 2. DTO 생성
BoardDTO dto = new BoardDTO();

// 3. 데이터 넣기
dto.setNo(no);
dto.setTitle(title);
dto.setContent(content);
dto.setWriter(writer);
dto.setPw(pw);

// 4. DB에 적용 시키기.
BoardDAO dao = new BoardDAO();
int result = dao.update(dto);

// 글보기로 자동 이동시킨다.
if(result == 1)
	response.sendRedirect("view.jsp?no="+ no + "&inc=f");
else
	response.sendRedirect("/error/error_info.jsp");
%>
