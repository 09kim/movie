package movie.action;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonParser;

import action.Action;
import movie.svc.MovieGetService;
import movie.vo.MovieBean;
import vo.ActionForward;

public class getMovieByTempAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int temp = Integer.parseInt((String)request.getParameter("temp"));
		MovieGetService movieGetService = new MovieGetService();
		ArrayList<MovieBean> list = movieGetService.getMovie(temp);
		Gson gs = new Gson();
		String json = gs.toJson(list);
		JsonParser jp = new JsonParser();
		JsonArray jo = (JsonArray) jp.parse(json);
		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		System.out.println(jo);
		out.println(jo);
		out.flush();
		
		return null;
	}

}
