package org.zerock.persistence;

import java.util.List;

import org.zerock.domain.ItemVO;

public interface ItemDAO {
	public List<ItemVO> listLimitDAO() throws Exception;
	
	
}
