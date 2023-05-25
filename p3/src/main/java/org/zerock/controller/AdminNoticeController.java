package org.zerock.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.Criteria;
import org.zerock.domain.NoticeVO;
import org.zerock.dto.FidNThread;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/notice")
public class AdminNoticeController {
	
	@Inject
	SqlSession sqlsession;
	
	private static String namespace = "org.zerock.mapper.AdminNoticeMapper";
	
	@Resource(name = "uploadPath")
	private String uploadPath;
	
	// UUID 중복되지 않는 고유한 키 값을 설정할 때 사용
		// uploadFile()은 원본 파일의 이름과 파일 데이터를 byte[]로 변환한 정보를 파라미터로 처리해서 실제로 파일 업로드한다.
		private String uploadFile(String originalName, byte[] fileData) throws Exception {
			UUID uid = UUID.randomUUID();
			String savedName = uid.toString() + "_" + originalName;

			// import java.io.File;
			File target = new File(uploadPath, savedName);

			// FileCopyUtils는 'org.springframework.util' 패키지에 설정된 클래스(실제 파일 처리)
			FileCopyUtils.copy(fileData, target);

			return savedName;
		}
	
	@GetMapping("/list")
	public void listGet(String option,Model model,Criteria cri) throws Exception{
		cri.setPerPageNum(20);
		String menu ="";
		
		if(option.equals("faq")) {
			menu="menu12";
		}else if(option.equals("qna")) {
			menu="menu13";
		}else if(option.equals("gongji")) {
			menu="menu14";
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cri",cri);
		map.put("gongji", option);
		
		model.addAttribute("option",option);
		model.addAttribute("menu",menu);
		model.addAttribute("list",sqlsession.selectList(namespace+".listAll",map));
	}
	@GetMapping("/write")
	public void writeGet(String option,Model model) throws Exception{
		String menu ="";
		
		
		if(option.equals("faq")) {
			menu="menu12";
		}else if(option.equals("qna")) {
			menu="menu13";
		}else if(option.equals("gongji")) {
			menu="menu14";
		}
		
		model.addAttribute("option",option);
		model.addAttribute("menu",menu);	
	
	}
	@PostMapping("/write")
	public String writePost(MultipartFile file,NoticeVO n,HttpSession session) throws Exception{
		String id= (String)session.getAttribute("m_id");
		String name = (String)session.getAttribute("m_name");
		
		Date today = new Date();
		SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String signdate = cal.format(today);
		
		int fid = 1;
		Integer fid_max = sqlsession.selectOne(namespace + ".fidCheck");
		if (fid_max != null && fid_max > 0) {
		    fid = fid_max + 1;
		}

		String savedName="";
		if(file.getSize() >0) {
		 savedName = uploadFile(file.getOriginalFilename(), file.getBytes());
		 n.setFile1(savedName);
		}
		n.setName(name);
		n.setId(id);
		n.setFid(fid);
		n.setSigndate(signdate);
		
		
		sqlsession.insert(namespace+".write",n);
		
		return "redirect:list?option="+n.getGongji();
	}
	@GetMapping("/modify")
	public void modifyGet(int n_uid,Model model) throws Exception{
		model.addAttribute("one",sqlsession.selectOne(namespace+".view",n_uid));
		
	}
	//게시글 수정
	@PostMapping("/modify")
	public String modifyPost(MultipartFile file,NoticeVO n,RedirectAttributes rttr) throws Exception{
		
		String savedName = uploadFile(file.getOriginalFilename(), file.getBytes());
		if(savedName != null) {
			n.setFile1(savedName);
		}
		
		
		sqlsession.update(namespace+".modify",n);
		rttr.addFlashAttribute("msg","수정되었습니다.");
		
		return "redirect:list?option="+n.getGongji();
	}
	//게시글 삭제
	@GetMapping("/delete")
	public String delteNotice(int n_uid,String option,RedirectAttributes rttr) throws Exception{
		
		sqlsession.delete(namespace+".delete",n_uid);
		rttr.addFlashAttribute("msg","삭제되었습니다.");
		return "redirect:list?option="+option;
	}
	//1:1문의 글 보기
	@GetMapping("/view")
	public void viewGet(int n_uid,Model model) throws Exception{
		model.addAttribute("one",sqlsession.selectOne(namespace+".view",n_uid));
	}
	
	//답변페이지 이동
	@GetMapping("/reply")
	public void replyGet(int n_uid,Model model) throws Exception{
		model.addAttribute("one",sqlsession.selectOne(namespace+".view",n_uid));
		
	}
	//답변등록
	@PostMapping("/reply")
	public String replyPost(NoticeVO vo,FidNThread fnt,RedirectAttributes rttr,HttpSession session) throws Exception{
		String id = (String)session.getAttribute("m_id");
		String name = (String)session.getAttribute("m_name");
		
		Date today = new Date();
		SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String signdate = cal.format(today);
		
		//String threadCheck =sqlsession.selectOne(namespace+".threadCheck",fnt); 
		//log.info("기존 thread="+threadCheck);
		
		vo.setThread(vo.getThread()+"A");
		vo.setId(id);
		vo.setName(name);
		vo.setRe_date(signdate);
		vo.setSubject("[RE]"+vo.getSubject());
		
		log.info(vo.toString());
		sqlsession.insert(namespace+".reply",vo);
		sqlsession.update(namespace+".updateStatus",vo.getFid());
		
		
		return "redirect:list?option=qna";
	}
	
}
