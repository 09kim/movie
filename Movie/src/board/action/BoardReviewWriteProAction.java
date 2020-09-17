package board.action;

import java.io.*;

import javax.servlet.http.*;

import action.*;
import board.svc.*;
import board.vo.*;
import vo.*;

public class BoardReviewWriteProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("BoardReviewWriteProAction");
		
		ActionForward forward = null;
		
		ReviewBean reviewBean = new ReviewBean();
		reviewBean.setIdx(Integer.parseInt(request.getParameter("idx")));
		reviewBean.setNick(request.getParameter("nick"));
		reviewBean.setGrade(Integer.parseInt(request.getParameter("grade")));
		reviewBean.setGenre(request.getParameter("genre"));
		reviewBean.setMovieSeq(Integer.parseInt(request.getParameter("movieSeq")));
		reviewBean.setTitle(request.getParameter("title"));
		reviewBean.setType_name(request.getParameter("type_name"));
		reviewBean.setContent(request.getParameter("content"));
		reviewBean.setLike_count(Integer.parseInt(request.getParameter("like_count")));
		
		
		BoardReviewWriteProService boardReviewWriteProService = new BoardReviewWriteProService();
		boolean isWriteSuccess = boardReviewWriteProService.article(reviewBean);
		
		// IP
		String ip = request.getRemoteAddr();
		
		if(!isWriteSuccess) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('리뷰 작성 실패')");
			out.println("history.back()");
			out.println("</script>");
			
		} else {
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("BoardReviewList.bo");
			
		}
		
		return forward;
	}

}
