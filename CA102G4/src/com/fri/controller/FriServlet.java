package com.fri.controller;

import java.io.IOException;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.fri.model.*;



public class FriServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
	}


	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		//送出好友邀請時
		if("insertFri".equals(action)) {
			
		}
		//解除好友關係時
		if("deleteFri".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/****************1.接受請求參數,錯誤驗證**********************/
				String meId = req.getParameter("meId");
				String friId  = req.getParameter("friId");

				
				if(meId == null || meId.trim().length() == 0) {
					errorMsgs.add("錯誤：登入者會員ID null!");
				}
				
				if(friId == null || friId.trim().length() == 0) {
					errorMsgs.add("錯誤：登入者好友的會員ID null!");
				}
				
				if(!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front_end/personal_area/personal_area_friend.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/****************2.確認資料無誤，即開始解除好友關係**********************/
				FriendService friSvc = new FriendService();
				 //因為成為好友後，會存兩筆，故要執行兩次deleteFri()
				friSvc.deleteFri(meId, friId);
				friSvc.deleteFri(friId, meId);
				/****************3.刪除完畢，開始轉交**********************/
				String url = "/front_end/personal_area/personal_area_friend.jsp";
				RequestDispatcher successView = req.getRequestDispatcher("/front_end/personal_area/personal_area_friend.jsp");
				successView.forward(req, res);
				
				
			}catch(Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/personal_area/personal_area_friend.jsp");
				failureView.forward(req, res);
			}
		}
		
		//封鎖好友時，收到personal_area_friend.jsp請求
		if("blockFri".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs",errorMsgs);
			
			try {
				/********************1.接受參數，錯誤驗證****************************/
				String meId = req.getParameter("meId");
				String friId = req.getParameter("friId");
				
				if(meId == null || meId.trim().length() == 0) {
					errorMsgs.add("錯誤：登入者會員ID null!");
				}
				
				if(friId == null || friId.trim().length() == 0) {
					errorMsgs.add("錯誤：登入者好友的會員ID null!");
				}
				
				if(!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front_end/personal_area/personal_area_friend.jsp");
					failureView.forward(req, res);
					return;
				}
				
				
				/********************2.完成錯誤驗證，準備封鎖朋友****************************/
				FriendService friSvc = new FriendService();
				friSvc.updateFriStat_Block(meId, friId, 3);
				
				/********************3.準備提交****************************************/
				String url = "/front_end/personal_area/personal_area_friend.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
				
				
			}catch(Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/personal_area/personal_area_friend.jsp");
				failureView.forward(req, res);
			}
			
			
			
		}
		
		//對某位好友解除封鎖時
		if("unBlockFri".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs",errorMsgs);
			
			try {
				String meId = req.getParameter("meId");
				String friId = req.getParameter("friId");
				/*****************1.取得參數，錯誤處理*************************/
				if(meId == null || meId.trim().length() == 0) {
					errorMsgs.add("錯誤:未取得登入者ID");
				}
				
				if(friId == null || friId.trim().length() == 0) {
					errorMsgs.add("錯誤:未取得登入者的好友ID");
				}
				
				if(!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front_end/personal_area/personal_area_friend.jsp");
					failureView.forward(req, res);
				}
				
				
				/*****************2.錯誤驗證無誤，進行解除封鎖********************/
				FriendService friSvc = new FriendService();
				friSvc.updateFriStat_Block(meId,friId,2);
				
				/*****************3.解除封鎖成功，準備提交********************/
				String url = "/front_end/personal_area/personal_area_friend.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req,res);
				
				
			}catch(Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/personal_area/personal_area_friend.jsp");
				failureView.forward(req, res);
			}
			
			
		}
		
		
		
	}

}
