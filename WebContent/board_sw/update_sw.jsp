<%@ page import="com.connection.board.Board_one"%>
<%@ page import="com.connection.board.DBConnBoard"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "java.sql.*"%>
<%@ page import="java.text.*"%>

 
<%
//자바 구문
request.setCharacterEncoding("UTF-8");
System.out.println("---update_sw.jsp");
%>

<%
Board_one nn = new Board_one();

int temp_no = Integer.parseInt(request.getParameter("no"));

String today_ = new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());

nn.setNo(temp_no);
nn.setTitle(request.getParameter("title"));
nn.setContent(request.getParameter("content"));
nn.setWriter(request.getParameter("writer"));
nn.setWriteDate(request.getParameter("writeDate"));

DBConnBoard tt = new DBConnBoard();
tt.update(nn);

%>

<%
// 글보기로 자동 이동시킨다.
response.sendRedirect("view_sw.jsp?no="+ temp_no);
%>
