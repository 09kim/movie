package movie.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import action.Action;
import api.*;
import vo.ActionForward;

public class MovieQueryProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setCharacterEncoding("UTF-8");
		String movieSeq = request.getParameter("movieSeq");
		String query = request.getParameter("query");
		String openDt = request.getParameter("openDt"); // 박스오피스에서 가져온 파라미터
		String movieNm = request.getParameter("movieNm"); // 박스오피스에서 가져온 파라미터
		System.out.println(openDt);
		System.out.println(movieNm);
		
		kmdbApi movie = new kmdbApi();
		BoxofficeApi boxoffice = new BoxofficeApi();
		String json = null;

		if (query != null && movieSeq == null) {
			json = movie.getMovie(query);
		}
		if (movieSeq !=null && query !=null) {
			json = movie.getMovieDetail(movieSeq, query);
		}
		if (openDt != null && movieNm !=null) {
			json = movie.getBoxoffice(openDt, movieNm); // 박스오피스
		}
		
		System.out.println(json);

//		System.out.println(json);

		JsonParser jsonParser = new JsonParser();
		JsonObject jsonObject = (JsonObject) jsonParser.parse(json);

//		System.out.println(jsonObject);

		JsonArray ja = (JsonArray) jsonObject.get("Data"); // 이거안하면 나오는게 이상함

		response.setContentType("application/json;charset=UTF-8");
		// Get the printwriter object from response to write the required json object to
		// the output stream
		PrintWriter out = response.getWriter();
		// Assuming your json object is **jsonObject**, perform the following, it will
		// return your json object
//		out.print("<script>location href='/movie1/test_list.jsp'</script>");
		out.print(jsonObject);
		out.flush();

//		ActionForward forward = new  ActionForward();
//		forward.setPath("/movie/test_list.jsp");
		return null;
	}

}
