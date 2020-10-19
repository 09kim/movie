package board.action;

import java.util.*;

import javax.servlet.http.*;

import action.*;
import board.svc.*;
import board.vo.*;
import vo.*;

public class BoardReviewDetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("BoardReviewDetailAction");
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
		
		
		HttpSession session = request.getSession();
		String nick = (String)session.getAttribute("nick");
		String reply = request.getParameter("reply");
		
		
		ReplyBean replyBean = new ReplyBean();
		replyBean.setIdx(idx);
		replyBean.setNick(nick);
		replyBean.setMovieSeq(movieSeq);
		replyBean.setReply(reply);
		
		
		
		
		// 선택한 리뷰 내용 들고오기
		BoardReviewService boardReviewService = new BoardReviewService();
		ReviewBean reviewBean = boardReviewService.selectReview(idx, movieSeq);
		request.setAttribute("reviewBean", reviewBean);
		
		
		// 댓글 리스트 불러오기
		BoardReplyService boardReplyService = new BoardReplyService();
		ArrayList<ReplyBean> replyList = boardReplyService.replyList(replyBean);
		request.setAttribute("replyList", replyList);
		
		
		ActionForward forword = new ActionForward();
		forword.setRedirect(false);
		forword.setPath("/board/board_reviewDetail.jsp");
		
		
		return forword;
	}

}
