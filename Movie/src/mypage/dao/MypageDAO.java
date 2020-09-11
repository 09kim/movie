package mypage.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import mypage.vo.MypageBean;
import vo.MemberBean;

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
	
	PreparedStatement pstmt;
	ResultSet rs;
	
	// 내 정보 조회 - 세은
	public MemberBean selectMypageinfo(String nick) {
		System.out.println("MypageDAO - getMypageInfo 도착");
		System.out.println(nick);
		
		MemberBean memberBean = new MemberBean();
		
		try {
			String sql = "SELECT * FROM member where nick=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, nick); // rs랑 자리 바꿈
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				memberBean.setEmail(rs.getString("email"));
				memberBean.setNick(rs.getString("nick"));
				memberBean.setPhone(rs.getString("phone"));
			}
			
		} catch (SQLException e) {
			System.out.println("MemberDAO - getMypageInfo() 에러! " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return memberBean;
		
	}
	
	// 내 정보 수정 - 세은
	 public void updateMypage(MemberBean memberBean) {
//		PreparedStatement pstmt = null;

         try {
             String sql = "update member set email=?, pass=?, phone=? where nick=?";
             pstmt = con.prepareStatement(sql);
             
             pstmt.setString(1, memberBean.getEmail());
             pstmt.setString(2, memberBean.getPass());
             pstmt.setString(3, memberBean.getPhone());
             pstmt.setString(4, memberBean.getNick());
             
             pstmt.executeUpdate();
             
             
             
         } catch (Exception e) {
             e.printStackTrace();
         }
     }
	

	// 평가한 영화 개수 조회 메서드 - NHJ
	public int selectGradeListCount() {
		int listCount = 0;
		
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
		
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
