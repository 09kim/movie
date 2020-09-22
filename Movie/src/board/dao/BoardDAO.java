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

	public ArrayList<ReviewBean> getComment(ReviewBean reviewBean) {
		ArrayList<ReviewBean> list = null;
		System.out.println("boardDAO");
		try {
			String sql = "SELECT * from review where nick =? and movieSeq =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, reviewBean.getNick());
			pstmt.setInt(2, reviewBean.getMovieSeq());
			rs = pstmt.executeQuery();

			while (rs.next()) {
				reviewBean.setGrade(rs.getInt("grade"));
				reviewBean.setLike_count(rs.getInt("like_count"));
				reviewBean.setContent(rs.getString("content"));
			}

			sql = "select * from review where movieSeq = ? ORDER BY idx DESC";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, reviewBean.getMovieSeq());
			rs = pstmt.executeQuery();
			list = new ArrayList<ReviewBean>();
			while (rs.next()) {
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


	public ArrayList<ReplyBean> getReply(ReplyBean replyBean) {
		System.out.println("BoardDAO - getReply()");

		ArrayList<ReplyBean> replyList = new ArrayList<ReplyBean>();

		try {
			String sql = "SELECT * from reply where re_ref=? and movieSeq=? ORDER BY idx DESC";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, replyBean.getRe_ref());
			pstmt.setInt(2, replyBean.getMovieSeq());
			rs = pstmt.executeQuery();

			while (rs.next()) {
				System.out.println(rs.getString(1));
				System.out.println(rs.getString(2));
				System.out.println(rs.getString(3));
				ReplyBean reply = new ReplyBean();
				reply.setNick(rs.getString("nick"));
				reply.setReply(rs.getString("reply"));
			}

		} catch (SQLException e) {

		} finally {
			close(rs);
			close(pstmt);
		}

		return replyList;
	}

}
