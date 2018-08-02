package com.ad.controller;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import com.ad.model.*;


@MultipartConfig(maxFileSize=-1,maxRequestSize=-1)

public class AdServlet extends HttpServlet {
       

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
	}


	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
//		String ad_TitleReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9)?!_‧★]{2,30}"; 沒用到了
		String ad_LinkReg = "(https?)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]";
		String ad_PicReg  = "^(jpeg|jpg|bmp|png|gif|ico)$";
		
		//新增廣告時，來自back_addad.jsp的請求
		if("insert".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs",errorMsgs);
			
			try {
				/*******************第一步：錯誤處理*******************/
				String ad_Title = req.getParameter("ad_Title");
				
				if(ad_Title == null || ad_Title.trim().length() == 0) {
					errorMsgs.add("標題：請勿空白。");
				}else if(ad_Title.trim().length()<2||ad_Title.trim().length()>30){
					errorMsgs.add("標題：請輸入2~30個字。");
				}

				
				String ad_Text = req.getParameter("ad_Text");
				if(ad_Text == null || ad_Text.trim().length() == 0) {
					errorMsgs.add("簡介：請勿空白。");
				}else if(ad_Text.trim().length()>100){
					errorMsgs.add("簡介：請勿超過100個字。");
				}
				
				String ad_Link = req.getParameter("ad_Link");
				if(ad_Link == null || ad_Link.trim().length() == 0) {
					errorMsgs.add("連結：請勿空白。");
				}else if(!ad_Link.trim().matches(ad_LinkReg)){
					errorMsgs.add("連結：格式不符。");
				}
				
				Part ad_Pic = req.getPart("ad_Pic");
				if(getFileNameFromPart(ad_Pic) == null) {
					errorMsgs.add("請選擇圖片上傳。");
				}else if(!getFileNameFromPart(ad_Pic).matches(ad_PicReg)) {
					errorMsgs.add("圖片格式不符(.jpg/jpeg/bmp/gif/png)。");
				}
				
				AdVO advo = new AdVO();
				advo.setAd_Title(ad_Title);
				advo.setAd_Text(ad_Text);
				advo.setAd_Link(ad_Link);
				
				//若以上驗證有錯誤訊息的話，將會於頁面顯示出錯誤部分
				if(!errorMsgs.isEmpty()) {
					req.setAttribute("adVO", advo);
					RequestDispatcher failureView = req.getRequestDispatcher("/back_end/ad/back_addad.jsp");
					failureView.forward(req, res);
					return;
				}
				
				//************************第二步：新增資料**************************
				InputStream is = ad_Pic.getInputStream();
				ByteArrayOutputStream baos = new ByteArrayOutputStream();
				byte[] buf = new byte[is.available()];
				
				int len = 0 ;
				while((len = is.read(buf))!=-1) {
					baos.write(buf,0,len);
				}
				baos.close();
				is.close();
				
				AdService adSvc =new AdService();
				adSvc.addAD(ad_Title, ad_Text, ad_Link,baos.toByteArray());
				
				//************************第三步：新增完成，準備提交**************************
				String url = "/back_end/ad/back_ad.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
	
			}catch(Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher filureView = req.getRequestDispatcher("/back_end/ad/back_addad.jsp");
				filureView.forward(req, res);
			}
			
		}
		
		//修改廣告資訊時，會跳轉到修改頁面
		if("getOne_For_Update".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				//*******************第一步：接受請求參數*******************
				String adId = req.getParameter("adId");
				/*****************第二步：取出廣告資料****************************/
				AdService adSvc = new AdService();
				AdVO advo = adSvc.getOne_ById(adId);
				/*****************第三步：查詢完成，準備轉交****************************/
				
				req.setAttribute("adVO", advo);
				String url="/back_end/ad/back_updatead.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
				
			}catch(Exception e){
				errorMsgs.add(e.getMessage());
				RequestDispatcher filureView = req.getRequestDispatcher("/back_end/ad/back_ad.jsp");
				filureView.forward(req, res);
			}
			
		}
		
		
		//送出修改廣告資訊後處理
		if("update".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			byte[] pic = null;
			ByteArrayOutputStream baos=null;
			
			
			try {
				//*******************第一步：接受請求參數，錯誤處理*******************
				String adId=req.getParameter("ad_ID");
				
				String ad_Title = req.getParameter("ad_Title");
				if(ad_Title == null || ad_Title.trim().length() == 0) {
					errorMsgs.add("標題：請勿空白");
				}else if(ad_Title.trim().length()<2||ad_Title.trim().length()>30){
					errorMsgs.add("標題：請輸入2~30個字。");
				}
				
				String ad_Text = req.getParameter("ad_Text");
				if(ad_Text == null || ad_Text.trim().length() == 0) {
					errorMsgs.add("簡介：請勿空白");
				}else if(ad_Text.trim().length()>100){
					errorMsgs.add("簡介：請勿超過100個字。");
				}
				
				String ad_Link = req.getParameter("ad_Link");
	
				if(ad_Link == null || ad_Link.trim().length() == 0) {
					errorMsgs.add("連結：請勿空白");
				}else if(!ad_Link.trim().matches(ad_LinkReg)){
					errorMsgs.add("連結：格式不符");
				}
				
				Part ad_Pic = req.getPart("ad_Pic");
				if(getFileNameFromPart(ad_Pic) == null) {
					AdService adSvc = new AdService();
					AdVO advo_DB = adSvc.getOne_ById(adId);
					pic = advo_DB.getAd_Pic();
				}else if(!getFileNameFromPart(ad_Pic).matches(ad_PicReg)) {
					errorMsgs.add("圖片格式不符(.jpg/jpeg/bmp/gif/png)。");
				}
				
				AdVO advo = new AdVO();
				advo.setAd_ID(adId);
				advo.setAd_Title(ad_Title);
				advo.setAd_Text(ad_Text);
				advo.setAd_Link(ad_Link);
				advo.setAd_Pic(pic);
				
				
				//若以上驗證有錯誤訊息的話，將會於頁面顯示出錯誤部分
				if(!errorMsgs.isEmpty()) {
					req.setAttribute("adVO", advo);
					RequestDispatcher failureView = req.getRequestDispatcher("/back_end/ad/back_updatead.jsp");
					failureView.forward(req, res);
					return;
				}
				
				//************************第二步：新增資料**************************
				if(getFileNameFromPart(ad_Pic) != null) {
					InputStream is = ad_Pic.getInputStream();
					baos = new ByteArrayOutputStream();
					byte[] buf = new byte[is.available()];
					
					int len = 0 ;
					while((len = is.read(buf))!=-1) {
						baos.write(buf,0,len);
					}
					baos.close();
					is.close();
					
					pic=baos.toByteArray();
				}
				
				AdService adSvc =new AdService();
				adSvc.updateAD(adId,ad_Title, ad_Text, ad_Link,pic);
				
				//************************第三步：修改完成，準備提交**************************
				String url = "/back_end/ad/back_ad.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
	
			}catch(Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher filureView = req.getRequestDispatcher("/back_end/ad/back_updatead.jsp");
				filureView.forward(req, res);
			}
			
			
			
		}
		
		//修改廣告的點擊率
		if("updateClick".equals(action)) {
			
			try {
			//*******************第一步：接受請求參數*******************
			String ad_Id = req.getParameter("AD_ID");
			
			//*******************第二步：修改點擊率*********************
			AdService adSvc = new AdService();
			adSvc.updateAD_click(ad_Id);
			
			//*******************第三步：修改完成，準備提交***************
			String url = "/front_end/ad/ad.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
	
			}catch(Exception e) {
				/*待打....*/
			}
			
		}
		
		
		
		//選擇刪除某個廣告
		if("delete".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			
			try {
				/*****************第一步：接受請求參數****************************/
				String adId=req.getParameter("adId");
				
				/*****************第二步：刪除該項廣告****************************/
				AdService adSvc = new AdService();
				adSvc.delectAD(adId);
				/*****************第三步：刪除完成，準備轉交****************************/
				String url="/back_end/ad/back_ad.jsp";
				RequestDispatcher successView =req.getRequestDispatcher(url);
				successView.forward(req, res);
				
			}catch(Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher filureView = req.getRequestDispatcher("/back_end/ad/back_ad.jsp");
				filureView.forward(req, res);
			}
			
			
		}
		
	}

	//為了判別是否有上傳圖片，故取出檔案名稱
	public String getFileNameFromPart(Part part) {
		String header = part.getHeader("content-disposition");
//		System.out.println("header=" + header); // 測試用
		String filename = new File(header.substring(header.lastIndexOf("=") + 2, header.length() - 1)).getName();
//		System.out.println("filename=" + filename);  //測試用
		//取出副檔名
		String fnameExt = filename.substring(filename.lastIndexOf(".")+1,filename.length()).toLowerCase();
//		System.out.println("fnameExt=" + fnameExt);  //測試用
		if (filename.length() == 0) {
			return null;
		}
		return fnameExt;
	}
}
