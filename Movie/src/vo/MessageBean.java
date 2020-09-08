package vo;

public class MessageBean {
	private String certificationNum; // 인증번호
	private String subject; // 메세지 제목
	private String content; // 메세지 내용
	private String from; // 보내는 사람
	private String to; // 받는 사람
	private String checkType; // 체크타입(이메일/핸드폰)
	
	
	
	public String getCheckType() {
		return checkType;
	}
	public void setCheckType(String checkType) {
		this.checkType = checkType;
	}
	public String getCertificationNum() {
		return certificationNum;
	}
	public void setCertificationNum(String certificationNum) {
		this.certificationNum = certificationNum;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getFrom() {
		return from;
	}
	public void setFrom(String from) {
		this.from = from;
	}
	public String getTo() {
		return to;
	}
	public void setTo(String to) {
		this.to = to;
	}
	
	
}
