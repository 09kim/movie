package mypage.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import mypage.vo.MypageBean;

import static db.JdbcUtil.*;

public class MypageDAO {

	private static MypageDAO instance;
	
	private MypageDAO() {}

	public static MypageDAO getInstance() {
		// 기존 MypageDAO 인스턴스가 없을 때만 생성하고, 있을 경우 생성하지 않음
		if(instance == null) {
			instance = new MypageDAO();
		}

		return instance;
	}
	
	
	// --------------------------------------------------------------
	// Service 클래스로부터  JdbcUtil 에서 제공받은 Connection 객체를 전달받기
	Connection con;

	public void setConnection(Connection con) {
		this.con = con;
	}

	// 평가한 영화 개수 조회 메서드 - NHJ
	public int selectGradeListCount() {
		int listCount = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT COUNT(*) FROM grade;";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			// 평가한 영화가 조회될 경우 (영화가 하나라도 존재할 경우)
			// => listCount 에 영화 수 저장
			if(rs.next()) {
				listCount = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("MypageDAO - selectGradeListCount() 에러!");
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return listCount;
	}
	
	// 평가 영화 조회 메서드 - NHJ
	public ArrayList<MypageBean> selectGradeList() {
		ArrayList<MypageBean> gradeList = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT * FROM grade;";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			gradeList = new ArrayList<MypageBean>();
			while(rs.next()) {
				MypageBean list = new MypageBean();
				
				list.setIdx(rs.getInt("idx"));
				list.setGener(rs.getString("gener"));
				list.setGrade(rs.getInt("grade"));
				list.setMovieSeq(rs.getInt("movieSeq"));
				list.setNick(rs.getString("nick"));
				list.setRuntime(rs.getInt("runtime"));
				list.setTitle(rs.getString("title"));
				list.setWish(rs.getString("wish"));
				
				gradeList.add(list);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("MypageDAO - selectGradeList() 에러!");
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return gradeList;
	}
	
	
	
}
