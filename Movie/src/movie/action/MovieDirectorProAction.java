package movie.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import action.Action;
import api.kmdbApi;
import vo.ActionForward;

public class MovieDirectorProAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String director = request.getParameter("query");
		kmdbApi movie = new kmdbApi();
		String json = null;
		
		if (director!=null) {
			json = movie.getMovieDetailByDirector(director);
		}

		System.out.println(json);

		JsonParser jsonParser = new JsonParser();
		JsonObject jsonObject = (JsonObject) jsonParser.parse(json);

		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(jsonObject);
		out.flush();

		
		
		

		return null;
	}

}
