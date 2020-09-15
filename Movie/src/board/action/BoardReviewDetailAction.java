package board.action;

import javax.servlet.http.*;

import action.*;
import board.svc.*;
import board.vo.*;
import vo.*;

public class BoardReviewDetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("BoardReviewDetailAction");
		
		ActionForward forward = null;
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		String page = request.getParameter("page");
		
		BoardReviewDetailService boardReviewDetailService = new BoardReviewDetailService();
		ReviewBean reviewBean = boardReviewDetailService.getReviewDetail(idx);
			
		// request 객체에 저장
		request.setAttribute("reviewBean", reviewBean);
		request.setAttribute("page", page);
		
		forward = new ActionForward();
		forward.setPath("/board/board_reviewView.jsp");
		
		
		return forward;
	}

}
