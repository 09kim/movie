package movie.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

import action.Action;
import movie.svc.MovieReviewService;
import movie.vo.ReviewBean;
import vo.ActionForward;

public class MovieReviewDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MovieCmtDeleteAction!");
		String nick = request.getParameter("nick");
		int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
		String typeName = request.getParameter("typeName");
		String comment = request.getParameter("comment");
		ReviewBean rb = new ReviewBean();
		rb.setNick(nick);
		rb.setMovieSeq(movieSeq);
		rb.setType(typeName);
		rb.setContent(comment);
		
		MovieReviewService movieReviewService = new MovieReviewService();
		boolean isInsert = movieReviewService.isDelete(rb);
		
		if(isInsert) {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		}
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
	    forward.setPath("/movie1/movie_detail.jsp");
//	    request.setAttribute("returnCmt", comment);
	    return forward;
		
	}

}
