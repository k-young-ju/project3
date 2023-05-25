package org.zerock.controller;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.ItemVO;
import org.zerock.domain.JjimVO;
import org.zerock.service.ItemService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/item")
public class JjimController {
	
	@Inject
	ItemService service;

	@Inject
	SqlSession sqlsession;
	
	private static String namespace = "org.zerock.mapper.JjimMapper";
	
	//찜 추가
		@GetMapping("/jjim_insert")
		public String jjimInsert(int uid, HttpSession session,RedirectAttributes rttr) throws Exception{
			String id = (String)session.getAttribute("m_id");
			
			java.util.Date today = new java.util.Date();
			SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String signdate = cal.format(today);
			
			JjimVO vo = new JjimVO();
			vo.setUid(uid);
			vo.setId(id);
			vo.setSigndate(signdate);
			int count = sqlsession.selectOne(namespace+".jjimCount",vo);
			if(count ==0) {			
			sqlsession.insert(namespace+".jjimInsert",vo);
			rttr.addFlashAttribute("msg","관심상품으로 등록되었습니다.");
			}else {
				rttr.addFlashAttribute("msg","관심상품으로 등록되어 있는 상품입니다.");
			}
			
			return "redirect:/item/view?uid="+uid;
		}
}
