
<%@page import="com.webjjang.board.dao.BoardReplyDAO"%>
<%@page import="com.webjjang.board.dto.BoardReplyDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	System.out.println("------ replyDelete.jsp --- ");
request.setCharacterEncoding("UTF-8"); // 한글 처리
// 넘어오는 데이터를 받아서 BoardDTO를 만들어 저장한 후 DB에 저장되도록 프로그램한다.
// 1. 데이터를 받는다.
String rno = request.getParameter("rno");
String pw = request.getParameter("pw");
// 2. DTO 생성해서 넣어준다.
BoardReplyDTO dto = new BoardReplyDTO();
dto.setRno(Integer.parseInt(rno));
dto.setPw(pw);
System.out.println("replyDelete.jsp.dto : " + dto);

// 3. DAO에 데이터를 넘겨서 처리하도록 한다.
BoardReplyDAO dao = new BoardReplyDAO();
int result = dao.delete(dto);
if (result != 0)
	out.print("111");
else
	out.print("000");
%>