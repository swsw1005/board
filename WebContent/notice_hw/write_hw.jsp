<%@ page import="com.connection.notice.Notice_one"%>
<%@ page import="com.connection.notice.DBConnNotice"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>

<%
	//자바 구문
request.setCharacterEncoding("UTF-8");
System.out.println("---------write_hw.jsp");
%>

<%
	//자바 구문

System.out.println("!! post from writeForm_hw.jsp");
System.out.println("commit to DB");

DBConnNotice tt = new DBConnNotice();
Notice_one nn = new Notice_one();

nn.setTitle(request.getParameter("title"));
nn.setContent(request.getParameter("content"));
nn.setStartdate(request.getParameter("startDate"));
nn.setEnddate(request.getParameter("endDate"));
nn.setUpdatedate(new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime()));

tt.insert(nn);

System.out.println("!! sendRedirect(\"list_hw.jsp\"");

response.sendRedirect("list_hw.jsp");
%>
