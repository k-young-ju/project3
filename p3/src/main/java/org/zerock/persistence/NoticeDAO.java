package org.zerock.persistence;

import java.util.List;
import java.util.Map;

import org.zerock.domain.NoticeVO;

public interface NoticeDAO {
	public void insertNoticeDAO(NoticeVO vo) throws Exception;
	public List<NoticeVO> listAll(Map<String, Object> map) throws Exception;
	public NoticeVO oneItemDAO(Map<String, Object> map) throws Exception;
	public NoticeVO frontWriteDAO(Map<String, Object> map) throws Exception;
	public NoticeVO nextWriteDAO(Map<String, Object> map) throws Exception;
	public void refIncreaseDAO(int n_uid) throws Exception;
}
