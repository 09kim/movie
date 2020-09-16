package board.action;

import java.util.*;

import javax.servlet.http.*;

import action.*;
import board.svc.*;
import board.vo.*;
import vo.*;

public class BoardReviewListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("BoardReviewListAction");
		HttpSession session = request.getSession();
		String nick = (String)session.getAttribute("nick");
		ActionForward forward = null;
		
		int page = 1;
		int limit = 10;
		
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		
		BoardReviewListService boardReviewListService = new BoardReviewListService();
		int listCount = boardReviewListService.getReviewListCount();
		
		ArrayList<ReviewBean> reviewList = boardReviewListService.getReviewList(page, limit,nick);
		
		int maxPage = (int)((double)listCount / limit + 0.95);
		int startPage = ((int)((double)page / 10 + 0.9) - 1) * 10 + 1;
		int endPage = startPage + 10 - 1;
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		PageInfo pageInfo = new PageInfo(page, maxPage, startPage, endPage, listCount);
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("reviewList", reviewList);
		
		forward = new ActionForward();
		forward.setPath("/board/board_reviewList.jsp");
		
		
		return forward;
	}

}
