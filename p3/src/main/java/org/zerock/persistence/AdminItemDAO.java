package org.zerock.persistence;

import java.util.List;

import org.zerock.domain.Criteria;
import org.zerock.domain.ItemVO;
import org.zerock.domain.MemberVO;

public interface AdminItemDAO {
	public List<MemberVO> listAllItemDAO(Criteria cri) throws Exception;
	public void adminRegisterItemDAO(ItemVO vo) throws Exception;
	public ItemVO adminOneItemDAO(int uid) throws Exception;
	public void adminModifyItemDAO(ItemVO vo) throws Exception;
}
