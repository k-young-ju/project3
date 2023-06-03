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
@RequestMapping("/admin/cart")
public class AdminCartController {
	
	@Inject
	SqlSession sqlsession;
	
	private static String namespace = "org.zerock.mapper.AdminCartMapper";

	@GetMapping("/list")
	public void listGet(Criteria cri,Model model) throws Exception{
		
		model.addAttribute("menu","menu11");
		model.addAttribute("list",sqlsession.selectList(namespace+".listAll",cri));
	}
	
	@GetMapping("/delete")
	public String deleteCart(int ct_uid) throws Exception{
	
		sqlsession.delete(namespace+".deleteCart",ct_uid);	
		return "redirect:list";
	}
}
