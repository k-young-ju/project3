package org.zerock.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.zerock.domain.NoticeVO;
import org.zerock.persistence.NoticeDAO;

@Service
public class NoticeServiceImpl implements NoticeService{

	@Inject
	NoticeDAO dao;

	
	
	@Override
	public void insertNoticeService(NoticeVO vo) throws Exception {
		dao.insertNoticeDAO(vo);
		
	}

	@Override
	public List<NoticeVO> listAll(Map<String, Object> map) throws Exception {
		
		return dao.listAll(map);
	}

	@Override
	public NoticeVO oneItemService(Map<String, Object> map) throws Exception {
		
		return dao.oneItemDAO(map);
	}

	@Override
	public NoticeVO frontWriteService(Map<String, Object> map) throws Exception {
		
		return dao.frontWriteDAO(map);
	}

	@Override
	public NoticeVO nextWriteService(Map<String, Object> map) throws Exception {
	
		return dao.nextWriteDAO(map);
	}

	@Override
	public void refIncreaseService(int n_uid) throws Exception {
		dao.refIncreaseDAO(n_uid);
		
	}


	
	
}
