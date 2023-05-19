package org.zerock.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.zerock.domain.Criteria;
import org.zerock.domain.ItemVO;
import org.zerock.domain.MemberVO;

@Repository
public class AdminItemDAOImpl implements AdminItemDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "org.zerock.mapper.AdminItemMapper";

	@Override
	public void adminRegisterItemDAO(ItemVO vo) throws Exception {
		session.insert(namespace+".register",vo);
		
	}

	@Override
	public List<MemberVO> listAllItemDAO(Criteria cri) throws Exception {
		
		return session.selectList(namespace+".listAll",cri);
	}

	@Override
	public ItemVO adminOneItemDAO(int uid) throws Exception {
		
		return session.selectOne(namespace+".oneItem",uid);
	}

	@Override
	public void adminModifyItemDAO(ItemVO vo) throws Exception {
		session.update(namespace+".modify",vo);
		
	}
	

	
}
