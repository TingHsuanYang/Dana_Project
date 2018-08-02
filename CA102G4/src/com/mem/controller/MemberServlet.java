package com.mem.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

import com.mem.model.MemberDAO;
import com.mem.model.MemberService;
import com.mem.model.MemberVO;


@MultipartConfig()
public class MemberServlet extends HttpServlet {
	
private static final long serialVersionUID = 1L;
	
	//【檢查使用者輸入的帳號(account) 密碼(password)是否有效】
	//【實際上應至資料庫搜尋比對】
	private MemberVO allowUser(String mem_Account, String mem_Password) {
		  
		  MemberDAO memberdao = new MemberDAO(); 
		  MemberVO memberVO = memberdao.login_Member(mem_Account,mem_Password);
	    if (memberVO != null) {
	        return memberVO;
	      }else {
	    	  return null;
	      }
	  }
	//結束

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
		String action = req.getParameter("action");
		req.setCharacterEncoding("UTF-8");
	    res.setContentType("text/html; charset=UTF-8");
		
				//登出開始
				HttpSession session = req.getSession();
				
				if("logout".equals(action)) {
					session.invalidate();
					res.sendRedirect(req.getContextPath()+"/front_end/index.jsp");

				}
				//登出結束
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
	    res.setContentType("text/html; charset=UTF-8");
		String mem_PhotoReg = "^(jpeg|jpg|bmp|png|gif)$";
	    String action = req.getParameter("action");
	    PrintWriter out = res.getWriter();
	   	HttpSession session = req.getSession();
			
		/*Enumeration enums = req.getParameterNames();
		while(enums.hasMoreElements()) {
			System.out.println(enums.nextElement());
		}*/		
		
		if("login".equals(action)) {
			System.out.println("test123");

			// 【取得使用者 帳號(account) 密碼(password)】
		    String mem_Account = req.getParameter("mem_Account");
		    String mem_Password = req.getParameter("mem_Password");
		    Map<String, String> errorMsgs = new HashMap<String,String>();
			System.out.println("test456");

		    if("".equals(mem_Account)) {
		    	errorMsgs.put("請輸入你的帳號", "帳號是電子信箱");
		    }
		    if("".equals(mem_Password)) {
		    	errorMsgs.put("請輸入你的密碼", "test");
		    }
		    
		    if(!errorMsgs.isEmpty()){
				System.out.println("test789");

		    	req.setAttribute("errorMsgs", errorMsgs);
		    	String url = "/front_end/member/mem_login.jsp";
		    	RequestDispatcher rd = req.getRequestDispatcher(url);
		    	rd.forward(req,res);
		    }

			// 【檢查該帳號 , 密碼是否有效】
			MemberVO memberVO = allowUser(mem_Account,mem_Password);
			if (memberVO == null) {          //【帳號 , 密碼無效時】
		      out.println("<HTML><HEAD><TITLE>Access Denied</TITLE></HEAD>");
		      out.println("<BODY>你的帳號 , 密碼無效!<BR>");
		      out.println("請按此重新登入 </member/mem_login.jsp>重新登入</A>");
		      out.println("</BODY></HTML>");
			}else {		
					//【帳號 , 密碼有效時, 才做以下工作】	    	
			      String member_Id = memberVO.getMem_Id();
			      String session_id = session.getId();
			      session.setAttribute(session_id, member_Id);  //*工作1: 才在session內做已經登入過的標識
			      
			      session.setAttribute("login_state",true);		//會員登入的狀態為true
			      
			      session.setAttribute("memberVO", memberVO); 	//session包著會員資料走
			      try {                                                        
			    	  String location = (String) session.getAttribute("location");
			    	  if (location != null) {
			    		  session.removeAttribute("location");   //*工作2: 看看有無來源網頁 (-->如有來源網頁:則重導至來源網頁)
			    		  res.sendRedirect(location);   
			    		  return;
			    	  }
			      }catch (Exception ignored) { 
		    	  
		      	  }
			      res.sendRedirect(req.getContextPath()+"/front_end/index.jsp");  //*工作3: (-->如無來源網頁:則重導至首頁)
			}
	}

		//System.out.println("action = "+action);
        if ("insert".equals(action)) { // 來自addMember.jsp的請求  
			
			Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				
				String mem_Name = req.getParameter("mem_Name");
				String mem_NameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (mem_Name == null || mem_Name.trim().length() == 0) {
					errorMsgs.put("mem_Name","姓名: 請勿空白");
				} else if(!mem_Name.trim().matches(mem_NameReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.put("mem_Name","姓名: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
	            }
				
				String mem_Account = req.getParameter("mem_Account");
				String mem_AccountReg = "[\\w-.]+@[\\w-]+(.[\\w_-]+)+";
				if (mem_Account == null || mem_Account.trim().length() == 0) {
					errorMsgs.put("mem_Account","帳號: 請勿空白");
				} else if(!mem_Account.trim().matches(mem_AccountReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.put("mem_Account","帳號: 只能是Email");
	            }
				
				String mem_Password = req.getParameter("mem_Password");
				String mem_PasswordReg = "^(?=.*\\d)(?=.*[a-z]).{6,10}$";
				if (mem_Password == null || mem_Password.trim().length() == 0) {
					errorMsgs.put("mem_Password","密碼: 請勿空白");
				} else if(!mem_Password.trim().matches(mem_PasswordReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.put("mem_Password","密碼: 只能是英文字母、數字 , 且長度必需在6到10之間");
	            }
				
				Integer mem_State = 3;

								
				System.out.println("test2");
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/member/addMember.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				MemberService memberSvc = new MemberService();
				memberSvc.addMember(mem_Account, mem_Password, mem_Name, mem_State);
				System.out.println("新增成功");
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/front_end/member/mem_login.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交到網站首頁
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception",e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/member/addMember.jsp");
				failureView.forward(req, res);
			}
		}
        
        
        if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求
        	
    		List<String> errorMsgs = new LinkedList<String>();
    		// Store this set in the request scope, in case we need to
    		// send the ErrorPage view.
    		req.setAttribute("errorMsgs", errorMsgs);
    	
    		try {
    			/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
    			String str = req.getParameter("mem_Id");
    			
    			// Send the use back to the form, if there were errors
    			if (!errorMsgs.isEmpty()) {
    				RequestDispatcher failureView = req
    						.getRequestDispatcher("/member/select_page.jsp");
    				failureView.forward(req, res);
    				return;//程式中斷
    			}
    			
    			String mem_Id = null;
    			try {
    				mem_Id = new String(str);
    			} catch (Exception e) {
    				errorMsgs.add("員工編號格式不正確");
    			}
    			// Send the use back to the form, if there were errors
    			if (!errorMsgs.isEmpty()) {
    				RequestDispatcher failureView = req
    						.getRequestDispatcher("/member/select_page.jsp");
    				failureView.forward(req, res);
    				return;//程式中斷
    			}
    			
    			/***************************2.開始查詢資料*****************************************/
    			MemberService memberSvc = new MemberService();
    			MemberVO memberVO = memberSvc.getOneMember(mem_Id);
    			if (memberVO == null) {
    				errorMsgs.add("查無資料");
    			}
    			// Send the use back to the form, if there were errors
    			if (!errorMsgs.isEmpty()) {
    				RequestDispatcher failureView = req
    						.getRequestDispatcher("/member/select_page.jsp");
    				failureView.forward(req, res);
    				return;//程式中斷
    			}
    			
    			/***************************3.查詢完成,準備轉交(Send the Success view)*************/
    			req.setAttribute("memberVO", memberVO); // 資料庫取出的empVO物件,存入req
    			String url = "/front_end/member/update_mem_profile.jsp";
    			RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
    			successView.forward(req, res);
    	
    			/***************************其他可能的錯誤處理*************************************/
    		} catch (Exception e) {
    			errorMsgs.add("無法取得資料:" + e.getMessage());
    			RequestDispatcher failureView = req
    					.getRequestDispatcher("/member/select_page.jsp");
    			failureView.forward(req, res);
    		}
    	}

        if ("UPDATE_MEMBER".equals(action)) { // 來自update_mem_profile.jsp的請求
        	System.out.println("修改有進來");
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			byte[] mem_Photo = null;
			ByteArrayOutputStream baos=null;

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String mem_Id = req.getParameter("mem_Id");

				String mem_Name = req.getParameter("mem_Name");
				System.out.println("mem_Name"+mem_Name);
				if (mem_Name == null || mem_Name.trim().length() == 0) {
					errorMsgs.add("會員姓名: 請勿空白");
				}else if(mem_Name.trim().length()<2||mem_Name.trim().length()>8){
					errorMsgs.add("會員姓名：請輸入2~8個字。");
				} 
				System.out.println("姓名有");

				String mem_Phone = req.getParameter("mem_Phone");
//				String mem_PhoneReg = "/^09\\d{8}$/";
				if (mem_Phone == null || mem_Phone.trim().length() == 0) {
					errorMsgs.add("會員手機: 請勿空白");
				} 
//				else if(!mem_Phone.trim().matches(mem_PhoneReg)) { //以下練習正則(規)表示式(regular-expression)
//					errorMsgs.add("會員手機: 只能是數字, 且長度必需10碼");
//	            }
				System.out.println("手機有");
				
				Integer mem_Sex = Integer.valueOf(req.getParameter("mem_Sex"));
				System.out.println("性別有");

				String mem_Profile = req.getParameter("mem_Profile");
				if (mem_Profile == null || mem_Profile.trim().length() == 0) {
					errorMsgs.add("自我介紹: 請勿空白");
					}else if(mem_Profile.trim().length()>60){
						errorMsgs.add("自我介紹：請勿超過60個字。");
					}
				System.out.println("自我介紹有");

				java.sql.Date mem_Birthday = null; 				
				try {
					mem_Birthday = java.sql.Date.valueOf(req.getParameter("mem_Birthday").trim());
				    } catch (IllegalArgumentException e) {
				    mem_Birthday = new java.sql.Date(System.currentTimeMillis());
				     errorMsgs.add("請選擇日期!");
				    }
				System.out.println("生日有");

				Part member_Photo = req.getPart("member_Photo");
				if(getFileNameFromPart(member_Photo) == null) {
					MemberService memberSvc = new MemberService();
					MemberVO memberVO_DB = memberSvc.getOneMember(mem_Id);
					mem_Photo = memberVO_DB.getMem_Photo();
				}else if(!getFileNameFromPart(member_Photo).matches(mem_PhotoReg)) {
					errorMsgs.add("圖片格式不符(.jpg/jpeg/bmp/gif/png)。");
				}
				System.out.println("圖片有");
				System.out.println("mem_Birthday"+mem_Birthday);
				
				MemberVO memberVO = new MemberVO();
				
				memberVO.setMem_Id(mem_Id);

				memberVO.setMem_Name(mem_Name);

				memberVO.setMem_Phone(mem_Phone);
				memberVO.setMem_Sex(mem_Sex);
				memberVO.setMem_Birthday(mem_Birthday);
				memberVO.setMem_Profile(mem_Profile);
				memberVO.setMem_Photo(mem_Photo);
				System.out.println("沒改...."+mem_Photo);
				
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("memberVO", memberVO); // 含有輸入格式錯誤的empVO物件,也存入req
					System.out.println("失敗囉");
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/member/update_mem_profile.jsp");
					failureView.forward(req, res);
					return; //程式中斷
					
				}
				
				/***************************2.開始修改資料*****************************************/
				if(getFileNameFromPart(member_Photo) != null) {
					InputStream is = member_Photo.getInputStream();
					baos = new ByteArrayOutputStream();
					byte[] buf = new byte[is.available()];
					
					int len = 0 ;
					while((len = is.read(buf))!=-1) {
						baos.write(buf,0,len);
					}
					baos.close();
					is.close();
					
					mem_Photo=baos.toByteArray();
					System.out.println("圖片修改成功");
				}
				System.out.println("修改快要成功");
				MemberService memberSvc = new MemberService();
				memberSvc.updateMember(mem_Id,mem_Name,mem_Phone,mem_Sex,mem_Birthday,mem_Photo,mem_Profile);
				
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				System.out.println("****資料庫新增成功 ......後");
				req.setAttribute("memberVO", memberVO); // 資料庫update成功後,正確的的memberVO物件,存入req
				System.out.println(memberVO);
				String url = "/front_end/member/update_mem_profile.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);
				System.out.println("大師兄回來了");
				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/member/update_mem_profile.jsp");
				failureView.forward(req, res);
			}
		}
        
        
        if ("UPDATE_PASSWORD".equals(action)) { // 來自update_mem_password.jsp的請求
        	System.out.println("修改密碼有進來耶");
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String mem_Account = req.getParameter("mem_Account");

				String mem_Password = req.getParameter("mem_Password");
				if (mem_Password == null || mem_Password.trim().length() == 0) {
					errorMsgs.add("密碼: 請勿空白");
				} 
				
				MemberVO memberVO = new MemberVO();
				
				memberVO.setMem_Account(mem_Account);

				memberVO.setMem_Password(mem_Password);

				
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("memberVO", memberVO); // 含有輸入格式錯誤的empVO物件,也存入req
					System.out.println("失敗囉");
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/member/update_mem_password.jsp");
					failureView.forward(req, res);
					return; //程式中斷
					
				}
								/***************************2.開始修改資料*****************************************/
				
				System.out.println("修改快要成功");
				MemberService memberSvc = new MemberService();
				memberSvc.mem_Update_Password(mem_Account,mem_Password);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("MemberVO", memberVO); // 資料庫update成功後,正確的的memberVO物件,存入req
				String url = "/front_end/index.jsp";
				RequestDispatcher successView = req.getRequestDispatcher("/front_end/member/mem_login.jsp"); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);
				System.out.println("大師兄的密碼回來了");
				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/member/mem_login.jsp");
				failureView.forward(req, res);
			}
		}
       
	
				


//if ("Login_Member".equals(action)) {
//
//	String mem_Account = req.getParameter("mem_Account");
//	String mem_Password = req.getParameter("mem_Password");
//
//	MemberService memberSvc = new MemberService();
//	MemberVO memberVO_login = memberSvc.Login_Member(mem_Account, mem_Password);
//	if (memberVO_login != null) {
//			HttpUtils.clearSessionMember(req);
//			HttpSession session = req.getSession();
//			// 已通過認證會員
//			HttpUtils.registerSessionMember(req, memberVO_login);
//			String location = (String) session.getAttribute("location");
//			if (location != null) {
//				session.removeAttribute("location"); // *工作2: 看看有無來源網頁
//				res.sendRedirect(location);
//				return;
//			} else {
//				HttpUtils.smartForward("/update_mem_profile.jsp", req, res);
//				return;// 程式中斷
//			}
//		} 
//	} else {
//		HttpUtils.smartForward("/member/login-error.jsp", req, res);
//		return;// 程式中斷
//	}
//}



//if ("UPDATE_MEMBER_PASSWORD".equals(action)) {
//
//	List<String> errorMsgs = new LinkedList<String>();
//	req.setAttribute("errorMsgs", errorMsgs);
//	try {
//		MemberVO memberFromSession = (MemberVO) req.getSession().getAttribute("MEMBER");
//		String mem_acct = memberFromSession.getMem_acct();
//		String newPassword = req.getParameter("newPassword").trim();
//		String newPassword2 = req.getParameter("newPassword2").trim();
//
//		if (newPassword == null || "".equals(newPassword)) {
//			errorMsgs.add("新密碼不能為空！");
//		}
//
//		if (newPassword2 == null || "".equals(newPassword2)) {
//			errorMsgs.add("確認新密碼不能為空！");
//		}
//
//		if (!newPassword.equals(newPassword2)) {
//			errorMsgs.add("兩次輸入的密碼不一致");
//		}
//		if (newPassword.equals(newPassword2)) {
//
//			MemberService memberSvc = new MemberService();
//			MemberVO memberVO = new MemberVO();
//			memberVO.setMem_acct(mem_acct);
//			memberVO.setMem_pwd(newPassword);
//			memberSvc.mem_Forget_Password(mem_acct, newPassword);
//			/***************************
//			 * 3.修改完成,準備轉交(Send the Success view)
//			 *************/
//			req.setAttribute("memberVO", memberVO);
//			req.getSession().setAttribute("MEMBER", memberVO);
//			HttpUtils.clearSessionMember(req);
//			req.setAttribute("url", HttpUtils.getSmartUrl("/member/login_Store.jsp", req));
//			HttpUtils.smartForward("/member/login_Member.jsp", req, res);
//			return;// 程式中斷
//		}
//
//		/*************************** 其他可能的錯誤處理 *************************************/
//	} catch (Exception e) {
//		e.printStackTrace();
//		errorMsgs.add("修改資料失敗:" + e.getMessage());
//		HttpUtils.smartForward("/member/login-error.jsp", req, res);
//		return;// 程式中斷
//	}
//}

        
	}
	//為了判別是否有上傳圖片，故取出檔案名稱
	
	public String getFileNameFromPart(Part part) {
		String header = part.getHeader("content-disposition");
		System.out.println("header=" + header); // 測試用
		String filename = new File(header.substring(header.lastIndexOf("=") + 2, header.length() - 1)).getName();
		System.out.println("filename=" + filename);  //測試用
		//取出副檔名
		String fnameExt = filename.substring(filename.lastIndexOf(".")+1,filename.length()).toLowerCase();
		System.out.println("fnameExt=" + fnameExt);  //測試用
		if (filename.length() == 0) {
			return null;
		}
		return fnameExt;
	}
	}

