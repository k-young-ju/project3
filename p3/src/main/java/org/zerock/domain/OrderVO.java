package org.zerock.domain;

import lombok.Data;

@Data
public class OrderVO {
	private String od_number;
	private int uid;
	private String id;
	private String o_id;
	private String od_status;
	private String od_date;
	private int point;
	private int total_qty;
	private int total_price;
	private String zipcode;
	private String zipcode1;
	private String zipcode2;
	private String zipcode3;
	private String zipcode4;
	private String name;
	private String phone;
	private String email;
	private String message;
	private Integer usepoint;
	private String subject;
}
