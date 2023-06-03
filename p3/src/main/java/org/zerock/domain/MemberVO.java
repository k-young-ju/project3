package org.zerock.domain;

import lombok.Data;

@Data
public class MemberVO {
	private String member_type;
	private String id;
	private String pass;
	private String name;
	private String email;
	private int level;
	private String zipcode;
	private String zipcode1;
	private String zipcode2;
	private String zipcode3;
	private String zipcode4;
	private String phone;
	private String signdate;
	private String delete_id;
	private int point;
	private int income;
	private String c_number;
}
