package org.zerock.controller;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class GoogleAuthentication extends Authenticator{
	PasswordAuthentication passAuth;

	public GoogleAuthentication() { 
		passAuth = new PasswordAuthentication("pay5390@gmail.com","gpzvpibttjkrpzql");
		//gmail 아이디(메일주소), 앱 비밀번호(2단계 인증) 발급받은 16자리
	}

	public PasswordAuthentication getPasswordAuthentication() {
		
		return passAuth;
	}
}
