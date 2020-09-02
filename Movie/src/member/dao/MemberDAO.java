package member.dao;

import static db.JdbcUtil.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import member.vo.MemberBEAN;
import vo.MemberBean;

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

	public int insertMember(MemberBEAN mb) {
		int insertCount=0;
		String sql = "SELECT MAX(idx) FROM member";
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			int maxNum = 1;
			if (rs.next()) {
				maxNum = rs.getInt(1) + 1;
			}
			System.out.println(maxNum);
			sql = "INSERT INTO member VALUES(?,?,?,?,?,now())";
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
	
	// 낙원(0902:dupCheck() 메서드 하나로 통합 및 중복되는 기능의 메서드[isEmailSame(),dupCheck()] 삭제)
		public boolean dupCheck(String params,String type) {
			boolean checkResult = true;

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
		
		
	public int login(MemberBean member) {
		System.out.println("MemberDAO 도착했읍니다");
		int isLogin = 0;
		
		
		try {
			
			String sql ="SELECT pass FROM member WHERE email=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member.getEmail());
			rs=pstmt.executeQuery();
			
			if(rs.next()) { // 이메일이 존재할 경우
				if(member.getPass().equals(rs.getString("pass"))) {
					isLogin=1;
				}else { // 패스워드가 일치하지 않을 경우
					isLogin=-1;
				}
			}else {
				isLogin=0;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("Member.dao - 오류!");
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return isLogin;
	}
	
	public boolean isLogin(MemberBean memberBean) {
		// TODO Auto-generated method stub
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
}
