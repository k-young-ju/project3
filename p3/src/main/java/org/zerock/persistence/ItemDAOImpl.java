package org.zerock.persistence;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.zerock.domain.Criteria;
import org.zerock.domain.ItemVO;

import lombok.extern.log4j.Log4j;

@Repository
@Log4j
public class ItemDAOImpl implements ItemDAO{
	
	@Inject
	SqlSession session;
	
	private static String namespace = "org.zerock.mapper.ItemMapper";

	@Override
	public List<ItemVO> listLimitDAO() throws Exception {
		
		return session.selectList(namespace+".listLimit");
	}

	@Override
	public List<ItemVO> listAllDAO(Map<String, Object> map) throws Exception {
		log.info("===DAO==="+map);
			
		return session.selectList(namespace+".listAll",map);
	}

	@Override
	public int countItemDAO(Map<String, Object> map) throws Exception {
		
		return session.selectOne(namespace+".countItem",map);
	}

	@Override
	public ItemVO viewDAO(int uid) throws Exception {
		
		return session.selectOne(namespace+".view",uid);
	}
	
	
	

}
