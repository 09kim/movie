package mypage.vo;

public class ProfileBean {
	// 프로필 사진 추가하기위한 Bean 추가 - 낙원 : 1015
	private String nick; // 닉네임
	private String orgFileName; // 원본 파일 이름
	private String uploadFileName; // 서버에 업로드된 파일 이름
	private String savePath; // 업로드되는 경로
	public String getNick() {
		return nick;
	}
	public void setNick(String nick) {
		this.nick = nick;
	}
	public String getOrgFileName() {
		return orgFileName;
	}
	public void setOrgFileName(String orgFileName) {
		this.orgFileName = orgFileName;
	}
	public String getUploadFileName() {
		return uploadFileName;
	}
	public void setUploadFileName(String uploadFileName) {
		this.uploadFileName = uploadFileName;
	}
	public String getSavePath() {
		return savePath;
	}
	public void setSavePath(String savePath) {
		this.savePath = savePath;
	}
	
	
	
	
	

}
