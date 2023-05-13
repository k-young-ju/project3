package org.zerock.service;

import java.util.List;


import org.zerock.domain.ItemVO;

public interface ItemService {
	public List<ItemVO> listLimitService() throws Exception;
}
