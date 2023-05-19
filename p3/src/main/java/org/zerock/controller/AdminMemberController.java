package org.zerock.controller;

import java.text.SimpleDateFormat;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.inject.Inject;
import javax.mail.Session;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.Criteria;
import org.zerock.domain.MemberVO;
import org.zerock.domain.PageMaker;
import org.zerock.service.AdminMemberService;
import org.zerock.service.MemberService;

@Controller
@RequestMapping("/admin/member")
public class AdminMemberController {
	private static final Logger logger = LoggerFactory.getLogger(AdminMemberController.class);
	
	@Inject
	private AdminMemberService service;
	
	@GetMapping("/join")
	public void joinGet(Model model) throws Exception{
	String menu = "menu1";
	model.addAttribute("menu",menu);
			
	}
	
	@PostMapping("/join")
	public String joinPost(MemberVO m,String member_type, RedirectAttributes rttr) throws Exception{
		
		java.util.Date today = new java.util.Date();
		SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String signdate = cal.format(today);

		m.setSigndate(signdate);
		
		if(member_type.equals("s")) {
			m.setLevel(5);
			System.out.println("level="+m.getLevel());
		}
		
	
		if(m.getM_id().matches("[A-Zㄱ-ㅎ]+") || Character.isDigit(m.getM_id().charAt(0)) ||m.getM_id().getBytes().length < 4){
			rttr.addFlashAttribute("msg","아이디를 요청한 형식에 맞게 작성해주세요");
			rttr.addFlashAttribute("option","memberAdd");
			rttr.addFlashAttribute("menu","menu1");
			return "redirect:join";
		}
		String pattern = "[a-zA-Zㄱ-ㅎ]+";
		Pattern regex = Pattern.compile(pattern);
		Matcher matcher = regex.matcher(m.getPhone());
		if(matcher.find()) {
			rttr.addFlashAttribute("msg","전화번호는 숫자로 입력하셔야합니다.");
			
			return "redirect:join";
		}
		System.out.println(m);
		service.joinService(m);
		rttr.addFlashAttribute("msg","회원추가 되었습니다.");
		
		return "redirect:list";
	}
	
	@GetMapping("/list")
	public void listGet(Model model, Criteria cri) throws Exception{
		String menu = "menu2";
		model.addAttribute("menu",menu);
		
		PageMaker pageMaker = new PageMaker();
		
		pageMaker.setCri(cri);
//		pageMaker.setTotalCount(131);
		pageMaker.setTotalCount(service.countMemberService(cri)); //총 회원수

		model.addAttribute("cri",cri);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("list", service.listAllMember(cri));
	}
	
	@GetMapping("/modify")
	public void modifyGet(String m_id, Model model) throws Exception{
		String menu = "menu2";
		model.addAttribute("menu",menu);
		
		MemberVO m = service.oneMemberService(m_id);
		String[] email_ch = m.getEmail().split("@");
		String email1 = email_ch[0];
		String email2 = email_ch[1];
		
		String[] phone_ch = m.getPhone().split("-");
		String phone1 = phone_ch[0];
		String phone2 = phone_ch[1];
		String phone3 = phone_ch[2];
		//System.out.println(phone1+"||"+phone2+"||"+phone3);
		//System.out.println(email1+"||"+email2);
		model.addAttribute("m",m);
		model.addAttribute("email1",email1);
		model.addAttribute("email2",email2);
		model.addAttribute("phone1",phone1);
		model.addAttribute("phone2",phone2);
		model.addAttribute("phone3",phone3);
		
	}
	
	@PostMapping("/modify")
	public String modifyPost(MemberVO m, RedirectAttributes rttr,Model model) throws Exception{
		logger.info(m.toString());
		service.updateMemberService(m);
		rttr.addFlashAttribute("msg","수정되었습니다");
			
		
		return "redirect:modify?m_id="+m.getM_id();
	}
		
	
}
