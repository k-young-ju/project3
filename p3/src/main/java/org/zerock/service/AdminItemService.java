package org.zerock.service;

import java.util.List;

import org.zerock.domain.Criteria;
import org.zerock.domain.ItemVO;
import org.zerock.domain.MemberVO;

public interface AdminItemService {
	public List<MemberVO> listAllItemService(Criteria cri) throws Exception;
	public void adminRegisterItemService(ItemVO vo) throws Exception;
	public ItemVO adminOneItemService(int uid) throws Exception;
	public void adminModifyItemService(ItemVO vo) throws Exception;

}
