package mypage.vo;

public class MypageGenreBean {
	private String genre;
	private int grade;
	private String nation; // 빈으로 관리할지 바로 스트링으로 관리할지 정하기
	
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public String getNation() {
		return nation;
	}
	public void setNation(String nation) {
		this.nation = nation;
	}
}
