package org.zerock.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.Criteria;
import org.zerock.domain.NoticeVO;
import org.zerock.service.ItemService;
import org.zerock.service.NoticeService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/notice")
public class NoticeController {
	
	@Inject
	NoticeService service;
	
	@Inject
	ItemService iservice;
	
	@Inject
	SqlSession sqlsession;
	
	private static String namespace = "org.zerock.mapper.AdminNoticeMapper";
	
	@GetMapping("/list")
	public void listGet(String option,String faq_type,Criteria cri, Model model) throws Exception{
		cri.setPerPageNum(10);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cri",cri);
		map.put("gongji",option);
		map.put("faq_type",faq_type);
		
		model.addAttribute("faq_type",faq_type);
		model.addAttribute("option",option);
		model.addAttribute("list",service.listAll(map));
	}
	
	@GetMapping("/write")
	public void writeGet(int uid,Model model) throws Exception{
		model.addAttribute("vo",iservice.viewService(uid));
	
	}
	@PostMapping("/write")
	public String writePost(NoticeVO vo,HttpSession session,RedirectAttributes rttr) throws Exception{
		
		String id= (String)session.getAttribute("m_id");
		String name = (String)session.getAttribute("m_name");
		
		int fid = 1;
		Integer fid_max = sqlsession.selectOne(namespace + ".fidCheck");
		if (fid_max != null && fid_max > 0) {
		    fid = fid_max + 1;
		}
		
		Date today = new Date();
		SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd- hh:mm:ss");
		String signdate = cal.format(today);
	
		vo.setO_id(id);
		vo.setId(id);
		vo.setName(name);
		vo.setFid(fid);
		vo.setThread("A");
		vo.setSigndate(signdate);
		
		service.insertNoticeService(vo);
		rttr.addFlashAttribute("msg","문의가 등록되었습니다.");
		return "redirect:list?option="+vo.getGongji();
	}
		
	@GetMapping("/view")
	public void viewGet(int n_uid,String gongji,Model model)throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("n_uid", n_uid);
		map.put("gongji", gongji);
		
		NoticeVO vo= service.oneItemService(map);
		NoticeVO front= service.frontWriteService(map);
		NoticeVO next = service.nextWriteService(map);
		//log.info("front"+front.toString());
		//log.info("next"+next.toString());
		service.refIncreaseService(n_uid);
		
		model.addAttribute("LF","\n");
		model.addAttribute("vo",vo);
		model.addAttribute("front",front);
		model.addAttribute("next",next);
	}
	
}
