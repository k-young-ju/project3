package org.zerock.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.zerock.service.ItemService;

@Controller
public class ItemController {
	private static final Logger logger = LoggerFactory.getLogger(ItemController.class);
	
	@Inject
	ItemService service;
	
	
}
