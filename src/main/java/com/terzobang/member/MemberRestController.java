package com.terzobang.member;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.terzobang.common.response.Response;
import com.terzobang.common.response.ResponseStatus;
import com.terzobang.member.bo.MemberBO;
import com.terzobang.member.model.Member;

@RestController
@RequestMapping("/member")
public class MemberRestController {
	
	@Autowired
	private MemberBO memberBO;
	
	
	// 회원가입 
	@RequestMapping("/signUp")
	public Response signUp(
			@RequestParam("loginId") String loginId,
			@RequestParam("password") String password,
			@RequestParam("name") String name,
			@RequestParam("email") String email,
			@RequestParam("addressStreet") String addressStreet,
			@RequestParam("addressDetail") String addressDetail) {
		
		return memberBO.createMember(loginId, password, name, email, addressStreet, addressDetail);
	}
	
	// 회원가입시 아이디 중복 검사
	@RequestMapping("/vaildateDuplicateLoginId")
	public Response vaildateDuplicateLoginId(@RequestParam("loginId") String loginId){
		
		return memberBO.vaildateDuplicateLoginId(loginId);	
	}
	
	@RequestMapping("/signIn")
	public Response signIn(
			@RequestParam("loginIdForLogin") String loginIdForLogin,
			@RequestParam("passwordForLogin") String passwordForLogin,
			HttpSession session) {
		
		Response result = memberBO.loginCheck(loginIdForLogin, passwordForLogin);
		if (result.getStatus() == ResponseStatus.SUCCESS) {
			Member loginMember = (Member) result.getData();
			session.setAttribute("loginMember", loginMember);
			session.setAttribute("loginMemberRole", loginMember.getRole().toString());
			session.setAttribute("loginMemberName", loginMember.getName());
			return result;
		}
		else {
			return result;
		}
			
	}
}
