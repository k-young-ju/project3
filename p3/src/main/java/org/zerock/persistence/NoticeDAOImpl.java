package org.zerock.persistence;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.zerock.domain.NoticeVO;

import lombok.extern.log4j.Log4j;

@Repository
@Log4j
public class NoticeDAOImpl implements NoticeDAO{
	
	@Inject
	SqlSession session;
	
	private static String namespace = "org.zerock.mapper.NoticeMapper";

	
	
	@Override
	public void insertNoticeDAO(NoticeVO vo) throws Exception {
		session.insert(namespace+".insertNotice",vo);
		
	}

	@Override
	public List<NoticeVO> listAll(Map<String, Object> map) throws Exception {
		
		return session.selectList(namespace+".listAll",map);
	}

	@Override
	public NoticeVO oneItemDAO(Map<String, Object> map) throws Exception {
		
		return session.selectOne(namespace+".oneItem",map);
	}

	@Override
	public NoticeVO frontWriteDAO(Map<String, Object> map) throws Exception {
		
		return session.selectOne(namespace+".frontWrite",map);
	}

	@Override
	public NoticeVO nextWriteDAO(Map<String, Object> map) throws Exception {
	
		return session.selectOne(namespace+".nextWrite",map);
	}

	@Override
	public void refIncreaseDAO(int n_uid) throws Exception {
		session.update(namespace+".refIncrease",n_uid);
		
	}

	
	
	
}
