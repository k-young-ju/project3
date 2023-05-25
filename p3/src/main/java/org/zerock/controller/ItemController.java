package org.zerock.controller;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
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
import org.zerock.domain.Criteria;
import org.zerock.domain.ItemVO;
import org.zerock.domain.PageMaker;
import org.zerock.domain.SearchCriteria;
import org.zerock.domain.SelectVO;
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
	public void viewGet(Criteria cri,int uid,Model model,HttpSession session) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		ItemVO vo = service.viewService(uid);
		String id = (String)session.getAttribute("m_id");
		if(id == null) {
			String o_id = (String)session.getAttribute("cart");
			map.put("id", o_id);
		}else {
			map.put("id", id);
		}
		
		map.put("uid", uid);
		map.put("cri", cri);
		
	
		//금액처럼 변환
		DecimalFormat formatter = new DecimalFormat("###,###");
		//String price1 = formatter.format(vo.getPrice());
				
		//색상이 여러개 존재한다면
		if(vo.getColor().contains(",")) {
			String[] color_ch = vo.getColor().split(",");
			ArrayList<String> color_list = new ArrayList<String>();
			for(int i =0;i<color_ch.length;i++) {
				color_list.add(color_ch[i]);
				System.out.println(color_list);
			}
			model.addAttribute("color_list",color_list);
		}
				
		log.info(vo.toString());
		
		if(vo.getDeliveryfee() ==0) {
			model.addAttribute("delivery","무료");
			model.addAttribute("deliveryInfo","기본 무료배송");
		}else {
			model.addAttribute("delivery","3,000");
			model.addAttribute("deliveryInfo","30,000원 이상 구매 시 무료배송");
		}
		
		model.addAttribute("reviewList",service.viewItemReviewService(map));
		model.addAttribute("noticeList",service.viewItemNoticeService(map));
		model.addAttribute("vo",vo);
		model.addAttribute("list",service.listAllSelectService(map));
	}
	
	//옵션선택시 selectoption 테이블에 저장
	@PostMapping("/color_select")
	public void colorSelect(String color, int uid,HttpSession session,Model model,RedirectAttributes rttr) throws Exception{
		log.info("=====color_select=====");
		
		Date today = new Date();
		SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd- hh:mm:ss");
		String signdate = cal.format(today);
		
		SelectVO svo = new SelectVO();
		String id = "";
		String cart = (String)session.getAttribute("cart");
		if(session.getAttribute("m_id") != null) {
			id=(String)session.getAttribute("m_id");
			svo.setId(id);
		}else {
			svo.setId(cart);
		}
		ItemVO vo = service.viewService(uid);
				
		svo.setColor(color);
		svo.setSubject(vo.getSubject());
		svo.setPrice(vo.getPrice());
		svo.setQty(1);
		svo.setUid(uid);
		
		log.info(svo);
		
		int count = service.countColorService(svo);		
		
		if(count ==0) {
			service.insertSelectService(svo);
		}
	
	}
	@GetMapping("/itemSearch")
	public void searchGet(SearchCriteria cri,Model model) throws Exception{
		log.info("==================searchGet=====");	
		log.info(cri.toString());
		
		if(cri.getSearchTitle() != null) {			
			PageMaker pageMaker = new PageMaker();
			
			pageMaker.setCri(cri);
			pageMaker.setTotalCount(service.countSearchService(cri));

			model.addAttribute("list", service.searchListService(cri)); 
			model.addAttribute("pageMaker",pageMaker);
			model.addAttribute("cri",cri);
		}	
		
	}
}
