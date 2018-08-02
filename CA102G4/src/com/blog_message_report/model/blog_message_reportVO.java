package com.blog_message_report.model;

public class blog_message_reportVO implements java.io.Serializable {
	private String mem_id;
	private String message_id;
	private Integer bmr_status;

	public blog_message_reportVO() {

	}

	public String getMem_id() {
		return mem_id;
	}

	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}

	public String getMessage_id() {
		return message_id;
	}

	public void setMessage_id(String message_id) {
		this.message_id = message_id;
	}

	public Integer getBmr_status() {
		return bmr_status;
	}

	public void setBmr_status(Integer bmr_status) {
		this.bmr_status = bmr_status;
	}

}
