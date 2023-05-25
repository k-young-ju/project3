package org.zerock.persistence;

import java.util.List;
import java.util.Map;

import org.zerock.domain.ItemVO;
import org.zerock.domain.NoticeVO;
import org.zerock.domain.SearchCriteria;
import org.zerock.domain.SelectVO;

public interface ItemDAO {
	public List<ItemVO> listLimitDAO() throws Exception;
	public List<ItemVO> listAllDAO(Map<String, Object> map) throws Exception;
	public int countItemDAO(Map<String, Object> map) throws Exception;
	public ItemVO viewDAO(int uid) throws Exception;
	public int countSearchDAO(SearchCriteria cri) throws Exception;
	public List<ItemVO> searchListDAO(SearchCriteria cri) throws Exception;
	public List<NoticeVO> viewItemNoticeDAO(Map<String, Object> map) throws Exception;
	public List<NoticeVO> viewItemReviewDAO(Map<String, Object> map) throws Exception;
	public int countColorDAO(SelectVO vo) throws Exception;
	public void insertSelectDAO(SelectVO vo) throws Exception;
	public List<SelectVO> listAllSelectDAO(Map<String, Object> map) throws Exception;
	public void deleteSelectDAO(int s_uid) throws Exception;
	
}
