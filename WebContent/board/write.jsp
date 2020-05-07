<%@page import="com.webjjang.board.dao.BoardDAO"%>
<%@page import="com.webjjang.board.dto.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
// 여기가 자바 부분입니다.
System.out.println("---------- write.jsp");
// 넘어오는 데이터를 받아서 BoardDTO를 만들어 저장한 후 DB에 저장되도록 프로그램한다.
// 넘어오는 데이터의 한글처리
request.setCharacterEncoding("utf-8");
// 1. 데이터를 받는다.
String title = request.getParameter("title");
String content = request.getParameter("content");
String writer = request.getParameter("writer");
String pw = request.getParameter("pw");

// 2. DTO 생성
BoardDTO dto = new BoardDTO();
// 3. dto에 데이터를 담는다.
dto.setTitle(title);
dto.setContent(content);
dto.setWriter(writer);
dto.setPw(pw);

// 4. DB에 데이터를 넣는 처리
//  dao를 생성하고 호출한다.
BoardDAO dao = new BoardDAO();
dao.write(dto);

// 처리가 다 끝나면 게시판 리스트로 자동 이동 시킨다.
response.sendRedirect("list.jsp");
%>
