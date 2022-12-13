package com.terzobang.member.bo;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.terzobang.cart.bo.CartBO;
import com.terzobang.common.response.Response;
import com.terzobang.common.response.ResponseUtil;
import com.terzobang.member.dao.MemberDAO;
import com.terzobang.member.model.Member;

@Service
@Transactional
public class MemberBO {
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	private MemberDAO memberDAO;
	
	@Autowired
	private CartBO cartBO;
	
	private Logger log = LoggerFactory.getLogger(MemberBO.class);
	
	// Member Create Service
	@Transactional
	public Response createMember(String loginId, String password, String name, String email, String addressStreet, String addressDetail) {
		
		String address = addressStreet + " " + addressDetail;
		String encodedPassword = passwordEncoder.encode(password);
		
		int row =  memberDAO.insertMember(name, address, loginId, encodedPassword, email);
		
		if(row == 1) {
			Member member = memberDAO.selectMemberByLoginId(loginId);
			cartBO.createCart(member.getId());
			
			return ResponseUtil.SUCCESS("회원가입에 성공했습니다. 로그인을 해주세요", 301);
		}
		else {
			log.warn("결과 row가 1개 이상입니다.");
			return ResponseUtil.FAIL("회원가입에 실패했습니다. 관리자에게 문의 부탁드립니다.", 500);
		}
	}
	
	// Vaildate Duplicate LoginId Service
	@Transactional
	public Response vaildateDuplicateLoginId(String loginId) {
		
		int row = memberDAO.vaildateLoginId(loginId);
		
		if (row > 0) {
			return ResponseUtil.FAIL("이미 존재하는 아이디입니다.", null);
		}
		else
			return ResponseUtil.SUCCESS("사용가능한 아이디입니다.", null);
	}
	
	// Login Check Service
	@Transactional
	public Response loginCheck(String loginIdForLogin, String passwordForLogin) {
		
		Member loginMember = new Member();
		loginMember = memberDAO.selectMemberByLoginId(loginIdForLogin);
		
		if (loginMember != null) {
			if(passwordEncoder.matches(passwordForLogin, loginMember.getPassword())) {
				return ResponseUtil.SUCCESS("로그인에성공했습니다.", loginMember); 
			}
			else { 
				return ResponseUtil.FAIL("비밀번호가 일치하지 않습니다.", null); 
			}
		}
		else {
			return ResponseUtil.FAIL("일치하는 아이디가 없습니다",  null);
		}
		
	}
	@Transactional
	public List<Member> getAllMember(){
		return memberDAO.selectAllMember();
	}
	@Transactional
	public List<Member> getAllAdmin(){
		return memberDAO.selectAllAdmin();
	}
	
}
