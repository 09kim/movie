package movie.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonArray;
import com.google.gson.JsonParser;

import action.Action;
import api.RestAPI_Python;
import vo.ActionForward;

public class MovieExpectedGrade implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String nick = request.getParameter("nick");
		RestAPI_Python rest = new RestAPI_Python();
		String grade = rest.getExpectedGrade(nick);
		JsonParser jsonParser = new JsonParser();
		JsonArray jsonObject = (JsonArray) jsonParser.parse(grade);
		
		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println(jsonObject);
		out.flush();
		return null;
	}
	
}
