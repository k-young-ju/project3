package org.zerock.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.zerock.domain.Criteria;
import org.zerock.domain.MemberVO;
import org.zerock.persistence.AdminMemberDAO;
import org.zerock.persistence.MemberDAO;

@Service
public class AdminMemberServiceImpl  implements AdminMemberService{

	@Inject
	private AdminMemberDAO dao;

	
	@Override
	public void joinService(MemberVO m) throws Exception {
		dao.joinDAO(m);
		
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
	public int countMemberService(Criteria cri) throws Exception {
		
		return dao.countMemberDAO(cri);
	}

	@Override
	public List<MemberVO> listAllMember(Criteria cri) throws Exception {
		
		return dao.listAllMember(cri);
	}
	
	
}
