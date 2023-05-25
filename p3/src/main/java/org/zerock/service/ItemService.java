package org.zerock.service;

import java.util.List;
import java.util.Map;

import org.zerock.domain.ItemVO;
import org.zerock.domain.NoticeVO;
import org.zerock.domain.SearchCriteria;
import org.zerock.domain.SelectVO;

public interface ItemService {
	public List<ItemVO> listLimitService() throws Exception;
	public List<ItemVO> listAllService(Map<String, Object> map) throws Exception;
	public int countItemService(Map<String, Object> map) throws Exception;
	public ItemVO viewService(int uid) throws Exception;
	public int countSearchService(SearchCriteria cri) throws Exception;
	public List<ItemVO> searchListService(SearchCriteria cri) throws Exception;
	public List<NoticeVO> viewItemNoticeService(Map<String, Object> map) throws Exception;
	public List<NoticeVO> viewItemReviewService(Map<String, Object> map) throws Exception;
	public int countColorService(SelectVO vo) throws Exception;
	public void insertSelectService(SelectVO vo) throws Exception;
	public List<SelectVO> listAllSelectService(Map<String, Object> map) throws Exception;
	public void deleteSelectService(int s_uid) throws Exception;
	
}
