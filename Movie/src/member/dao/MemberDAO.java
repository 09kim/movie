package member.dao;

import static db.JdbcUtil.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import member.exception.MemberLoginException;
import member.vo.MemberBean;

public class MemberDAO {
	private MemberDAO() {
	};

	private static MemberDAO instance;

	public static MemberDAO getInstance() {
		if (instance == null) {
			instance = new MemberDAO();
		}

		return instance;
	}

	Connection con ;

	public void setConnection(Connection con) {
		this.con = con;
	}
	
	PreparedStatement pstmt;
	
	ResultSet rs ;

	public int insertMember(MemberBean mb) {
		int insertCount=0;
		
		try {
			String sql = "SELECT MAX(idx) FROM member";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			int maxNum = 0;
			if (rs.next()) {
				maxNum = rs.getInt(1) + 1;
			}
			sql = "INSERT INTO member VALUES(?,?,?,?,?,null,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, maxNum);
			pstmt.setString(2, mb.getEmail());
			pstmt.setString(3, mb.getPass());
			pstmt.setString(4, mb.getNick());
			pstmt.setString(5, mb.getPhone());
			insertCount = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return insertCount;
	}
	

		public boolean dupCheck(String params,String type) {
			boolean checkResult = true;
			System.out.println(params);
			System.out.println(type);
			try {
				String sql = "SELECT " + type + " FROM member where " + type + "=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, params);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					checkResult = false;
				}

			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println("MemberDAO - dupCheck() 오류!");
			} finally {
				close(rs);
				close(pstmt);
			}
			return checkResult;
		}
		
		
	public String login(MemberBean member) throws Exception{
		System.out.println("MemberDAO 도착했읍니다");
		String nick = "";
		
		try {
			
			String sql ="SELECT pass,nick FROM member WHERE email=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member.getEmail());
			rs=pstmt.executeQuery();
			if(rs.next()) { // 이메일이 존재할 경우
				System.out.println("rs.next()");
				if(member.getPass().equals(rs.getString("pass"))) {
					System.out.println("로그인가능");
					nick = rs.getString("nick");
				}else { // 패스워드가 일치하지 않을 경우
					throw new MemberLoginException("패스워드 불일치");
				}
			}else {
				throw new MemberLoginException("없는 아이디 입니다.");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("Member.dao - 오류!");
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return nick;
	}
	
	public boolean isLogin(MemberBean memberBean) {
		return false;
	}
	
	public ArrayList<MemberBean> selectMemberList() {
		System.out.println("MemberDAO - selectMeberList 작동");
		ArrayList<MemberBean> memberList = null;
		
		
		try {
			String sql = "SELECT * FROM member";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			memberList = new ArrayList<MemberBean>();
			while(rs.next()) {
				MemberBean member = new MemberBean();
				
				member.setIdx(rs.getInt("idx")); 
				member.setEmail(rs.getString("email"));

				member.setPass(rs.getString("pass"));
				member.setNick(rs.getString("nick"));
				member.setPhone(rs.getString("phone"));

				member.setDate(rs.getDate("date"));
				
				memberList.add(member);
			}
			
		} catch (SQLException e) {
			System.out.println("MemberDAO - selectMemberList() 에러!: " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		return memberList;
	}
	public boolean isEmailSame(MemberBean memberBean) {
		boolean isEmailSame = false;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT * FROM member WHERE email=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memberBean.getEmail());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(memberBean.getEmail().equals(rs.getString("email"))) {
					isEmailSame = true;
				}
			}
			
		} catch (SQLException e) {
			System.out.println("MemberDAO - isEmailSame() 에러!: " + e.getMessage());
		}
		
		return isEmailSame;
	}
	
	
	
	// 파라미터 있을 경우
	public ArrayList<MemberBean> selectMemberList(String orderTarget, String orederType) {
		System.out.println("MemberDAO - selectMeberList 작동");
		ArrayList<MemberBean> memberList = null;
		
		
		try {
			String sql = "SELECT * FROM member ORDER BY " + orderTarget + " " + orederType;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			memberList = new ArrayList<MemberBean>();
			while(rs.next()) {
				System.out.println(rs.getInt("idx"));
				MemberBean member = new MemberBean();
				
				member.setIdx(rs.getInt("idx")); 
				member.setEmail(rs.getString("email"));
				member.setPass(rs.getString("pass"));
				member.setNick(rs.getString("nick"));
				member.setPhone(rs.getString("phone"));

				member.setDate(rs.getDate("date"));
				
				memberList.add(member);
			}
		} catch (SQLException e) {
			System.out.println("MemberDAO - selectMemberList() 에러!: " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		return memberList;
	}
	
	// 이메일로 패스워드 찾기시 패스워드 변경해주는 메서드(낙원:0917)
	public int updatePassword(String email,String pass) {
		int completeCount=0;
		
		try {
			String sql = "SELECT * FROM member where email=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				sql = "UPDATE member SET pass=? where email=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, pass);
				pstmt.setString(2, email);
				completeCount= pstmt.executeUpdate();
			} else {
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return completeCount;
	}

}