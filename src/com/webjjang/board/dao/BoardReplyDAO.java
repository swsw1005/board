package com.webjjang.board.dao;

import java.sql.*;
import java.util.*;
import com.webjjang.board.dto.BoardReplyDTO;
import com.webjjang.util.db.DBInfo;

public class BoardReplyDAO {

    // DB
    Connection con = null;
    // Statement stmt = null;
    PreparedStatement pstmt = null;
    Statement stmt = null;
    ResultSet rs = null;

    // ............................................................

    public List<BoardReplyDTO> getReplyList(int no) throws Exception {
        // 출력객체
        List<BoardReplyDTO> vec = new ArrayList<>();

        try {
            // 1+2
            con = DBInfo.getConnection();
            // 3. sql
            String sql = "select rno, no, writer, to_char(writedate, 'yyyy.mm.dd') writedate,"
                    + " content from board_rep  where no = ?  order by rno desc ";
            // 4. 실행객체
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, no);
            // 5. 실행
            rs = pstmt.executeQuery();
            // 6. 표시 > list에 담기
            if (rs != null) {
                while (rs.next()) {
                    BoardReplyDTO dto = new BoardReplyDTO();
                    dto.setNo(rs.getInt("no"));
                    dto.setRno(rs.getInt("rno"));
                    dto.setWriter(rs.getString("writer"));
                    dto.setWriteDate(rs.getString("writedate"));
                    dto.setContent(rs.getString("content"));
                    vec.add(dto);
                }
            }
        } catch (Exception e) {
            e.getStackTrace();
            throw new Exception("댓글 불러오던중 오류");
        } finally {
            DBInfo.close(con, pstmt, rs);
        }
        return vec;
    }

    // ............................................................
    public int insert(BoardReplyDTO dto) throws Exception {
        // 출력객체
        int temp = 0;
        try {
            // 1+2
            con = DBInfo.getConnection();
            // 3. sql
            String sql = "insert into board_rep(rno, no, content, writer, pw) "
                    + " values(  (select nvl(max(rno), 0) + 1 from board_rep)   , ?, ?, ?, ?)";
            // 4. 실행객체, 데이터 셋팅
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, dto.getNo());
            pstmt.setString(2, dto.getContent());
            pstmt.setString(3, dto.getWriter());
            pstmt.setString(4, dto.getPw());
            // 5. 실행
            rs = pstmt.executeQuery();
            // 6. 표시 > list에 담기
            if (rs != null) {
                System.out.println(rs);
            }
        } catch (Exception e) {
            e.getStackTrace();
            throw new Exception("댓글 입력중 오류");
        } finally {
            DBInfo.close(con, pstmt, rs);
        }
        return temp;
    } // insert() end

    // ............................................................

}