package com.chat.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TestChatRoom_JDBCDAO implements ChatRoom_Interface{
	private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String URL="jdbc:oracle:thin:@localhost:1521:xe";
	private static final String USER="CA102G4";
	private static final String PASSWORD="12345678";
	
	private static final String ADDCHATROOM_STMT="INSERT INTO CHATROOM(CHATROOM_ID,CHATROOM_NAME,CHATREC) VALUES('CR'||LPAD(TO_CHAR(CHATROOM_SEQ.NEXTVAL),6,'0'),?,?)";
	private static final String UPDATECHATROOM_STMT="UPDATE CHATROOM SET CHATROOM_NAME=?,CHATREC=?  WHERE CHATROOM_ID=?";
	private static final String DELCHATROOM_STMT="DELETE CHATROOM WHERE CHATROOM_ID=?";
	private static final String FINDALLCHATROOM_STMT="SELECT * FROM CHATROOM";
	
	//新增聊天對話
	@Override
	public int addChatRoom(ChatRoom cr) {
		int count = 0 ;
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(DRIVER);
			con=DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt=con.prepareStatement(ADDCHATROOM_STMT);
			pstmt.setString(1, cr.getChatRoom_Name());
			pstmt.setString(2, cr.getChatRec());
			count=pstmt.executeUpdate();
			
		}catch(ClassNotFoundException ce) {
			throw new RuntimeException("無法載入資料庫驅動程式"+ce.getMessage());
		}catch(SQLException se) {
			throw new RuntimeException("資料庫發生錯誤"+se.getMessage());
		}finally {
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		return count;
	}

	//修改聊天對話(名子或聊天紀錄)
	@Override
	public int updateChatRoom(ChatRoom cr) {
		int count = 0 ;
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(DRIVER);
			con=DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt=con.prepareStatement(UPDATECHATROOM_STMT);
			pstmt.setString(1, cr.getChatRoom_Name());
			pstmt.setString(2, cr.getChatRec());
			pstmt.setString(3, cr.getChatRoom_ID());
			count=pstmt.executeUpdate();
			
		}catch(ClassNotFoundException ce) {
			throw new RuntimeException("無法載入資料庫驅動程式"+ce.getMessage());
		}catch(SQLException se) {
			throw new RuntimeException("資料庫發生錯誤"+se.getMessage());
		}finally {
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		return count;
	}
	
	//刪除聊天對話(當最後一個人離開聊天對話時)
	@Override
	public int delChatRoom(String chatRoom_id) {
		int count = 0 ;
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(DRIVER);
			con=DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt=con.prepareStatement(DELCHATROOM_STMT);
			pstmt.setString(1, chatRoom_id);
			count=pstmt.executeUpdate();
			
		}catch(ClassNotFoundException ce) {
			throw new RuntimeException("無法載入資料庫驅動程式"+ce.getMessage());
		}catch(SQLException se) {
			throw new RuntimeException("資料庫發生錯誤"+se.getMessage());
		}finally {
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		return count;
	}

	//所有聊天對話
	@Override
	public List<ChatRoom> myChatRoom() {
		List<ChatRoom> list = new ArrayList<>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ChatRoom cr = null;
		
		try {
			Class.forName(DRIVER);
			con=DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt=con.prepareStatement(FINDALLCHATROOM_STMT);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				cr=new ChatRoom();
				cr.setChatRoom_ID(rs.getString("CHATROOM_ID"));
				cr.setChatRoom_Name(rs.getString("CHATROOM_NAME"));
				cr.setChatRec(rs.getString("CHATREC"));
				list.add(cr);
			}
			
		}catch(ClassNotFoundException ce) {
			throw new RuntimeException("無法載入資料庫驅動程式"+ce.getMessage());
		}catch(SQLException se) {
			throw new RuntimeException("資料庫發生錯誤"+se.getMessage());
		}finally {
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		return list;
	}
	
	
	public static void main(String args[]) {
		TestChatRoom_JDBCDAO dao = new TestChatRoom_JDBCDAO();
		
		//新增聊天對話(第一次建立聊天室時)
		ChatRoom cr = new ChatRoom();
		cr.setChatRoom_Name("測試");
		cr.setChatRec("");
		int count = dao.addChatRoom(cr);
		System.out.println("新增了"+count+"筆聊天對話");
		
		//修改聊天對話(名子或聊天紀錄)
		ChatRoom cr1 = new ChatRoom();
		cr1.setChatRoom_ID("CR000001");
		cr1.setChatRoom_Name("Aile與Eddie的聊天室");
		cr1.setChatRec("[{'MEM_ID':'M000003','MSG':'我愛足球','TIME':'2018-07-23 01:00:00'},{'MEM_ID':'M000010','MSG':'我愛美女','TIME':'2018-07-23 01:00:00'},{'MEM_ID':'M000010','MSG':'YAYAYA','TIME':'2018-07-23 01:00:00'}]");
		int update_Count = dao.updateChatRoom(cr1);
		System.out.println("更新聊天對話的資訊，共"+update_Count+"筆");
		
		//刪除聊天對話(當最後一個人離開聊天對話時)
		int delCount=dao.delChatRoom("CR000004");
		System.out.println("刪除"+delCount+"筆聊天對話");
		
		//所有聊天對話
		List<ChatRoom> all=dao.myChatRoom();
		for(ChatRoom i : all ) {
			System.out.print(i.getChatRoom_ID()+" , ");
			System.out.print(i.getChatRoom_Name()+" , ");
			System.out.println(i.getChatRec());
		}
		
	}
}
