package movie.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import action.Action;
import api.kmdbApi;
import movie.svc.MovieChartService;
import movie.vo.MovieBean;
import vo.ActionForward;

public class MovieDetailBySearch implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		String nick = (String) session.getAttribute("nick");
		String movieSeq = request.getParameter("movieSeq");
		String movieTitle = request.getParameter("movieTitle");
		String moviePoster = request.getParameter("image");
		kmdbApi movie = new kmdbApi();
		String json = "";
		json = movie.getMovieDetail(movieSeq, movieTitle);

		MovieBean mb = new MovieBean();
		mb.setNick(nick);
		mb.setMovieSeq(movieSeq);
		mb.setMovieTitle(movieTitle);
		mb.setMoviePoster(moviePoster);
		
		MovieChartService movieChartService = new MovieChartService();
		
		movieChartService.setWordForChart(mb);

		JsonParser jsonParser = new JsonParser();
		JsonObject jsonObject = (JsonObject) jsonParser.parse(json);

		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(jsonObject);
		out.flush();

		return null;
	}

}
