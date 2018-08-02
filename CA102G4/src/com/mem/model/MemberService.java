package com.mem.model;

import java.sql.Date;
import java.util.List;

public class MemberService {

	private MemberDAO_interface dao;

	public MemberService() {
		dao = new MemberDAO();
	}

	public MemberVO addMember(String mem_Account, String mem_Password,String mem_Name,Integer mem_State) {

		MemberVO memberVO = new MemberVO();
		memberVO.setMem_Name(mem_Name);
		memberVO.setMem_Account(mem_Account);
		memberVO.setMem_Password(mem_Password);
		memberVO.setMem_State(mem_State);

		dao.insert(memberVO);

		return memberVO;
	}

	//預留給 Struts 2 用的
	public void addMember(MemberVO memberVO) {
		dao.insert(memberVO);
	}
	
	
	
	public MemberVO updateMember(String mem_Id,String mem_Name
			,String mem_Phone,Integer mem_Sex,Date mem_Birthday
			,byte[] mem_Photo
			,String mem_Profile) {
		

		MemberVO memberVO = new MemberVO();
		memberVO.setMem_Id(mem_Id);
		memberVO.setMem_Name(mem_Name);
		memberVO.setMem_Phone(mem_Phone);
		memberVO.setMem_Sex(mem_Sex);
		memberVO.setMem_Birthday(mem_Birthday);
		memberVO.setMem_Photo(mem_Photo);
		memberVO.setMem_Profile(mem_Profile);

		dao.update_Member(memberVO);

		return memberVO;
	}

	//預留給 Struts 2 用的
	public void updateMember(MemberVO MemberVO) {
		dao.update_Member(MemberVO);
	}
	
	
	
	public MemberVO mem_Update_Password(String mem_Account, String mem_Password){
		
		MemberVO memberVO = new MemberVO();
		
		memberVO.setMem_Account(mem_Account);
		memberVO.setMem_Password(mem_Password);

		dao.Mem_Update_Password(memberVO);
		
		return memberVO;
	}
	

	

	public void deleteMember(String mem_Id) {
		dao.delete(mem_Id);
	}

	public MemberVO getOneMember(String mem_Id) {
		return dao.findByPrimaryKey(mem_Id);
	}

	public List<MemberVO> getAll() {
		return dao.getAll();
	}
	
//	public MemberVO Login_Member(String mem_Account, String mem_Password) {
//
//		MemberVO memberVO = new MemberVO();
//		memberVO.setMem_Account(mem_Account);
//		memberVO.setMem_Password(mem_Password);
//		return dao.login_Member(memberVO);
//	}
	
}

