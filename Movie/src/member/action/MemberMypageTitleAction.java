package member.action;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import action.Action;
import member.svc.MemberMypageService;
import movie.vo.MovieBean;
import vo.ActionForward;

public class MemberMypageTitleAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String nick = request.getParameter("nick");
		MemberMypageService memberMypageService = new MemberMypageService();
		ArrayList<MovieBean> list =memberMypageService.getMypageTitle(nick);
		JsonObject json = new JsonObject();
		JsonObject jo = new JsonObject();
		JsonArray ja = new JsonArray();
		for(MovieBean mb : list) {
			jo.addProperty(mb.getMovieTitle(), mb.getMovieGrade());
		}
		ja.add(jo);
		json.addProperty("Nick", nick);
		json.add("Movie", ja);
		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println(json);
		out.flush();
		System.out.println(json);
		return null;
	}

}
