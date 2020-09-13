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

public class MovieDetailByBox implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String openDt = request.getParameter("openDt"); // 박스오피스에서 가져온 파라미터
		String movieNm = request.getParameter("movieNm"); // 박스오피스에서 가져온 파라미터
		
		
		kmdbApi movie = new kmdbApi();
		String json = null;
		
		if (openDt != null && movieNm != null) {
			json = movie.getBoxoffice(openDt, movieNm); // 박스오피스
		}
		
		JsonParser jsonParser = new JsonParser();
		JsonObject jsonObject = (JsonObject) jsonParser.parse(json);


		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(jsonObject);
		out.flush();
		return null;
	}

}
