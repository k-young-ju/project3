package org.zerock.controller;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.zerock.domain.Criteria;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/review")
public class AdminReviewController {
	
	@Inject
	SqlSession sqlsession;
	
	private static String namespace = "org.zerock.mapper.AdminReviewMapper";
	
	@GetMapping("/list")
	public void listGet(Criteria cri,Model model) throws Exception{
		
		model.addAttribute("list",sqlsession.selectList(namespace+".listAll",cri));
		model.addAttribute("menu","menu12");
	}

}
