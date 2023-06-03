package org.zerock.controller;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.Criteria;
import org.zerock.domain.MemberVO;
import org.zerock.domain.PageMaker;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/member")
public class AdminMemberController {
	private static final Logger logger = LoggerFactory.getLogger(AdminMemberController.class);
	
		
	@Inject
	private SqlSession sqlsession;
	
	private static String namespace = "org.zerock.mapper.AdminMemberMapper";
	
	private static String namespaceOrder = "org.zerock.mapper.AdminOrderMapper";
	
	@GetMapping("/join")
	public void joinGet(Model model) throws Exception{
	String menu = "menu1";
	model.addAttribute("menu",menu);
			
	}
	
	@PostMapping("/join")
	public String joinPost(MemberVO m,String member_type, RedirectAttributes rttr) throws Exception{
		String name =m.getName().replace(",","").trim();
		log.info(m.toString());
		m.setName(name);
		
		
		java.util.Date today = new java.util.Date();
		SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String signdate = cal.format(today);

		m.setSigndate(signdate);
		
		if(member_type.equals("s")) {
			m.setLevel(5);
			System.out.println("level="+m.getLevel());
		}else {
			m.setLevel(1);
		}
		
	
		if(m.getId().matches("[A-Zㄱ-ㅎ]+") || Character.isDigit(m.getId().charAt(0)) ||m.getId().getBytes().length < 4){
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
		//System.out.println(m);
		
		sqlsession.insert(namespace+".join",m);
		
		rttr.addFlashAttribute("msg","회원추가 되었습니다.");
		
		return "redirect:list?option=all";
	}
	
	@GetMapping("/list")
	public void listGet(String option,Model model, Criteria cri) throws Exception{
		String menu = "menu2";
		cri.setPerPageNum(10);
		
		PageMaker pageMaker = new PageMaker();
		
		pageMaker.setCri(cri);
//		pageMaker.setTotalCount(131);
		if(option.equals("all")) {
			pageMaker.setTotalCount(sqlsession.selectOne(namespace+".countMember",cri)); //총 회원수
			model.addAttribute("list", sqlsession.selectList(namespace+".listAll",cri));
		}else if(option.equals("remain")) {
			pageMaker.setTotalCount(sqlsession.selectOne(namespace+".countMemberRemain",cri)); //총 회원수
			model.addAttribute("list", sqlsession.selectList(namespace+".listRemain",cri));
		}else if(option.equals("delete")) {
			pageMaker.setTotalCount(sqlsession.selectOne(namespace+".countMemberDelete",cri)); //총 회원수
			model.addAttribute("list", sqlsession.selectList(namespace+".listDelete",cri));
		}
		
		model.addAttribute("option",option);	
		model.addAttribute("menu",menu);
		model.addAttribute("cri",cri);
		model.addAttribute("pageMaker", pageMaker);
		
	}
	
	@GetMapping("/modify")
	public void modifyGet(String id, Model model) throws Exception{
		String menu = "menu2";
		model.addAttribute("menu",menu);
		
		MemberVO m = sqlsession.selectOne(namespace+".onemember",id);
			
		String[] email_ch = m.getEmail().split("@");
		String email1 = email_ch[0];
		String email2 = email_ch[1];
		
		if(m.getC_number() !=null) {
			String[] c_number_ch =m.getC_number().split("-");
			String c_number1 = c_number_ch[0];
			String c_number2 = c_number_ch[1];
			
			model.addAttribute("c_number1",c_number1);
			model.addAttribute("c_number2",c_number2);
		}
		
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
		//logger.info(m.toString());
				
		sqlsession.update(namespace+".modify",m);
		
		rttr.addFlashAttribute("msg","수정되었습니다");
				
		return "redirect:modify?id="+m.getId();
	}
	
	@GetMapping("/delete")
	public String deleteMember(String id) throws Exception{
		sqlsession.update(namespace+".delete",id);
		
		return "redirect:list?option=all";
	}
	@GetMapping("level_ch")
	public String levelChange(int level,String id) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id",id);
		map.put("level", level);
		sqlsession.update(namespace+".levelChange",map);
		return "redirect:list?option=all";
	}
	
	@GetMapping("/viewPoint")
	public void viewPoint(String id,Model model) throws Exception{
		String menu = "menu2";
		
		model.addAttribute("menu",menu);
		model.addAttribute("list",sqlsession.selectList(namespaceOrder+".usepointList",id));
		model.addAttribute("vo",sqlsession.selectOne(namespace+".onemember",id));
	}
	
}
