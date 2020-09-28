package movie.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import movie.svc.MovieGetPosterForExpectationService;
import vo.ActionForward;

public class MovieGetPosterForExpectationAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String movieSeq = request.getParameter("movieSeq");
		MovieGetPosterForExpectationService movieGetPosterForExpectationService = new MovieGetPosterForExpectationService();
		
		String poster = movieGetPosterForExpectationService.getPoster(movieSeq);
		System.out.println(poster);
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println(poster);
		out.flush();
		
		return null;
	}

}
