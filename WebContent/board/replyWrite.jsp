<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ page import="java.util.*"%>
<%@page import="com.webjjang.board.dto.*"%>
<%@page import="com.webjjang.board.dao.*"%>

<%
	//자바 구문
request.setCharacterEncoding("UTF-8");
System.out.println("------replyWrite.jsp");
%>


<%
	//1. 데이터를 받는다.
String no = request.getParameter("no").trim();
System.out.println("no : " + no);

String content = request.getParameter("content");
System.out.println("content : " + content);

String writer = request.getParameter("writer");
String pw = request.getParameter("pw");

//2. DTO 생성해서 넣어준다.
BoardReplyDTO dto = new BoardReplyDTO();
dto.setNo(Integer.parseInt(no));
dto.setContent(content);
dto.setWriter(writer);
dto.setPw(pw);
System.out.println(dto.toString());

//3. DAO에 데이터를 넘겨서 처리하도록 한다.
BoardReplyDAO dao = new BoardReplyDAO();
dao.insert(dto);
%>

