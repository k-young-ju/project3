package org.zerock.persistence;

import java.util.List;

import org.zerock.domain.Criteria;
import org.zerock.domain.MemberVO;

public interface AdminMemberDAO {
	
	public void joinDAO(MemberVO m) throws Exception;
	public MemberVO oneMemberDAO(String m_id) throws Exception;
	public void updateMemberDAO(MemberVO m) throws Exception;
	public void deleteMemberDAO(String m_id) throws Exception;
	public int countMemberDAO(Criteria cri) throws Exception;
	public List<MemberVO> listAllMember(Criteria cri) throws Exception;

}
