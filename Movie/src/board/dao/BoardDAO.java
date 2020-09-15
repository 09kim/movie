package board.dao;

import static db.JdbcUtil.close;

import java.sql.*;
import java.util.*;

import board.vo.*;


public class BoardDAO {
	private BoardDAO() {}
	
	private static BoardDAO instance;
	
	public static BoardDAO getInstance() {
		if (instance == null) {
			instance = new BoardDAO();
		}
		
		return instance;
	}

	Connection con ;
	
	public void setConnection(Connection con) {
		this.con = con;
	}
	
	PreparedStatement pstmt;
	ResultSet rs ;

	// -------------------------------------------------
	
	public int insertReview(ReviewBean reviewBean) {
		System.out.println("BoardDAO - insertReview()");
		
		int insertCount = 0;
		
		try {
			String sql = "select max(idx) from review";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			int idx = 1;
			
			if(rs.next()) {
				idx = rs.getInt(1) + 1;
			}
			
			sql = "insert into review values(?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.setString(2, reviewBean.getNick());
			pstmt.setInt(3, reviewBean.getGrade());
			pstmt.setString(4, reviewBean.getGenre());
			pstmt.setInt(5, reviewBean.getMovieSeq());
			pstmt.setString(6, reviewBean.getTitle());
			pstmt.setString(7, reviewBean.getType_name());
			pstmt.setString(8, reviewBean.getContent());
			pstmt.setInt(9, reviewBean.getLike_count());
			
			insertCount = pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("BoardDAO - insertReview 에러 : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return insertCount;
	}

	public int selectReviewListCount() {
		System.out.println("BoardDAO - selectReviewListCount()");
		
		int listCount = 0;
		
		try {
			String sql = "select count(*) from review";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				listCount = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("BoardDAO - selectReviewListCount 에러 : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return listCount;
	}

	public ArrayList<ReviewBean> selectReviewList(int page, int limit) {
		System.out.println("BoardDAO - selectReviewList");
		
		ArrayList<ReviewBean> reviewList = null;
		
		try {
			int startRow = (page - 1) * 10;
			String sql = "SELECT * FROM review";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			reviewList = new ArrayList<ReviewBean>();
			
			while(rs.next()) {
				ReviewBean reviewBean = new ReviewBean();
				reviewBean.setIdx(rs.getInt(1));
				reviewBean.setNick(rs.getString(2));
				reviewBean.setGrade(rs.getInt(3));
				reviewBean.setGenre(rs.getString(4));
				reviewBean.setMovieSeq(rs.getInt(5));
				reviewBean.setTitle(rs.getString(6));
				reviewBean.setType_name(rs.getString(7));
				reviewBean.setContent(rs.getString(8));
				reviewBean.setLike_count(rs.getInt(9));
				
				reviewList.add(reviewBean);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("BoardDAO - selectReviewList() 에러" + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
				
		return reviewList;
	}

	public ReviewBean selectReviewDetail(int idx) {
		// TODO Auto-generated method stub
		return null;
	}

	public int updateReadcount(int idx) {
		// TODO Auto-generated method stub
		return 0;
	}


	
	
	
	
	
	
	
	
}
