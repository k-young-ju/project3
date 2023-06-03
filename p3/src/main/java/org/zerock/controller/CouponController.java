package org.zerock.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.CouponVO;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/coupon")
public class CouponController {
	
	@Inject
	SqlSession sqlsession;
	
	private static String namespace = "org.zerock.mapper.CouponMapper";
	
	@GetMapping("/list")
	public void couponGet(HttpSession session,Model model) throws Exception{
		String id = (String)session.getAttribute("m_id");
		
		model.addAttribute("count",sqlsession.selectOne(namespace+".countCoupon",id));
		model.addAttribute("list",sqlsession.selectList(namespace+".couponList",id));

	}

	@PostMapping("/list")
	public String couponPost(CouponVO vo,HttpSession session,RedirectAttributes rttr) throws Exception{
		String id = (String)session.getAttribute("m_id");
		vo.setId(id);
		CouponVO cp = sqlsession.selectOne(namespace+".couponCheck",vo);
		if(ObjectUtils.isEmpty(cp)) {
			rttr.addFlashAttribute("msg", "존재하지않는 쿠폰번호입니다.");
		}else {
			if(cp.getId() == id || (cp.getId() !=null && cp.getId() !=id)) {
				rttr.addFlashAttribute("msg", "이미 등록된 쿠폰입니다.");
			}else {
				sqlsession.update(namespace+".registerCoupon",vo);
				rttr.addFlashAttribute("msg", "쿠폰이 등록되었습니다");
			}
		}

		
		return "redirect:coupon_list";
	}
	@GetMapping("/couponSelect")
	public void selectGet(HttpSession session,Model model) throws Exception{
		String id =(String)session.getAttribute("m_id");
		
		model.addAttribute("count",sqlsession.selectOne(namespace+".countCoupon",id));
		model.addAttribute("list",sqlsession.selectList(namespace+".couponList",id));
	}
}
