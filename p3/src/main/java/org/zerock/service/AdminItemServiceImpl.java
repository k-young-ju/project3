package org.zerock.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.zerock.domain.Criteria;
import org.zerock.domain.ItemVO;
import org.zerock.domain.MemberVO;
import org.zerock.persistence.AdminItemDAO;

@Service
public class AdminItemServiceImpl implements AdminItemService{
		
	@Inject
	AdminItemDAO dao;

	@Override
	public void adminRegisterItemService(ItemVO vo) throws Exception {
		dao.adminRegisterItemDAO(vo);
		
	}

	@Override
	public List<MemberVO> listAllItemService(Criteria cri) throws Exception {
		
		return dao.listAllItemDAO(cri);
	}

	@Override
	public ItemVO adminOneItemService(int uid) throws Exception {
		
		return dao.adminOneItemDAO(uid);
	}

	@Override
	public void adminModifyItemService(ItemVO vo) throws Exception {
		dao.adminModifyItemDAO(vo);
		
	}
	
	
}
