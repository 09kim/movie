package board.action;

import javax.servlet.http.*;

import action.*;
import board.svc.*;
import vo.*;

public class BoardReviewDetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
		
		BoardReviewService boardReviewService = new BoardReviewService();
		boardReviewService.selectComment(idx, movieSeq);
		
		
		return null;
	}

}
