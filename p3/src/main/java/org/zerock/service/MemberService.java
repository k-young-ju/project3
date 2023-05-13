package org.zerock.service;

import org.zerock.domain.MemberVO;

public interface MemberService {
	public int idCheckService(String m_id) throws Exception;
	public void joinService(MemberVO m) throws Exception;
	public int loginCountService(MemberVO m) throws Exception;
	public MemberVO loginService(MemberVO m) throws Exception;
	public MemberVO oneMemberService(String m_id) throws Exception;
	public void updateMemberService(MemberVO m) throws Exception;
	public void deleteMemberService(String m_id) throws Exception;
	public MemberVO findIdPhoneService(MemberVO m) throws Exception;
	public MemberVO findIdEmailService(MemberVO m) throws Exception;
}
