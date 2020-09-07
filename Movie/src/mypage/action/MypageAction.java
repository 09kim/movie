package mypage.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import member.action.DupCheckAction;
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
		boolean isInsert = false;
		String resultMsg = "";
		
		MypageService mypageService = new MypageService();
		
		try {
			isInsert = mypageService.mypageinsert(memberBean);  
			
		} catch (Exception e) {
			resultMsg = e.getMessage();
		}

		ActionForward forward = null;
		if (!isInsert) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('" + resultMsg + "');history.back();</script>");
		} else {
			forward = new ActionForward();
			forward.setPath("./");
		}
		
//		DupCheckAction dupcheckAction = new DupCheckAction();
		
		

		return forward;
	}

}





















