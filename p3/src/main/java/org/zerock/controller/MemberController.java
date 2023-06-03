package org.zerock.controller;

import java.io.PrintWriter;
import java.math.BigInteger;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.CouponVO;
import org.zerock.domain.MemberVO;
import org.zerock.dto.CouponNumberMaker;
import org.zerock.service.MemberService;

import com.mysql.cj.log.Log;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member")
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Inject
	private MemberService service;
	
	@Inject
	SqlSession sqlsession;
	
	private static String namespace = "org.zerock.mapper.MemberMapper";
	
	private static String namespaceCoupon = "org.zerock.mapper.CouponMapper";
	
	private static String namespaceOrder = "org.zerock.mapper.OrderMapper";
	
		
	@GetMapping("/login")
	public void loginGet(HttpSession session,Model model) throws Exception{
		
		 
	}
	
	

	
	@GetMapping("/join")
	public void joinGet() throws Exception{
		
	}
	
	@PostMapping("/join")
	public String joinPost(MemberVO m,String member_type, RedirectAttributes rttr) throws Exception{
		
		java.util.Date today = new java.util.Date();
		SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String signdate = cal.format(today);
		
		SimpleDateFormat cal2 = new SimpleDateFormat("yyyyMMddHHmmss");
		String signdate2 = cal2.format(today);
		m.setSigndate(signdate);
		
		if(member_type.equals("s")) {
			m.setLevel(5);
			System.out.println("level="+m.getLevel());
		}
		
		 String randomString = CouponNumberMaker.generateRandomString(14);
         StringBuilder sb = new StringBuilder();
         for(int i=0;i<signdate2.length();i++) {
        	 sb.append(signdate2.charAt(i));
        	 sb.append(randomString.charAt(i));
         }
        String cp_number = sb.toString();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cp_number", cp_number);
		map.put("id", m.getId());
		
		//회원가입 3000원 쿠폰 지급
		sqlsession.insert(namespace+".insertJoinCoupon",map);
		
		System.out.println(m);
		if(m.getId().matches("[A-Zㄱ-ㅎ]+") || Character.isDigit(m.getId().charAt(0)) ||m.getId().getBytes().length < 4){
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
		
	//메일인증 문자 발송
	@RequestMapping(value="/mailSend", produces = "text/plain;charset=UTF-8",method = RequestMethod.POST )
	public void mailSendGO(String num, String email,HttpServletRequest request, HttpServletResponse response) throws Exception{
		//logger.info(num+"||"+email);
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
	 
	 MemberVO member = service.loginService(m);
	 
	 if(loginCount ==1) {
		
		 
		 if(member.getDelete_id().equals("y")){
			 rttr.addFlashAttribute("msg","탈퇴한 회원입니다.");
			 return "redirect:login";
		 }else if(!member.getPass().equals(m.getPass())){
			 rttr.addFlashAttribute("msg","비밀번호를 다시 확인해주세요");
			 return "redirect:login";
		 }else {
			 session.setAttribute("m_id", member.getId());
			 session.setAttribute("level", member.getLevel());
			 session.setAttribute("m_name", member.getName());
			logger.info(session.toString());
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
public void myPageGet(HttpSession session,Model model) throws Exception{
	String id =(String)session.getAttribute("m_id");
	//쿠폰 수 조회
	int countCoupon = sqlsession.selectOne(namespaceCoupon+".countCoupon",id);
	
	//주문 상태별 개수 1:입금확인중,2.배송준비중,3.배송중,4.배송완료,5.취소
	int countOrder1 =sqlsession.selectOne(namespaceOrder+".countStatus1",id);
	int countOrder2 =sqlsession.selectOne(namespaceOrder+".countStatus2",id);
	int countOrder3 =sqlsession.selectOne(namespaceOrder+".countStatus3",id);
	int countOrder4 =sqlsession.selectOne(namespaceOrder+".countStatus4",id);
	int countOrder5 =sqlsession.selectOne(namespaceOrder+".countStatus5",id);
	
	//총 주문금액
	Integer totalOrderPrice =sqlsession.selectOne(namespaceOrder+".totalOrderPrice",id);
	if(totalOrderPrice ==null) {
		totalOrderPrice=0;
	}
	//총 적립포인트
	Integer totalOrderPoint =sqlsession.selectOne(namespaceOrder+".totalOrderPoint",id);
	if(totalOrderPoint ==null) {
		totalOrderPoint=0;
	}
	//보유 포인트
	Integer memberPoint = sqlsession.selectOne(namespace+".havePoint",id);
	if(memberPoint ==null) {
		memberPoint=0;
	}
	//사용포인트
	Integer usepoint =sqlsession.selectOne(namespaceOrder+".usedPoint",id);
	if(usepoint ==null) {
		usepoint=0;
	}
	
	model.addAttribute("usepoint",usepoint);
	model.addAttribute("memberPoint",memberPoint);
	model.addAttribute("totalOrderPrice",totalOrderPrice);
	model.addAttribute("totalOrderPoint",totalOrderPoint);
	model.addAttribute("countOrder1",countOrder1);
	model.addAttribute("countOrder2",countOrder2);
	model.addAttribute("countOrder3",countOrder3);
	model.addAttribute("countOrder4",countOrder4);
	model.addAttribute("countOrder5",countOrder5);
	model.addAttribute("countCoupon",countCoupon);
	
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
public String deleteMembe(String id, HttpSession session) throws Exception{
	service.deleteMemberService(id);
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
	
	String name = m.getName().replace(",", "").trim();
	String[] email_ch =m.getEmail().split(",");
	String email = email_ch[0];
	m.setEmail(email);
	m.setName(name);
	log.info(m.toString());
	int idCount = 0;
	if(m.getMember_type().equals("p")) {
		if(m.getPhone().equals("--")) {
			member = service.findIdEmailService(m);
			idCount = service.findIdEmailCountService(m);
		}else {
			member = service.findIdPhoneService(m);
			idCount = service.findIdPhoneCountService(m);
		}
	}else {
		if(m.getC_number().equals("-")) {
			member = service.findIdEmailService(m);
			idCount = service.findIdEmailCountService(m);
		}else {
			member = service.findIdCnumberServic(m);
			idCount = service.findIdCnumberCountService(m);
		}
	}
	
		
	System.out.println(idCount);
	if(ObjectUtils.isEmpty(member)){
		rttr.addFlashAttribute("msg","입력하신 정보와 매칭되는 아이디는 존재하지 않습니다.");
		return "redirect:find_id";
	}else {
		model.addAttribute("idCount",idCount);
		model.addAttribute("member",member);
		
		return "/member/find_id_result";
	}
	
}

@GetMapping("/find_id_result")
public void findIdResult() throws Exception{
	
}

@GetMapping("/find_pass")
public void findPassGet() throws Exception{
	
}
@PostMapping("/find_pass")
public String findPassPost(MemberVO m,RedirectAttributes rttr, Model model) throws Exception{
MemberVO member = new MemberVO();
String id = m.getId().replace(",", "").trim();
String name = m.getName().replace(",", "").trim();
String[] email_ch =m.getEmail().split(",");
String email = email_ch[0];
m.setEmail(email);
m.setName(name);
m.setId(id);

	logger.info(m.toString());
	int passCount = 0;
	
	if(m.getMember_type().equals("p")) {
		if(m.getPhone().equals("--")) {
			member = service.findPassEmailService(m);
			passCount = service.findPassEmailCountService(m);
		}else {
			member = service.findPassPhoneService(m);
			passCount = service.findPassPhoneCountService(m);
		}
	}else {
		if(m.getC_number().equals("-")) {
			member = service.findPassEmailService(m);
			passCount = service.findPassEmailCountService(m);
		}else {
			member = service.findPassCnumberService(m);
			passCount = service.findPassCnumberCountService(m);
		}
	}

	
	System.out.println(passCount);
	if(ObjectUtils.isEmpty(member)){
		rttr.addFlashAttribute("msg","입력하신 정보와 매칭되는 정보는 존재하지 않습니다.");
		return "redirect:find_pass";
	}else {
		model.addAttribute("passCount",passCount);
		model.addAttribute("member",member);
		
		return "/member/find_pass_result";
	}
}


@GetMapping("/point_list")
public void pointGet(HttpSession session,Model model) throws Exception{
	String id =(String)session.getAttribute("m_id");
	//사용포인트
	Integer usepoint =sqlsession.selectOne(namespaceOrder+".usedPoint",id);
	if(usepoint==null) {
		usepoint=0;
	}
	
	model.addAttribute("usepoint",usepoint);
	model.addAttribute("point",sqlsession.selectOne(namespace+".point",id));
	model.addAttribute("list",sqlsession.selectList(namespaceOrder+".usePointOrder",id));
}

@GetMapping("/callback")
public void navercallback(MemberVO m) throws Exception{
	logger.info(m.toString());
	
}

@GetMapping("/naverLogin")
public String naverLogin(String email,HttpSession session) throws Exception{
	session.setAttribute("m_id", email);
	
	return "index";
}

@GetMapping("/kakaoLogin")
public String kakaoLogin(String id,HttpSession session) throws Exception{
	session.setAttribute("m_id", id);
	return "index";
}

@PostMapping("/orderNon")
public String orderNon(String orderName,String orderNum,RedirectAttributes rttr) throws Exception{
	
	Map<String, Object> map = new HashMap<String, Object>();
	map.put("od_number", orderNum);
	map.put("name", orderName);
	int count =sqlsession.selectOne(namespaceOrder+".findOrder",map);
	if(count ==0) {
		rttr.addFlashAttribute("msg","해당 정보와 동일한 주문내역은 존재하지 않습니다.");
		return "redirect:login";
	}else {
		return "redirect:/order/orderResult?od_number="+orderNum;
	}
}
}
