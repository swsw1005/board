<%@ page import="com.connection.notice.Notice_one"%>
<%@ page import="com.connection.notice.DBConnNotice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*"%>

<%
	//자바 구문
request.setCharacterEncoding("UTF-8");
System.out.println("---update_hw.jsp");
%>

<%
	// 여기가 자바 부분입니다.
System.out.println("-------- update_hw.jsp");
//DB에 받아온 데이터를 update 처리한다.

Notice_one nn = new Notice_one();

int temp_no = Integer.parseInt(request.getParameter("no"));

String today_ = new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());

nn.setNo(temp_no);
nn.setTitle(request.getParameter("title"));
nn.setContent(request.getParameter("content"));
nn.setStartdate(request.getParameter("startDate"));
nn.setEnddate(request.getParameter("endDate"));
nn.setUpdatedate(today_);

System.out.println(today_);

DBConnNotice tt = new DBConnNotice();
tt.update(nn);

// 글보기로 자동 이동시킨다.
response.sendRedirect("view_hw.jsp?no=" + temp_no);
%>
