package board.svc;

import static db.JdbcUtil.*;



import java.sql.Connection;
import java.util.ArrayList;

import board.dao.BoardDAO;
import board.vo.*;

public class BoardReplyService {
	
	public boolean insertReply(ReplyBean replyBean) {
		System.out.println("BoardReplyService - insertReply()");
		
		boolean isSuccess = false;
		
		Connection con = getConnection();
		BoardDAO boardDAO = BoardDAO.getInstance();
		boardDAO.setConnection(con);
		
		int insertCount = boardDAO.insertReply(replyBean);
		
		if(insertCount > 0) {
			commit(con);
			isSuccess = true;
		} else {
			rollback(con);
		}
		
		close(con);
		
		return isSuccess;
		
	}

	public ArrayList<ReplyBean> replyList(ReplyBean replyBean) {
		System.out.println("BoardReplyService - replyList()");
		
		Connection con = getConnection();
		BoardDAO boardDAO = BoardDAO.getInstance();
		boardDAO.setConnection(con);
		
		ArrayList<ReplyBean> replyList = boardDAO.getListReply(replyBean);
		
		close(con);
		
		return replyList;
	}

	public boolean updateReply(ReplyBean replyBean) {
		System.out.println("BoardReplyService - updateReply()");
		
		boolean isSuccess = false;
		
		Connection con = getConnection();
		BoardDAO boardDAO = BoardDAO.getInstance();
		boardDAO.setConnection(con);
		
		int insertCount = boardDAO.updateReply(replyBean);
		
		if(insertCount > 0) {
			commit(con);
			isSuccess = true;
		} else {
			rollback(con);
		}
		
		close(con);
		
		return isSuccess;
	}

	public boolean deleteReply(int re_ref) {
		System.out.println("BoardReplyService - deleteReply()");
		
		boolean isSuccess = false;
		
		Connection con = getConnection();
		BoardDAO boardDAO = BoardDAO.getInstance();
		boardDAO.setConnection(con);
		
		int insertCount = boardDAO.deleteReply(re_ref);
		
		if(insertCount > 0) {
			commit(con);
			isSuccess = true;
		} else {
			rollback(con);
		}
		
		close(con);
		
		return isSuccess;
	}

}
