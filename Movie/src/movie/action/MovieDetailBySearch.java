package movie.action;

import java.net.URLEncoder;

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
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		String nick = (String) session.getAttribute("nick");
		String movieSeq = request.getParameter("movieSeq");
		int movieSeqInt = Integer.parseInt(movieSeq);
		String movieTitle = request.getParameter("query");
		String moviePoster = request.getParameter("image");
		int temp = Integer.parseInt(request.getParameter("temp"));
		String weather = request.getParameter("weather");
		MovieBean mb = new MovieBean();
		mb.setNick(nick);
		mb.setMovieSeq(movieSeqInt);
		mb.setMovieTitle(movieTitle);
		mb.setMoviePoster(moviePoster);
		mb.setTemp(temp);
		mb.setWeather(weather);
		MovieChartService movieChartService = new MovieChartService();
		ActionForward forward = new ActionForward();
		
		
		if(nick!=null) {
			movieChartService.setChart(mb);
		}
		
			forward.setPath("MovieDetailPro.mo?movieSeq="+movieSeq+"&query="+URLEncoder.encode(movieTitle, "UTF-8")); // URL 한글처리 해줘야함~!
		
		forward.setRedirect(true);

		return forward;
	}

}
