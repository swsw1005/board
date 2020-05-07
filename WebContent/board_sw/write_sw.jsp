<%@ page import="com.connection.board.Board_one"%>
<%@ page import="com.connection.board.DBConnBoard"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*"%>

<%
	//자바 구문
request.setCharacterEncoding("UTF-8");
System.out.println("---------write_hw.jsp");
%>

<%
	//자바 구문

String today_ = new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());

System.out.println("!! post from writeForm_hw.jsp");
System.out.println("commit to DB");

DBConnBoard tt = new DBConnBoard();
Board_one nn = new Board_one();

nn.setTitle(request.getParameter("title"));
nn.setContent(request.getParameter("content"));
nn.setWriter(request.getParameter("writer"));
nn.setWriteDate(today_);
nn.setPw(request.getParameter("pw"));

tt.insert(nn);

System.out.println("!! sendRedirect(\"list_hw.jsp\"");

response.sendRedirect("list_sw.jsp");
%>
