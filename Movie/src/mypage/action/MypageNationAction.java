package mypage.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kenai.jffi.Array;

import action.Action;
import mypage.svc.MypagePreferedThings;
import vo.ActionForward;

public class MypageNationAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String nick = request.getParameter("nick");
		MypagePreferedThings mpt = new MypagePreferedThings();
		StringBuffer nation = mpt.getMypageNation(nick);
		System.out.println(nation);
		return null;
	}

}
