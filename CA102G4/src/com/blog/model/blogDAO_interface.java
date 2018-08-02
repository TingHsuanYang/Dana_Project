package com.blog.model;

import java.util.List;

public interface blogDAO_interface {
	
	public int insert(blogVO blog);

	public int update(blogVO blog);

	public int delete(String blog_id);

	public List<blogVO> findByMemId(String mem_id);

//	List<blogVO> getAll();

	public List<blogVO> getAllByNew();
	
	public List<blogVO> getAllByNewFour();

	public List<blogVO> getAllByHot();
	
	public List<blogVO> getAllByHotFour();

	public List<blogVO> getAllByKeyword(String keyword);
	
	public blogVO findByPrimaryKey(String blog_id);
	
	public List<blogVO> getThreeByMem_id(String mem_id,String blog_id);
	
	public int updateStatus(Integer blog_status,String blog_id);
}
