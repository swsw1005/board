package com.webjjang.board.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.webjjang.board.dto.BoardDTO;
import com.webjjang.util.db.DBInfo;

public class BoardDAO {

	// DB
	Connection con = null;
	// Statement stmt = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	// 출력 데이터
	List<BoardDTO> list = null;

	// ### 메소드

	void connect() {
		try {
			// 1. 드라이버 확인
			Class.forName(DBInfo.DRIVER);
			// 2. 연결conn
			con = DriverManager.getConnection(DBInfo.URL, DBInfo.UID, DBInfo.UPW);
		} catch (Exception e3) {
			System.out.println("connect() fail");
			e3.getStackTrace();
		} // try-catch end

	} // connect() end

	/// select 리스트
	public List<BoardDTO> list() {

		System.out.println("BoardDTO.List()");

		try {
			// 1+2
			connect();
			// 3. 실행쿼리 문자열
			String sql = "select no, title, writer, to_char(writedate, 'yyyy.mm.dd') writedate,"
					+ " hit from board order by no desc";
			// 4. 실행객체 데이터세팅
			pstmt = con.prepareStatement(sql);
			// 5. 실행 execute
			rs = pstmt.executeQuery();
			// 6. 결과표시(ResultSet) + list.add
			if (rs != null) {
				while (rs.next()) {
					if (list == null) {
						list = new ArrayList<>();
					}
					BoardDTO dto = new BoardDTO();
					dto.setNo(rs.getInt("no"));
					dto.setTitle(rs.getString("title"));
					dto.setWriter(rs.getString("writer"));
					dto.setWriteDate(rs.getString("writedate"));
					dto.setHit(rs.getInt("hit"));

					list.add(dto);
				} // while end
			} // if end
		} catch (Exception ex) {
			ex.getStackTrace();

		} finally {

			try {
				// 7. 닫기
				if (con != null) {
					con.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (rs != null) {
					rs.close();
				}

			} catch (Exception ex2) {
				ex2.getStackTrace();
			}

		} // finally end

		return list;
	} // list() end

	///
	public int increase(int no) {
		System.out.println("BoardDAO.increase()");
		// 출력 데이터 선언
		int result = 0;

		// dto에 데이터 넣기 처리
		try { // 정상처리
			connect();
			// 3. 실행 쿼리 - 문자열
			String sql = "update board set hit = hit + 1 " + " where no = ?";
			// 4. 실행객체, 데이터 셋팅
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			// 5. 실행
			// select -> executeQuery(), insert/update/delete->executeUpdate()
			result = pstmt.executeUpdate();
			// 6. 결과표시 -> 리스트에 담기
			if (result == 1) {
				System.out.println("BoardDAO.increase():조회수 1증가");
			} else {
				System.out.println("BoardDAO.increase():조회수 1증가 실패");
			}
		} catch (Exception e) {
			// 예외처리
			e.printStackTrace();
		} finally {
			try {
				// 7. 닫기
				if (con != null)
					con.close();
				if (pstmt != null)
					pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}

		}

		System.out.println("BoardDAO.increase().result:" + result);

		return result;
	}// increase() end

	///
	public Integer delete(int no) {
		System.out.println("BoardDAO.delete().no:" + no);
		// 출력 데이터 선언
		Integer result = 0;

		try { // 정상처리
			connect();
			// 3. 실행 쿼리 - 문자열
			String sql = "delete from board where no = ?";
			// 4. 실행객체, 데이터 셋팅
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			// 5. 실행
			// select -> executeQuery(), insert/update/delete->executeUpdate()
			result = pstmt.executeUpdate();
			// 6. 결과표시
			if (result == 1)
				System.out.println("BoardDAO.delete():글삭제 성공!");
		} catch (Exception e) {
			// 예외처리
			e.printStackTrace();
		} finally {
			try {
				// 7. 닫기
				if (con != null)
					con.close();
				if (pstmt != null)
					pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}

		}

		return result;
	}// delete end

	/// select 글보기
	public BoardDTO view(int no) {
		System.out.println("BoardDAO.view()");
		System.out.println("DTO.no : " + no);

		// 출력 개체
		BoardDTO dto = null;

		try {
			// 1+2
			connect();
			// 3. 실행쿼리 문자열
			String sql = "select no, title, content, writer, " + " to_char(writeDate, 'yyyy.mm.dd') writeDate "
					+ " , hit " + " from board " + " where no = ?";
			// 4. 실행객체 데이터세팅
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			// 5. 실행 execute
			rs = pstmt.executeQuery();
			// 6. 결과표시(ResultSet) + list.add
			if (rs != null && rs.next()) {
				dto = new BoardDTO();
				dto.setNo(rs.getInt("no"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setWriter(rs.getString("writer"));
				dto.setWriteDate(rs.getString("writeDate"));
				dto.setHit(rs.getInt("hit"));
			}
		} catch (Exception ex) {
			ex.getStackTrace();
		} finally {
			try {
				// 7. 닫기
				if (con != null) {
					con.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (rs != null) {
					rs.close();
				}

			} catch (Exception ex2) {
				ex2.getStackTrace();
			}
		} // finally end
		return dto;
	} // view() end

	/// insert
	public Integer write(BoardDTO dto) {
		// dto 넘어왓는지 확인용
		System.out.println("DTO;" + dto);
		// 출력 데이터 선언
		Integer result = 0;

		try {
			// 1+2
			connect();
			// 3. 실행 쿼리 - 문자열
			String sql = "insert into board(no, title, content, writer, pw) "
					+ " values(board_seq.nextval, ?, ?, ?, ?)";
			// 4. 실행객체, 데이터 셋팅
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getWriter());
			pstmt.setString(4, dto.getPw());
			// 5. 실행
			// select -> executeQuery(), insert/update/delete->executeUpdate()
			result = pstmt.executeUpdate();
			// 6. 결과표시
			if (result == 1) {
				System.out.println("BoardDAO.write():글쓰기 성공!");
			}
		} catch (Exception e) {
			// 예외처리
			e.printStackTrace();
		} finally {
			try {
				// 7. 닫기
				if (con != null)
					con.close();
				if (pstmt != null)
					pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}

		}

		return result;
	}

	/// update
	public Integer update(BoardDTO dto) {
		// dto 넘어왓는지 확인용
		System.out.println("update DTO;" + dto);
		// 출력 데이터 선언
		Integer result = 0;

		try {
			// 1+2
			connect();
			// 3. 실행 쿼리 - 문자열
			String sql = "update board set title=?, content=?, " + " writer=? " + " where no = ? and pw = ?";
			// 4. 실행객체, 데이터 셋팅
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getWriter());
			pstmt.setInt(4, dto.getNo());
			pstmt.setString(5, dto.getPw());
			// 5. 실행
			// select -> executeQuery(), insert/update/delete->executeUpdate()
			result = pstmt.executeUpdate();
			// 6. 결과표시
			if (result == 1)
				System.out.println("BoardDAO.update():글수정 성공!");
		} catch (Exception e) {
			// 예외처리
			e.printStackTrace();
		} finally {
			try {
				// 7. 닫기
				if (con != null)
					con.close();
				if (pstmt != null)
					pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return result;
	}

	/// delete

}