package movie.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import movie.svc.MovieChartService;
import movie.vo.MovieBean;
import vo.ActionForward;

public class MovieDetailBySearch implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		String nick = (String) session.getAttribute("nick");
		int movieSeq = Integer.parseInt(request.getParameter("movieSeq"));
		String movieTitle = request.getParameter("query");
		String moviePoster = request.getParameter("image");

		MovieBean mb = new MovieBean();
		mb.setNick(nick);
		mb.setMovieSeq(movieSeq);
		mb.setMovieTitle(movieTitle);
		mb.setMoviePoster(moviePoster);
		
		MovieChartService movieChartService = new MovieChartService();
		ActionForward forward = new ActionForward();
		
		if(nick!=null) {
			movieChartService.setWordForChart(mb);
		}
		forward.setPath("MovieDetailPro.mo");

		return forward;
	}

}
