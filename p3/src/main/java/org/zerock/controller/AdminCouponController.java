package org.zerock.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.CouponVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageMaker;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/coupon")
public class AdminCouponController {
	
	@Inject
	SqlSession sqlsession;
	
	private static String namespace = "org.zerock.mapper.AdminCouponMapper";
	
	@GetMapping("/list")
	public void listGet(Criteria cri,Model model) throws Exception{
		cri.setPerPageNum(15);
		
		PageMaker pageMaker = new PageMaker();
		
		pageMaker.setCri(cri);
//		pageMaker.setTotalCount(131);
		
		pageMaker.setTotalCount(sqlsession.selectOne(namespace+".countCoupon",cri)); 

		
		model.addAttribute("cri",cri);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("list",sqlsession.selectList(namespace+".listAll",cri));
		model.addAttribute("menu","menu17");
	}
	
	@PostMapping("/list")
	public String registerGet(CouponVO cp,String pointCommas,RedirectAttributes rttr) throws Exception{
			
		if (pointCommas.contains(",")) {
		    pointCommas = pointCommas.replace(",", "").trim();
		    cp.setPoint(Integer.parseInt(pointCommas));
		}else {
			cp.setPoint(Integer.parseInt(pointCommas));
		}
		log.info("pointCommas=" + pointCommas);
		
		log.info(cp.toString());
		sqlsession.update(namespace+".update",cp);
		rttr.addFlashAttribute("msg","등록되었습니다.");
		
		return "redirect:list";
	}
	
	@GetMapping("/delete")
	public String deletecoupon(String cp_number) throws Exception{
		sqlsession.delete(namespace+".delete",cp_number);
		
		return "redirect:list";
	}
	
	@GetMapping("/select_delete")
	public String selectDelete(String cp_numbers) throws Exception{
		//log.info(cp_numbers);
		String[] cp_number_ch=cp_numbers.split(",");
		//log.info("개수"+cp_number_ch.length);
		for(int i=0;i<cp_number_ch.length;i++) {
			sqlsession.delete(namespace+".delete",cp_number_ch[i]);
		}
		return "redirect:list";
	}
}
