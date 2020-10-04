package board.action;

import java.text.*;
import java.util.*;

import javax.servlet.http.*;

import action.*;
import board.svc.*;
import board.vo.*;
import vo.*;

public class BoardReplyUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("BoardReplyUpdateAction");
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		HttpSession session = request.getSession();
		String nick = (String)session.getAttribute("nick");
		int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
		String reply = request.getParameter("reply");
		int re_ref = Integer.parseInt(request.getParameter("re_ref"));
		Date date = new Date(System.currentTimeMillis());
		String currDate = new SimpleDateFormat("yyyy-MM-dd").format(date);
		currDate = request.getParameter("date");
		
		
		ReplyBean replyBean = new ReplyBean();
		replyBean.setIdx(idx);
		replyBean.setNick(nick);
		replyBean.setMovieSeq(movieSeq);
		replyBean.setReply(reply);
		replyBean.setRe_ref(re_ref);
		replyBean.setDate(date);
		
		
		BoardReplyService boardReplyService = new BoardReplyService();
		boolean isSuccess = boardReplyService.updateReply(replyBean);
			
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("BoardReviewView.bo");
		
	    return forward;
		
	}

}
