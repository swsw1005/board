package com.connection.notice;

import java.io.*;
import java.sql.*;
import java.util.*;

public class DBConnNotice {

	// DB
	String driver, url, user, pwd;
	Connection con = null;
	Statement stmt = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	// 1. 공지사항 리스트
	public ArrayList<Integer> list_no = new ArrayList<>();
	public ArrayList<String> list_title = new ArrayList<>();
	public ArrayList<String> list_startDate = new ArrayList<>();
	public ArrayList<String> list_endDate = new ArrayList<>();
	// 2. 공지보기
	public int notice_no;
	public String notice_title;
	public String notice_content;
	public String notice_startDate;
	public String notice_endDate;
	public String notice_updateDate;

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
			sql = "select count(*) from notice";

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
		// 1. 공지사항 리스트
		// "select no, title, to_char(startdate, 'yyyy-mm-dd') startdate,
		// to_char(enddate, 'yyyy-mm-dd') enddate from notice where startDate <= sysdate
		// and sysdate <= enddate+1 order by no desc";
		connect();

		list_no.clear();
		list_title.clear();
		list_startDate.clear();
		list_endDate.clear();

		try {
			// sql = "select no, title, to_char(startdate, 'yyyy-mm-dd') startdate,
			// to_char(enddate, 'yyyy-mm-dd') enddate from notice where startDate <= sysdate
			// and sysdate <= enddate+1 order by no desc";
			sql = "select no, title, to_char(startdate, 'yyyy-mm-dd') startdate,  to_char(enddate, 'yyyy-mm-dd') enddate from notice   order by no desc";

			System.out.println("sql!!");
			System.out.println(sql);

			rs = stmt.executeQuery(sql);

			if (rs != null) {

				while (rs.next()) {

					list_no.add(Integer.parseInt(rs.getString("no")));
					list_title.add(rs.getString("title"));
					list_startDate.add(rs.getString("startdate"));
					list_endDate.add(rs.getString("enddate"));

				}
			}
		} catch (Exception e) {
			System.out.println("1111");
			e.getStackTrace();
		}

	} // reload_list() end

	public void reload_one(int no_search) {
		// 3. 공지보기
		// 공지번호, 제목, 내용, 공지시작일, 공지종료일, 최종수정일
		// select no, title, content,to_char(startdate, 'yyyy-mm-dd') startdate,
		// to_char(enddate, 'yyyy-mm-dd') enddate from notice where no= no_search
		connect();

		try {
			sql = "select no, title, content,to_char(startdate, 'yyyy-mm-dd') startdate,  to_char(enddate, 'yyyy-mm-dd') enddate,to_char(updatedate, 'yyyy-mm-dd') updatedate from notice where no="
					+ no_search;

			System.out.println("sql!!");
			System.out.println(sql);

			rs = stmt.executeQuery(sql);

			if (rs != null) {

				while (rs.next()) {

					notice_no = no_search;
					notice_title = rs.getString("title");
					notice_content = rs.getString("content");
					notice_startDate = rs.getString("startDate");
					notice_endDate = rs.getString("endDate");
					notice_updateDate = rs.getString("updatedate");
				}
			}
		} catch (Exception e) {
			System.out.println("1111");
			e.getStackTrace();
		}

	} // reload_one(int no_search) end

	public void insert(Notice_one a) {
		// 2. 공지등록
		// 제목, 내용, 공지시작일, 공지종료일
		// insert into notice (no, title, content, startdate, enddate,updatedate)
		// values( (select nvl(max(no),0)
		// from notice) + 1, '제에목' , '내애용', '2020-04-15','2020-05-21','2020-04-15');
		connect();

		sql = "insert into notice (no, title, content, startdate, enddate,updatedate)"
				+ "values( (select nvl(max(no),0)  from notice) + 1,?,?,?,?,?)";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, a.getTitle());
			pstmt.setString(2, a.getContent());
			pstmt.setString(3, a.getStartdate());
			pstmt.setString(4, a.getEnddate());
			pstmt.setString(5, a.getUpdatedate());

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
	} // insert(Notice_one a) end

	public void update(Notice_one a) {
		// 4. 공지수정
		// 공지번호(수정불가), 제목, 내용, 공지시작일, 공지종료일
		// update notice set
		// title = ' ',
		// content = ' ',
		// startdate='0000-00-00',
		// enddate='0000-00-00',
		// where no = 0;
		connect();

		sql = " update notice set " + "title = ?," + "content = ?," + "startdate = ?," + "enddate = ?,"
				+ "updatedate = ?" + "where no = ?";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, a.getTitle());
			pstmt.setString(2, a.getContent());
			pstmt.setString(3, a.getStartdate());
			pstmt.setString(4, a.getEnddate());
			pstmt.setString(5, a.getUpdatedate());
			pstmt.setInt(6, a.getNo());

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

	}// update(Notice_one a) end

	public void delete(int del_no) {
		// & 5. 공지삭제
		// 공지번호

		connect();

		sql = "delete from notice where no=" + del_no;

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
		// DBConnNotice tt = new DBConnNotice();

		// tt.reload_one(10);

		// SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		// String a1 = sdf.format(Calendar.getInstance().getTime());

		// System.out.println(a1);

		// Notice_one no = new Notice_one();
		// no.setTitle("제에에목");
		// no.setContent("내애애용");
		// no.setStartdate("2020-04-21");
		// no.setEnddate("2020-05-25");
		// no.setUpdatedate(a1);
		// no.setNo(7);

		// tt.update(no);

		// tt.list_length();

		// System.out.println(tt.list_length());

		// tt.reload_list();

		// System.out.println(tt.list_length());

		// System.out.println(tt.list_no.get(4));
		// System.out.println();

		// for (int i = 0; i < tt.list_length(); i++) {
		// System.out.print(tt.list_no.get(i) + " ");
		// }
		// tt.reload_list();
		// System.out.println(tt.list_title.get(10));

	}
}