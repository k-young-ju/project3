package org.zerock.service;

import java.util.List;

import org.zerock.domain.Criteria;
import org.zerock.domain.MemberVO;

public interface AdminMemberService {
	
	public void joinService(MemberVO m) throws Exception;
	public MemberVO oneMemberService(String m_id) throws Exception;
	public void updateMemberService(MemberVO m) throws Exception;
	public void deleteMemberService(String m_id) throws Exception;
	public int countMemberService(Criteria cri) throws Exception;
	public List<MemberVO> listAllMember(Criteria cri) throws Exception;
}
