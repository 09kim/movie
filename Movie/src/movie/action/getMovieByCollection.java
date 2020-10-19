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
import api.RestAPI_Python;
import api.RestAPI_Spring;
import movie.svc.MovieGetService;
import movie.vo.MovieBean;
import mypage.action.Mypage;
import vo.ActionForward;

public class getMovieByCollection implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		RestAPI_Spring rs = new RestAPI_Spring();
		String type = "1";
		if(request.getParameter("type").equals("2")) {
			type = "2";
		}
		String collection = rs.getCollection(type);
		
		
		
		JsonParser jsonParser = new JsonParser();
		JsonArray jsonObject = (JsonArray) jsonParser.parse(collection);
		
		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println(jsonObject);
		out.flush();
		return null;
	}

}
