package mypage.dao;

import static db.JdbcUtil.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import member.vo.MemberBEAN;
import vo.MemberBean;


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
	
	public MemberBean selectMypageinfo(String nick) {
		
		System.out.println("MypageDAO - getMypageInfo 도착");
		
		MemberBean memberBean = new MemberBean();
		
		
		try {
			String sql = "SELECT * FROM member where nick=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, nick);
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
	
	
	 public void updateMypage(MemberBean memberBean) {
		 
		PreparedStatement pstmt = null;
			
         
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

}























