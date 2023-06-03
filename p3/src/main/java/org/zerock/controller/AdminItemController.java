package org.zerock.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.Criteria;
import org.zerock.domain.ItemVO;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/admin/item")
@Log4j
public class AdminItemController {
	private static final Logger logger = LoggerFactory.getLogger(AdminItemController.class);
	
		
	@Inject
	SqlSession sqlsession;
	
	private static String namespace = "org.zerock.mapper.AdminItemMapper";

	// 첨부파일 저장 경로
	// servlet-context.xml에 있는 bean id="uploadPath" 경로 매칭
	@Resource(name = "uploadPath")
	private String uploadPath;
			
	
	@GetMapping("/list")
	public void adminItemListGet(Criteria cri, Model model) throws Exception{
		String menu = "menu4";
		
		model.addAttribute("menu",menu);
		model.addAttribute("list",sqlsession.selectList(namespace+".listAll",cri));
	}
	
	@GetMapping("/register")
	public void registerGet(Model model) throws Exception{
			logger.info("============= register : get ================");
			String menu = "menu3";
			model.addAttribute("menu",menu);
	}

	//한글 파일 이름이 깨진다면 web.xml에 한글 처리용 필터를 적용
	@PostMapping("/register")
	public String registerPost(MultipartFile[] file, ItemVO vo,RedirectAttributes rttr) throws Exception {
		String savedName[] = new String[file.length];  //저장 파일명 배열 처리
		logger.info("============= register : post ================");
		
		Date today = new Date();
		SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd- hh:mm:ss");
		String signdate = cal.format(today);
		
		vo.setSigndate(signdate);
	
		
		System.out.println("파일길이="+file.length);
		for(int i=0; i<file.length; i++) {

			if(file[i].getSize() > 0) { //파일크기가 0보다 크다면 : 파일 유무

//				logger.info("originalName: " + file[i].getOriginalFilename());
//				logger.info("size: " + file[i].getSize()); //byte 단위
//				logger.info("contentType: " + file[i].getContentType());

				int num = (int)(Math.random()*100000);

				savedName[i] = num + "_" + file[i].getOriginalFilename(); //랜덤숫자_파일명 처리
				byte[] fileData = file[i].getBytes();

//				logger.info("============= savedName["+i+"] ====:"+savedName[i]);

				File target = new File(uploadPath, savedName[i]);

				FileCopyUtils.copy(fileData, target); //파일 업로드
			}
		}
		vo.setFile1(savedName[0]);
		vo.setFile2(savedName[1]);
		vo.setFile3(savedName[2]);
		vo.setFile4(savedName[3]);
		vo.setFile5(savedName[4]);
		
		logger.info(vo.toString());
		
		sqlsession.insert(namespace+".register",vo);
		
		
		rttr.addFlashAttribute("msg","상품이 등록되었습니다.");
		rttr.addFlashAttribute("menu","menu4");
		rttr.addFlashAttribute("option","itemList");

		return "redirect:list";
	}
	
	@GetMapping("/modify")
	public void modifyGet(int uid,Model model) throws Exception{
		System.out.println(uid);
		String menu = "menu4";
		
		model.addAttribute("menu",menu);
		model.addAttribute("oneItem",sqlsession.selectOne(namespace+".oneItem",uid));
		
	}
	
	@PostMapping("/modify")
	public String modifyPost(MultipartFile[] file, ItemVO vo,RedirectAttributes rttr) throws Exception{
		logger.info(vo.toString());
		String savedName[] = new String[file.length];  //저장 파일명 배열 처리
				
		System.out.println("파일길이="+file.length);
		for(int i=0; i<file.length; i++) {

			if(file[i].getSize() > 0) { //파일크기가 0보다 크다면 : 파일 유무

				logger.info("originalName: " + file[i].getOriginalFilename());
				logger.info("size: " + file[i].getSize()); //byte 단위
				logger.info("contentType: " + file[i].getContentType());

				int num = (int)(Math.random()*100000);

				savedName[i] = num + "_" + file[i].getOriginalFilename(); //랜덤숫자_파일명 처리
				byte[] fileData = file[i].getBytes();

				logger.info("============= savedName["+i+"] ====:"+savedName[i]);

				File target = new File(uploadPath, savedName[i]);

				FileCopyUtils.copy(fileData, target); //파일 업로드
			}
		}
		
			vo.setFile1(savedName[0]);
			vo.setFile2(savedName[1]);
			vo.setFile3(savedName[2]);
			vo.setFile4(savedName[3]);
			vo.setFile5(savedName[4]);
		
				
		logger.info(vo.toString());
				
		sqlsession.update(namespace+".modify",vo);
		
		rttr.addFlashAttribute("msg","상품이 수정되었습니다.");
	
		return "redirect:list?uid="+vo.getUid();
	}
	@GetMapping("/jjim_list")
	public void jjimList(Criteria cri,Model model) throws Exception{
		
		String menu = "menu5";
		
		model.addAttribute("menu",menu);
		model.addAttribute("list",sqlsession.selectList(namespace+".listJjim",cri));
		
	}
	
}
