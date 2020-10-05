package board.dao;

import static db.JdbcUtil.*;

import java.sql.*;
import java.util.*;

import board.vo.*;

public class BoardDAO {
	private BoardDAO() {
	}

	private static BoardDAO instance;

	public static BoardDAO getInstance() {
		if (instance == null) {
			instance = new BoardDAO();
		}

		return instance;
	}

	Connection con;

	public void setConnection(Connection con) {
		this.con = con;
	}

	PreparedStatement pstmt;
	ResultSet rs;

	// -------------------------------------------------

	public int selectReviewListCount() {
		System.out.println("BoardDAO - selectReviewListCount()");

		int listCount = 0;

		try {
			String sql = "select count(*) from review";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
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

			while (rs.next()) {
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


	
	public ArrayList<ReviewBean> getReview(ReviewBean reviewBean){

		ArrayList<ReviewBean> list = null;
		try {
			String sql = "select * from review where movieSeq = ? ORDER BY idx DESC";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, reviewBean.getMovieSeq());
			rs = pstmt.executeQuery();
			list = new ArrayList<ReviewBean>();
			while (rs.next()) {
				ReviewBean reviewB = new ReviewBean();
				reviewB.setIdx(rs.getInt("idx"));
				reviewB.setNick(rs.getString("nick"));
				reviewB.setMovieSeq(rs.getInt("movieSeq"));
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


	public ReviewBean getReviewDetail(int idx, int movieSeq) {
		System.out.println("BoardDAO");
		
		ReviewBean reviewBean = new ReviewBean();
		
		try {
			String sql = "SELECT * FROM review WHERE idx=? AND movieSeq=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.setInt(2, movieSeq);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				reviewBean.setIdx(rs.getInt("idx"));
				reviewBean.setGrade(rs.getInt("grade"));
				reviewBean.setMovieSeq(rs.getInt("movieSeq"));
				reviewBean.setTitle(rs.getString("title"));
				reviewBean.setContent(rs.getString("content"));
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("BoardDAO - getReviewDetail() 에러 : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return reviewBean;
	}

	public int insertReply(ReplyBean replyBean) {
		System.out.println("BoardDAO - insertReply()");
		
		int insertCount = 0;
		
		try {
			String sql = "select max(re_ref) from reply";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			int num = 0;;
			
			if(rs.next()) {
				num = rs.getInt(1) + 1;
			}
			
			sql = "INSERT INTO reply VALUES(idx,?,?,?,?,now(),0)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, replyBean.getNick());
			pstmt.setInt(2, replyBean.getMovieSeq());
			pstmt.setString(3, replyBean.getReply());
			pstmt.setInt(4, num);
			
			insertCount = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("BoardDAO - insertReply() 에러 : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return insertCount;
	}
	

	public ArrayList<ReplyBean> getListReply(ReplyBean replyBean) {
		System.out.println("BoardDAO - getListReply()");
		
		ArrayList<ReplyBean> replyList = new ArrayList<ReplyBean>();
		
		try {
			String sql = "select * from reply where movieSeq=? ORDER BY idx DESC, date DESC";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, replyBean.getMovieSeq());
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ReplyBean reply = new ReplyBean();
				reply.setNick(rs.getString("nick"));
				reply.setReply(rs.getString("reply"));
				reply.setRe_ref(rs.getInt("re_ref"));
				reply.setDate(rs.getDate("date"));
				reply.setReport(rs.getInt("report"));
				
				replyList.add(reply);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("BoardDAO - getListReply() 에러: " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return replyList;
	}

	public int updateReply(ReplyBean replyBean) {
		System.out.println("BoardDAO - updateReply()");
		
		int insertCount = 0;
		
		try {
			String sql = "update reply set reply=? where re_ref=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, replyBean.getReply());
			pstmt.setInt(2, replyBean.getRe_ref());
			insertCount = pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("BoardDAO - updateReply() 에러: " + e.getMessage());
		} finally {
			close(pstmt);
		}
				
		return insertCount;
	}

	public int deleteReply(int re_ref) {
		System.out.println("BoardDAO - deleteReply()");
		
		int insertCount = 0;
		
		try {
			String sql = "delete from reply where re_ref=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, re_ref);
			
			insertCount = pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("BoardDAO - deleteReply() 에러: " + e.getMessage());
		} finally {
			close(pstmt);
		}
				
		return insertCount;
	}

	public int reportReply(ReplyBean replyBean) {
		System.out.println("BoardDAO - reportReply()");
		
		int insertCount = 0;
		
		try {
			String sql = "update reply set report=report+1 where re_ref=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, replyBean.getRe_ref());
			insertCount = pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("BoardDAO - reportReply() 에러: " + e.getMessage());
		} finally {
			close(pstmt);
		}
				
		return insertCount;
	}

}
