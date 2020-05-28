package com.webjjang.board.rep;

import java.sql.*;
import java.util.*;

import com.webjjang.board.dto.BoardReplyDTO;
import com.webjjang.util.db.DBInfo;

public class ReplyDAO {

    // DB
    Connection con = null;
    // Statement stmt = null;
    PreparedStatement pstmt = null;
    Statement stmt = null;
    ResultSet rs = null;

    // ### 메소드
    void connect() {
        try {
            // 1. 드라이버 확인+2
            con = DBInfo.getConnection();
        } catch (Exception e3) {
            System.out.println("connect() fail");
            e3.getStackTrace();
        } // try-catch end

    } // connect() end

    // ................................................................

    /// select 리스트
    public List<ReplyDTO> getList(int no) {

        List<ReplyDTO> list = new ArrayList<>();
        System.out.println("ReplyDTO.List()");
        try {
            // 1. 드라이버 확인+2
            con = DBInfo.getConnection();
            // 3. 실행쿼리 문자열
            String sql = "select rno, no, writer, to_char(writedate, 'yyyy.mm.dd') writedate,"
                    + " content from board_rep  where no = ?  order by rno desc ";
            // 4. 실행객체 데이터세팅
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, no);
            // 5. 실행 execute
            rs = pstmt.executeQuery();
            // 6. 결과표시(ResultSet) + list.add
            if (rs != null) {
                while (rs.next()) {
                    ReplyDTO dto = new ReplyDTO();
                    dto.setNo(rs.getInt("no"));
                    dto.setRno(rs.getInt("rno"));
                    dto.setContent(rs.getString("content"));
                    dto.setWriter(rs.getString("writer"));
                    dto.setWritedate(rs.getString("writedate"));
                    // dto.setPw(rs.getString("pw"));
                    list.add(dto);
                } // while end
            } // if end
        } catch (Exception ex) {
            ex.printStackTrace();
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

    // ................................................................

    public void insert(ReplyDTO dto) {

        System.out.println("ReplyDTO.List()");

        try {
            // 1+2
            connect();
            // 3. 실행쿼리 문자열
            String sql = "select rno, no, writer, to_char(writedate, 'yyyy.mm.dd') writedate,"
                    + " content from board_rep order by no desc";
            // 4. 실행객체 데이터세팅
            pstmt = con.prepareStatement(sql);
            // 5. 실행 execute
            rs = pstmt.executeQuery();
            // 6. 결과표시(ResultSet)

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
            } catch (Exception ex2) {
                ex2.getStackTrace();
            }
        } // finally end

    }

    // ................................................................

    public int update(BoardReplyDTO dto) throws Exception {
        // 출력객체
        int result = 0;

        try {
            // 1+2
            con = DBInfo.getConnection();
            // 3. sql
            String sql = "update board_rep " + " set content = ?, writer = ? " + " where rno = ? and pw = ?";

            // 4. 실행객체
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, dto.getContent());
            pstmt.setString(2, dto.getWriter());
            pstmt.setInt(3, dto.getRno());
            pstmt.setString(4, dto.getPw());
            // 5. 실행
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.getStackTrace();
            throw new Exception("  ");
        } finally {
            DBInfo.close(con, pstmt, rs);
        }
        return result;
    } // update() end------------

    // ................................................................

    public int delete(int no) throws Exception {
        // 출력객체
        int result = 0;

        try {
            // 1+2
            con = DBInfo.getConnection();
            // 3. sql
            String sql = "delete from board_rep where no = ?";
            // 4. 실행객체
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, no);
            // 5. 실행
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.getStackTrace();
            throw new Exception("  ");
        } finally {
            DBInfo.close(con, pstmt, rs);
        }
        return result;
    } // delete() end------------

    // ................................................................

}