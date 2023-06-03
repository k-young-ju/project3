package org.zerock.service;

import java.net.URI;
import java.net.URISyntaxException;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;
import org.zerock.domain.KakaoPayApprovalVO;
import org.zerock.domain.KakaoPayReadyVO;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class KakaoPay {
	 private static final String HOST = "https://kapi.kakao.com";
	    
	    private KakaoPayReadyVO kakaoPayReadyVO;
	    private KakaoPayApprovalVO kakaoPayApprovalVO;
	    
	    public String kakaoPayReady(String price,String qty,String subject) {
	 
	        RestTemplate restTemplate = new RestTemplate();
	 
	        // 서버로 요청할 Header
	        HttpHeaders headers = new HttpHeaders();
	        headers.add("Authorization", "KakaoAK " + "47b5baa3c8656ecd5f08104227dc45c5");
	        headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
	        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
	        
	        // 서버로 요청할 Body
	        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
	        params.add("cid", "TC0ONETIME");
	        params.add("partner_order_id", "1001");
	        params.add("partner_user_id", "gorany");
	        params.add("item_name", subject);
	        params.add("quantity", qty);
	        params.add("total_amount", price);
	        params.add("tax_free_amount", "100");
	        params.add("approval_url", "http://192.168.0.16:8080/kakaoPaySuccess");
	        params.add("cancel_url", "http://192.168.0.16:8080/kakaoPayCancel");
	        params.add("fail_url", "http://192.168.0.16:8080/kakaoPaySuccessFail");
	 
	         HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
	 
	        try {
	            kakaoPayReadyVO = restTemplate.postForObject(new URI(HOST + "/v1/payment/ready"), body, KakaoPayReadyVO.class);
	            
	            log.info("" + kakaoPayReadyVO);
	            
	            return kakaoPayReadyVO.getNext_redirect_pc_url();
	 
	        } catch (RestClientException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        } catch (URISyntaxException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        }
	        
	        return "/pay";
	        
	    }
	    
	    public KakaoPayApprovalVO kakaoPayInfo(String pg_token) {
	 
	        log.info("KakaoPayInfoVO............................................");
	        log.info("-----------------------------");
	        
	        RestTemplate restTemplate = new RestTemplate();
	 
	        // 서버로 요청할 Header
	        HttpHeaders headers = new HttpHeaders();
	        headers.add("Authorization", "KakaoAK " + "47b5baa3c8656ecd5f08104227dc45c5");
	        headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
	        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
	 
	        // 서버로 요청할 Body
	        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
	        params.add("cid", "TC0ONETIME");
	        params.add("tid", kakaoPayReadyVO.getTid());
	        params.add("partner_order_id", "1001");
	        params.add("partner_user_id", "gorany");
	        params.add("pg_token", pg_token);
	        params.add("total_amount", "2100");
	        
	        HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
	        
	        try {
	            kakaoPayApprovalVO = restTemplate.postForObject(new URI(HOST + "/v1/payment/approve"), body, KakaoPayApprovalVO.class);
	            log.info("" + kakaoPayApprovalVO);
	          
	            return kakaoPayApprovalVO;
	        
	        } catch (RestClientException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        } catch (URISyntaxException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        }
	        
	        return null;
	    }
}
