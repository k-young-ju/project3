package org.zerock.adminController;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.zerock.controller.ItemController;

@Controller
@RequestMapping("/admin/item")
public class AdminItemController {
	private static final Logger logger = LoggerFactory.getLogger(AdminItemController.class);
	
	@GetMapping("/register")
	public void registerGet() throws Exception{
		
		
	}
}
