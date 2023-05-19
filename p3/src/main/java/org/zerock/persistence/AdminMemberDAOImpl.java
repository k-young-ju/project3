package org.zerock.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.zerock.domain.Criteria;
import org.zerock.domain.MemberVO;


@Repository
public class AdminMemberDAOImpl implements AdminMemberDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "org.zerock.mapper.AdminMemberMapper";

	
	@Override
	public void joinDAO(MemberVO m) throws Exception {
		
		session.insert(namespace+".join",m);
	}

	@Override
	public MemberVO oneMemberDAO(String m_id) throws Exception {
		
		return session.selectOne(namespace+".onemember",m_id);
	}

	@Override
	public void updateMemberDAO(MemberVO m) throws Exception {
		session.update(namespace+".modify",m);
		
	}

	@Override
	public void deleteMemberDAO(String m_id) throws Exception {
		session.update(namespace+".delete",m_id);
		
	}

	
	
	@Override
	public int countMemberDAO(Criteria cri) throws Exception {
		
		return session.selectOne(namespace+".countMember",cri);
	}

	@Override
	public List<MemberVO> listAllMember(Criteria cri) throws Exception {
		
		return session.selectList(namespace+".listAll",cri);
	}
	
	
}
