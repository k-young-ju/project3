package org.zerock.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.AddrVO;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/addr")
public class AddrController {
	
	@Inject
	SqlSession sqlsession;
	
	private static String namespace = "org.zerock.mapper.AddrMapper";
	
	@GetMapping("/list")
	public void listGet(HttpSession session,Model model) throws Exception{
		String id = (String)session.getAttribute("m_id");
		
		model.addAttribute("count",sqlsession.selectOne(namespace+".countAddr",id));
		model.addAttribute("list",sqlsession.selectList(namespace+".listAll",id));
		
	}
	@GetMapping("/write")
	public void writeGet() throws Exception{
		
	}
	@PostMapping("/write")
	public String wirtePost(AddrVO vo,HttpSession session,RedirectAttributes rttr) throws Exception{
		String id = (String)session.getAttribute("m_id");
		vo.setId(id);
		log.info(vo);
		sqlsession.insert(namespace+".insertAddr",vo);
		rttr.addFlashAttribute("msg","등록되었습니다.");
		return "redirect:list";
	}
	
	@GetMapping("/modify")
	public void modifyGet(int ad_uid,Model model) throws Exception{
		AddrVO vo = sqlsession.selectOne(namespace+".oneAddr",ad_uid);
		String[] phone_ch =vo.getPhone().split("-");
		
		model.addAttribute("phone1",phone_ch[0]);
		model.addAttribute("phone2",phone_ch[1]);
		model.addAttribute("phone3",phone_ch[2]);
		model.addAttribute("vo",vo);
	}
	@PostMapping("/modify")
	public String modifyPost(AddrVO vo,HttpSession session,RedirectAttributes rttr) throws Exception{
		String id = (String)session.getAttribute("m_id");
		vo.setId(id);
		log.info(vo);
		sqlsession.update(namespace+".modify",vo);
		rttr.addFlashAttribute("msg","수정되었습니다.");
		return "redirect:modify?ad_uid="+vo.getAd_uid();
	}
	
	@GetMapping("/delete")
	public String deleteAddr(int ad_uid,RedirectAttributes rttr) throws Exception{
		log.info("======delete======");
		sqlsession.delete(namespace+".deleteAddr",ad_uid);
		
		rttr.addFlashAttribute("msg","삭제되었습니다.");
		return "redirect:list";
	}
	
	@GetMapping("/selectList")
	public void selectListGet(HttpSession session,Model model) throws Exception{
		String id = (String)session.getAttribute("m_id");
		
		model.addAttribute("count",sqlsession.selectOne(namespace+".countAddr",id));
		model.addAttribute("list",sqlsession.selectList(namespace+".listAll",id));
	}
}
