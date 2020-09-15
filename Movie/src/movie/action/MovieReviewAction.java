package movie.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

import action.Action;
import movie.svc.MovieReviewService;
import movie.vo.ReviewBean;
import vo.ActionForward;

public class MovieReviewAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String nick = request.getParameter("nick");
		int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
		String typeName = request.getParameter("typeName");
		String comment = request.getParameter("comment");
		System.out.println("ReviewAction");
		ReviewBean rb = new ReviewBean();
		rb.setNick(nick);
		rb.setMovieSeq(movieSeq);
		rb.setType(typeName);
		rb.setContent(comment);
		
		MovieReviewService movieReviewService = new MovieReviewService();
		movieReviewService.isInsert(rb);
		
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(nick+ "님의 리뷰 : " + comment);
		
//		ActionForward forward = new ActionForward();
//		forward.setRedirect(false);
//	    forward.setPath("/movie1/movie_detail.jsp");
//	      
//	    return forward;
		return null;
		
	}

}
