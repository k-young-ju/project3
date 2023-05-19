package org.zerock.service;

import java.util.List;

import org.zerock.domain.CartVO;

public interface CartService {
	public int countColorService(CartVO vo) throws Exception;
	public void insertCartService(CartVO vo) throws Exception;
	public List<CartVO> listAllCartService(int uid) throws Exception;
	public void deleteCartService(int ct_uid) throws Exception;
}
