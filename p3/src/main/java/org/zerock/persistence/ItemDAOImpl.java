package org.zerock.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.zerock.domain.ItemVO;

@Repository
public class ItemDAOImpl implements ItemDAO{
	
	@Inject
	SqlSession session;
	
	private static String namespace = "org.zerock.mapper.ItemMapper";

	@Override
	public List<ItemVO> listLimitDAO() throws Exception {
		
		return session.selectList(namespace+".listLimit");
	}

}
