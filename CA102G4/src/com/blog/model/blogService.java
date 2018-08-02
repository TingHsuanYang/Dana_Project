package com.blog.model;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import javax.servlet.http.Part;

public class blogService {
	private blogDAO_interface dao;

	public blogService() {
		dao = new blogDAO();
	}

	public blogVO addBlog(String trip_no, String mem_id, String blog_title, String blog_content,
			java.sql.Date travel_date, Integer blog_views, byte[] blog_coverimage) {
		blogVO blogVO = new blogVO();

		blogVO.setTrip_no(trip_no);
		blogVO.setMem_id(mem_id);
		blogVO.setBlog_title(blog_title);
		blogVO.setBlog_content(blog_content);
		blogVO.setTravel_date(travel_date);
		blogVO.setBlog_views(blog_views);
		blogVO.setBlog_coverimage(blog_coverimage);
		dao.insert(blogVO);

		return blogVO;
	}

	public blogVO updateBlog(String trip_no, String blog_title, String blog_content, java.sql.Date travel_date, byte[] blog_coverimage,String blog_id) {
		blogVO blogVO = new blogVO();

		blogVO.setTrip_no(trip_no);
		blogVO.setBlog_title(blog_title);
		blogVO.setBlog_content(blog_content);
		blogVO.setTravel_date(travel_date);
		blogVO.setBlog_coverimage(blog_coverimage);
		blogVO.setBlog_id(blog_id);
		dao.update(blogVO);

		return blogVO;
	}

	public void deleteBlog(String blog_id) {
		dao.delete(blog_id);
	}

	public List<blogVO> getAllByNew() {
		return dao.getAllByNew();
	}

	public List<blogVO> getAllByHot() {
		return dao.getAllByHot();
	}

	public List<blogVO> getAllByNewFour() {
		return dao.getAllByNewFour();
	}

	public List<blogVO> getAllByHotFour() {
		return dao.getAllByHotFour();
	}

	public List<blogVO> findByMemId(String mem_id) {
		return dao.findByMemId(mem_id);
	}

	public List<blogVO> getAllByKeyword(String keyword) {
		return dao.getAllByKeyword(keyword);
	}
	public blogVO findByPrimaryKey(String blog_id) {
		return dao.findByPrimaryKey(blog_id);
	}
	public List<blogVO> getThreeByMem_id(String mem_id,String blog_id) {
		return dao.getThreeByMem_id(mem_id, blog_id);
	}
	public void hideBlog(Integer blog_status,String blog_id) {
		dao.updateStatus(blog_status, blog_id);
	}
	//import blob image to database
	public static byte[] getPictureByteArray(Part part) throws IOException {
		InputStream in = part.getInputStream();
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		byte[] buffer = new byte[8192];
		int i;
		while ((i = in.read(buffer)) != -1) {
			baos.write(buffer, 0, i);
		}
		baos.close();
		in.close();

		return baos.toByteArray();
	}
}
