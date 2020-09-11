package movie.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import action.Action;
import api.BoxofficeApi;
import vo.ActionForward;

public class MovieBoxOfficeNationAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String movieCd = request.getParameter("movieCd");
		System.out.println(movieCd);
		BoxofficeApi ba = new BoxofficeApi();
		String getBox = ba.getBoxOfficeNation(movieCd);
		
		JsonParser jsonParser = new JsonParser();
		JsonObject jsonObject = (JsonObject) jsonParser.parse(getBox);


		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		System.out.println(jsonObject);
		out.print(jsonObject);
		return null;
	}

}
