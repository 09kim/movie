package mypage.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import member.vo.MemberBEAN;
import mypage.svc.MypageService;
import vo.ActionForward;

public class MypageAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String email = request.getParameter("email");
		String nick = request.getParameter("nick");
		
		MemberBEAN memberBean = new MemberBEAN();
		memberBean.setEmail(email);
		memberBean.setNick(nick);
		
		MypageService mypageService = new MypageService();
		
		
		return null;
	}

}
