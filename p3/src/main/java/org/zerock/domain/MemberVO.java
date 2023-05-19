package org.zerock.domain;

import lombok.Data;

@Data
public class MemberVO {
	private String member_type;
	private String m_id;
	private String pass;
	private String m_name;
//	private String birth1;
//	private String birth2;
//	private String birth3;
//	private String gender;
	private String email;
//	private String email2;
	private int level;
	private String zipcode;
	private String zipcode1;
	private String zipcode2;
	private String zipcode3;
	private String zipcode4;
	private String phone;
//	private String phone2;
//	private String phone3;
	private String signdate;
	private String delete_id;
	private int mileage;
	private int income;
}
