package com.blog.controller;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;


/**
 * Servlet implementation class ADPicReader
 */
@WebServlet("/blogPicReader")
public class blogPicReader extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection con;
	
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String blog_id = req.getParameter("blog_id");
		
		res.setContentType("image/gif");
		ServletOutputStream out =res.getOutputStream();
		
		try {
			Statement stat=con.createStatement();
			ResultSet rs =stat.executeQuery("SELECT BLOG_COVERIMAGE FROM BLOG WHERE BLOG_ID='"+blog_id+"'");
			if(rs.next()) {
				BufferedInputStream in = new BufferedInputStream(rs.getBinaryStream("BLOG_COVERIMAGE"));
				byte[] buf = new byte[4*1024];
				int len;
				while((len= in.read(buf))!=-1) {
					out.write(buf,0,len);
				}
				in.close();
			}
			
			rs.close();
			stat.close();
		}catch(SQLException se){
			System.out.println(se);
		}
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doGet(req, res);
	}
	
	public void init() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "CA102G4", "12345678");
		}catch(ClassNotFoundException ce){
			throw new RuntimeException("無法載入資料庫驅動程式"+ce.getMessage());
		}catch(SQLException se) {
			throw new RuntimeException("資料庫發生錯誤"+se.getMessage());
		}
	}
	
	public void distory() {
		try {
			 if(con!=null) con.close();
		} catch (SQLException e) {
			System.out.println(e);
		}
	}
}


