package member.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.python.util.PythonInterpreter;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import action.Action;
import member.svc.MemberMypageService;
import movie.vo.MovieBean;
import vo.ActionForward;

public class MemberMypageTitleAction implements Action {
	private static PythonInterpreter interpreter;
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
//		response.setContentType("application/json;charset=UTF-8");
//		PrintWriter out = response.getWriter();
//		out.flush();
		interpreter = new PythonInterpreter();
		interpreter.execfile("D:\\wordspace_py5\\Movie\\recommend.py");
				
		return null;
	}

}
