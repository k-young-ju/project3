package org.zerock.persistence;

import javax.inject.Inject;
import javax.xml.stream.events.Namespace;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.zerock.controller.MemberController;
import org.zerock.domain.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO{
	private static final Logger logger = LoggerFactory.getLogger(MemberDAO.class);
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "org.zerock.mapper.MemberMapper";

	@Override
	public int idCheckDAO(String m_id) throws Exception {
		logger.info("dao"+m_id);
		return session.selectOne(namespace+".idCount",m_id) ;
	}

	@Override
	public void joinDAO(MemberVO m) throws Exception {
		session.insert(namespace+".join",m);
		
	}
	
	

	@Override
	public int loginCountDAO(MemberVO m) throws Exception {
		
		return session.selectOne(namespace+".loginCount",m);
	}

	@Override
	public MemberVO loginDAO(MemberVO m) throws Exception {
		
		return session.selectOne(namespace+".login",m);
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
	public MemberVO findIdPhoneDAO(MemberVO m) throws Exception {
		
		return session.selectOne(namespace+".findIdPhone",m);
	}

	@Override
	public MemberVO findIdEmailDAO(MemberVO m) throws Exception {
		
		return session.selectOne(namespace+".findIdEmail",m);
	}
	
	
	
	

}
