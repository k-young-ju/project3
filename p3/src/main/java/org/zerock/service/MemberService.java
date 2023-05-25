package org.zerock.service;

import org.zerock.domain.MemberVO;

public interface MemberService {
	public int idCheckService(String id) throws Exception;
	public void joinService(MemberVO m) throws Exception;
	public int loginCountService(MemberVO m) throws Exception;
	public MemberVO loginService(MemberVO m) throws Exception;
	public MemberVO oneMemberService(String id) throws Exception;
	public void updateMemberService(MemberVO m) throws Exception;
	public void deleteMemberService(String id) throws Exception;
	public MemberVO findIdPhoneService(MemberVO m) throws Exception;
	public MemberVO findIdEmailService(MemberVO m) throws Exception;
	public int findIdPhoneCountService(MemberVO m) throws Exception;
	public int findIdEmailCountService(MemberVO m) throws Exception;
	public int findPassPhoneCountService(MemberVO m) throws Exception;
	public int findPassEmailCountService(MemberVO m) throws Exception;
	public MemberVO findPassPhoneService(MemberVO m) throws Exception;
	public MemberVO findPassEmailService(MemberVO m) throws Exception;
	public  int findIdCnumberCountService(MemberVO m) throws Exception;
	public MemberVO findIdCnumberServic(MemberVO m) throws Exception;
	public  int findPassCnumberCountService(MemberVO m) throws Exception;
	public MemberVO findPassCnumberService(MemberVO m) throws Exception;
}
