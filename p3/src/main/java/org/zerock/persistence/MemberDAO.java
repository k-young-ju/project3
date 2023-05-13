package org.zerock.persistence;

import org.zerock.domain.MemberVO;

public interface MemberDAO {
	public int idCheckDAO(String m_id) throws Exception;
	public void joinDAO(MemberVO m) throws Exception;
	public int loginCountDAO(MemberVO m) throws Exception;
	public MemberVO loginDAO(MemberVO m) throws Exception;
	public MemberVO oneMemberDAO(String m_id) throws Exception;
	public void updateMemberDAO(MemberVO m) throws Exception;
	public void deleteMemberDAO(String m_id) throws Exception;
	public MemberVO findIdPhoneDAO(MemberVO m) throws Exception;
	public MemberVO findIdEmailDAO(MemberVO m) throws Exception;
	
}
