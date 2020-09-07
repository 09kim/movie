package mypage.dao;

import static db.JdbcUtil.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import member.vo.MemberBEAN;


public class MypageDAO {
	
	private MypageDAO() {};
	
	private static MypageDAO instance;
	
	public static MypageDAO getInstance() {
		if (instance == null) {
			instance = new MypageDAO();
		}
		
		return instance;
	}
	
	Connection con;
	
	public void setConnection(Connection con) {
		this.con = con;
	}
	
	PreparedStatement pstmt;
	ResultSet rs;
	
	public MemberBEAN getMypageInfo(MemberBEAN memberBean) {
		
		System.out.println("MypageDAO - getMypageInfo 도착");
		
		String email = memberBean.getEmail();
		
		try {
			String sql = "SELECT * FROM member where email=?";
			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			pstmt.setString(1, email);
			
			if(rs.next()) {
				memberBean.setEmail(rs.getString("email"));
				memberBean.setNick(rs.getString("nick"));
			}
			
		} catch (SQLException e) {
			System.out.println("MemberDAO - getMypageInfo() 에러! " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return memberBean;
		
	}

}























