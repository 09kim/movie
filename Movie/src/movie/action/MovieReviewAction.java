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
		System.out.println("MOVIEREVIEW!@#@!#!#!$@!$@!$!@$@!@!$@!$@!");
		String nick = request.getParameter("nick");
		int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
		String typeName = request.getParameter("typeName");
		String review = request.getParameter("review");
		ReviewBean rb = new ReviewBean();
		System.out.println(nick);
		rb.setNick(nick);
		rb.setMovieSeq(movieSeq);
		rb.setType(typeName);
		rb.setContent(review);
		
		MovieReviewService movieReviewService = new MovieReviewService();
		boolean isInsert = movieReviewService.isInsert(rb);
		
		if(isInsert) {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(nick+ "님의 리뷰 : " + review);
		}
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
	    forward.setPath("/movie1/movie_detail.jsp");
//	    request.setAttribute("returnCmt", comment);
	    return forward;
		
	}

}
