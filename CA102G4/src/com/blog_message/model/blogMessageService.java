package com.blog_message.model;

import java.util.List;

public class blogMessageService {
	private blog_messageDAO_interface dao;

	public blogMessageService() {
		dao = new blog_messageDAO();
	}

	public blog_messageVO addBlogMessage(String blog_id, String mem_id, String blog_message) {
		blog_messageVO blog_messageVO = new blog_messageVO();

		blog_messageVO.setBlog_id(blog_id);
		blog_messageVO.setMem_id(mem_id);
		blog_messageVO.setMessage_id(blog_message);
		dao.insert(blog_messageVO);

		return blog_messageVO;
	}

	public blog_messageVO updateBlogMessage(String blog_message, String message_id) {
		blog_messageVO blog_messageVO = new blog_messageVO();

		blog_messageVO.setBlog_message(blog_message);
		blog_messageVO.setMessage_id(message_id);
		dao.update(blog_messageVO);

		return blog_messageVO;
	}

	public void deleteBlogMessage(String message_id) {
		dao.delete(message_id);
	}
	
	public List<blog_messageVO> findByBlogId(String blog_id){
		return dao.findByBlogId(blog_id);
	}
}
