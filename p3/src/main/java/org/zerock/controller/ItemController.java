package org.zerock.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.CartVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.ItemVO;
import org.zerock.domain.PageMaker;
import org.zerock.service.CartService;
import org.zerock.service.ItemService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/item")
@Log4j
public class ItemController {
	private static final Logger logger = LoggerFactory.getLogger(ItemController.class);
	
	@Inject
	ItemService service;
	
	@Inject
	SqlSession sqlsession;
	
	@Inject
	CartService cservice;
			
	private static String namespace = "org.zerock.mapper.ItemMapper";
	
	@GetMapping("/list")
	public void itemListGet(@ModelAttribute("cri") Criteria cri,String option,String sorted ,Model model) throws Exception{
		log.info("===controller listGet===="+sorted);
		Map<String, Object> map = new HashMap<String, Object>();
		PageMaker pageMaker = new PageMaker();
		
		map.put("cri", cri);
		map.put("option", option);
		map.put("sorted", sorted);
		
		pageMaker.setCri(cri);
		//pageMaker.setTotalCount(131);
		pageMaker.setTotalCount(service.countItemService(map)); //총 게시물 수
		log.info(map.toString());
		
		model.addAttribute("option",option);
//		model.addAttribute("cri",cri);
		model.addAttribute("map",map);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("list",sqlsession.selectList(namespace+".listAll",map));
		//model.addAttribute("list",service.listAllService(map));
		
	}
	@GetMapping("/view")
	public void viewGet(int uid,Model model) throws Exception{
		ItemVO vo = service.viewService(uid);
		
		model.addAttribute("vo",vo);
		model.addAttribute("list",cservice.listAllCartService(uid));
	}
	//옵션선택시 장바구니 추가
	@PostMapping("/color_select")
	public void colorSelect(String color, int uid,HttpSession session,Model model,RedirectAttributes rttr) throws Exception{
		log.info("=====color_select=====");
		String id = "";
		if(session.getAttribute("m_id") != null) {
			id=(String)session.getAttribute("m_id");
		}
		ItemVO vo = service.viewService(uid);
		CartVO cvo = new CartVO();
		cvo.setColor(color);
		cvo.setFile1(vo.getFile1());
		cvo.setS_id(vo.getS_id());
		cvo.setM_id(id);
		cvo.setPrice(vo.getPrice());
		cvo.setQty(1);
		cvo.setUid(uid);
		
		log.info(cvo);
		
		int count = cservice.countColorService(cvo);		
		
		if(count ==0) {
			cservice.insertCartService(cvo);
		}
	
	}
	//카트 삭제
	@PostMapping("/cart_delete")
	public void viewCartDelete(int ct_uid) throws Exception{
		cservice.deleteCartService(ct_uid);
	}
	
}
