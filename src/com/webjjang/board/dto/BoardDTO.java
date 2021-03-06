package com.webjjang.board.dto;

import lombok.*;

@Setter
@Getter
public class BoardDTO {

    private int no;
    private String title;
    private String content;
    private String writer;
    private String writeDate;
    private int hit;
    private int reply_cnt;
    private String pw;
}