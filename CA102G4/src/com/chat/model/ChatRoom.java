package com.chat.model;

import java.io.Serializable;

public class ChatRoom implements Serializable{
	private String chatRoom_ID;
	private String chatRoom_Name;
	private String chatRec;
	
	public ChatRoom() {}
	
	public void setChatRoom_ID(String chatRoom_ID) {
		this.chatRoom_ID=chatRoom_ID;
	}
	
	public String getChatRoom_ID() {
		return chatRoom_ID;
	}
	
	public String getChatRoom_Name() {
		return chatRoom_Name;
	}

	public void setChatRoom_Name(String chatRoom_Name) {
		this.chatRoom_Name = chatRoom_Name;
	}

	public String getChatRec() {
		return chatRec;
	}

	public void setChatRec(String chatRec) {
		this.chatRec = chatRec;
	}
	
	

}
