package movie.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import action.Action;
import api.kmdbApi;
import vo.ActionForward;

public class MovieQueryProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setCharacterEncoding("UTF-8");
		String movieSeq = request.getParameter("movieSeq");
		String query = request.getParameter("query");
		String movieNm = request.getParameter("movieNm");
		String openDt = request.getParameter("openDt");
		kmdbApi movie = new kmdbApi();
		String json = null;

		if (query != null && movieSeq == null) {
			json = movie.getMovie(query);
		} 
		else if(movieSeq != null && query != null) {
			json = movie.getMovieDetail(movieSeq, query);
		} 
		else if (!(movieNm == null && openDt == null)) {
			json = movie.getBoxoffice(openDt, movieNm);
		}

		System.out.println("movieSeq : " + movieSeq);
		System.out.println("query : " + query);
		System.out.println("movieNm : " + movieNm);
		System.out.println("openDt : " + openDt);
		
		JsonParser jsonParser = new JsonParser();
		JsonObject jsonObject = (JsonObject) jsonParser.parse(json);



		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(jsonObject);
		out.flush();

//		ActionForward forward = new  ActionForward();
//		forward.setPath("/movie/test_list.jsp");
		return null;
	}

}
