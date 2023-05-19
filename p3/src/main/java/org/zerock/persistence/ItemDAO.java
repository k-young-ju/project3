package org.zerock.persistence;

import java.util.List;
import java.util.Map;

import org.zerock.domain.Criteria;
import org.zerock.domain.ItemVO;

public interface ItemDAO {
	public List<ItemVO> listLimitDAO() throws Exception;
	public List<ItemVO> listAllDAO(Map<String, Object> map) throws Exception;
	public int countItemDAO(Map<String, Object> map) throws Exception;
	public ItemVO viewDAO(int uid) throws Exception;
	
}
