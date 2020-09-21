package mypage.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;

import action.Action;
import mypage.svc.MypagePreferedThings;
import vo.ActionForward;

public class MypageNationAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String nick = request.getParameter("nick");
		MypagePreferedThings mpt = new MypagePreferedThings();
		JsonObject nation = mpt.getMypageNation(nick);
		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(nation);
		out.flush();
		return null;
	}

}
