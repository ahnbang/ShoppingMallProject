package com.terzobang.member.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.terzobang.member.model.Member;

@Repository
public interface MemberDAO {
	
	// 회원가입 - 회원 정보 insert
	public int insertMember(
			@Param("name") String name,
			@Param("address") String address,
			@Param("loginId") String loginId,
			@Param("password") String password,
			@Param("email") String email);
	
	public int vaildateLoginId(String loginId);
	
	public Member selectMemberByLoginId(String loginId);
	
	public Member selectMemberByMemberName(String name);
	
	public Member selectMemberByMemberId(int id);
	
	
}
