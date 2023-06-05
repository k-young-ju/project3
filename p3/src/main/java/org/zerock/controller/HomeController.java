package org.zerock.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.dto.CouponNumberMaker;
import org.zerock.persistence.ItemDAO;
import org.zerock.persistence.MemberDAO;

import lombok.extern.log4j.Log4j;


@Controller
@Log4j
public class HomeController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Inject
	MemberDAO mdao;
	
	@Inject
	ItemDAO idao;
	
	@Inject
	SqlSession sqlsession;
	
	private static String namespace = "org.zerock.mapper.MemberMapper";
	
	private static String namespaceCoupon = "org.zerock.mapper.CouponMapper";
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home( Model model) throws Exception{
		logger.info("Welcome home! ");
		log.info("Welcome home!")	;	
		model.addAttribute("bestList",idao.listLimitDAO());
		model.addAttribute("url","index");
		logger.info(idao.listLimitDAO().toString());
		
		java.util.Date today = new java.util.Date();
		SimpleDateFormat cal = new SimpleDateFormat("yyyyMMddHHmmss");
		String signdate = cal.format(today);
		
		java.util.Date today2 = new java.util.Date();
		SimpleDateFormat cal2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String signdate2 = cal2.format(today2);
		
		//모든 쿠폰 등록일 기준 7일 후 	
		List<String> date_list = sqlsession.selectList(namespaceCoupon+".sevendayList");
		
		//log.info(date_list);
		
		for(String date : date_list) {
			Date signDate = cal2.parse(date);
			log.info("parse:"+signDate);
			sqlsession.delete(namespaceCoupon+".deleteAfter7days",signDate);
			
		}
		
		 // 임의의 문자열을 생성하는 메서드
        String randomString = CouponNumberMaker.generateRandomString(14);
         StringBuilder sb = new StringBuilder();
         for(int i=0;i<signdate.length();i++) {
        	 sb.append(signdate.charAt(i));
        	 sb.append(randomString.charAt(i));
         }
        String cp_number = sb.toString();
        
        //log.info(cp_number);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("cp_number", cp_number);
        int point =3000;
        map.put("point", point);
        map.put("signdate", signdate2);
        sqlsession.insert(namespace+".autoInsert",map); //3000원 쿠폰 자동생성
         
		return "index";
	}
	
	@RequestMapping(value="/admin", method = RequestMethod.GET)
	public String aaaadmin(HttpSession session, RedirectAttributes rttr) throws Exception{
		
	return "/admin/index";
			
	}
		  
	
}
