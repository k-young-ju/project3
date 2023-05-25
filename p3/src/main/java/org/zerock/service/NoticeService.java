package org.zerock.service;

import java.util.List;
import java.util.Map;

import org.zerock.domain.Criteria;
import org.zerock.domain.NoticeVO;

public interface NoticeService {
	public void insertNoticeService(NoticeVO vo) throws Exception;
	public List<NoticeVO> listAll(Map<String, Object> map) throws Exception;
	public NoticeVO oneItemService(Map<String, Object> map) throws Exception; 
	public NoticeVO frontWriteService(Map<String, Object> map) throws Exception;
	public NoticeVO nextWriteService(Map<String, Object> map) throws Exception;
	public void refIncreaseService(int n_uid) throws Exception;
	
}
