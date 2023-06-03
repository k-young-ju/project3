package org.zerock.controller;

import java.util.HashMap;
import java.util.Map;

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
@RequestMapping("/admin/order")
public class AdminOrderController {
	
	@Inject
	SqlSession sqlsession;
	
	private static String namespace = "org.zerock.mapper.AdminOrderMapper";
	
	private static String namespaceCart = "org.zerock.mapper.AdminCartMapper";
	
	private static String namespaceCoupon = "org.zerock.mapper.AdminCouponMapper";
	
	private static String namespaceMember = "org.zerock.mapper.AdminMemberMapper";
	
	@GetMapping("/list")
	public void listGet(Criteria cri, String path,Model model) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cri",cri);
		map.put("path", path);
		String menu="";
		if(path.equals("order")) {
			menu="menu6";
		}else if(path.equals("orderComplete")) {
			menu="menu7";
		}else if(path.equals("delivery")) {
			menu="menu8";
		}else if(path.equals("deliveryComplete")) {
			menu="menu9";	
		}else {
			menu="menu10";
		}
		
		
		model.addAttribute("menu",menu);
		model.addAttribute("path",path);
		model.addAttribute("list",sqlsession.selectList(namespace+".listAll",map));
		
	}
	
	@GetMapping("/update")
	public String updateGet(String id,String path,String od_number) throws Exception{
		Map<String, Object>map = new HashMap<String, Object>();
		map.put("path", path);
		map.put("od_number", od_number);
		map.put("id", id);
		sqlsession.update(namespace+".statusUpdate",map);
		
		if(path.equals("order")) {
			return "redirect:list?path=orderComplete";
		}else if(path.equals("orderComplete")) {
			return "redirect:list?path=delivery";
		}else if(path.equals("delivery")) {
			//사용자 포인트 추가
			int point = sqlsession.selectOne(namespace+".pointGet",map);
			map.put("point", point);
			sqlsession.insert(namespaceMember+".pointPlus",map);
			return "redirect:list?path=deliveryComplete";
		}else {
			return "redirect:list?path=cancel";
		}
		
	}
	
	@GetMapping("/view")
	public void viewGet(String od_number,Model model) throws Exception{
		
		
		model.addAttribute("vo",sqlsession.selectOne(namespace+".result",od_number)); //주문정보
		model.addAttribute("list",sqlsession.selectList(namespaceCart+".cartResult",od_number));//상품정보
		model.addAttribute("usepoint",sqlsession.selectOne(namespace+".usepoint",od_number)); //사용포인트
		model.addAttribute("cp",sqlsession.selectOne(namespaceCoupon+".usecoupon",od_number)); //사용쿠폰 금액
		model.addAttribute("od_number",od_number);
	}
}
