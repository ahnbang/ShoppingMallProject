package com.terzobang.member;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	// 회원가입 View
	@RequestMapping("/signUpView")
	public String signUpView() {
		return "/member/signUpIn";
	}
	
	// 로그인 View
	@RequestMapping("/signInView")
	public String signInView() {
		return "/member/signUpIn";	
	}	
	
	// 로그아웃
	@RequestMapping("/signOut")
	public String singOut(HttpSession session) {
		session.removeAttribute("loginMember");
		session.removeAttribute("loginMemberRole");
		session.removeAttribute("loginMemberName");
		return "redirect:/main";
	}

}
