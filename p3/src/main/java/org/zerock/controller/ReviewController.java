package org.zerock.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import org.zerock.domain.ReviewVO;
import org.zerock.service.ItemService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/review")
public class ReviewController {
	
	@Inject
	SqlSession sqlsession;
	
	private static String namespace = "org.zerock.mapper.ReviewMapper";
	
	@Inject
	ItemService iservice;
	
	

	@Resource(name = "uploadPath")

	private String uploadPath;
	
	@GetMapping("/write")
	public void writeGet(int uid, Model model) throws Exception{
		model.addAttribute("vo",iservice.viewService(uid));
	}
	
	@PostMapping("/write")
	public String writePost(MultipartFile file,ReviewVO vo,HttpSession session,RedirectAttributes rttr) throws Exception{
		String id = (String)session.getAttribute("m_id");
		String name = (String)session.getAttribute("m_name");
		Date today = new Date();
		SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd- hh:mm:ss");
		String signdate = cal.format(today);
		
	
		
		String savedName = uploadFile(file.getOriginalFilename(), file.getBytes());
		if(file.getSize() > 0) {
			vo.setFile1(savedName);
		}

		vo.setSigndate(signdate);
		vo.setId(id);
		vo.setName(name);
		log.info(vo.toString());
		sqlsession.insert(namespace+".insertReview",vo);
		
		rttr.addFlashAttribute("msg","리뷰가 등록되었습니다.");
		return "redirect:list";
	}
	@GetMapping("/list")
	public void listGet(Criteria cri,Model model) throws Exception{
			
		model.addAttribute("list",sqlsession.selectList(namespace+".listAll",cri));
	}
	
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
		@GetMapping("/view")
		public void viewGet(int r_uid,int uid,Model model) throws Exception{
						
			model.addAttribute("item",iservice.viewService(uid));
			model.addAttribute("vo",sqlsession.selectOne(namespace+".view",r_uid));
		}
		@GetMapping("/modify")
		public void modfiyGet(int r_uid,int uid,Model model) throws Exception{
			model.addAttribute("vo",sqlsession.selectOne(namespace+".view",r_uid));
			model.addAttribute("item",iservice.viewService(uid));
		}
		
		@PostMapping("/modify")
		public String modifyPost(MultipartFile file,ReviewVO vo,RedirectAttributes rttr) throws Exception{
			
			String savedName = uploadFile(file.getOriginalFilename(), file.getBytes());
			if(file.getSize() > 0) {
				vo.setFile1(savedName);
			}
			sqlsession.update(namespace+".updateReview",vo);
			rttr.addFlashAttribute("msg","수정되었습니다.");
			return "redirect:list";
		}
}
