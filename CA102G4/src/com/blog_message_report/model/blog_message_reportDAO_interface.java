package com.blog_message_report.model;

import java.util.List;

public interface blog_message_reportDAO_interface {

	public int insert(blog_message_reportVO blog_message_reportVO);

	public int update(blog_message_reportVO blog_message_reportVO);

	public List<blog_message_reportVO> getAll();
}
