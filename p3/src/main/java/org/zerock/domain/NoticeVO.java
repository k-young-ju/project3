package org.zerock.domain;

import lombok.Data;

@Data
public class NoticeVO {
	private int n_uid;
	private String id;
	private String name;
	private String subject;
	private String comment;
	private String signdate;
	private String gongji;
	private String file1;
	private int fid;
	private String thread;
	private String re_date;
	private String status;
	private String deleteyn;
	private int ref;
	private String faq_type;
	private int uid;
	private String secretset;
	private String o_id; //문의 원글 작성자
}
