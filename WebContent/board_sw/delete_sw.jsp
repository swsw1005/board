<%@ page import="com.connection.board.Board_one"%>
<%@ page import="com.connection.board.DBConnBoard"%>



<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "java.sql.*"%>
 
<%
	//자바 구문
request.setCharacterEncoding("UTF-8");
System.out.println("---delete.jsp");

//1. DB에서 삭제하고
DBConnBoard tt = new DBConnBoard();
tt.delete(Integer.parseInt(request.getParameter("no")));

//2. list로 redirect
response.sendRedirect("list_sw.jsp");
%>