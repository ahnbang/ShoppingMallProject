package com.terzobang.member.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.terzobang.member.model.Member;
import com.terzobang.member.model.MemberRole;

@Repository
public interface MemberDAO {
	
	// 회원가입 - 회원 정보 insert
	public int insertMember(
			@Param("name") String name,
			@Param("address") String address,
			@Param("loginId") String loginId,
			@Param("password") String password,
			@Param("email") String email,
			@Param("role") MemberRole memberRole);
	
	public int vaildateLoginId(String loginId);
	
	public Member selectMemberByLoginId(String loginId);
	
	public Member selectMemberByMemberName(String name);
	
	public Member selectMemberByMemberId(int id);
	
	public List<Member> selectAllMember();
	
	public List<Member> selectAllAdmin();
	
	
}
