package org.zerock.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.ItemVO;
import org.zerock.persistence.ItemDAO;
import org.zerock.persistence.MemberDAO;

import lombok.extern.log4j.Log4j;


@Controller
@Log4j
public class HomeController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Inject
	MemberDAO mdao;
	
	@Inject
	ItemDAO idao;
	
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home( Model model) throws Exception{
		logger.info("Welcome home! ");
		log.info("Welcome home!")	;	
		model.addAttribute("bestList",idao.listLimitDAO());
		model.addAttribute("url","index");
		logger.info(idao.listLimitDAO().toString());
		return "index";
	}
	
	@RequestMapping(value="/admin", method = RequestMethod.GET)
	public String aaaadmin(HttpSession session, RedirectAttributes rttr) throws Exception{
		
	return "/admin/index";
			
	}
	
}
