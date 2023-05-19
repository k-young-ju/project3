package org.zerock.service;

import java.util.List;
import java.util.Map;

import org.zerock.domain.Criteria;
import org.zerock.domain.ItemVO;

public interface ItemService {
	public List<ItemVO> listLimitService() throws Exception;
	public List<ItemVO> listAllService(Map<String, Object> map) throws Exception;
	public int countItemService(Map<String, Object> map) throws Exception;
	public ItemVO viewService(int uid) throws Exception;
}
