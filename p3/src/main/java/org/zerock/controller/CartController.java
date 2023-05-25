package org.zerock.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.zerock.domain.CartVO;
import org.zerock.domain.ItemVO;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/cart")
public class CartController {

		
	@Inject
	SqlSession sqlsession;
	
	private static String namespace = "org.zerock.mapper.CartMapper";
	
	@GetMapping("/list")
	public void listGet(Model model,HttpSession session) throws Exception{
		String id =(String)session.getAttribute("m_id");
		String o_id =(String)session.getAttribute("cart");
		if(id !=null) {
			model.addAttribute("list",sqlsession.selectList(namespace+".listCart",id));
		}else {
			model.addAttribute("list",sqlsession.selectList(namespace+".listCartNon",o_id));
		}
		
	}
	

	@GetMapping("/insert")
	public String cartInsert(int uid,HttpSession session) throws Exception{
		Date today = new Date();
		SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd- hh:mm:ss");
		String signdate = cal.format(today);
	
		String id = (String)session.getAttribute("m_id");
		ItemVO it = sqlsession.selectOne(namespace+".itemInfo",uid);
		
		CartVO c = new CartVO();
		
		if(id ==null) {
			String o_id = (String)session.getAttribute("cart");
			c.setO_id(o_id);
		}else {
			c.setId(id);
		}
		c.setS_id(it.getS_id());
		c.setSigndate(signdate);
		c.setUid(uid);
		c.setPrice(it.getPrice());
		c.setQty(1);
		c.setFile1(it.getFile1());
		c.setSubject(it.getSubject());
		
		sqlsession.insert(namespace+".cartInsert",c);
		return "redirect:/cart/list";
	}
}
