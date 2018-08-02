package com.chat.model;

import java.util.List;

public interface ChatRoom_Interface {
	//新增聊天對話
	int addChatRoom(ChatRoom cr);
	//修改聊天對話(名子或聊天紀錄)
	int updateChatRoom(ChatRoom cr);
	//刪除聊天對話(當最後一個人離開聊天對話時)
	int delChatRoom(String chatRoom_id);
	//所有聊天對話
	List<ChatRoom> myChatRoom();
}
