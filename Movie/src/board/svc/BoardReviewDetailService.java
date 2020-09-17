package board.svc;

import static db.JdbcUtil.*;

import java.sql.*;

import board.dao.*;
import board.vo.*;

public class BoardReviewDetailService {

	public ReviewBean getReviewDetail(int idx) {
		System.out.println("BoardReviewDetailService - getReviewDetail()");
		
		Connection con = getConnection();
		
		BoardDAO boardDAO = BoardDAO.getInstance();
		boardDAO.setConnection(con);
		
		ReviewBean reviewBean = boardDAO.selectReviewDetail(idx);
		
		// 조회된 게시물이 존재할 경우 조회수 업데이트 수행
		if(reviewBean != null) {
			int updateCount = boardDAO.updateReadcount(idx);
			
			if(updateCount > 0) {
				commit(con);
			} else {
				rollback(con);
			}
		}
		
		close(con);
		
		
		return reviewBean;
	}

}
