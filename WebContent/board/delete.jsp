<%@page import="com.webjjang.board.dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 이곳이 자바 부분입니다.
System.out.println("-------------- delete.jsp");
// 삭제할 번호와 비밀번호를 받아서 DB에서 삭제한다.
// no 를 받아서  no에 맞는 데이터를 DB에서 가져온다.
int no = Integer.parseInt(request.getParameter("no"));
// DB에서 데이터 가져오기.
BoardDAO dao = new BoardDAO();
int result = dao.delete(no);

// 자동으로 리스트로 간다.
if(result == 1)
	response.sendRedirect("list.jsp");
else
	response.sendRedirect("/error/error_info.jsp");
%>