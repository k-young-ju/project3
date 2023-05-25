package org.zerock.domain;

import lombok.Data;

@Data
public class ReviewVO {
	private int r_uid;
	private int uid;
	private String subject;
	private String comment;
	private int score;
	private String signdate;
	private String id;
	private String name;
	private String file1;
	private String itemimg;
	private String itemname;
	
}
