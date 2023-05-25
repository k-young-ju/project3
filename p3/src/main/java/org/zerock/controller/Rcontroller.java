package org.zerock.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.service.MemberService;

import lombok.extern.log4j.Log4j;

@RestController
@Log4j
public class Rcontroller {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	
	@Inject
	private MemberService service;
	
		
	@Inject
	SqlSession sqlsession;
	
	private static String namespace = "org.zerock.mapper.RestMapper";
	
	@RequestMapping(value="/idok", produces="text/plain;charset=UTF-8", method = RequestMethod.POST)
	public String idCheck( String id, Model model) throws Exception{
		
			logger.info(id);
			if(id.equals("")) {
				return "<div style='color:red'>&nbsp아이디를 입력해 주세요. (영문소문자/숫자, 4~16자)</div>";
			}
			if(id.matches("[A-Zㄱ-ㅎ]+") || Character.isDigit(id.charAt(0)) ||id.getBytes().length < 4) { //영문 대문자나 한글인지 또는 첫글자가 숫자인지 또는 글자수가 4자 이하인지
				return "<div style='color:red'>&nbsp아이디는 영문소문자 또는 숫자 4~16자로 입력해 주세요</div>";
				
			}
			int result = sqlsession.selectOne(namespace+".idCount",id);
			//int result = service.idCheckService(id);
			
			if(result ==0) {
				return "<div style='color:blue'>&nbsp;"+id+"는 사용가능한 아이디입니다.</div>";
			}else {
				return "<div style='color:red'>&nbsp;"+id+"는 존재하는 아이디입니다.</div>";
			}
		
	}
	
		//선택옵션 삭제
		@PostMapping("/select_delete")
		public void viewCartDelete(int ct_uid) throws Exception{
			//cservice.deleteCartService(ct_uid);
			sqlsession.delete(namespace+".deleteSelect",ct_uid);
					
		}
		//장바구니 수량변경
		@PostMapping("/updateQty")
		public void updateQty(int s_uid, Integer qty) throws Exception{
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("s_uid", s_uid);
			map.put("qty", qty);
			log.info(map.toString());
			sqlsession.update(namespace+".updateQty",map);
			
		}
	
}
