package org.zerock.persistence;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.zerock.domain.ItemVO;
import org.zerock.domain.NoticeVO;
import org.zerock.domain.SearchCriteria;
import org.zerock.domain.SelectVO;

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

	
	
	@Override
	public int countSearchDAO(SearchCriteria cri) throws Exception {
		
		return session.selectOne(namespace+".countSearch",cri);
	}

	@Override
	public List<ItemVO> searchListDAO(SearchCriteria cri) throws Exception {
		
		return session.selectList(namespace+".searchList",cri);
	}

	@Override
	public List<NoticeVO> viewItemNoticeDAO(Map<String, Object> map) throws Exception {
		
		return session.selectList(namespace+".viewItemNotice",map);
	}

	@Override
	public List<NoticeVO> viewItemReviewDAO(Map<String, Object> map) throws Exception {
		
		return session.selectList(namespace+".viewItemReview",map);
	}

	@Override
	public int countColorDAO(SelectVO vo) throws Exception {
		
		return session.selectOne(namespace+".countColor",vo);
	}

	@Override
	public void insertSelectDAO(SelectVO vo) throws Exception {
		session.insert(namespace+".insertSelect",vo);
		
	}

	@Override
	public List<SelectVO> listAllSelectDAO(Map<String, Object> map) throws Exception {
		
		return session.selectList(namespace+".selectAll",map);
	}

	@Override
	public void deleteSelectDAO(int s_uid) throws Exception {
		session.delete(namespace+".deleteSelect",s_uid);
		
	}

	
	
	
	

}
