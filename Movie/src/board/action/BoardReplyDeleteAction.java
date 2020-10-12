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
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		BoardReplyService boardReplyService = new BoardReplyService();
		boolean isSuccess = boardReplyService.deleteReply(idx);
			
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("BoardReviewView.bo");
		
	    return forward;
	}

}
