package board.action;

import java.io.*;
import java.text.*;
import java.util.*;

import javax.servlet.http.*;

import action.*;
import board.svc.*;
import board.vo.*;
import vo.*;

public class BoardReviewReportAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("BoardReviewReportAction");
		
		ActionForward forward = null;
		
		HttpSession session = request.getSession();
		String nick = (String)session.getAttribute("nick");
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		ReviewBean reviewBean = new ReviewBean();
		reviewBean.setIdx(idx);
		reviewBean.setNick(nick);
		
		
		BoardReviewService boardReviewService = new BoardReviewService();
		boolean isInsert = boardReviewService.insertReport(reviewBean);
		
		if(!isInsert) {
			String out = "out";
			HttpSession session2 = request.getSession();
			session2.setAttribute("out", out);
			
		} else {
			
			BoardReviewService boardReviewService2 = new BoardReviewService();
			boolean isSuccess = boardReviewService2.reviewReport(reviewBean);
			
			forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("MovieDetail.mo");
		}
		
	    return forward;
	}

}
