package com.mem.model;

import java.util.List;
import java.util.Set;

import com.grp.model.GrpVO;
import com.grp_com.model.Grp_comVO;
import com.grp_mem.model.Grp_memVO;
import com.grp_report.model.Grp_reportVO;
import com.photo.model.Photo_wallVO;
import com.photo_report.model.Photo_reportVO;

public interface MemberDAO_interface {
	public void insert(MemberVO memberVO);
	public void update(MemberVO memberVO);
	public void delete(String mem_Id);
	public MemberVO findByPrimaryKey(String mem_Id) ;
	public List<MemberVO> getAll() ;
	public void update_Member(MemberVO memberVO);
	public MemberVO login_Member(String mem_Account,String mem_Password) ;
	public void Mem_Update_Password(MemberVO memberVO);

//	public void Mem_Forget_Password(String mem_Account,String mem_Password);
//
//	public Set<Grp_memVO>getGrp_memByMem_Id(String mem_Id);
//	public Set<Grp_reportVO>getGrp_reportByMem_Id(String mem_Id);
//	public Set<Grp_comVO>getGrp_comByMem_Id(String mem_Id);
//	public Set<GrpVO>getGrpByMem_Id(String mem_Id);
//	public Set<photo_ReportVO>getphoto_ReportByMem_Id(String mem_Id);
//	public Set<photo_WallVO>getphoto_WallByMem_Id(String mem_Id);

}