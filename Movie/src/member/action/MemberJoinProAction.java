package member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import member.svc.MemberJoinProService;
import member.vo.MemberBEAN;
import vo.ActionForward;

public class MemberJoinProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {


		String email = request.getParameter("email");
		String pass = request.getParameter("pass");
		String nick = request.getParameter("nick");
		String phone = request.getParameter("phone");
		
		
		MemberBEAN mb = new MemberBEAN();
		mb.setEmail(email);
		mb.setPass(pass);
		mb.setNick(nick);
		mb.setPhone(phone);
		boolean isInsert = false;
		String resultMsg = "";

		MemberJoinProService memberJoinProService = new MemberJoinProService();
		try {
			isInsert = memberJoinProService.insertMember(mb);
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

		return forward;
	}

}
