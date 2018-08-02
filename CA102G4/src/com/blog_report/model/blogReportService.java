package com.blog_report.model;

import java.util.List;

public class blogReportService {
	private blog_reportDAO dao;

	public blogReportService() {
		dao = new blog_reportDAO();
	}

	public blog_reportVO addBlogReport(String blog_id, String mem_id) {
		blog_reportVO blog_reportVO = new blog_reportVO();

		blog_reportVO.setBlog_id(blog_id);
		blog_reportVO.setMem_id(mem_id);
		dao.insert(blog_reportVO);

		return blog_reportVO;
	}

	public blog_reportVO updateBlogReport(Integer br_status, String blog_id, String mem_id) {
		blog_reportVO blog_reportVO = new blog_reportVO();

		blog_reportVO.setBr_status(br_status);
		blog_reportVO.setBlog_id(blog_id);
		blog_reportVO.setMem_id(mem_id);
		dao.update(blog_reportVO);

		return blog_reportVO;
	}

	public List<blog_reportVO> getAll() {
		return dao.getAll();
	}
}
