package org.zerock.controller;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.ItemVO;
import org.zerock.domain.JjimVO;
import org.zerock.service.ItemService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/item")
public class JjimController {
	
	@Inject
	ItemService service;

	@Inject
	SqlSession sqlsession;
	
	private static String namespace = "org.zerock.mapper.JjimMapper";
	
	//찜 추가
		@GetMapping("/jjim_insert")
		public String jjimInsert(int uid,String pathname, HttpSession session,RedirectAttributes rttr) throws Exception{
			log.info("=========pathname="+pathname);
			String id = (String)session.getAttribute("m_id");
						
			java.util.Date today = new java.util.Date();
			SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String signdate = cal.format(today);
			
			JjimVO vo = new JjimVO();
			vo.setUid(uid);
			vo.setId(id);
			vo.setSigndate(signdate);
			int count = sqlsession.selectOne(namespace+".jjimCount",vo);
			if(count ==0) {			
			sqlsession.insert(namespace+".jjimInsert",vo);
				rttr.addFlashAttribute("msg","관심상품으로 등록되었습니다.");
			}else {
				rttr.addFlashAttribute("msg","관심상품으로 등록되어 있는 상품입니다.");
			}
			if(pathname.equals("/item/view")) {
				return "redirect:"+pathname+"?uid="+uid;
			}else {
				return "redirect:"+pathname;
			}
			
		
		}
		//찜 목록 출력
		@GetMapping("/jjim_list")
		public void jjimListGet(HttpSession session,Model model) throws Exception{
			String id =(String)session.getAttribute("m_id");
								
			model.addAttribute("list",sqlsession.selectList(namespace+".listAll",id));
			
		}
		
		//찜->카트담기 팝업
		@GetMapping("/jjimCartSelection")
		public void popUpGet(int uid,Model model,HttpSession session) throws Exception{
			String id = (String)session.getAttribute("m_id");
			ItemVO vo = service.viewService(uid);
			
			//금액처럼 변환
			DecimalFormat formatter = new DecimalFormat("###,###");
			String price1 = formatter.format(vo.getPrice());
			
			if(vo.getColor().contains(",")) {
				ArrayList<String> list = new ArrayList<String>();
				String[] color_ch = vo.getColor().split(",");
				for(int i=0;i<color_ch.length;i++) {
					list.add(color_ch[i]);
				}
				model.addAttribute("color_list",list);
			}
			Map<String, Object> map =  new HashMap<String, Object>();
			map.put("uid", uid);
			map.put("id", id);
			
			model.addAttribute("list",service.listAllSelectService(map));
			model.addAttribute("price1",price1);
			model.addAttribute("vo",vo);  //상품 정보
		}
		@GetMapping("/delete")
		public String deleteGet(int j_uid,HttpSession session) throws Exception{
			String id=(String)session.getAttribute("m_id");
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("j_uid", j_uid);
			map.put("id", id);
			sqlsession.delete(namespace+".delete",map);
			return "redirect:list";
		}
		
		@GetMapping("/allDeletejjim")
		public String allDeletejjimGet(String pathname,HttpSession session) throws Exception{
			String id = (String)session.getAttribute("m_id");
					
			sqlsession.delete(namespace+".deleteAll",id);
					
			return "redirect:"+pathname;
		}
}
