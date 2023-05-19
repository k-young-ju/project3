package org.zerock.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.service.MemberService;

@RestController
public class Rcontroller {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	
	@Inject
	private MemberService service;
	
	@RequestMapping(value="/idok", produces="text/plain;charset=UTF-8", method = RequestMethod.POST)
	public String idCheck( String m_id, Model model) throws Exception{
		
			logger.info(m_id);
			if(m_id.equals("")) {
				return "<div style='color:red'>&nbsp아이디를 입력해 주세요. (영문소문자/숫자, 4~16자)</div>";
			}
			if(m_id.matches("[A-Zㄱ-ㅎ]+") || Character.isDigit(m_id.charAt(0)) ||m_id.getBytes().length < 4) { //영문 대문자나 한글인지 또는 첫글자가 숫자인지 또는 글자수가 4자 이하인지
				return "<div style='color:red'>&nbsp아이디는 영문소문자 또는 숫자 4~16자로 입력해 주세요</div>";
				
			}
			int result = service.idCheckService(m_id);
			
			if(result ==0) {
				return "<div style='color:blue'>&nbsp;"+m_id+"는 사용가능한 아이디입니다.</div>";
			}else {
				return "<div style='color:red'>&nbsp;"+m_id+"는 존재하는 아이디입니다.</div>";
			}
		
	}
	
	
}
