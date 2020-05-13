package com.webjjang.board.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardReplyDTO {

    private int rno;
    private int no;
    private String content;
    private String writer;
    private String writeDate;
    private String pw;

}