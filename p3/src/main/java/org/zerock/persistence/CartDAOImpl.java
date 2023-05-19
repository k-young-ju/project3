package org.zerock.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.zerock.domain.CartVO;

import lombok.extern.log4j.Log4j;

@Repository
@Log4j
public class CartDAOImpl implements CartDAO{

	@Inject
	SqlSession session;
	
	private static String namespace = "org.zerock.mapper.CartMapper";

	@Override
	public void insertCartDAO(CartVO vo) throws Exception {
		
		session.insert(namespace+".insertCart",vo);
	}

	@Override
	public List<CartVO> listAllCartDAO(int uid) throws Exception {
		
		return session.selectList(namespace+".cartAll",uid);
	}

	@Override
	public int countColorDAO(CartVO vo) throws Exception {
		
		return session.selectOne(namespace+".countColor",vo);
	}

	@Override
	public void deleteCartDAO(int ct_uid) throws Exception {
		
		session.delete(namespace+".deleteCart",ct_uid);
	}
	
	
}
