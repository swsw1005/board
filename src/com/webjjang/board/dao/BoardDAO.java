package com.webjjang.board.dao;

import java.sql.*;
import java.util.*;
import com.webjjang.board.dto.BoardDTO;
import com.webjjang.util.db.DBInfo;
import net.webjjang.util.PageObject;

public class BoardDAO {

	// DB
	Connection con = null;
	// Statement stmt = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	// ### 메소드
	// ............................................................
	void connect() {
		try {
			// 1. 드라이버 확인+2
			con = DBInfo.getConnection();
		} catch (Exception e3) {
			System.out.println("connect() fail");
			e3.getStackTrace();
		} // try-catch end

	} // connect() end

	// ............................................................

	/// select 리스트
	public List<BoardDTO> list(PageObject pageObject) {

		System.out.println("BoardDTO.List()");
		List<BoardDTO> list = new ArrayList<>();

		try {
			// 1+2
			connect();
			// 3-1. 정렬된 데이터 가져오기
			String sql = "select no, title, writer, " + " to_char(writeDate, 'yyyy.mm.dd') writeDate " + " , hit "
					+ " from board " + " order by no desc";
			// 3-2. 정렬된 데이터에서 순서번호 붙이기
			sql = "select rownum rnum, no, title, writer, " + " writeDate, hit from (" + sql + ")";
			// 3-3. 원하는 부분에 해당되는 데이터 가져오기
			sql = "select no, title, writer, writeDate , hit " + " from (" + sql + ") "
					+ " where rnum between ? and ? ";
			// 4. 실행객체 데이터세팅
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, pageObject.getStartRow());
			pstmt.setInt(2, pageObject.getEndRow());
			// 5. 실행 execute
			rs = pstmt.executeQuery();
			// 6. 결과표시(ResultSet) + list.add
			if (rs != null) {
				while (rs.next()) {
					BoardDTO dto = new BoardDTO();
					dto.setNo(rs.getInt("no"));
					dto.setTitle(rs.getString("title"));
					dto.setWriter(rs.getString("writer"));
					dto.setWriteDate(rs.getString("writeDate"));
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
	} // list() ............................................................

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

	// ............................................................

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

	// ............................................................

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

	// ............................................................

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

	// ............................................................

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

	// ............................................................

	public int getTotalRow() {
		System.out.println("BoardDAO.getTotalRow()");
		// 출력 데이터 선언
		int total = 0;

		// dto에 데이터 넣기 처리
		try { // 정상처리
				// 1. 드라이버 확인
				// 2. 연결
			connect();
			// 3. 실행 쿼리 - 문자열
			String sql = "select count(*) from board";
			// 4. 실행객체, 데이터 셋팅
			pstmt = con.prepareStatement(sql);
			// 5. 실행
			// select -> executeQuery(), insert/update/delete->executeUpdate()
			rs = pstmt.executeQuery();
			// 6. 결과표시 -> 리스트에 담기
			if (rs != null && rs.next()) {
				total = rs.getInt(1);
			}
		} catch (Exception e) {
			// 예외처리
			e.printStackTrace();
		} finally {
			try {
				DBInfo.close(con, pstmt, rs);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		System.out.println("BoardDAO.getTotalRow().total : " + total);
		return total;
	}

	// ............................................................

	public void resetPW() {
		// sub 수정 위한 void method (ex) 조회수 증가
		try {
			// 1+2
			connect();
			// 3. sql
			String sql = "update board set pw = '123' ";
			// 4. 실행객체
			pstmt = con.prepareStatement(sql);
			// 5. 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.getStackTrace();
		} finally {
			try {
				DBInfo.close(con, pstmt, rs);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	} // resetPW() end------------

	// boardCopy_start-----------------------------------------------------------------------------
	public void boardCopy(int k) {
		System.out.println("---BoardDAO boardCopy");
		for (int i = 1; i < k; i++) {
			try {
				// 1+2
				connect();
				// 3-1. 정렬된 데이터 가져오기
				String sql = "select title, content, writer from board " + " order by no asc";
				// 3-2. 정렬된 데이터에서 순서번호 붙이기
				sql = "select rownum rnum, title, content, writer from (" + sql + ")";
				// 3-3. 원하는 부분에 해당되는 데이터 가져오기
				sql = "select title, content, writer from (" + sql + ") " + " where rnum = ? ";

				System.out.println(sql);

				// select title, content, writer from
				// ( select rownum rnum, title, content, writer from
				// ( select title, content, writer from board order by no desc ) )
				// where rnum = 1 ;

				// 4. 실행객체
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, i);
				// 5. 실행
				rs = pstmt.executeQuery();
				String title = "";
				String content = "";
				String writer = "";

				if (rs.next()) {
					title = rs.getString("title");
					content = rs.getString("content");
					writer = rs.getString("writer");

					title = (title + "       ").substring(0, 8) + i;
					content = (content + "       ").substring(0, 8) + i;
					writer = (writer + "       ").substring(0, 8) + i;
				}

				System.out.println(title + "  " + content + "  " + writer);

				// 3. sql
				sql = "insert into board(no, title, content, writer, writeDate, pw, hit) "
						+ " values(board_seq.nextval, ?, ?, ?, sysdate , '123' , 0)";
				// 4. 실행객체
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, title);
				pstmt.setString(2, content);
				pstmt.setString(3, writer);
				// 5. 실행
				pstmt.executeUpdate();

				System.out.println(i + "번째 복사");

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					DBInfo.close(con, pstmt, rs);
				} catch (Exception e) {
					e.printStackTrace();
				}
			} // finally end
		} // for end

	} // boardCopy_end-----------------------------------------------------------------------------

	public static void main(String[] args) {
		BoardDAO dao = new BoardDAO();

		dao.boardCopy(236);

		System.out.println(dao.getTotalRow());
	}

}