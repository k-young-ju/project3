package org.zerock.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.zerock.domain.ItemVO;
import org.zerock.persistence.ItemDAO;
import org.zerock.persistence.MemberDAO;


@Controller
public class HomeController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Inject
	MemberDAO mdao;
	
	@Inject
	ItemDAO idao;
	
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home( Model model) throws Exception{
		logger.info("Welcome home! ");
				
		model.addAttribute("bestList",idao.listLimitDAO());
		model.addAttribute("url","index");
		
		return "index";
	}
	
	
	
}
