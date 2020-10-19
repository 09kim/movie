package board.action;

import java.io.*;
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

		int idx = Integer.parseInt(request.getParameter("idx"));
		HttpSession session = request.getSession();
		String nick = (String)session.getAttribute("nick");
		
		
		ReplyBean replyBean = new ReplyBean();
		replyBean.setNick(nick);
		replyBean.setIdx(idx);
		
		
		BoardReplyService boardReplyService = new BoardReplyService();
		boolean isInsert = boardReplyService.insertReport(replyBean, idx);
		
		if(!isInsert) {
//			response.setContentType("text/html;charset=UTF-8");
//			PrintWriter out = response.getWriter();
//			out.println("<script type='text/javascript'>");
//			out.println("alert('이미 신고하셨습니다');");
//			out.println("history.back()");
//			out.println("</script>");
			String out = "out";
			HttpSession session2 = request.getSession();
			session2.setAttribute("out", out);
			
		} else {
			
			BoardReplyService boardReplyService2 = new BoardReplyService();
			boolean isSuccess = boardReplyService.reportReply(replyBean);
			
			forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("BoardReviewView.bo");
		}
		
	    return forward;
	}

}
