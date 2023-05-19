package org.zerock.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.zerock.domain.Criteria;
import org.zerock.domain.ItemVO;
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

	

}
