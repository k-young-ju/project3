package org.zerock.controller;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.zerock.domain.CouponVO;
import org.zerock.domain.MemberVO;
import org.zerock.domain.OrderVO;
import org.zerock.service.KakaoPay;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class KakaoPayController {
	@Setter(onMethod_ = @Autowired)
    private KakaoPay kakaopay;
	
	@Inject
    SqlSession sqlsession;
	
	private static String namespace = "org.zerock.mapper.OrderMapper";
	
	private static String namespaceMember = "org.zerock.mapper.MemberMapper";
	
	private static String namespaceCart = "org.zerock.mapper.CartMapper";
	
	private static String namespaceCoupon = "org.zerock.mapper.CouponMapper";
    
	
    @GetMapping("/kakaoPay")
    public String kakaoPayGet(@RequestParam("data") String data,HttpSession session) {
    	 log.info("kakaoPay get............................................");
    	log.info("sss"+data);
    	
    	JSONObject json = new JSONObject(data);

    	String price =json.getString("total_price");
 		int qty = json.getInt("total_qty");
 	   	String subject = json.getString("subject");
    	
    	session.setAttribute("jsonData",data);
 		
 		
    	 return "redirect:kakaoPaySuccess";
    }
    
//    @PostMapping("/kakaoPay")
//    public String kakaoPay(String subject) {
//        log.info("kakaoPay post............................................");
//        log.info(subject.toString());
//       
//        
//        
//         
//        return "redirect:" + kakaopay.kakaoPayReady();
// 
//    }
    
    
    
    @GetMapping("/kakaoPaySuccess")
    public String kakaoPaySuccess(HttpSession session) {
        log.info("kakaoPaySuccess get............................................");
        String data =(String)session.getAttribute("jsonData");
        
    	JSONObject json = new JSONObject(data);
        
             
        String id =(String)session.getAttribute("m_id");
 		MemberVO mv = new MemberVO();
 		OrderVO vo = new OrderVO();
 		 		
 		//log.info("ct_uids="+ct_uids);
 			
 		java.util.Date today = new java.util.Date();
 		SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
 		String signdate = cal.format(today);
 		String usepointStr = json.getString("usepoint");
 		
 		mv.setId(id);
 		//사용자 포인트 차감
 		if(usepointStr !=null && !usepointStr.equals("")) {
 			int usepoint = Integer.parseInt(usepointStr);
 			mv.setPoint(usepoint);
 			vo.setUsepoint(usepoint);
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
 		vo.setEmail(json.getString("email"));
 		vo.setPhone(json.getString("phone"));
 		vo.setName(json.getString("name"));
 		vo.setZipcode(json.getString("zipcode"));
 		vo.setZipcode1(json.getString("zipcode1"));
 		vo.setZipcode2(json.getString("zipcode2"));
 		vo.setZipcode3(json.getString("zipcode3"));
 		vo.setZipcode4(json.getString("zipcode4"));
 		vo.setTotal_price(json.getInt("total_price"));
 		vo.setMessage(json.getString("message"));
 		 		
 		String cp_number = json.getString("cp_number");
 		//쿠폰 사용
 		if(cp_number !=null) {
 			CouponVO cp =  new CouponVO();
 			cp.setCp_number(cp_number);
 			cp.setOd_number(num);
 			sqlsession.update(namespaceCoupon+".use",cp);
 		}
 		String ct_uids =json.getString("ct_uids");
 		//order table에 담기
 		sqlsession.insert(namespace+".insertOrder",vo);
 		String[]ct_uid_ch = ct_uids.split(",");
 		Map<String, Object> map = new HashMap<String, Object>();
 		map.put("o_id", num);
 		
 		
 		//카트 o_id와 주문번호 동일 처리
 		for(int i=0;i<ct_uid_ch.length;i++) {
 			map.put("ct_uid", ct_uid_ch[i]);
 			sqlsession.update(namespaceCart+".updateOid",map);
 			
 			map.remove("ct_uid");
 					
 		}
 		 	
       // model.addAttribute("info", kakaopay.kakaoPayInfo(pg_token));
        
        return "redirect:/order/orderResult?od_number="+num;
    }
}
