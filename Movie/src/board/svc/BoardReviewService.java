package board.svc;

import static db.JdbcUtil.*;



import java.sql.Connection;
import java.util.ArrayList;

import board.dao.BoardDAO;
import board.vo.*;

public class BoardReviewService {
	
	
	public ArrayList<ReviewBean> selectComment(ReviewBean reviewBean){
		
		System.out.println("ReviewViewService");
		Connection con = getConnection();
		BoardDAO mo = BoardDAO.getInstance();
		mo.setConnection(con);
		ArrayList<ReviewBean> reviewList = mo.getReview(reviewBean);
		
		close(con);
		return reviewList;
	}

	public ReviewBean selectReview(int idx, int movieSeq) {
		System.out.println("BoardReviewService - selectReview");
		
		Connection con = getConnection();
		BoardDAO boardDAO = BoardDAO.getInstance();
		boardDAO.setConnection(con);
		
		ReviewBean reviewBean = boardDAO.getReviewDetail(idx, movieSeq);
		
		close(con);
		
		return reviewBean;
		
	}

	public boolean reviewLike(ReviewBean reviewBean) {
		System.out.println("BoardReviewService - reviewLike()");
		
		boolean isSuccess = false;
		
		Connection con = getConnection();
		BoardDAO boardDAO = BoardDAO.getInstance();
		boardDAO.setConnection(con);
		
		int insertCount = boardDAO.reviewLike(reviewBean);
		
		if(insertCount > 0) {
			commit(con);
			isSuccess = true;
		} else {
			rollback(con);
		}
		
		close(con);
		
		return isSuccess;
	}

	public boolean insertLike(ReviewBean reviewBean) {
		System.out.println("BoardReviewService - insertLike()");
		
		boolean isSelect = false;
		
		Connection con = getConnection();
		BoardDAO boardDAO = BoardDAO.getInstance();
		boardDAO.setConnection(con);
		
		int selectCount = boardDAO.selectLike(reviewBean);
		
		if(selectCount > 0) {
			commit(con);
			isSelect = true;
		} else {
			rollback(con);
		}
		
		close(con);
		
		return isSelect;
	}

	public boolean reviewReport(ReviewBean reviewBean) {
		System.out.println("BoardReviewService - reviewReport()");
		
		boolean isSuccess = false;
		
		Connection con = getConnection();
		BoardDAO boardDAO = BoardDAO.getInstance();
		boardDAO.setConnection(con);
		
		int insertCount = boardDAO.reviewReport(reviewBean);
		
		if(insertCount > 0) {
			commit(con);
			isSuccess = true;
		} else {
			rollback(con);
		}
		
		close(con);
		
		return isSuccess;
	}

	public boolean insertReport(ReviewBean reviewBean) {
		System.out.println("BoardReviewService - insertReport()");

		boolean isSelect = false;
		
		Connection con = getConnection();
		BoardDAO boardDAO = BoardDAO.getInstance();
		boardDAO.setConnection(con);
		
		int selectCount = boardDAO.selectReport(reviewBean);
		
		if(selectCount > 0) {
			commit(con);
			isSelect = true;
		} else {
			rollback(con);
		}
		
		close(con);
		
		return isSelect;
	}

	
	
}
