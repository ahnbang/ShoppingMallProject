package com.terzobang;

import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.transaction.annotation.Transactional;

import com.terzobang.member.bo.MemberBO;
import com.terzobang.member.dao.MemberDAO;
import com.terzobang.member.model.Member;
import com.terzobang.member.model.MemberRole;
@SpringBootTest

public class MemberServiceTest {
	@Autowired PasswordEncoder passwordEncoder;
	@Autowired MemberBO memberBO;
	@Autowired MemberDAO memberDAO;
	
	// Given Test Parameter
	String loginId = "kimLoginId";
	String password = "kimPassword";
	String name = "kim";
	String email = "kim@gmail.com";
	String addressStreet = "서울시";
	String addressDetail = "어딘가";
	
	@Test
	@DisplayName("회원 가입 테스트")
	@Transactional
	// MemberBO - createMember Method Test
	void 회원가입() throws Exception{
		
		//Given
		Member testMember = new Member();
				
		
		//When
		memberBO.createMember(loginId, password, name,  email,  addressStreet,addressDetail);
		testMember = memberDAO.selectMemberByMemberName(name);
		
		//Then
		
		assertEquals(name, testMember.getName());
		assertEquals(MemberRole.USER, testMember.getRole()); // default roleType이 enum 인지 check
		
	}
	@Test
	@DisplayName("암호화 테스트")
	@Transactional
	// passwordEncoder Test
	void 비밀번호암호화() throws Exception {
	
		// given
		Member testMember = new Member();
	
	    // when
		memberBO.createMember(loginId, password, name,  email,  addressStreet,addressDetail);
		String encodedPassword = memberDAO.selectMemberByMemberName(name).getPassword();
		

	    // then
	    assertAll(
	            () -> assertNotEquals(password, encodedPassword), // 암호화 전후 같으면 안됨
	            () -> assertTrue(passwordEncoder.matches(password, encodedPassword)) // 복호화시 같아야함
	            
	      );
	   } 
	
	
	}