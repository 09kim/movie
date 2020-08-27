package member.dao;

import static db.JdbcUtil.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import member.exception.MemberInsertException;
import member.vo.MemberBEAN;

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

	public void setCon(Connection con) {
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
			sql = "INSERT INTO member VALUES(?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, maxNum);
			pstmt.setString(2, mb.getEmail());
			pstmt.setString(3, mb.getPass());
			pstmt.setString(4, mb.getPhone());
			insertCount = pstmt.executeUpdate();
			
			
			
		} catch (SQLException e) {
			e.getMessage();
		} finally {
			close(pstmt);
		}
		
		return insertCount;
	}

}
