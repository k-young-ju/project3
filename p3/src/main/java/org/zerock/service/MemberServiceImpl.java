package org.zerock.service;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.zerock.domain.MemberVO;
import org.zerock.persistence.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService{
	private static final Logger logger = LoggerFactory.getLogger(MemberService.class);

	@Inject
	private MemberDAO dao;
	
	@Override
	public int idCheckService(String m_id) throws Exception {
		logger.info("service"+m_id);
		return dao.idCheckDAO(m_id);
	}

	@Override
	public void joinService(MemberVO m) throws Exception {
		
		dao.joinDAO(m);
	}
	
	

	@Override
	public int loginCountService(MemberVO m) throws Exception {
	
		return dao.loginCountDAO(m);
	}

	@Override
	public MemberVO loginService(MemberVO m) throws Exception {
		
		return dao.loginDAO(m);
	}

	@Override
	public MemberVO oneMemberService(String m_id) throws Exception {
		
		return dao.oneMemberDAO(m_id);
	}

	@Override
	public void updateMemberService(MemberVO m) throws Exception {
		
		dao.updateMemberDAO(m);
		
		
	}

	@Override
	public void deleteMemberService(String m_id) throws Exception {
		dao.deleteMemberDAO(m_id);
		
	}

	@Override
	public MemberVO findIdPhoneService(MemberVO m) throws Exception {
		
		return dao.findIdPhoneDAO(m);
	}

	@Override
	public MemberVO findIdEmailService(MemberVO m) throws Exception {
		
		return dao.findIdEmailDAO(m);
	}
	
	
	
	

}
