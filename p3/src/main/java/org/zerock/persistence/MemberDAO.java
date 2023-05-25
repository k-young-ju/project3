package org.zerock.persistence;

import org.zerock.domain.MemberVO;

public interface MemberDAO {
	public int idCheckDAO(String id) throws Exception;
	public void joinDAO(MemberVO m) throws Exception;
	public int loginCountDAO(MemberVO m) throws Exception;
	public MemberVO loginDAO(MemberVO m) throws Exception;
	public MemberVO oneMemberDAO(String id) throws Exception;
	public void updateMemberDAO(MemberVO m) throws Exception;
	public void deleteMemberDAO(String id) throws Exception;
	public int findIdPhoneCountDAO(MemberVO m) throws Exception;
	public int findIdEmailCountDAO(MemberVO m) throws Exception;
	public MemberVO findIdPhoneDAO(MemberVO m) throws Exception;
	public MemberVO findIdEmailDAO(MemberVO m) throws Exception;
	public int findPassPhoneCountDAO(MemberVO m) throws Exception;
	public int findPassEmailCountDAO(MemberVO m) throws Exception;
	public MemberVO findPassPhoneDAO(MemberVO m) throws Exception;
	public MemberVO findPassEmailDAO(MemberVO m) throws Exception;
	public  int findIdCnumberCountDAO(MemberVO m) throws Exception;
	public MemberVO findIdCnumberDAO(MemberVO m) throws Exception;
	public  int findPassCnumberCountDAO(MemberVO m) throws Exception;
	public MemberVO findPassCnumberDAO(MemberVO m) throws Exception;
	
}
