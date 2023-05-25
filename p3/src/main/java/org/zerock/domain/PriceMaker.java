package org.zerock.domain;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import lombok.Data;

@Data
public class PriceMaker {
	private int price;
	private int qty;
	private int total_price;
	
		
	public int makeQuery(int price, int qty) {
	

		return price*qty;
	}
		
}
