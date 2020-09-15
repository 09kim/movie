package board.svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.*;
import java.util.*;

import board.dao.*;
import board.vo.*;

public class BoardReviewListService {

	public int getReviewListCount() {
		System.out.println("BoardReviewListService - getReviewListCount()");
		
		int listCount = 0;
		
		Connection con = getConnection();
		
		BoardDAO boardDAO = BoardDAO.getInstance();
		boardDAO.setConnection(con);
		
		listCount = boardDAO.selectReviewListCount();
		
		close(con);
		
		return listCount;
	}

	public ArrayList<ReviewBean> getReviewList(int page, int limit) {
		System.out.println("BoardReviewListService - getReviewList()");
		
		ArrayList<ReviewBean> reviewList = null;
		
		Connection con = getConnection();
		
		BoardDAO boardDAO = BoardDAO.getInstance();
		boardDAO.setConnection(con);
		
		reviewList = boardDAO.selectReviewList(page, limit);
		
		close(con);
		
		return reviewList;
	}

}
