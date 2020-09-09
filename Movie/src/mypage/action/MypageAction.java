package mypage.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import mypage.svc.MypageService;
import vo.ActionForward;
import vo.MemberBean;

public class MypageAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String email = request.getParameter("email");
		System.out.println("email" );
		HttpSession session = request.getSession();
		String nick = (String) session.getAttribute("nick");
//		String nick = request.getParameter("nick");
		
		MemberBean memberBean = new MemberBean();
		memberBean.setEmail(email);
		memberBean.setNick(nick);
		boolean isselect = false;
		String resultMsg = "";
		
		MypageService mypageService = new MypageService();
		
		try {
			isselect = mypageService.selectMypage(memberBean);
			
		} catch (Exception e) {
			resultMsg = e.getMessage();
		}

		ActionForward forward = null;
		
		if (!isselect) {
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





















