package org.zerock.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.zerock.domain.ItemVO;
import org.zerock.domain.NoticeVO;
import org.zerock.domain.SearchCriteria;
import org.zerock.domain.SelectVO;
import org.zerock.persistence.ItemDAO;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ItemServiceImpl implements ItemService{
	
	@Inject
	ItemDAO dao;

	@Override
	public List<ItemVO> listLimitService() throws Exception {
		
		return dao.listLimitDAO();
	}

	@Override
	public List<ItemVO> listAllService(Map<String, Object> map) throws Exception {
		log.info("===service==="+map);
		return dao.listAllDAO(map);
	}

	@Override
	public int countItemService(Map<String, Object> map) throws Exception {
		
		return dao.countItemDAO(map);
	}

	@Override
	public ItemVO viewService(int uid) throws Exception {
		
		return dao.viewDAO(uid);
	}

	
	
	@Override
	public int countSearchService(SearchCriteria cri) throws Exception {
		
		return dao.countSearchDAO(cri);
	}

	@Override
	public List<ItemVO> searchListService(SearchCriteria cri) throws Exception {
		
		return dao.searchListDAO(cri);
	}

	@Override
	public List<NoticeVO> viewItemNoticeService(Map<String, Object> map) throws Exception {
		
		return dao.viewItemNoticeDAO(map);
	}

	@Override
	public List<NoticeVO> viewItemReviewService(Map<String, Object> map) throws Exception {
		
		return dao.viewItemReviewDAO(map);
	}

	@Override
	public int countColorService(SelectVO vo) throws Exception {
	
		return dao.countColorDAO(vo);
	}

	@Override
	public void insertSelectService(SelectVO vo) throws Exception {
	dao.insertSelectDAO(vo);
		
	}

	@Override
	public List<SelectVO> listAllSelectService(Map<String, Object> map) throws Exception {
	
		return dao.listAllSelectDAO(map);
	}

	@Override
	public void deleteSelectService(int s_uid) throws Exception {
		dao.deleteSelectDAO(s_uid);
		
	}

	

	

}
