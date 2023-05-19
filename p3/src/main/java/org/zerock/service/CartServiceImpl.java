package org.zerock.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.zerock.domain.CartVO;
import org.zerock.persistence.CartDAO;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class CartServiceImpl implements CartService{

	@Inject
	CartDAO dao;

	
	
	@Override
	public int countColorService(CartVO vo) throws Exception {

		return dao.countColorDAO(vo);
	}

	@Override
	public void insertCartService(CartVO vo) throws Exception {
		dao.insertCartDAO(vo);
		
	}

	@Override
	public List<CartVO> listAllCartService(int uid) throws Exception {
		
		return dao.listAllCartDAO(uid);
	}

	@Override
	public void deleteCartService(int ct_uid) throws Exception {
		
		dao.deleteCartDAO(ct_uid);
	}
	
	

}
