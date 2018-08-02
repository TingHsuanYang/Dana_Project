package com.chat.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TestChatRoom_Join_JDBCDAO implements ChatRoom_Join_Interface{
	private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String USER = "CA102G4";
	private static final String PASSWORD = "12345678";
	
//	private static final String ADDCRJOIN_STMT="INSERT INTO CHATROOM_JOIN (CHATROOM_ID,JOIN_MEMID) VALUES ('CR'||LPAD(TO_CHAR(CHATROOM_SEQ.CURRVAL),6,'0'),?)";
	private static final String ADDCRJOIN_STMT="INSERT INTO CHATROOM_JOIN (CHATROOM_ID,JOIN_MEMID) VALUES (?,?)";
	private static final String DELCRJOIN_STMT="DELETE CHATROOM_JOIN WHERE CHATROOM_ID=? AND JOIN_MEMID=?";
	private static final String FINDCR_BYMEMID_STMT="SELECT * FROM CHATROOM_JOIN WHERE JOIN_MEMID=?";
	
	//新增用戶到聊天對話
	@Override
	public int addMemInCR(ChatRoom_Join crj) {
		int count = 0;
		Connection con = null ;
		PreparedStatement pstmt = null;
		try {
			Class.forName(DRIVER);
			con=DriverManager.getConnection(URL,USER,PASSWORD);
			pstmt=con.prepareStatement(ADDCRJOIN_STMT);
			pstmt.setString(1,crj.getChatRoom_ID());
			pstmt.setString(2,crj.getJoin_MemID());
			
			count=pstmt.executeUpdate();
			
		}catch(ClassNotFoundException ce) {
			throw new RuntimeException ("資料庫無法載入驅動程式"+ce.getMessage());
		}catch(SQLException se) {
			throw new RuntimeException("資料庫發生錯誤"+se.getMessage());
		}finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
		
		return count;
	}

	//將用戶退出聊天對話
	@Override
	public int delMemOutCR(ChatRoom_Join crj) {
		int count = 0;
		Connection con = null ;
		PreparedStatement pstmt = null;
		try {
			Class.forName(DRIVER);
			con=DriverManager.getConnection(URL,USER,PASSWORD);
			pstmt=con.prepareStatement(DELCRJOIN_STMT);
			pstmt.setString(1,crj.getChatRoom_ID());
			pstmt.setString(2,crj.getJoin_MemID());
			count=pstmt.executeUpdate();
			
		}catch(ClassNotFoundException ce) {
			throw new RuntimeException ("資料庫無法載入驅動程式"+ce.getMessage());
		}catch(SQLException se) {
			throw new RuntimeException("資料庫發生錯誤"+se.getMessage());
		}finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
		
		return count;
	}

	//查詢我所有參與的聊天室
	@Override
	public List<ChatRoom_Join> findMyChatRoom(String memID) {
		List<ChatRoom_Join> list = new ArrayList<>();
		ChatRoom_Join cj=null;
		
		Connection con = null ;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		
		try {
			Class.forName(DRIVER);
			con=DriverManager.getConnection(URL,USER,PASSWORD);
			pstmt=con.prepareStatement(FINDCR_BYMEMID_STMT);
			pstmt.setString(1,memID);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				cj=new ChatRoom_Join();
				cj.setChatRoom_ID(rs.getString("CHATROOM_ID"));
				cj.setJoin_MemID(rs.getString("JOIN_MEMID"));
				list.add(cj);
			}
			
		}catch(ClassNotFoundException ce) {
			throw new RuntimeException ("資料庫無法載入驅動程式"+ce.getMessage());
		}catch(SQLException se) {
			throw new RuntimeException("資料庫發生錯誤"+se.getMessage());
		}finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
		
		return list;
	}

	public static void main(String args[]) {
		TestChatRoom_Join_JDBCDAO dao = new TestChatRoom_Join_JDBCDAO();
		
		//新增用戶到聊天對話
		ChatRoom_Join crj=new ChatRoom_Join();
		crj.setChatRoom_ID("CR000002");
		crj.setJoin_MemID("M000009");
		int count = dao.addMemInCR(crj);
		System.out.println("新增用戶到聊天對話，共"+count+"筆");
		
		//將用戶退出聊天對話
		ChatRoom_Join crj1=new ChatRoom_Join();
		crj1.setChatRoom_ID("CR000001");
		crj1.setJoin_MemID("M000001");
		int delcount = dao.delMemOutCR(crj1);
		System.out.println("將用戶從聊天對話踢出，共"+delcount+"筆");
		
		//查詢我所有參與的聊天室
		List<ChatRoom_Join> myCR=dao.findMyChatRoom("M000003");
		for(ChatRoom_Join i : myCR) {
			System.out.print(i.getChatRoom_ID()+" , ");
			System.out.println(i.getJoin_MemID());
		}
		
		
	}
}
