package org.zerock.persistence;

import java.util.List;

import org.zerock.domain.CartVO;

public interface CartDAO {
	public int countColorDAO(CartVO vo) throws Exception;
	public void insertCartDAO(CartVO vo) throws Exception;
	public List<CartVO> listAllCartDAO(int uid) throws Exception;
	public void deleteCartDAO(int ct_uid) throws Exception;
}
