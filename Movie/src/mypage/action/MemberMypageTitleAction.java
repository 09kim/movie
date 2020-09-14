package mypage.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonArray;
import com.google.gson.JsonParser;

import action.Action;
import api.RestAPI_test;
import vo.ActionForward;

public class MemberMypageTitleAction implements Action {
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String nick = request.getParameter("nick");
//		MemberMypageService memberMypageService = new MemberMypageService();
//		ArrayList<MovieBean> list =memberMypageService.getMypageTitle(nick);
//		JsonObject json = new JsonObject();
//		JsonObject jo = new JsonObject();
//		JsonArray ja = new JsonArray();
//		for(MovieBean mb : list) {
//			jo.addProperty(mb.getMovieTitle(), mb.getMovieGrade());
//		}
//		ja.add(jo);
//		json.addProperty("Nick", nick);
//		json.add("Movie", ja);
//		response.setContentType("application/json;charset=UTF-8");
//		PrintWriter out = response.getWriter();
//		out.flush();
		RestAPI_test rest = new RestAPI_test();
		String grade = rest.getExpectedGrade(nick);
		String user = rest.getRecommendUser(nick);
		JsonParser jsonParser = new JsonParser();
		JsonArray jsonObject1 = (JsonArray) jsonParser.parse(grade);
		JsonArray jsonObject2 = (JsonArray) jsonParser.parse(user);
		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println(jsonObject2);
		out.flush();
		
				
		return null;
	}

}
