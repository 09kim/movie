package board.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

import action.Action;
import board.svc.*;
import board.vo.*;
import vo.ActionForward;

public class BoardReplyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("BoardReplyAction");
		
		ActionForward forward = null;
		
		
		String nick = request.getParameter("nick");
		int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
		String reply = request.getParameter("reply");

		ReplyBean replyBean = new ReplyBean();
		replyBean.setNick(nick);
		replyBean.setMovieSeq(movieSeq);
		replyBean.setReply(reply);
//		replyBean.setReply_count(reply_count);
		
		
//		ReviewBean reviewBean = new ReviewBean();
//		reviewBean.setNick(nick);
//		reviewBean.setMovieSeq(movieSeq);
//		reviewBean.setReply(reply);
		
		
		BoardReplyService boardReplyService = new BoardReplyService();
		boardReplyService.isInsert(replyBean);
		
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(nick + " 님의 댓글 : " + reply);
		
		forward = new ActionForward();
		forward.setPath("/board/board_reviewView.jsp");
	    request.setAttribute("returnReply", reply);
	    
	    return forward;
		
	}

}
