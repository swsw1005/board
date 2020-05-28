<%@page import="org.apache.tomcat.util.json.Token"%>
<%@page import="org.apache.tomcat.util.json.JSONParser"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.webjjang.board.dao.BoardReplyDAO"%>
<%@page import="com.webjjang.board.dto.BoardReplyDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%
System.out.println("------------- replyUpdate.jsp");
// 넘어오는 데이터를 받아서 BoardDTO를 만들어 저장한 후 DB에 저장되도록 프로그램한다.
// 넘어오는 데이터의 한글처리
request.setCharacterEncoding("utf-8");
// 1. 데이터를 받는다.
String rno = request.getParameter("rno");
String content = request.getParameter("content");
String writer = request.getParameter("writer");
String pw = request.getParameter("pw");
// 2. DTO 생성해서 넣어준다.
BoardReplyDTO dto = new BoardReplyDTO();
dto.setRno(Integer.parseInt(rno));
dto.setContent(content);
dto.setWriter(writer);
dto.setPw(pw);
System.out.println("replyUpdate.jsp.dto : " + dto);

// 3. DAO에 데이터를 넘겨서 처리하도록 한다.
BoardReplyDAO dao = new BoardReplyDAO();
int result = dao.update(dto);
if (result != 0)
	out.print("111");
else
	out.print("000");
%>