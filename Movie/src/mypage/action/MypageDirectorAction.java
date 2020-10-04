package mypage.action;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;

import action.Action;
import mypage.svc.MypagePreferedThings;
import mypage.svc.MypageServiceForMain;
import vo.ActionForward;

public class MypageDirectorAction implements Action {
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String nick = request.getParameter("nick");
		MypagePreferedThings mpt = new MypagePreferedThings();
		MypageServiceForMain myPageServiceForMain = new MypageServiceForMain();
		ArrayList<String> list  = myPageServiceForMain.getInformation(nick,Mypage.director);
		System.out.println(list);
		myPageServiceForMain.setMypage(nick, list, Mypage.director);
		JsonObject jo = mpt.getMypageDirector(nick);
		
		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(jo);
		out.flush();
		return null;
	}

}
