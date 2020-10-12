package board.vo;

import java.util.*;

public class ReviewReportBean {
	
	private int idx;
	private String nick;
	private int review_ref;
	private Date date;
	
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getNick() {
		return nick;
	}
	public void setNick(String nick) {
		this.nick = nick;
	}
	
	public int getReview_ref() {
		return review_ref;
	}
	public void setReview_ref(int review_ref) {
		this.review_ref = review_ref;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	
}
