package com.webjjang.board.rep;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReplyDTO {

    private int no;
    private int rno;
    private String content;
    private String writer;
    private String writedate;
    private String pw;

}