package org.zerock.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.zerock.domain.CartVO;
import org.zerock.domain.ItemVO;
import org.zerock.domain.SelectVO;

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
			model.addAttribute("count",sqlsession.selectOne(namespace+".listCount",id));
			model.addAttribute("list",sqlsession.selectList(namespace+".listCart",id));
		}else {
			model.addAttribute("count",sqlsession.selectOne(namespace+".listCountNon",o_id));
			model.addAttribute("list",sqlsession.selectList(namespace+".listCartNon",o_id));
		}
		
	}
	@PostMapping("/list")
	public String listPost(int uid,int ct_uid) throws Exception{
//		CartVO vo = new CartVO();
//		vo.setUid(uid);
//		vo.setCt_uid(ct_uid);
//		sqlsession.update(namespace+".updatePath",vo);
		
		return "redirect:/order/orderForm?ct_uid="+ct_uid;
	}

	@GetMapping("/insert")
	public String cartInsert(int uid,String color,String path,HttpSession session) throws Exception{
		Date today = new Date();
		SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd- hh:mm:ss");
		String signdate = cal.format(today);
			
		String id = (String)session.getAttribute("m_id");
		String o_id = (String)session.getAttribute("cart");
		
		ItemVO it = sqlsession.selectOne(namespace+".itemInfo",uid);
									
		CartVO c = new CartVO();

		if(path.equals("order")) {
			sqlsession.delete(namespace+".deleteBaro",id);
		}
		
		if(id ==null) {
			c.setO_id(o_id);
			
		}else {
			c.setId(id);
			
		}
		
		c.setS_id(it.getS_id());
		c.setSigndate(signdate);
		
		c.setUid(uid);
		c.setPrice(it.getPrice());
		c.setQty(1);
		c.setColor(color);
		c.setFile1(it.getFile1());
		c.setSubject(it.getSubject());
		if(path.equals("cart")) {
			c.setCt_type("장바구니");
		}else if(path.equals("order")){
			c.setCt_type("바로구매");
		}
		
		//장바구니에 상품있는지 확인
		int countCart =sqlsession.selectOne(namespace+".cartCheck",c);
		if(countCart ==0) {
			sqlsession.insert(namespace+".cartInsert",c);
		}else {
			sqlsession.update(namespace+".qtyUpdate",c);
		}
		
		int ct_uid = sqlsession.selectOne(namespace+".cartPrimaryKey",c);
		System.out.println(ct_uid);
		
		if(path.equals("cart")) {
			return "redirect:/cart/list";
		}else {
			return "redirect:/order/orderForm?ct_uid="+ct_uid;
		}
		
	}
	
	@GetMapping("/insert2")
	public String insert2Get(int uid, String color,String path,HttpSession session) throws Exception{
		
		log.info("==========insetrt2======");
		
		String[] color_ch = color.split(",");
			
		String ct_uids ="";
		Date today = new Date();
		SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd- hh:mm:ss");
		String signdate = cal.format(today);
	
		String id = (String)session.getAttribute("m_id");
		String o_id = (String)session.getAttribute("cart");
		ItemVO it = sqlsession.selectOne(namespace+".itemInfo",uid);
		
		if(path.equals("order")) {
			sqlsession.delete(namespace+".deleteBaro",id);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uid", uid);
		CartVO c = new CartVO();
		
		if(id ==null) {
			c.setO_id(o_id);
			map.put("o_id", o_id);
		}else {
			c.setId(id);
			map.put("id", id);
		}
		log.info(map.toString());
		
			for(int i=0;i<color_ch.length;i++) {
				map.put("color",color_ch[i]);
				
				int qty_ch = sqlsession.selectOne(namespace+".checkColor",map);
				
				c.setS_id(it.getS_id());
				c.setSigndate(signdate);
				c.setUid(uid);
				c.setColor(color_ch[i]);
				c.setPrice(it.getPrice());
				c.setQty(qty_ch);
				c.setFile1(it.getFile1());
				c.setSubject(it.getSubject());
				
				if(path.equals("cart")) {
					c.setCt_type("장바구니");
				}else if(path.equals("order")){
					c.setCt_type("바로구매");
				}
				map.put("c", c);
				int count =sqlsession.selectOne(namespace+".cartCheck2",map);
				if(count ==0) {
					sqlsession.insert(namespace+".cartInsert",c);
				}else {
					sqlsession.update(namespace+".qtyUpdate2",c);
				}
				ct_uids +=sqlsession.selectOne(namespace+".cartPrimaryKey",c)+",";
				sqlsession.delete(namespace+".deleteSelect",map);
				map.remove("color");
			}
			
			if(path.equals("cart")) {
				return "redirect:/cart/list";
			}else {
				return "redirect:/order/orderForm?ct_uids="+ct_uids;
			}
	}
	@GetMapping("/delete")
	public String deleteCart(int ct_uid,HttpSession session) throws Exception{
		String id=(String)session.getAttribute("m_id");
		String o_id=(String)session.getAttribute("cart");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("o_id", o_id);
		map.put("ct_uid", ct_uid);
	
		sqlsession.delete(namespace+".delete",map);
		return "redirect:list";
	}
	
	@GetMapping("/allDeleteCart")
	public String allDeleteCartget(String pathname,HttpSession session) throws Exception{
		String id = (String)session.getAttribute("m_id");
		String o_id = (String)session.getAttribute("cart");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("o_id", o_id);
		
		sqlsession.delete(namespace+".deleteAll",map);
		
		
		return "redirect:"+pathname;
	}
	
}
