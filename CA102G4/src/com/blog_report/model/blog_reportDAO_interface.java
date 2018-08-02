package com.blog_report.model;

import java.util.List;

public interface blog_reportDAO_interface {
	
	public int insert(blog_reportVO blog_reportVO);
	
	public int update(blog_reportVO blog_reportVO);
	
	public List<blog_reportVO> getAll();
}
