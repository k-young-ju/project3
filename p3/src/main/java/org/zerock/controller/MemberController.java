package org.zerock.controller;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.inject.Inject;
import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.MemberVO;
import org.zerock.service.IKakaoLoginService;
import org.zerock.service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Inject
	private MemberService service;
	
	@Inject
	private IKakaoLoginService kservice;
	
	@GetMapping("/login")
	public void loginGet() throws Exception{
		
	}
	
	
	@GetMapping("/join")
	public void joinGet() throws Exception{
		
	}
	
	@PostMapping("/join")
	public String joinPost(MemberVO m,String member_type, RedirectAttributes rttr) throws Exception{
		
		java.util.Date today = new java.util.Date();
		SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String signdate = cal.format(today);

		m.setSigndate(signdate);
		
		if(member_type.equals("s")) {
			m.setLevel("5");
			System.out.println("level="+m.getLevel());
		}
		
		System.out.println(m);
		if(m.getM_id().matches("[A-Zㄱ-ㅎ]+") || Character.isDigit(m.getM_id().charAt(0)) ||m.getM_id().getBytes().length < 4){
			rttr.addFlashAttribute("msg","아이디를 요청한 형식에 맞게 작성해주세요");
			return "redirect:join";
		}
		String pattern = "[a-zA-Zㄱ-ㅎ]+";
		Pattern regex = Pattern.compile(pattern);
		Matcher matcher = regex.matcher(m.getPhone());
		if(matcher.find()) {
			rttr.addFlashAttribute("msg","전화번호는 숫자로 입력하셔야합니다.");
			return "redirect:join";
		}
	
		service.joinService(m);
		rttr.addFlashAttribute("msg","회원가입 되었습니다. 반갑습니다.");
		return "redirect:/";
	}
	
	@ResponseBody //ajax에서 사용 ->문자열로 반환하면 경로가 아닌 문자열을 보낸다.
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
	//메일인증 문자 발송
	@RequestMapping(value="/mailSend", produces = "text/plain;charset=UTF-8",method = RequestMethod.POST )
	public void mailSendGO(String num, String email,HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		logger.info(num+"||"+email);
		String subject ="인증번호 확인하세요";
		String content = "인증번호 :"+num;
		
		PrintWriter out = response.getWriter();
		
		try {
			Properties p = System.getProperties();
			
			p.put("mail.smtp.starttls.enable","true");
			p.put("mail.smtp.host","smtp.gmail.com"); //gmail.com
			p.put("mail.smtp.auth", "true");
			p.put("mail.smtp.port", "587"); //gmail 포트번호
			
			Authenticator auth = new GoogleAuthentication(); //인증정보 생성
			
			Session s = Session.getInstance(p, auth); //메일 전송 역할하는 객체 생성
			Message m = new MimeMessage(s); //s객체를 사용하여 전송할 m객체 생성
			
			Address receiver_address = new InternetAddress(email); //받는 사람

			//메일 전송에 필요한 설정 부분
			m.setHeader("content-type", "text/html;charset=utf-8");
			m.addRecipient(Message.RecipientType.TO, receiver_address);
			m.setSubject(subject);
			m.setContent(content, "text/html;charset=utf-8");
			m.setSentDate(new Date());
			
			Transport.send(m); //메세지를 메일로 전송
			
			out.print("메일 전송");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
 @PostMapping("/login")
 public String loginPost(MemberVO m, HttpSession session, RedirectAttributes rttr) throws Exception{
	 	 
	 int loginCount = service.loginCountService(m);
	 
	 if(loginCount ==1) {
		 MemberVO member = service.loginService(m);
		 
		 if(member.getDelete_id().equals("y")){
			 rttr.addFlashAttribute("msg","탈퇴한 회원입니다.");
			 return "redirect:login";
		 }else if(!member.getPass().equals(m.getPass())){
			 rttr.addFlashAttribute("msg","비밀번호를 다시 확인해주세요");
			 return "redirect:login";
		 }else {
			 session.setAttribute("m_id", m.getM_id());
			 session.setAttribute("level", m.getLevel());
			 session.setAttribute("name", m.getM_name());
			 return "redirect:/";
		 }
				
	 }else {
		 rttr.addFlashAttribute("msg","존재하지않는 회원입니다.");
		 return "redirect:login";
	 }
	 
 }
 
@GetMapping("/logout")
public String logout(HttpSession session) throws Exception{
	session.invalidate();
	
	return "redirect:/";
}

//마이페이지 이동
@GetMapping("/myPage")
public void myPageGet() throws Exception{
	
	
}

@GetMapping("/modify")
public void modifyGet(HttpSession session, Model model) throws Exception{
	String id = (String)session.getAttribute("m_id");
	MemberVO m = service.oneMemberService(id);
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
//회원수정
@PostMapping("/modify")
public String modifyPost(MemberVO m, RedirectAttributes rttr) throws Exception{
	logger.info(m.toString());
	service.updateMemberService(m);
	rttr.addFlashAttribute("msg","수정되었습니다");
	
	return "redirect:modify";
}

//회원탈퇴
@GetMapping("delete")
public String deleteMembe(String m_id, HttpSession session) throws Exception{
	service.deleteMemberService(m_id);
	session.invalidate();
	
	return "redirect:/";
}

//아이디 찾기
@GetMapping("/find_id")
public void findIdGet() throws Exception{
	
}

@PostMapping("/find_id")
public String findIdPost(MemberVO m, Model model,RedirectAttributes rttr) throws Exception{
	MemberVO member = new MemberVO();
	
	
	if(m.getPhone().equals("--")) {
		member = service.findIdEmailService(m);
	}else {
		member = service.findIdPhoneService(m);
	}
	
	if(ObjectUtils.isEmpty(member)){
		rttr.addFlashAttribute("msg","입력하신 정보와 매칭되는 아이디는 존재하지 않습니다.");
		return "redirect:find_id";
	}else {
		model.addAttribute("member",member);
		
		return "/member/find_id_result";
	}
	
}

@GetMapping("/find_id_result")
public void findIdResult() throws Exception{
	
}
}