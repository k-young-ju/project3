package org.zerock.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.CartVO;
import org.zerock.domain.CouponVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.MemberVO;
import org.zerock.domain.OrderVO;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/order")
public class OrderController {
	
	@Inject
	SqlSession sqlsession;
	
	private static String namespace = "org.zerock.mapper.OrderMapper";
	
	private static String namespaceMember = "org.zerock.mapper.MemberMapper";
	
	private static String namespaceCart = "org.zerock.mapper.CartMapper";
	
	private static String namespaceItem = "org.zerock.mapper.ItemMapper";
	
	private static String namespaceCoupon = "org.zerock.mapper.CouponMapper";

	@GetMapping("/orderForm")
	public void orderFormPost(Integer ct_uid,String ct_uids,HttpSession session,Model model) throws Exception{
		String id = (String)session.getAttribute("m_id");
		String o_id = (String)session.getAttribute("cart");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("ct_uid", ct_uid);
		if(id==null) {
			map.put("o_id", o_id);
		}else {
			map.put("id", id);
			
			MemberVO m = sqlsession.selectOne(namespaceMember+".onemember",id);
			if(m != null) {
				String[] phone_ch = m.getPhone().split("-");
				String[] email_ch =m.getEmail().split("@");
				
				model.addAttribute("phone1",phone_ch[0]);
				model.addAttribute("phone2",phone_ch[1]);
				model.addAttribute("phone3",phone_ch[2]);
				model.addAttribute("email1",email_ch[0]);
				model.addAttribute("email2",email_ch[1]);
				model.addAttribute("m",m);
				model.addAttribute("couponCount",sqlsession.selectOne(namespaceCoupon+".countCoupon",id)); //보유 쿠폰 개수
				model.addAttribute("point",sqlsession.selectOne(namespaceMember+".point",id));
			}
		}
		ArrayList<CartVO> list = new ArrayList<CartVO>();
		if(ct_uid !=null) {
			 list.add(sqlsession.selectOne(namespaceCart+".orderCartList",ct_uid));
		}else {
			String[] ct_uid_ch = ct_uids.split(",");
			
			for(int i=0;i<ct_uid_ch.length;i++) {
				list.add(sqlsession.selectOne(namespaceCart+".orderCartList",ct_uid_ch[i]));
			}
		}
		
		model.addAttribute("list",list); //상품정보
		
		
	}
	
	@GetMapping("/list")
	public void listGet(Criteria cri,HttpSession session,String od_status,String od_date1,String od_date2,Model model) throws Exception{
		OrderVO vo = new OrderVO();
		Map<String, Object> map = new HashMap<String, Object>();
		if(od_status !=null) {
			vo.setOd_status(od_status);
			
		}
		java.util.Date today = new java.util.Date();
		SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String signdate = cal.format(today);
		
		Calendar cal2 = Calendar.getInstance();
		cal2.add(Calendar.MONTH, -3);
		Date threeMonthsAgo = cal2.getTime();
		String signdate2 = cal.format(threeMonthsAgo);
		log.info(signdate2);
		log.info(threeMonthsAgo);
		
		if(od_date1 ==null && od_date2 ==null) {
			od_date1 = signdate2.substring(0,10);
			od_date2 = signdate.substring(0,10);
		}
		if(od_date1 != null && od_date2 != null) {
			map.put("od_date1", od_date1);
			map.put("od_date2", od_date2);
		}
		
		
		cri.setPerPageNum(15);
		String id = (String)session.getAttribute("m_id");
		map.put("id", id);
		map.put("cri", cri);
		map.put("vo", vo);
		
		model.addAttribute("od_status",od_status);
		model.addAttribute("od_date1",od_date1);
		model.addAttribute("od_date2",od_date2);
		model.addAttribute("count",sqlsession.selectOne(namespace+".countList",id));
		model.addAttribute("list",sqlsession.selectList(namespace+".listAll",map));
	}
	
	@PostMapping(value="/orderForm", produces ="text/plain;charset=UTF-8" )
	public String orderPost(OrderVO vo,String ct_uids,String qtys,Model model,String cp_number, HttpSession session,Integer usepoint) throws Exception{
		String id =(String)session.getAttribute("m_id");
		MemberVO mv = new MemberVO();
		log.info("=====orderResult=====");
		log.info("vo="+vo.toString());
		log.info("ct_uids="+ct_uids);
		log.info("qtys="+qtys);
		log.info(vo.toString());
			
		java.util.Date today = new java.util.Date();
		SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String signdate = cal.format(today);
		
		mv.setId(id);
		//사용자 포인트 차감
		if(usepoint !=null) {
					
			mv.setPoint(usepoint);
			sqlsession.update(namespaceMember+".pointMinus",mv);
		}
		
		//주문번호 생성
		SimpleDateFormat cal2 = new SimpleDateFormat("HHmmss");
		String signdate2 = cal2.format(today);
	
		Random random = new Random();
		int[] randomNums = new int[signdate2.length()];
		for(int i=0;i<randomNums.length;i++) {
			randomNums[i] = random.nextInt(100);
		}
		String numstr = "";
		for(int i=0;i<signdate2.length();i++) {
			numstr +=signdate2.charAt(i)+randomNums[i];
		}
		String num = "o"+numstr; 
		//log.info(num);
		
		vo.setOd_number(num);
		vo.setId(id);
		vo.setOd_date(signdate);	
		
		//쿠폰 사용
		if(cp_number !=null) {
			CouponVO cp =  new CouponVO();
			cp.setCp_number(cp_number);
			cp.setOd_number(num);
			sqlsession.update(namespaceCoupon+".use",cp);
		}
		
		//order table에 담기
		sqlsession.insert(namespace+".insertOrder",vo);
		String[]ct_uid_ch = ct_uids.split(",");
		String[] qty_ch = qtys.split(",");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("o_id", num);
		
		
		//카트 o_id와 주문번호 동일 처리
		for(int i=0;i<qty_ch.length;i++) {
			map.put("ct_uid", ct_uid_ch[i]);
			map.put("qty", qty_ch[i]);
			sqlsession.update(namespaceCart+".updateOid",map);
			int uid =sqlsession.selectOne(namespaceCart+".itemUid",ct_uid_ch[i]);
			map.put("uid", uid);
			//재고 감소&판매량 증가
			sqlsession.update(namespaceItem+".orderQtyChange",map);
			
			
			map.remove("ct_uid");
			map.remove("qty");
					
		}
	
				
		return "redirect:orderResult?od_number="+num;
	}
	@GetMapping("/orderResult")
	public void orderResultGet(String od_number,HttpSession session,Model model) throws Exception{
		String id=(String)session.getAttribute("m_id");
		
		model.addAttribute("od_status",sqlsession.selectOne(namespace+".cancelStatus",od_number));	
		model.addAttribute("vo",sqlsession.selectOne(namespace+".result",od_number)); //주문정보
		model.addAttribute("list",sqlsession.selectList(namespaceCart+".cartResult",od_number));//상품정보
		model.addAttribute("point",sqlsession.selectOne(namespaceMember+".point",id)); //보유 포인트
		model.addAttribute("usepoint",sqlsession.selectOne(namespace+".usepoint",od_number));
		model.addAttribute("couponCount",sqlsession.selectOne(namespaceCoupon+".countCoupon",id)); //보유 쿠폰 개수
		model.addAttribute("couponpoint",sqlsession.selectOne(namespaceCoupon+".usecoupon",od_number)); //사용쿠폰 금액
		model.addAttribute("od_number",od_number);
		
	}
	@GetMapping("/orderCancel")
	public String calcel(String od_number,RedirectAttributes rttr,HttpSession session) throws Exception{
		String id=(String)session.getAttribute("m_id");
		Map<String, Object>map = new HashMap<String, Object>();
				
		map.put("id", id);
		Integer usepoint = sqlsession.selectOne(namespace+".usepointGet",od_number);
		
		if(usepoint != null && usepoint !=0) {
		 	map.put("point", usepoint);
			sqlsession.update(namespaceMember+".ordercancel",map);
		}
		
		sqlsession.update(namespace+".cancel",od_number);
		sqlsession.update(namespaceCoupon+".cancel",od_number);
		
		rttr.addFlashAttribute("msg","주문이 취소되었습니다");
		return "redirect:/";
	}
}
