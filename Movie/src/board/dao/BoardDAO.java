package board.dao;

import static db.JdbcUtil.*;

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
			pstmt.setInt(9, 0); // 좋아요 수
//			pstmt.setString(10, reviewBean.getReply());
//			pstmt.setInt(11, reviewBean.getReply_count()); // 댓글수
//			pstmt.setInt(12, idx); // re_ref(원본글)
//			pstmt.setInt(13, 0);
//			pstmt.setInt(14, 0);
			
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

	public ArrayList<ReviewBean> selectReviewList(int page, int limit, String nick) {
		System.out.println("BoardDAO - selectReviewList");
		
		ArrayList<ReviewBean> reviewList = null;
		
		try {
			int startRow = (page - 1) * 10;
			String sql = "SELECT * FROM review WHERE nick=? ORDER BY idx DESC LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, nick);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, limit);
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
//				reviewBean.setReply(rs.getString(10));
//				reviewBean.setReply_count(rs.getInt(11));
//				reviewBean.setRe_ref(rs.getInt(12));
//				reviewBean.setRe_lev(rs.getInt(13));
//				reviewBean.setRe_seq(rs.getInt(14));
				
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
	
	public ArrayList<ReviewBean> getComment(ReviewBean reviewBean){
		ArrayList<ReviewBean> list = null;
		System.out.println("boardDAO");
		try {
			String sql = "SELECT * from review where nick =? and movieSeq =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,reviewBean.getNick());
			pstmt.setInt(2,reviewBean.getMovieSeq());
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				reviewBean.setGrade(rs.getInt("grade"));
				reviewBean.setLike_count(rs.getInt("like_count"));
				reviewBean.setContent(rs.getString("content"));
			}
			
				sql = "select * from review where movieSeq = ? ORDER BY idx DESC";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, reviewBean.getMovieSeq());
				rs = pstmt.executeQuery();
				list = new ArrayList<ReviewBean>();
				while(rs.next()) {
					ReviewBean reviewB = new ReviewBean();
					reviewB.setNick(rs.getString("nick"));
					reviewB.setContent(rs.getString("content"));
					reviewB.setGrade(rs.getInt("grade"));
					reviewB.setLike_count(rs.getInt("like_count"));
					list.add(reviewB);
					
				}
			
			
		} catch (SQLException e) {
			
		} finally {
			close(rs);
			close(pstmt);
		}
		
		
		return list;
	}


	public int insertReply(ReplyBean replyBean) {
		System.out.println("BoardDAO - insertReply");
		
		int insertCount = 0;
		
		int ref = replyBean.getRe_ref();
		int seq = replyBean.getRe_seq();
		
		int idx = 1;
		
		try {
			String sql = "select max(idx) from reply";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				idx = rs.getInt(1) + 1;
			}
			
			sql = "update reply set re_seq=re_seq+1 where re_ref=? and re_seq=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, ref);
			pstmt.setInt(2, seq);
			
			int updateCount = pstmt.executeUpdate();
			
			if(updateCount > 0) {
				commit(con);
			}
			
			seq++;
			
			sql = "insert into reply values(?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.setString(2, replyBean.getNick());
			pstmt.setInt(3, replyBean.getMovieSeq());
			pstmt.setString(4, replyBean.getReply());
			pstmt.setInt(5, 0);
			pstmt.setInt(6, ref);
			pstmt.setInt(7, seq);
			
			insertCount = pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("BoardDAO - insertReply() 에러");
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return insertCount;
	}



	
	
	
	
	
	
	
	
}
