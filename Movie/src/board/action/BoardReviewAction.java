package board.action;

import java.util.ArrayList;

import javax.servlet.http.*;

import action.*;
import board.svc.BoardReviewService;
import board.vo.ReviewBean;
import vo.ActionForward;

public class BoardReviewAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
		HttpSession session = request.getSession();
		String nick = (String)session.getAttribute("nick");
		System.out.println("ReviewAction");
		System.out.println(movieSeq);
		
		ReviewBean reviewBean = new ReviewBean();
		reviewBean.setNick(nick);
		reviewBean.setMovieSeq(movieSeq);
		
		BoardReviewService boardReviewService = new BoardReviewService();
		ArrayList<ReviewBean> reviewList = boardReviewService.selectComment(reviewBean);
		request.setAttribute("reviewList", reviewList);
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
	    forward.setPath("/board/board_reviewView.jsp");
	    return forward;
		
	}

}
