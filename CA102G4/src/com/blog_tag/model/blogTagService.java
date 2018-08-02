package com.blog_tag.model;

import java.util.List;

public class blogTagService {
	private blog_tagDAO_interface dao;

	public blogTagService() {
		dao = new blog_tagDAO();
	}

	public blog_tagVO addBlogTag(String blog_id, String btn_id) {
		blog_tagVO blog_tagVO = new blog_tagVO();

		blog_tagVO.setBlog_id(blog_id);
		blog_tagVO.setBtn_id(btn_id);
		dao.insert(blog_tagVO);

		return blog_tagVO;
	}

	public void deleteBlogTagOne(String blog_id, String btn_id) {
		blog_tagVO blog_tagVO = new blog_tagVO();

		blog_tagVO.setBlog_id(blog_id);
		blog_tagVO.setBtn_id(btn_id);
		dao.deleteOne(blog_tagVO);
	}

	public void deleteBlogTagAll(String blog_id) {

		dao.deleteAll(blog_id);
	}

	public List<blog_tagVO> getAllByABLOG(String blog_id) {
		return dao.getAllByABlog(blog_id);
	}
}
