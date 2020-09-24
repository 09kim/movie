package board.svc;

import static db.JdbcUtil.*;



import java.sql.Connection;
import java.util.ArrayList;

import board.dao.BoardDAO;
import board.vo.ReviewBean;

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

	
	
}
