package org.zerock.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.zerock.domain.ItemVO;
import org.zerock.persistence.ItemDAO;

@Service
public class ItemServiceImpl implements ItemService{
	
	@Inject
	ItemDAO dao;

	@Override
	public List<ItemVO> listLimitService() throws Exception {
		
		return dao.listLimitDAO();
	}

	

}
