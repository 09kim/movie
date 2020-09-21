package board.svc;

import static db.JdbcUtil.*;

import java.sql.*;

import board.dao.*;
import board.vo.*;

public class BoardReplyService {
	
	public boolean isInsert(ReplyBean replyBean) {
		System.out.println("BoardReplyService - isInsert()");
		
		boolean isInsert = false;
		
		Connection con = getConnection();
		BoardDAO boardDAO = BoardDAO.getInstance();
		boardDAO.setConnection(con);
		
		int insertCount = boardDAO.insertReply(replyBean);
		
		if(insertCount > 0) {
			isInsert = true;
			commit(con);
		}else {
			rollback(con);
		}
		
		close(con);
		
		return isInsert;
	}

//	public boolean isInsert(ReviewBean reviewBean) {
//		System.out.println("BoardReplyService - isInsert()");
//		
//		boolean isInsert = false;
//		
//		Connection con = getConnection();
//		BoardDAO boardDAO = BoardDAO.getInstance();
//		boardDAO.setConnection(con);
//		
//		int insertCount = boardDAO.insertReply(reviewBean);
//		
//		if(insertCount > 0) {
//			isInsert = true;
//			commit(con);
//		}else {
//			rollback(con);
//		}
//		
//		close(con);
//		
//		return isInsert;
//	}

	
}
