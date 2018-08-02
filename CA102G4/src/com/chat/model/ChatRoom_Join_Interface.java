package com.chat.model;

import java.util.*;

public interface ChatRoom_Join_Interface {
	
	//新增用戶到聊天對話
	int addMemInCR(ChatRoom_Join crj);
	
	//將用戶退出聊天對話
	int delMemOutCR(ChatRoom_Join crj);
	
	//查詢我所有參與的聊天室
	List<ChatRoom_Join> findMyChatRoom(String memID);
	
	
	
}
