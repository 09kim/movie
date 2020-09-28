package board.action;

import java.text.*;
import java.util.*;

import javax.servlet.http.*;

import action.*;
import board.svc.*;
import board.vo.*;
import vo.*;

public class BoardReplyDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("BoardReplyDeleteAction");
		
		int re_ref = Integer.parseInt(request.getParameter("re_ref"));
//		ReplyBean replyBean = new ReplyBean();
//		int re_ref = replyBean.getRe_ref();
		System.out.println(re_ref);
		
		BoardReplyService boardReplyService = new BoardReplyService();
		boolean isSuccess = boardReplyService.deleteReply(re_ref);
			
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("BoardReviewView.bo");
		
	    return forward;
	}

}
