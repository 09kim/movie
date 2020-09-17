package board.svc;

import static db.JdbcUtil.*;

import java.sql.*;

import board.dao.*;
import board.vo.*;


public class BoardReviewWriteProService {

	public boolean article(ReviewBean reviewBean) {
		System.out.println("BoardReviewProService - article()");
		
		boolean isWriteSuccess = false;
		
		Connection con = getConnection();
		
		BoardDAO boardDAO = BoardDAO.getInstance();
		boardDAO.setConnection(con);
		
		int insertCount = boardDAO.insertReview(reviewBean);
		
		if(insertCount > 0) {
			commit(con);
			isWriteSuccess = true;
		} else {
			rollback(con);
		}

		close(con);
		
		return isWriteSuccess;
	}

}
