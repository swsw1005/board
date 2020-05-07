<%@ page import="com.connection.notice.Notice_one"%>
<%@ page import="com.connection.notice.DBConnNotice"%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>

<%
	//자바 구문
request.setCharacterEncoding("UTF-8");
System.out.println("---delete.jsp");

//1. DB에서 삭제하고
DBConnNotice tt = new DBConnNotice();
tt.delete(Integer.parseInt(request.getParameter("no")));

//2. list로 redirect
response.sendRedirect("list_hw.jsp");
%>