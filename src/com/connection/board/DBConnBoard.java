package com.connection.board;

import java.io.*;
import java.sql.*;
import java.util.*;

public class DBConnBoard {

	// DB
	String driver, url, user, pwd;
	Connection con = null;
	Statement stmt = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	// 1. 게시판 리스트
	public ArrayList<Integer> list_no = new ArrayList<>();
	public ArrayList<String> list_title = new ArrayList<>();
	public ArrayList<String> list_writer = new ArrayList<>();
	public ArrayList<String> list_writeDate = new ArrayList<>();
	public ArrayList<Integer> list_hit = new ArrayList<>();
	// 2. 게시글 보기
	public int board_no;
	public String board_title;
	public String board_content;
	public String board_writer;
	public String board_writeDate;
	public int board_hit;

	public void connect() {
		// DB접속 공통 메소드
		Properties pp = new Properties();

		try {
			pp.load(new FileInputStream("properties/DB.properties"));

			System.out.println("프로퍼티 로딩 ok");
		} catch (Exception ex) {
			System.out.println("!!!! properties 읽기 예외  " + ex);
		}

		// driver = pp.getProperty("driver");
		// url = pp.getProperty("url");
		// user = pp.getProperty("user");
		// pwd = pp.getProperty("pwd");

		url = "JDBC:oracle:thin:@localhost:1551:xe";
		driver = "oracle.jdbc.driver.OracleDriver";
		user = "java00";
		pwd = "q1w2e3";

		///

		System.out.println(driver + "  " + user);

		try {
			// 1. 드라이버 확인
			Class.forName(driver);
			System.out.println("드라이버 OK");

		} catch (ClassNotFoundException ex) {
			System.out.println("!!! driver check fail");
		}
		try {
			// 2. 연결
			con = DriverManager.getConnection(url, user, pwd);
			System.out.println("연결 ok");
			// 3. sql 문 작성 : String으로 쿼리문 넣어준다.
			stmt = con.createStatement();

		} catch (SQLException e) {
			System.out.println("!!!SQLException-------------");
			e.printStackTrace();
		}

	} // connect() end

	public int list_length() {
		// 0. 공지사항 리스트 길이만
		connect();

		int temp_no = 0;

		try {
			sql = "select count(*) from board";

			System.out.println("sql!!");
			System.out.println(sql);

			rs = stmt.executeQuery(sql);

			if (rs != null) {

				while (rs.next()) {
					temp_no = rs.getInt(1);
				}
			}
		} catch (Exception e) {
			System.out.println("1111");
			e.getStackTrace();
		}
		return temp_no;
	}

	public void reload_list() {
		// 1. 게시판 리스트
		// "select no, title, to_char(writeDate, 'yyyy-mm-dd') writeDate,
		// writer, hit from notice order by no desc";
		connect();

		list_no.clear();
		list_title.clear();
		list_writer.clear();
		list_writeDate.clear();
		list_hit.clear();

		try {
			sql = "select no, title, to_char(writeDate, 'yyyy-mm-dd') writeDate, writer, hit from board order by no desc";

			System.out.println("sql!!");
			System.out.println(sql);

			rs = stmt.executeQuery(sql);

			if (rs != null) {

				while (rs.next()) {

					list_no.add(Integer.parseInt(rs.getString("no")));
					list_title.add(rs.getString("title"));
					list_writer.add(rs.getString("writer"));
					list_writeDate.add(rs.getString("writedate"));
					list_hit.add(Integer.parseInt(rs.getString("hit")));

				}
			}
		} catch (Exception e) {
			System.out.println("1111");
			e.getStackTrace();
		}

	} // reload_list() end

	public void reload_one(int no_search) {
		// 3. 게시글 보기
		// 공지번호, 제목, 내용, 공지시작일, 공지종료일, 최종수정일
		// select no, title, content, to_char(writedate, 'yyyy-mm-dd') writedate,
		// writer, hit from board where no= no_search
		connect();

		try {
			sql = "select no, title, content, to_char(writedate, 'yyyy-mm-dd') writedate,"
					+ "writer, hit from board where no=" + no_search;

			System.out.println("sql!!");
			System.out.println(sql);

			rs = stmt.executeQuery(sql);

			if (rs != null) {

				while (rs.next()) {

					// public int board_no;
					// public String board_title;
					// public String board_content;
					// public String board_writer;
					// public String board_writeDate;
					// public int board_hit;

					board_no = no_search;
					board_title = rs.getString("title");
					board_content = rs.getString("content");
					board_writer = rs.getString("writer");
					board_writeDate = rs.getString("writedate");
					board_hit = Integer.parseInt(rs.getString("hit"));
				}
			}
		} catch (Exception e) {
			System.out.println("1111");
			e.getStackTrace();
		}

	} // reload_one(int no_search) end

	public void insert(Board_one a) {
		// 2. 공지등록
		// 제목, 내용, 공지시작일, 공지종료일
		// insert into notice (no, title, content, startdate, enddate,updatedate)
		// values( (select nvl(max(no),0)
		// from notice) + 1, '제에목' , '내애용', '2020-04-15','2020-05-21','2020-04-15');
		connect();

		sql = "insert into board (no, title, content, writer, writedate, pw)"
				+ "values( (select nvl(max(no),0)  from board) + 1,?,?,?,?,?)";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, a.getTitle());
			pstmt.setString(2, a.getContent());
			pstmt.setString(3, a.getWriter());
			pstmt.setString(4, a.getWriteDate());
			pstmt.setString(5, a.getPw());

			System.out.println(pstmt.toString());

		} catch (SQLException e1) {
			System.out.println("pstmt 하다가 오류...");
			e1.printStackTrace();
		}

		try {
			// stmt.executeUpdate(str_query);
			pstmt.executeUpdate();
			System.out.println("insert OK");

			pstmt.close();

		} catch (SQLException ex) {
			System.out.println("insert 하다가 오류  " + ex);
		}
	} // insert(Board_one a) end

	public void update(Board_one a) {
		// 4. 게시글 수정
		// 공지번호(수정불가), 제목, 내용, 공지시작일, 공지종료일
		// update notice set
		// title = ' ',
		// content = ' ',
		// where no = 0;
		connect();

		sql = " update board set " + "title = ?," + "content = ?," + "writer = ?," + "writedate = ?" + "where no = ?";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, a.getTitle());
			pstmt.setString(2, a.getContent());
			pstmt.setString(3, a.getWriter());
			pstmt.setString(4, a.getWriteDate());
			pstmt.setInt(5, a.getNo());

			System.out.println(sql);

		} catch (SQLException e1) {
			System.out.println("pstmt 하다가 오류...");
			e1.printStackTrace();
		}

		try {
			// stmt.executeUpdate(str_query);
			pstmt.executeUpdate();
			System.out.println("update OK");

			pstmt.close();

		} catch (SQLException ex) {
			System.out.println("update 하다가 오류  " + ex);
		}

	}// update(Board_one a) end

	public void delete(int del_no) {
		// & 5. 공지삭제
		// 공지번호

		connect();

		sql = "delete from board where no=" + del_no;

		System.out.println(sql);

		try {
			stmt.executeUpdate(sql);
			System.out.println("delete OK");
		} catch (SQLException e) {
			System.out.println("del ERROR");
			e.printStackTrace();
		}

	}// delete(int del_no) end

	public static void main(String[] args) {

		DBConnBoard tt = new DBConnBoard();

		Board_one nn = new Board_one();
		nn.setNo(1);

		nn.setTitle("java!!");
		nn.setContent("java java!!!!");
		nn.setWriter("kim");
		nn.setWriteDate("2020-04-28");
		nn.setPw("q1w2e3");

		System.out.println(nn.getContent());

		// tt.update(nn);

		tt.delete(3);

		System.out.println("----");

	}
}