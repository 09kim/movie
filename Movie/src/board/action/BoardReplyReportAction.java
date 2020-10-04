package board.action;

import java.text.*;
import java.util.*;

import javax.servlet.http.*;

import action.*;
import board.svc.*;
import board.vo.*;
import vo.*;

public class BoardReplyReportAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("BoardReplyReportAction");
		
		ActionForward forward = null;
		
		HttpSession session = request.getSession();
		String nick = (String)session.getAttribute("nick");
		int re_ref = Integer.parseInt(request.getParameter("re_ref"));
		
		ReplyBean replyBean = new ReplyBean();
		replyBean.setNick(nick);
		replyBean.setRe_ref(re_ref);
		
		BoardReplyService boardReplyService = new BoardReplyService();
		boolean isSuccess = boardReplyService.reportReply(replyBean);
			
		forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("BoardReviewView.bo");
		
	    return forward;
	}

}
