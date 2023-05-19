package org.zerock.domain;

import lombok.Data;

@Data
public class CartVO {
	int ct_uid;
	String o_id;
	String m_id;
	String s_id;
	int uid;
	int price;
	int qty;
	int point;
	String signdate;
	String file1;
	String color;
}
