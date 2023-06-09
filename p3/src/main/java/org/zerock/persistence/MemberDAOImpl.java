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
	public int idCheckDAO(String id) throws Exception {
		logger.info("dao"+id);
		return session.selectOne(namespace+".idCount",id) ;
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
	public MemberVO oneMemberDAO(String id) throws Exception {
		
		return session.selectOne(namespace+".onemember",id);
	}

	@Override
	public void updateMemberDAO(MemberVO m) throws Exception {
		session.update(namespace+".modify",m);
		
	}

	@Override
	public void deleteMemberDAO(String id) throws Exception {
		session.update(namespace+".delete",id);
		
	}

	@Override
	public MemberVO findIdPhoneDAO(MemberVO m) throws Exception {
		
		return session.selectOne(namespace+".findIdPhone",m);
	}

	@Override
	public MemberVO findIdEmailDAO(MemberVO m) throws Exception {
		
		return session.selectOne(namespace+".findIdEmail",m);
	}

	@Override
	public int findIdPhoneCountDAO(MemberVO m) throws Exception {
		
		return session.selectOne(namespace+".findIdPhoneCount",m);
	}

	@Override
	public int findIdEmailCountDAO(MemberVO m) throws Exception {
		
		return session.selectOne(namespace+".findIdEmailCount",m);
	}

	@Override
	public int findPassPhoneCountDAO(MemberVO m) throws Exception {
		
		return session.selectOne(namespace+".findPassPhoneCount",m);
	}

	@Override
	public int findPassEmailCountDAO(MemberVO m) throws Exception {
		
		return session.selectOne(namespace+".findPassEmailCount",m);
	}

	@Override
	public MemberVO findPassPhoneDAO(MemberVO m) throws Exception {
		
		return session.selectOne(namespace+".findPassPhone",m);
	}

	@Override
	public MemberVO findPassEmailDAO(MemberVO m) throws Exception {
		
		return session.selectOne(namespace+".findPassEmail",m);
	}

	@Override
	public int findIdCnumberCountDAO(MemberVO m) throws Exception {
		
		return session.selectOne(namespace+".findIdCnumberCount",m);
	}

	@Override
	public MemberVO findIdCnumberDAO(MemberVO m) throws Exception {
		
		return session.selectOne(namespace+".findIdCnumber",m);
	}

	@Override
	public int findPassCnumberCountDAO(MemberVO m) throws Exception {
		
		return session.selectOne(namespace+".findPassCnumberCount",m);
	}

	@Override
	public MemberVO findPassCnumberDAO(MemberVO m) throws Exception {
		
		return session.selectOne(namespace+".findPassCnumber",m);
	}
	
	
	
	

}
