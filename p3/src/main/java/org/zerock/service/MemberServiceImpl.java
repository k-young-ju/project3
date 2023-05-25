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
	public int idCheckService(String id) throws Exception {
		logger.info("service"+id);
		return dao.idCheckDAO(id);
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
	public MemberVO oneMemberService(String id) throws Exception {
		
		return dao.oneMemberDAO(id);
	}

	@Override
	public void updateMemberService(MemberVO m) throws Exception {
		
		dao.updateMemberDAO(m);
		
		
	}

	@Override
	public void deleteMemberService(String id) throws Exception {
		dao.deleteMemberDAO(id);
		
	}

	@Override
	public MemberVO findIdPhoneService(MemberVO m) throws Exception {
		
		return dao.findIdPhoneDAO(m);
	}

	@Override
	public MemberVO findIdEmailService(MemberVO m) throws Exception {
		
		return dao.findIdEmailDAO(m);
	}

	@Override
	public int findIdPhoneCountService(MemberVO m) throws Exception {
		
		return dao.findIdPhoneCountDAO(m);
	}

	@Override
	public int findIdEmailCountService(MemberVO m) throws Exception {
		
		return dao.findIdEmailCountDAO(m);
	}

	@Override
	public int findPassPhoneCountService(MemberVO m) throws Exception {
		
		return dao.findPassPhoneCountDAO(m);
	}

	@Override
	public int findPassEmailCountService(MemberVO m) throws Exception {
		
		return dao.findPassEmailCountDAO(m);
	}

	@Override
	public MemberVO findPassPhoneService(MemberVO m) throws Exception {
		
		return dao.findPassPhoneDAO(m);
	}

	@Override
	public MemberVO findPassEmailService(MemberVO m) throws Exception {
		
		return dao.findPassEmailDAO(m);
	}

	@Override
	public int findIdCnumberCountService(MemberVO m) throws Exception {
		
		return dao.findIdCnumberCountDAO(m);
	}

	@Override
	public MemberVO findIdCnumberServic(MemberVO m) throws Exception {
		
		return dao.findIdCnumberDAO(m);
	}

	@Override
	public int findPassCnumberCountService(MemberVO m) throws Exception {
		
		return dao.findPassCnumberCountDAO(m);
	}

	@Override
	public MemberVO findPassCnumberService(MemberVO m) throws Exception {
		
		return dao.findPassCnumberDAO(m);
	}
	
	
	
	

}
